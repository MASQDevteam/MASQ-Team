pageextension 70131 "Location Card Extension" extends "Location Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Code)
        {
            field("Code 2"; Rec."Code 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Code 2 field.', Comment = '%';
            }
            field("Warehouse Category"; Rec."Warehouse Category")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warehouse Category field.', Comment = '%';
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