pageextension 70106 "Posted purchcase Receipt exte" extends "Posted Purchase Receipts"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor Name")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the order that created the entry.';
            }
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