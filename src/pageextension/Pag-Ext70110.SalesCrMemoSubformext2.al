pageextension 70110 "Sales Cr. Memo Subform ext2" extends "Sales Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Meg Vendor Item Code")
        {
            field("Meg Item Type"; Rec."Meg Item Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the current item''s type. Used in "Delivery Order" report "in Posted Sales Invoice" page.';
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