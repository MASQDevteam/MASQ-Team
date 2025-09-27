codeunit 70116 "Custom Workflow PaymentLine"
//FQ MASQ Start
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowMgt.CanExecuteWorkflow(RecRef, GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure GetWorkflowCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ' '));
    end;


    [IntegrationEvent(false, false)]
    procedure OnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    // Add events to the library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::"Payment Line");
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), Database::"Payment Line",
          GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), DATABASE::"Payment Line",
          GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);
    end;
    // subscribe

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow PaymentLine", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow PaymentLine", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;

    // handle the document;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        CustomWorkflowHdr: Record "Payment Line";
    begin
        case RecRef.Number of
            Database::"Payment Line":
                begin
                    RecRef.SetTable(CustomWorkflowHdr);
                    CustomWorkflowHdr.Validate("Payment Status", CustomWorkflowHdr."Payment Status"::"Pending Approval");
                    CustomWorkflowHdr.Modify(true);
                    Variant := CustomWorkflowHdr;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        CustomWorkflowHdr: Record "Payment Line";
    begin
        case RecRef.Number of
            DataBase::"Payment Line":
                begin
                    RecRef.SetTable(CustomWorkflowHdr);
                    ApprovalEntryArgument."Document No." := CustomWorkflowHdr.Number;

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CustomWorkflowHdr: Record "Payment Line";
    begin
        case RecRef.Number of
            DataBase::"Payment Line":
                begin
                    RecRef.SetTable(CustomWorkflowHdr);
                    CustomWorkflowHdr.Validate("Payment Status", CustomWorkflowHdr."Payment Status"::Released);
                    CustomWorkflowHdr.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    //NB MASQ Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        RfpLine: Record "Payment Line"; // PK = Number, Line No.
        PaymentLine: Record "Payment Line"; //NB MASQ
    begin
        if not RecRef.Get(ApprovalEntry."Record ID to Approve") then
            exit;

        if RecRef.Number <> Database::"Payment Line" then
            exit;

        RecRef.SetTable(RfpLine); // This will hydrate Number + Line No from the RecordRef
        if RfpLine."Payment Status" <> RfpLine."Payment Status"::Declined then begin

            PaymentLine.Reset();
            PaymentLine.SetRange(Number, RfpLine.Number);
            PaymentLine.SetRange("Payment Status", PaymentLine."Payment Status"::Released);
            PaymentLine.SetFilter("Line No", '<>%1', RfpLine."Line No");
            if PaymentLine.FindFirst() then
                Error('You can not declined this RFP as payment %1 is alreday done', PaymentLine."Payment Value");

            RfpLine.Validate("Payment Status", RfpLine."Payment Status"::Declined);
            RfpLine.Validate(Comment, 'Declined by ' + UserId + ' for payment value ' + Format(RfpLine."Payment Value"));
            RfpLine.Validate("Payment Value", 0);
            RfpLine.Modify(true);
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnCancelApprovalRequestsForRecordOnAfterCreateApprovalEntryNotification, '', false, false)]
    // local procedure OnCancelApprovalRequestsForRecordOnAfterCreateApprovalEntryNotification(var ApprovalEntry: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance"; OldStatus: Enum "Approval Status")
    // var
    //     RecRef: RecordRef;
    //     RfpLine: Record "Payment Line"; // PK = Number, Line No.
    // begin
    //     if not RecRef.Get(ApprovalEntry."Record ID to Approve") then
    //         exit;

    //     if RecRef.Number <> Database::"Payment Line" then
    //         exit;

    //     RecRef.SetTable(RfpLine); // This will hydrate Number + Line No from the RecordRef
    //     if RfpLine."Payment Status" <> RfpLine."Payment Status"::Open then begin
    //         RfpLine.Validate("Payment Status", RfpLine."Payment Status"::Open);
    //         RfpLine.Modify(true);
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CustomWorkflowHdr: Record "Payment Line";
    begin
        case RecRef.Number of
            Database::"Payment Line":
                begin
                    RecRef.SetTable(CustomWorkflowHdr);
                    CustomWorkflowHdr.Validate("Payment Status", CustomWorkflowHdr."Payment Status"::Open);
                    CustomWorkflowHdr.Modify(true);
                    Handled := true;
                end;
        end;
    end;
    //NB MASQ End

    //==========================================

    /*   [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
      local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
      var
      begin

      end; */

    //FQ MASQ End
    var

        WorkflowMgt: Codeunit "Workflow Management";

        RUNWORKFLOWONSENDFORAPPROVALCODE: Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE: Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt: Label 'Approval of %1 is requested Payment Line.';
        WorkflowCancelForApprovalEventDescTxt: Label 'Approval of %1 is canceled Payment Line.';


}