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

            column(Item_No_; "No.")
            {
            }
            column(Vendor_No_; "Vendor No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Picture; ItemTenantMedia.Content)
            {
            }
            column(Inventory; Inventory) { }
			column(Meg_Vendor_Item_Code;"Meg Vendor Item Code"){}

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                if Item.Picture.Count > 0 then begin
                    ItemTenantMedia.Get(Item.Picture.Item(1));
                    ItemTenantMedia.CalcFields(Content);
                end;
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

            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        Item.CalcFields(Inventory);
    end;

    var
        CompanyInfo: Record "Company Information";
        ItemTenantMedia: Record "Tenant Media";
}
