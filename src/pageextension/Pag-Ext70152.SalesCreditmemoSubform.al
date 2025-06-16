pageextension 70152 "Sales Credit memo Subform" extends "Sales Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here

        modify("Job No.")
        {
            Editable = true;
            Visible = false;
        }
        modify("Job Task No.")
        { Editable = false; Visible = true; }

        addafter("Job Task No.")
        {
            field("Job Planning Line No."; Rec."Job Planning Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Project Planning Line No. field.', Comment = '%';
                Editable = false;
            }
            field("Job Contract Entry No."; Rec."Job Contract Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the entry number of the project planning line that the sales line is linked to.';
                Editable = false;
            }
            field("Apollo Job Unit Cost"; Rec."Apollo Job Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Apollo Job Unit Cost field.', Comment = '%';
                Editable = false;
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