pageextension 70113 "Dimensionvalue extension" extends "Dimension Values"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Moonlight Item Type"; Rec."Moonlight Item Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Moonlight Item Type field.', Comment = '%';
            }
            field("Moonlight Brand"; Rec."Moonlight Brand")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Moonlight Brand field.', Comment = '%';
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