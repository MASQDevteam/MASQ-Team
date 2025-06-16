page 70132 "Job Information Card"
{
    PageType = Card;
    SourceTable = "Job Information";  // Referring to the new table (70121)
    ApplicationArea = All;
    //   UsageCategory = Administration;

    layout
    {
        area(content)
        {

            group("General Information")
            {
                //  Editable = Rec.Status <> Rec.Status::Lose;
                field("Job#";
                Rec."Job#")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sales Rep"; Rec."Sales Rep")
                {
                    ApplicationArea = All;
                }
                field("Job Value"; Rec."Job Value")
                {
                    ApplicationArea = All;
                }
                // field("Status"; Rec."Status")
                // {
                //     ApplicationArea = All;
                //     StyleExpr = StyleExprTxt;
                //     trigger OnValidate()
                //     var
                //     begin
                //         GetStyle();
                //     end;
                // }
            }

            group("Project and Financial Information")
            {
                //  Editable = Rec.Status <> Rec.Status::Lose;
                field("Project Manager"; Rec."Project Manager")
                {
                    ApplicationArea = All;
                }
                field("Job Currency"; Rec."Job Currency")
                {
                    ApplicationArea = All;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
                field(Developer; Rec.Developer)
                {
                    ApplicationArea = All;
                }
                field("Total Expense Allocated"; Rec."Total Expense Allocated")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            part("Subjob Information Subform"; "Subjob Information Subform")
            {
                ApplicationArea = Basic, Suite;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Job#" = field("Job#");
                UpdatePropagation = Both;
            }
            part("Expenses"; "Job Expense Allocation Subform")
            {
                ApplicationArea = Basic, Suite;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Job#" = field("Job#"), "Subjob ID" = field("Subjob ID");
                UpdatePropagation = Both;
                Provider = "Subjob Information Subform";
                // Editable = Rec.Status <> Rec.Status::Lose;
            }

            part(PurchLines; "Purchase Order Subform")
            {
                ApplicationArea = Suite;
                // Editable = IsPurchaseLinesEditable;
                // Enabled = IsPurchaseLinesEditable;
                ShowFilter = true;
                Provider = "Subjob Information Subform";

                SubPageLink = "Job#" = field("Job#"), "Subjob ID" = field("Subjob ID");
                UpdatePropagation = Both;
                Editable = false;
                Enabled = false;
            }
            part(PurchInvLines; "Posted Purch. Invoice Subform")
            {
                Caption = 'Posted Lines';
                ApplicationArea = Basic, Suite;
                Editable = false;
                Enabled = false;
                Provider = "Subjob Information Subform";
                // Editable = IsPurchaseLinesEditable;
                // Enabled = IsPurchaseLinesEditable;
                ShowFilter = true;
                SubPageLink = "Job#" = field("Job#"), "Subjob ID" = field("Subjob ID");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Save)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // Custom save logic can be added here if needed.
                    Message('Job Information Saved');
                end;
            }
        }
    }
    Local procedure GetStyle()
    var
    begin
        IF rec.Status = Rec.Status::Lose then
            StyleExprTxt := 'Unfavorable'
        else
            If rec.Status = Rec.Status::Lose then
                StyleExprTxt := 'Favorable'
            else
                StyleExprTxt := 'None'
    end;

    var
        StyleExprTxt: Text;
}
