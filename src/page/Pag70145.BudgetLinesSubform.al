page 70145 "Budget Lines Subform"
{
    PageType = ListPart;
    SourceTable = "Job Task";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies the number of the job that the job task is related to.';
                    Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies the number of the job task you are setting up. You can enter a maximum of 20 characters, both numbers and letters.';


                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies a description of the job task. You can enter anything that is meaningful in describing the task. The description is copied and used in descriptions on the job planning line.';
                }

                field("Job Task Type"; Rec."Job Task Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purpose of the account. Newly created accounts are automatically assigned the Posting account type, but you can change this. Choose the field to select one of the following five options:';
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an interval or a list of job task numbers.';
                }
                field("Job Posting Group"; Rec."Job Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the job posting group of the task.';
                    Visible = false;
                }
                field("WIP-Total"; Rec."WIP-Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the job tasks you want to group together when calculating Work In Process (WIP) and Recognition.';
                    Visible = false;
                }
                field("WIP Method"; Rec."WIP Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the Work in Process calculation method that is associated with a job. The value in this field comes from the WIP method specified on the job card.';
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date for the job task. The date is based on the date on the related job planning line.';
                    Visible = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date for the job task. The date is based on the date on the related job planning line.';
                    Visible = false;
                }
                field("Budget Amount"; Rec."Budget Amount")
                { ApplicationArea = All; }
                field("Schedule (Total Cost)"; Rec."Schedule (Total Cost)")
                {
                    ApplicationArea = All;
                    Caption = 'Budget (Total Cost)';
                    ToolTip = 'Specifies, in the local currency, the total budgeted cost for the job task during the time period in the Planning Date Filter field.';
                    Visible = false;
                }
                field("Schedule (Total Price)"; Rec."Schedule (Total Price)")
                {
                    ApplicationArea = All;
                    Caption = 'Budget (Total Price)';
                    ToolTip = 'Specifies, in local currency, the total budgeted price for the job task during the time period in the Planning Date Filter field.';
                    Visible = false;
                }
                field("Amount on Purch. Orders"; Rec."Amount on Purch. Orders")
                {
                    ToolTip = 'Specifies the value of the Amount on Purch. Orders field.', Comment = '%';
                }

                field("PPI Amount LCY"; Rec."PPI Amount LCY")
                {
                    Caption = 'Posted Purch. Invoices Amount';
                    ApplicationArea = All;
                    // Visible = (BudgetCurrency = '');
                }
                field("PPI Amount ACY"; Rec."PPI Amount ACY")
                {
                    Caption = 'Posted Purch. Invoices Amount(ACY)';
                    ApplicationArea = All;
                    // Visible = (BudgetCurrency = 'EURO');
                }
                field("Purchase Credit Memo Amount"; Rec."Purchase Credit Memo Amount")
                {
                    ToolTip = 'Specifies the value of the Purchase Credit Memo Amount field.', Comment = '%';
                }
                // field("Journal Expenditure Amount"; Rec."Journal Expenditure Amount")
                // {
                //     Caption = 'Journal Expenditure Amount';
                // }
                field("Paid Amount"; Rec."Paid Amount")
                {
                    Caption = 'Paid Amount';
                    ApplicationArea = All;
                }
                /*    field("Paid Amount test"; Rec."Paid Amount test")
                    {
                        Caption = 'Paid Amount 2';
                    }*/
                field("Expected Financial Amount"; Rec."Expected Financial Amount")
                {
                }
                field("G/L Financial Amount LCY"; Rec."G/L Financial Amount LCY")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Financial Amount LCY field.';
                }
                field("G/L Financial Amount ACY"; Rec."G/L Financial Amount ACY")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Financial Amount EURO field.';
                }
                field("G/L Financial Amount LCY3"; Rec."G/L Financial Amount LCY")
                {
                    Caption = 'Financial Amount';
                    ApplicationArea = All;
                    //     Visible = (BudgetCurrency = '');
                }
                // field("G/L Financial Amount USD"; Rec."G/L Financial Amount USD")
                // {
                //     Caption = 'Financial Amount';
                //     Visible = (BudgetCurrency = 'USD');
                // }
                // field("Bank Charges Amount"; Rec."Bank Charges Amount")
                // {
                // }

                // field("GENJNL Batch Filter"; Rec."GENJNL Batch Filter")
                // {
                // }
                // field("Payment Batch Filter"; Rec."Payment Batch Filter")
                // {
                // }
                /* field("Paid Financial Amount"; Rec."Paid Financial Amount")
                 {
                 }*/
                // field("Remaining from PO"; Rec."Remaining from PO")
                // {
                //     trigger OnDrillDown()
                //     var
                //         PurchaseLine: Record "Purchase Line";
                //     begin
                //         Clear(PurchaseLine);
                //         PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                //         PurchaseLine.SetRange("Job No.", "Job No.");
                //         PurchaseLine.SetRange("Job Task No.", "Job Task No.");
                //         Page.Run(Page::"Purchase Lines", PurchaseLine);
                //     end;
                // }
                /* field("Remaining from PPI"; Rec."Remaining from PPI")
                 {
                 }*/
                field("Remaining from Budget"; Rec."Remaining from Budget")
                {
                    ApplicationArea = All;
                }
                field("Remaining from PO"; Rec."Remaining from PO")
                {
                    ToolTip = 'Specifies the value of the Remaining from PO field.', Comment = '%';
                }
                field("Remaining from PPI"; Rec."Remaining from PPI")
                {
                    ToolTip = 'Specifies the value of the Remaining from PPI field.', Comment = '%';
                }
                field("Remaining From Financial"; Rec."Remaining From Financial")
                {
                    ApplicationArea = All;
                }

                /*  field("Usage (Total Cost)"; Rec."Usage (Total Cost)")
                  {
                       ApplicationArea = All;
                      Caption = 'Actual (Total Cost)';
                      ToolTip = 'Specifies, in local currency, the total cost of the usage of items, resources and general ledger expenses posted on the job task during the time period in the Posting Date Filter field.';
                      Visible = false;
                  }
                  field("Usage (Total Price)"; Rec."Usage (Total Price)")
                  {
                       ApplicationArea = All;
                      Caption = 'Actual (Total Price)';
                      ToolTip = 'Specifies, in the local currency, the total price of the usage of items, resources and general ledger expenses posted on the job task during the time period in the Posting Date Filter field.';
                      Visible = false;
                  }
                  field("Contract (Total Cost)"; Rec."Contract (Total Cost)")
                  {
                       ApplicationArea = All;
                      Caption = 'Billable (Total Cost)';
                      ToolTip = 'Specifies, in local currency, the total billable cost for the job task during the time period in the Planning Date Filter field.';
                      Visible = false;
                  }
                  field("Contract (Total Price)"; Rec."Contract (Total Price)")
                  {
                       ApplicationArea = All;
                      Caption = 'Billable (Total Price)';
                      ToolTip = 'Specifies, in the local currency, the total billable price for the job task during the time period in the Planning Date Filter field.';
                      Visible = false;
                  }
                  field("Contract (Invoiced Cost)"; Rec."Contract (Invoiced Cost)")
                  {
                       ApplicationArea = All;
                      Caption = 'Billable (Invoiced Cost)';
                      ToolTip = 'Specifies, in the local currency, the total billable cost for the job task that has been invoiced during the time period in the Posting Date Filter field.';
                      Visible = false;
                  }
                  field("Contract (Invoiced Price)"; Rec."Contract (Invoiced Price)")
                  {
                       ApplicationArea = All;
                      Caption = 'Billable (Invoiced Price)';
                      ToolTip = 'Specifies, in the local currency, the total billable price for the job task that has been invoiced during the time period in the Posting Date Filter field.';
                      Visible = false;
                  }*//*
                  field("EAC (Total Cost)"; CalcEACTotalCost)
                  {
                       ApplicationArea = All;
                      Caption = 'EAC (Total Cost)';
                      ToolTip = 'Specifies the estimate at completion (EAC) total cost for a job task line. If the Apply Usage Link check box on the job is selected, then the EAC (Total Cost) field is calculated as follows:';
                      Visible = false;
                  }
                  field("EAC (Total Price)"; CalcEACTotalPrice)
                  {
                       ApplicationArea = All;
                      Caption = 'EAC (Total Price)';
                      ToolTip = 'Specifies the estimate at completion (EAC) total price for a job task line. If the Apply Usage Link check box on the job is selected, then the EAC (Total Price) field is calculated as follows:';
                      Visible = false;
                  }*/
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension value code that the job task is linked to. You cannot change the code because the entry has been posted.';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension value code that the job task is linked to. You cannot change the code because the entry has been posted.';
                    Visible = false;
                }
                field("Outstanding Orders"; Rec."Outstanding Orders")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the sum of outstanding orders, in local currency, for this job task. The value of the Outstanding Amount (LCY) field is used for entries in the Purchase Line table of document type Order to calculate and update the contents of this field.';
                    //     Visible = false;

                    trigger OnDrillDown()
                    var
                        PurchLine: Record "Purchase Line";
                    begin
                        JobTaskLines.SetPurchLineFilters(PurchLine);
                        PurchLine.SETFILTER("Outstanding Amount (LCY)", '<> 0');
                        PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
                    end;
                }/*
                   field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
                   {
                        ApplicationArea = All;
                       Editable = false;
                       ToolTip = 'Specifies the sum, in the local currency, for items that you have received but have not yet been invoiced. The value in the Amt. Rcd. Not Invoiced (LCY) field is used for entries in the Purchase Line table of document type Order to calculate and update the contents of this field.';
                       Visible = false;

                       trigger OnDrillDown()
                       var
                           PurchLine: Record "Purchase Line";
                       begin
                           JobTaskLines.SetPurchLineFilters(PurchLine);
                           PurchLine.SETFILTER("Amt. Rcd. Not Invoiced (LCY)", '<> 0');
                           PAGE.RUNMODAL(PAGE::"Purchase Lines", PurchLine);
                       end;
                   }*///EDM.AI-UPBudget
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        PostingBudget := (Rec."Job Task Type" = "Job Task Type"::Posting);
        Rec.CALCFIELDS("Currency Code");
        BudgetCurrency := Rec."Currency Code";
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.UpdateBudgetValues(Rec, TRUE);
    end;

    var
        [InDataSet]
        StyleIsStrong: Boolean;
        JobTaskLines: Page "Job Task Lines";
        PostingBudget: Boolean;
        //    BudgetEvents: Codeunit "Budget Subscriber Events";
        BudgetCurrency: Code[10];
        DimensionValue: Record "Dimension Value";
}

