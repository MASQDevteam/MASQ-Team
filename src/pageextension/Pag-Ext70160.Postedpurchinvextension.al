pageextension 70160 "Posted purch inv extension" extends "Posted Purchase Invoice"
{
    layout
    {
        modify("Order No.")
        {
            Visible = true;
            ApplicationArea = All;
            Importance = Standard;
        }
        addafter("Meg SO No.")
        {
            field("PO Type"; Rec."PO Type")
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Date field.', Comment = '%';
            }
        }
    }
}