pageextension 70148 "General Journal extension" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter(Comment)
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related project.';
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related project task.';
            }
            field("Job Quantity"; Rec."Job Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity for the project ledger entry that is derived from posting the journal line. If the Project Quantity is 0, the total amount on the project ledger entry will also be 0.';
            }
            field("Travel Request Code"; Rec."Travel Request Code")
            {
                ApplicationArea = All;
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