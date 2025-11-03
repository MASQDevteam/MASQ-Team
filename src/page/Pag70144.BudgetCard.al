page 70144 "Budget Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Prices';
    RefreshOnActivate = true;
    SourceTable = Job;
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Editable = CurrencyCodeEditable;
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency code for a job. By default, the currency code is empty. If you enter a foreign currency code, it results in the job being planned and invoiced in that currency.';

                    trigger OnValidate()
                    begin
                        CurrencyCheck;
                    end;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Person Responsible"; Rec."Person Responsible")
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
                field("Last Date Modified"; Rec."Last Date Modified")
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
            }
            part("Budget Lines"; "Budget Lines Subform")
            {
                ApplicationArea = All;
                Caption = 'Budget Lines';
                SubPageLink = "Job No." = FIELD("No.");
                SubPageView = SORTING("Job Task No.") ORDER(Ascending);
            }
        }
        area(factboxes)
        {
            // part("Budget Details"; Rec."Budget Factbox")
            // {
            //     Caption = 'Budget Details';
            //     Provider = "Budget Lines";
            //     SubPageLink = "Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No.");
            // }//EDM.AI-UPBudget
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
        area(navigation)
        {
            /*  group("&Copy")
              {
                  Caption = '&Copy';
                  Image = Copy;
                  action("Copy To Budget")
                  {
                      Image = CopyBudget;

                      trigger OnAction()
                      var
                          BudgetControl: Codeunit "Budget Control";
                      begin
                          BudgetControl.CopyJobToBudget("No.");
                      end;
                  }
                  action("Copy To Budget By Dimension")
                  {
                      Image = CopyBudget;
                      Promoted = true;
                      PromotedIsBig = true;

                      trigger OnAction()
                      var
                          BudgetControl: Codeunit "Budget Control";
                      begin
                      end;
                  }*/
            action("Add Payroll Budget")
            {
                Visible = false;
            }
            action("Copy From GL Budget By Dimension")
            {
                Caption = 'Copy From G/L Budget By Dimension';
                Image = CopyBudget;
                Promoted = true;
                PromotedCategory = New;

            }
            action("Import Budget History")
            {
                Caption = 'Import Budget History';
                Image = ImportChartOfAccounts;
                Promoted = true;
                PromotedCategory = New;
                Visible = false;
            }

            group(Budget)
            {
                Caption = 'Budget';
                Image = Job;
                action("&Dimensions")
                {
                    ApplicationArea = Jobs;
                    Caption = '&Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(167), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View this job''s default dimensions.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrencyCheck;
    end;

    trigger OnInit()
    begin
        CurrencyCodeEditable := TRUE;
        InvoiceCurrencyCodeEditable := TRUE;
        //  JobSimplificationAvailable := IsJobSimplificationAvailable;
    end;

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




    var
       // [InDataSet]
        InvoiceCurrencyCodeEditable: Boolean;
       // [InDataSet]
        CurrencyCodeEditable: Boolean;
        JobSimplificationAvailable: Boolean;
        JobTask: Record "Job Task";

        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        EditBudget: Boolean;

    local procedure CurrencyCheck()
    begin
        IF Rec."Currency Code" <> '' THEN
            InvoiceCurrencyCodeEditable := FALSE
        ELSE
            InvoiceCurrencyCodeEditable := TRUE;

        IF Rec."Invoice Currency Code" <> '' THEN
            CurrencyCodeEditable := FALSE
        ELSE
            CurrencyCodeEditable := TRUE;
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;
}

