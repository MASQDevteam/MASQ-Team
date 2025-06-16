page 70134 "Job Expense Allocation Subform"
{
    PageType = ListPart;
    SourceTable = "Job Expense Allocation";
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Allocation ID"; Rec."Allocation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Job#"; Rec."Job#")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subjob ID"; Rec."Subjob ID")
                {
                    ToolTip = 'Specifies the value of the Subjob ID field.', Comment = '%';
                    Editable = false;
                }

                field("Expense Type"; Rec."Expense Type")
                {
                    ApplicationArea = All;
                }

                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;

                    trigger OnValidate()

                    var
                    begin

                    end;
                }

                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }

                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {

    }
}
