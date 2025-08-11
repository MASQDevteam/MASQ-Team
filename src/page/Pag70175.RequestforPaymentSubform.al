
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
                field("Payment Value"; Rec."Payment Value")
                {
                    ToolTip = 'Specifies the value of the Payment Value field.', Comment = '%';
                }
                field("Payment %"; Rec."Payment %")
                {
                    ToolTip = 'Specifies the value of the Payment % field.', Comment = '%';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Payment Date field.', Comment = '%';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.', Comment = '%';
                }
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
                begin
                    //  PurchReqWorkFlowFunctions.ChangePurchReqStatus(Rec);//EDM.YEHYA+-
                    Rec.TESTFIELD("Payment Status", Rec."Payment Status"::Open);
                    // Rec.CheckPayments();
                    //EDM
                    // RequestLine.SETRANGE("Document No.", Rec."No.");
                    //  IF NOT RequestLine.FINDFIRST THEN
                    //     ERROR('You have to enter your request description in the purchase request line to send approval request');
                    //EDM
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Suite;
                Caption = 'Cancel Approval Re&quest';
                // Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Enabled = (Rec."Payment Status" = Rec."Payment Status"::"Pending Approval");

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Sub: Codeunit "Travel Req. WorkFlow Functions";
                begin
                    Rec.TESTFIELD("Payment Status", Rec."Payment Status"::"Pending Approval");

                    // Sub.OnCancelPurchaseReqApprovalRequest(Rec);
                    Rec."Payment Status" := Rec."Payment Status"::Open;//to be removed
                end;
            }
            action("Send to Payment journal")
            {
                ApplicationArea = All;
                Image = Journals;
                //Enabled = ((Rec."RFP Type" = Rec."RFP Type"::"Supplier payment") and (REc.Executed = true));
                // trigger OnAction()
                // begin
                //     Rec.TestField("Sent to journals", false);
                //     Rec.TestField(Supplier);
                //     Rec.TestField("Bank Number");
                //     Rec.SendtoPaymentJournal();
                //     Rec."Sent to journals" := true;
                // end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
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
        end;
    end;

    trigger OnOpenPage()//to be removed
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
    end;

}
