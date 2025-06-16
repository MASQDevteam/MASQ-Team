pageextension 70149 "Posted Sales Invoice Lines ext" extends "Posted Sales Invoice Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Line Discount %")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
            }
            // field("Order No."; Rec."Order No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Order No. field.', Comment = '%';
            // }
            field("Order Line No."; Rec."Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Line No. field.', Comment = '%';
            }
            field("MASQ Purchase Order Line No."; Rec."MASQ Purchase Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Purchase Order Line No. field.', Comment = '%';
            }
            field("MASQ Purchase Order No."; Rec."MASQ Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Purchase Order No. field.', Comment = '%';
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