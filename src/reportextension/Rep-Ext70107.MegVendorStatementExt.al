reportextension 70107 "Meg Vendor Statement Ext" extends "Meg Vendor Statement"
{
    dataset
    {
        modify("Detailed Vendor Ledg. Entry")
        {
            RequestFilterFields = "Document Type", "Posting Date";
        }
        add(VendLedgEntry2)
        {
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
        }
        
    }
    var
        ProjectName: Text[50];
}
