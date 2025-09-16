
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
                field("Payment Status"; Rec."Payment Status")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.', Comment = '%';
                    StyleExpr = PaymentApprovalStatus;
                }

                //NB MASQ Start
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
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
                    //  PurchReqWorkFlowFunctions.ChangePurchReqStatus(Rec);//EDM.YEHYA+-
                    //  Rec.TESTFIELD("Payment Status", Rec."Payment Status"::Open);
                    // Rec.CheckPayments();
                    //EDM
                    // RequestLine.SETRANGE("Document No.", Rec."No.");
                    //  IF NOT RequestLine.FINDFIRST THEN
                    //     ERROR('You have to enter your request description in the purchase request line to send approval request');
                    //EDM

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
                    //Rec.TESTFIELD("Payment Status", Rec."Payment Status"::"Pending Approval");
                    // Sub.OnCancelPurchaseReqApprovalRequest(Rec);
                    //Rec."Payment Status" := Rec."Payment Status"::Open;//to be removed
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
        //     SUPPLIERPAYMENTREQUEST: Record "SUPPLIER PAYMENT REQUEST";
        UserSetup: Record "User Setup"; //NB MASQ
    begin
        //     if SUPPLIERPAYMENTREQUEST.Get(Rec.Number) then begin
        //         Rec.Currency := SUPPLIERPAYMENTREQUEST.Currency;
        //         Rec.Supplier := SUPPLIERPAYMENTREQUEST.Supplier;
        //         Rec."PO#" := SUPPLIERPAYMENTREQUEST."PO#";
        //         Rec."PO Value" := SUPPLIERPAYMENTREQUEST."PO Value";
        //         Rec."Level of Urgency" := SUPPLIERPAYMENTREQUEST."Level of Urgency";
        //         Rec."Project Name" := SUPPLIERPAYMENTREQUEST."Project Name";
        //         Rec."Requested By (Person)" := SUPPLIERPAYMENTREQUEST."Requested By (Person)";
        //     end;

        /*  OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
         CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
         HasApprovalEntries := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId); */

        //NB MASQ Start
        UserSetup.Get(UserId);
        if UserSetup."Edit Payment Line" then
            EditLine := true
        else
            EditLine := false;
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
            Rec."Project Name" := SUPPLIERPAYMENTREQUEST."Project Name";
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

    //NB MASQ Start
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        PaymentLine: Record "Payment Line";
    begin
        // PaymentLine.Reset();
        // PaymentLine.SetRange(Number, Rec.Number);
        // if PaymentLine.FindSet() then begin
        //     PaymentLine.CalcSums("Payment Value");
        //     if PaymentLine."Payment Value" <> Rec."PO Value" then
        //         Error('Sum of Payments must be equal to the PO Value');
        // end;
    end;
    //NB MASQ End

    /*  trigger OnOpenPage()//to be removed
     var
         UserSetup: Record "User Setup";
         ApprovedEntries: Record "Approval Entry";
         CancelledEntries: Record "Approval Entry";
         RejectedEntries: Record "Approval Entry";
         AllApprovalEntries: Record "Approval Entry";

         PurchaseOrder: Record "Purchase Header";
         POEnum: Enum "Purchase Document Type";
     begin
         Clear(ApprovedEntries);
         ApprovedEntries.SetRange("Document No.", Rec.Number);
         ApprovedEntries.SetRange("RFP Line No.", Rec."Line No");
         ApprovedEntries.SetRange(Status, ApprovedEntries.Status::Approved);
         ApprovedEntries.SetRange("Pending Approvals", 0);
         IF ApprovedEntries.FindFirst() then begin
             Rec."Payment Status" := Rec."Payment Status"::Released;
             Rec.Modify();
         end;

         Clear(CancelledEntries);
         CancelledEntries.SetRange("Document No.", Rec.Number);
         ApprovedEntries.SetRange("RFP Line No.", Rec."Line No");
         CancelledEntries.SetRange(Status, CancelledEntries.Status::Canceled);
         IF CancelledEntries.FindFirst() then begin

             Clear(AllApprovalEntries);
             AllApprovalEntries.SetRange("Document No.", Rec.Number);

             Clear(CancelledEntries);
             CancelledEntries.SetRange("Document No.", Rec.Number);
             ApprovedEntries.SetRange("RFP Line No.", Rec."Line No");
             CancelledEntries.SetRange(Status, CancelledEntries.Status::Canceled);
             IF AllApprovalEntries.Count = CancelledEntries.Count then begin
                 Rec."Payment Status" := Rec."Payment Status"::Open;
                 Rec.Modify();
             end;
         end;

         Clear(RejectedEntries);
         RejectedEntries.SetRange("Document No.", Rec.Number);
         ApprovedEntries.SetRange("RFP Line No.", Rec."Line No");
         RejectedEntries.SetRange(Status, RejectedEntries.Status::Rejected);
         IF RejectedEntries.FindFirst() then begin
             Rec."Payment Status" := Rec."Payment Status"::Declined;
             Rec.Modify();
         end;
     end; */




    /* local procedure GetCurrentlySelectedLines(var PaymentLines: Record "Payment Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(PaymentLines);
        PaymentLines.SetFilter("Payment Status", '%1', PaymentLines."Payment Status"::Open);
        exit(PaymentLines.FindSet());
    end; */

    var
        customWorkMgmt: Codeunit "Custom Workflow PaymentLine";
        OpenApprovalEntriesExistCurrUser,
        OpenApprovalEntriesExist, CanCancelApprovalForRecord, ShowWorkflowStatus
        , StatusEdit, HasApprovalEntries : Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PaymentApprovalStatus: Text;
        PaymentLineStatus: Codeunit StatusColorChange;
        EditLine: Boolean;
}
