report 70116 "Item Inventory With Picture"
{
    ApplicationArea = All;
    Caption = 'List of items with pictures';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/Layouts/ItemInventoryWithPicture.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Item Category Code";
            column(Item_No_; "No.") { }
            column(Vendor_No_; "Vendor No.") { }
            column(Description; Description) { }
            column(ItemPicture; ItemTenantMedia.Content) { }
            column(Picture; CompanyInfo.Picture) { }
            column(Inventory; Inventory) { }
            column(Meg_Vendor_Item_Code; "Meg Vendor Item Code") { }
            column(Location_Code; LastLocationName) { }
            column(Meg_Family; "Meg Family") { }
            column(Meg_Item_Subcategory_Code; "Meg Item Subcategory Code") { }

            trigger OnPreDataItem()
            begin
                // Apply performance filters
                if ShowOnlyItemsWithInventory then
                    SetFilter(Inventory, '>0');
            end;

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
                Location: Record Location;
            begin
                // Use partial records for better performance - only load required fields
                SetLoadFields("No.", "Vendor No.", Description, "Meg Vendor Item Code", Inventory, Picture);

                // Skip items without pictures if filter is enabled
                if ShowOnlyItemsWithPictures and (Picture.Count = 0) then
                    CurrReport.Skip();

                // Only process items with pictures to avoid unnecessary Tenant Media lookups
                if Picture.Count > 0 then begin
                    if ItemTenantMedia.Get(Picture.Item(1)) then begin
                        ItemTenantMedia.CalcFields(Content);
                    end else begin
                        // Clear the content if Tenant Media doesn't exist
                        ItemTenantMedia.Init();
                    end;
                end else begin
                    // Clear the content if no picture
                    ItemTenantMedia.Init();
                end;

                // Get last location code with optional filter
                LastLocationCode := GetLastLocationCode("No.");

                // Skip if location filter is set and doesn't match
                if (LocationFilter <> '') and (LastLocationCode <> LocationFilter) then
                    CurrReport.Skip();

                if Location.Get(LastLocationCode) then
                    LastLocationName := LastLocationCode + ' - ' + Location.Name
                else
                    LastLocationName := LastLocationCode;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Filter Options';

                    field(ShowOnlyItemsWithPictures; ShowOnlyItemsWithPictures)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Items With Pictures';
                        ToolTip = 'Filter to show only items that have pictures attached. This will significantly improve report performance.';
                    }

                    field(ShowOnlyItemsWithInventory; ShowOnlyItemsWithInventory)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Only Items With Inventory > 0';
                        ToolTip = 'Filter to show only items that have inventory greater than zero. This will reduce the number of records processed.';
                    }

                    field(LocationFilter; LocationFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Location Filter';
                        ToolTip = 'Filter items by their last transaction location. Leave blank to show all locations.';
                        TableRelation = Location.Code;
                    }
                }
            }
        }
        actions
        {

        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        ShowOnlyItemsWithPictures := true;
        ShowOnlyItemsWithInventory := true;
    end;

    local procedure GetLastLocationCode(ItemNo: Code[20]): Code[10]
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.SetCurrentKey("Item No.", "Entry No.");
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        if ItemLedgerEntry.FindLast() then
            exit(ItemLedgerEntry."Location Code");

        exit('');
    end;

    var
        CompanyInfo: Record "Company Information";
        ItemTenantMedia: Record "Tenant Media";
        ShowOnlyItemsWithPictures: Boolean;
        ShowOnlyItemsWithInventory: Boolean;
        LocationFilter: Code[10];
        LastLocationCode: Code[10];
        LastLocationName: Text[100];
}