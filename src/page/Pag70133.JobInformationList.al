page 70133 "Job Information List"
{
    PageType = List;
    SourceTable = "Job Information";  // Referring to the new table (70121)
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = "Job Information Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Job#"; Rec."Job#")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Job identifier for the quotation';
                    Editable = false;

                }
                field("Sales Rep"; Rec."Sales Rep")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Sales representative responsible for this job';
                }
                field("Job Value"; Rec."Job Value")//landed Cost
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'The value of the job';
                }
                // }
                // field("Status"; Rec."Status")
                // {
                //     ApplicationArea = All;
                //     StyleExpr = StyleExprTxt;
                //     ToolTip = 'Current status of the job';
                // }
                field("Project Manager"; Rec."Project Manager")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Project Manager identifier';
                }
                field("Job Currency"; Rec."Job Currency")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Currency used for the job';
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Name of the project associated with this job';
                }
                field(Developer; Rec.Developer)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Development-related identifier for this job';
                }
                field("Total Expense Allocated"; Rec."Total Expense Allocated")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    ToolTip = 'Total expense allocated for the job';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(NewRecord)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    JobInfoRec: Record "Job Information";
                begin
                    // Create a new Job Information record
                    JobInfoRec.Init();
                    JobInfoRec.Insert();
                    // Optionally navigate to the Job Information card page
                    PAGE.Run(PAGE::"Job Information Card", JobInfoRec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin

        //   GetStyle();
    end;

    Local procedure GetStyle()
    var
    begin
        IF rec.Status = Rec.Status::Lose then
            StyleExprTxt := 'Unfavorable'
        else
            If rec.Status = Rec.Status::Win then
                StyleExprTxt := 'Favorable'
            else
                StyleExprTxt := 'None'
    end;

    var
        StyleExprTxt: Text;

    // Optional: Sorting, Filtering, or other actions can be added here
}
