pageextension 70134 "Posted purchcase Receipts exte" extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor Name")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here


    }

    var
        myInt: Integer;
}