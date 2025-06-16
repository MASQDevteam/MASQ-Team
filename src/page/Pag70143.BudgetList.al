page 70143 "Budget List"
{
    AutoSplitKey = true;
    Caption = 'Budgets Control';
    CardPageID = "Budget Card";
    Editable = false;
    PageType = List;
    SourceTable = Job;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            /*   part("Budget Details"; Rec."Budget Factbox")
               {
                   ApplicationArea = Jobs;
                   Caption = 'Budget Details';
                   SubPageLink = "Job No." = FIELD("No.");
                   Visible = JobSimplificationAvailable;
               }*/
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(creation)
        {
            // action(Print)
            // {
            //     Image = print;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     var
            //         Job: Record Job;
            //     begin
            //         CurrPage.SETSELECTIONFILTER(Job);
            //         REPORT.RUN(REPORT::"Budget Control", TRUE, FALSE, Job);
            //     end;
            // }//EDM.AI-Reports

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var

    begin
        GLSetup.Get();
        UserSetup.Get(UserId);
        EditBudget := false;

        IF GLSetup."Restrict Budget Edit for Users" then begin
            EditBudget := UserSetup."Can Edit Budget Control";
        end else begin
            EditBudget := true;
        end;


        IF not EditBudget then
            Error('No Permission!!!!!');

    end;

    trigger OnModifyRecord(): Boolean
    var
    begin
        GLSetup.Get();
        UserSetup.Get(UserId);
        EditBudget := false;

        IF GLSetup."Restrict Budget Edit for Users" then begin
            EditBudget := UserSetup."Can Edit Budget Control";
        end else begin
            EditBudget := true;
        end;

        IF not EditBudget then
            Error('No Permission!!!!!');

    end;

    trigger OnDeleteRecord(): Boolean
    var
    begin
        GLSetup.Get();
        UserSetup.Get(UserId);
        EditBudget := false;

        IF GLSetup."Restrict Budget Edit for Users" then begin
            EditBudget := UserSetup."Can Edit Budget Control";
        end else begin
            EditBudget := true;
        end;

        IF not EditBudget then
            Error('No Permission!!!!!');

    end;

    // trigger OnInit()
    // begin
    //     JobSimplificationAvailable := IsJobSimplificationAvailable;
    // end;

    var
        JobSimplificationAvailable: Boolean;
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        EditBudget: Boolean;
}

