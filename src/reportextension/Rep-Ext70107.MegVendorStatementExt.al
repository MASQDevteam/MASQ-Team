reportextension 70107 "Meg Vendor Statement Ext" extends "Meg Vendor Statement"
{
    RDLCLayout = 'MegVendorStatementNew.rdl';
    dataset
    {
        modify("Detailed Vendor Ledg. Entry")
        {
            RequestFilterFields = "Document Type", "Posting Date";
        }

        // add(VendLedgEntry2)
        // {

        //     column(Global_Dimension_1_Code; "Global Dimension 1 Code")
        //     {

        //     }
        //     column(ProjectName; ProjectName)
        //     {

        //     }
        // }


    }
    // trigger OnPostReport()
    // var
    //     DimensionValue: Record "Dimension Value";
    // begin
    //     ProjectName := '';
    //     DimensionValue.SetRange("Dimension Code", 'PROJECT');
    //     DimensionValue.SetRange(Code, VendLedgEntry2."Global Dimension 1 Code");
    //     if DimensionValue.FindFirst() then begin
    //         ProjectName := DimensionValue.Name;
    //     end;
    // end;

    var
        ProjectName: Text[50];
}
