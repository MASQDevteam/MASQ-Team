report 70116 "Item Inventory With Picture"
{
    ApplicationArea = All;
    Caption = 'Item Inventory With Picture';
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
            column(Location_Code; LastLocationCode) { }
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

                LastLocationCode := '';
                ItemLedgerEntry.SetCurrentKey("Item No.", "Entry No.");
                ItemLedgerEntry.SetRange("Item No.", "No.");
                if ItemLedgerEntry.FindLast() then
                    LastLocationCode := ItemLedgerEntry."Location Code";
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
    end;

    var
        CompanyInfo: Record "Company Information";
        ItemTenantMedia: Record "Tenant Media";
        ShowOnlyItemsWithPictures: Boolean;
        ShowOnlyItemsWithInventory: Boolean;
        LastLocationCode: Code[10];
}
