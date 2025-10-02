
page 70175 "Request for Payment Subform"
{
    ApplicationArea = All;
    Caption = 'Request for Payment Subform';
    PageType = ListPart;
    SourceTable = "Payment Line";
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Payment Date field.', Comment = '%';
                    //NB MASQ Start
                    Editable = (Rec."Payment Status" = Rec."Payment Status"::Open) or (EditLine and (Rec."Payment Status" = Rec."Payment Status"::Released));
                    //NB MASQ End
                }
                field("Payment Value"; Rec."Payment Value")
                {
                    ToolTip = 'Specifies the value of the Payment Value field.', Comment = '%';
                    //NB MASQ Start
                    Editable = (Rec."Payment Status" = Rec."Payment Status"::Open) or (EditLine and (Rec."Payment Status" = Rec."Payment Status"::Released));
                    //NB MASQ End
                }
                field("Payment %"; Rec."Payment %")
                {
                    ToolTip = 'Specifies the value of the Payment % field.', Comment = '%';
                }
                field("Payment Status"; Rec."Payment Status") //NB MASQ
                {
                    ApplicationArea = All;
                }
                //NB MASQ Start 30-Sep-25
                field("Level of Urgency"; Rec."Level of Urgency")
                {
                    ToolTip = 'Specifies the value of the Level of Urgency field.', Comment = '%';
                    StyleExpr = StyleExprText;
                }
                field("Reason For Transfer"; Rec."Reason For Transfer")
                {
                    ToolTip = 'Specifies the value of the Reason For Transfer field.', Comment = '%';
                }
                field(Production; Rec.Production)
                {
                    ApplicationArea = All;
                }
                field("Procurment Status"; Rec."Procurment Status")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.', Comment = '%';
                    StyleExpr = PaymentApprovalStatus;
                }
                field("Finance Status"; Rec."Finance Status")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.', Comment = '%';
                    StyleExpr = PaymentApprovalStatus;
                }
                field("Expected Execution Date"; Rec."Expected Execution Date") //NB MASQ
                {
                    ApplicationArea = All;
                }
                field("Accounting Status"; Rec."Accounting Status")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.', Comment = '%';
                    StyleExpr = PaymentApprovalStatus;
                }
                field("Bank Number"; Rec."Bank Number")
                {
                    ToolTip = 'Specifies the value of the Bank Number field.', Comment = '%';
                }
                //NB MASQ Start
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                //NB MASQ End 30-Sep-25
                field("Payment Method"; Rec."Payment Method")
                {
                    ToolTip = 'Specifies the value of the Payment Method field.', Comment = '%';
                }
                //NB MASQ End
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Enabled = (Rec."Payment Status" = Rec."Payment Status"::Open);
                trigger OnAction()
                var
                    PurchReqWorkFlowFunctions: Codeunit "Travel Req. WorkFlow Functions";
                    RecRef: RecordRef;
                    productionBom: page "Production BOM";
                begin
                    RecRef.GetTable(Rec);
                    if customWorkMgmt.CheckApprovalsWorkflowEnabled(RecRef) then
                        customWorkMgmt.OnSendWorkFlowForApproval(RecRef);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                ToolTip = 'Cancel the approval request.';
                //NB MASQ Start
                Enabled = (Rec."Payment Status" = Rec."Payment Status"::"Pending Approval") or
                        ((Rec."Payment Status" = Rec."Payment Status"::Released) and (Rec."Sent to journals" = false));
                //NB MASQ End
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Sub: Codeunit "Travel Req. WorkFlow Functions";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    customWorkMgmt.OnCancelWorkFlowForApproval(RecRef);
                end;
            }
            //NB MASQ Start
            action("Send to Payment journal")
            {
                ApplicationArea = All;
                Image = Journals;
                Enabled = (Rec."RFP Type" = Rec."RFP Type"::"Supplier payment") And (Rec.Executed = true);
                trigger OnAction()
                begin
                    Rec.TestField("Sent to journals", false);
                    Rec.TestField(Supplier);
                    Rec.TestField("Bank Number");
                    Rec.SendtoPaymentJournal();
                    Rec."Sent to journals" := true;
                end;
            }
            //NB MASQ End
        }
    }

    //NB MASQ Start
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if UserSetup."Edit Payment Line" then
            EditLine := true
        else
            EditLine := false;
    end;
    //NB MASQ End

    trigger OnAfterGetCurrRecord()
    var
        UserSetup: Record "User Setup"; //NB MASQ
        PaymentLine: Record "Payment Line";
        SUPPLIERPAYMENTREQUEST: Record "SUPPLIER PAYMENT REQUEST";
        TotalPayValue: Decimal;
    begin
        //NB MASQ Start
        UserSetup.Get(UserId);
        if UserSetup."Edit Payment Line" then
            EditLine := true
        else
            EditLine := false;

        if SUPPLIERPAYMENTREQUEST.Get(Rec.Number) then begin
            PaymentLine.Reset();
            PaymentLine.SetRange(Number, Rec.Number);
            PaymentLine.SetRange("Payment Status", PaymentLine."Payment Status"::Released);
            if PaymentLine.FindSet() then
                repeat
                    TotalPayValue += PaymentLine."Payment Value";
                until PaymentLine.Next() = 0;

            if TotalPayValue = SUPPLIERPAYMENTREQUEST."PO Value" then begin
                SUPPLIERPAYMENTREQUEST.Validate(Status, SUPPLIERPAYMENTREQUEST.Status::Paid);
                SUPPLIERPAYMENTREQUEST.Modify(true);
            end;
        end;
        //NB MASQ End

        PaymentApprovalStatus := PaymentLineStatus.ChangeColorBasedonCustomStatusPaymentLine(rec);
        CurrPage.Update(false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        SUPPLIERPAYMENTREQUEST: Record "SUPPLIER PAYMENT REQUEST";
    begin
        if SUPPLIERPAYMENTREQUEST.Get(Rec.Number) then begin
            Rec.Currency := SUPPLIERPAYMENTREQUEST.Currency;
            Rec.Supplier := SUPPLIERPAYMENTREQUEST.Supplier;
            Rec."PO#" := SUPPLIERPAYMENTREQUEST."PO#";
            Rec."PO Value" := SUPPLIERPAYMENTREQUEST."PO Value";
            Rec."Level of Urgency" := SUPPLIERPAYMENTREQUEST."Level of Urgency";
            Rec."Project Name" := SUPPLIERPAYMENTREQUEST.Project; //NB MASQ
            Rec."Requested By (Person)" := SUPPLIERPAYMENTREQUEST."Requested By (Person)";

            //NB MASQ Start
            Rec."Bank Number" := SUPPLIERPAYMENTREQUEST."Bank Number";
            Rec.Executed := SUPPLIERPAYMENTREQUEST.Executed;
            Rec.Branch := SUPPLIERPAYMENTREQUEST.Branch;
            Rec."Payment Terms" := SUPPLIERPAYMENTREQUEST."Payment Terms";
            Rec."Payment Method" := SUPPLIERPAYMENTREQUEST."Payment Method";
            Rec."Requested By / Department" := SUPPLIERPAYMENTREQUEST."Requested By / Department";
            //NB MASQ End
        end;
    end;
    //NB MASQ Start 30-Sep-25
    procedure ChangeUrgencyColor()
    var
    begin
        //TRANSFER FIELDS
        case Rec."Level of Urgency" of
        // rec."Level of Urgency"::"1. Critical":
        //     begin
        //         StyleExprText := 'Unfavorable';
        //     end;
        // rec."Level of Urgency"::"2. Major":
        //     begin
        //         StyleExprText := 'Ambiguous';
        //     end;
        // rec."Level of Urgency"::"3. Medium":
        //     begin
        //         StyleExprText := 'Favorable';
        //     end;
        // rec."Level of Urgency"::"4. Minor":
        //     begin
        //         StyleExprText := 'StandardAccent';
        //     end;
        end;
    end;
    //NB MASQ End 30-Sep-25

    var
        customWorkMgmt: Codeunit "Custom Workflow PaymentLine";
        OpenApprovalEntriesExistCurrUser,
        OpenApprovalEntriesExist, CanCancelApprovalForRecord, ShowWorkflowStatus
        , StatusEdit, HasApprovalEntries : Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PaymentApprovalStatus: Text;
        PaymentLineStatus: Codeunit StatusColorChange;
        EditLine: Boolean;
        StyleExprText: Text; //NB MASQ
}
