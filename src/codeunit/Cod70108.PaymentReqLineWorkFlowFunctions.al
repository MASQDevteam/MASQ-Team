codeunit 70115 "PaymentRLineWorkFlowFunctions"
{
    // Workflow Functions for Purchase Request Object

    Permissions = TableData 91 = rimd,
                  TableData 454 = rimd,
                  TableData 70139 = rimd,
                  TableData 2000000068 = rimd;

    trigger OnRun()
    var
        Detailedvendor: Record "Detailed Vendor Ledg. Entry";
    begin
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";

    local procedure PaymentReqAppCode1(): Code[128]//Response
    begin
        EXIT(UPPERCASE('PaymentReqRes'));
    end;



    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]//add Response library
    local procedure PaymentReqAppAdd1()
    var
        Resptxt: Label 'Change "Payment Status" of the Payment Line Request';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(PaymentReqAppCode1, 70139, Resptxt, 'Group 0');
    end;

    local procedure PaymentReqCancelCode1(): Code[128]//Response
    begin
        EXIT(UPPERCASE('PaymentReqCancel'));
    end;



    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]//add Response library
    local procedure PaymentReqCancel1()
    var
        Resptxt: Label 'Change "Payment Status" of the Payment Line Request Cancel';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(PaymentReqCancelCode1, 70139, Resptxt, 'Group 2');
    end;

    local procedure PaymentReqRejectCode1(): Code[128]//Response
    begin
        EXIT(UPPERCASE('PaymentReqResReject'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]//add Response library
    local procedure PaymentReqAppAddReject1()
    var
        Resptxt: Label 'Change "Payment Status" of the Payment Line Request Reject';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(PaymentReqRejectCode1, 70139, Resptxt, 'Group 0');
    end;

    local procedure PaymentReqApprovedCode1(): Code[128]//Response
    begin
        EXIT(UPPERCASE('PaymentReqResApproved'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]//add Response library
    local procedure PaymentReqApprovedAdd1()
    var
        Resptxt: Label 'Change "Payment Status" of the Payment Line Request Approved';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(PaymentReqApprovedCode1, 70139, Resptxt, 'Group 0');
    end;

    local procedure PaymentReqSendEmailCode1(): Code[128]//Response
    begin
        EXIT(UPPERCASE('PaymentReqSendEmailRes'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]//add Response library
    local procedure PaymentReqSendEmailAdd1()
    var
        Resptxt: Label 'Send Email to Approver Payment Line Request';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(PaymentReqSendEmailCode1, 70139, Resptxt, 'Group 0');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]//to be removed
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        PaymentRequest: Record "Payment Line";
    begin
        case RecRef.Number of
            DATABASE::"Payment Line":
                begin
                    RecRef.SetTable(PaymentRequest);
                    PaymentRequest.Validate("Payment Status", PaymentRequest."Payment Status"::"Pending Approval");
                    PaymentRequest.Modify(true);
                    Variant := PaymentRequest;
                    IsHandled := true;
                    Message('Pending Approval1');
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, OnExecuteWorkflowResponse, '', false, false)]//execute the Response WHAT TO DO
    local procedure PurchReqAppRes(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
        Admin: Record "User Setup";
        ReqNo: Code[50];
        Request: Code[50];
        Appentry: Record "Approval Entry";
        PRref: RecordRef;
        PaymentRequest: Record "Payment Line";
        ApprovalEntry: Record "Approval Entry";
        MASQEmail: Codeunit "MASQ Email";
        User: Record User;
        ApprovalEntry2: Record "Approval Entry";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            CASE WorkflowResponse."Function Name" OF
                PaymentReqAppCode1://Response
                    BEGIN
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            PaymentRequest.GET(PRref.RECORDID);
                        PaymentRequest."Payment Status" := PaymentRequest."Payment Status"::"Pending Approval";
                        PaymentRequest.Modify();
                        ResponseExecuted := true;
                        Message('Pending Approval2');
                    END;
                PaymentReqCancelCode1()://Response
                    BEGIN
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            PaymentRequest.GET(PRref.RECORDID);
                        PaymentRequest."Payment Status" := PaymentRequest."Payment Status"::Open;
                        PaymentRequest.Modify();
                        ResponseExecuted := true;
                    END;
                PaymentReqRejectCode1(): //Response
                    BEGIN
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            ApprovalEntry.GET(PRref.RECORDID);
                        PaymentRequest.Reset();
                        PaymentRequest.Get(ApprovalEntry."Document No.");
                        PaymentRequest."Payment Status" := PaymentRequest."Payment Status"::Declined;
                        PaymentRequest.Modify();
                        ResponseExecuted := true;
                    END;
                PaymentReqApprovedCode1(): //Response
                    BEGIN
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            ApprovalEntry.GET(PRref.RECORDID);
                        PaymentRequest.Reset();
                        PaymentRequest.Get(ApprovalEntry."Document No.");
                        PaymentRequest."Payment Status" := PaymentRequest."Payment Status"::Released;
                        PaymentRequest.Modify();
                        ResponseExecuted := true;
                    END;
                PaymentReqSendEmailCode1(): //Response
                    begin
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            PaymentRequest.GET(PRref.RECORDID);
                        Clear(ApprovalEntry2);
                        ApprovalEntry2.SetRange("Document No.", PaymentRequest.Number);
                        ApprovalEntry2.SetFilter(Status, '<> %1', ApprovalEntry2.Status::Canceled);
                        IF ApprovalEntry2.FindSet() then
                            repeat
                                Clear(User);
                                User.SetRange("User Name", ApprovalEntry2."Approver ID");
                                User.FindFirst();
                                MASQEmail.SendEmailPaymentRequest(User, PaymentRequest, ApprovalEntry2);//SendEmail
                            until ApprovalEntry2.Next() = 0;
                        ResponseExecuted := true;
                    end;
            END;
    end;

    local procedure PaymentReqNotifyCode1(): Code[128]//Response
    begin
        EXIT(UPPERCASE('NotifyApp'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]//add Response library
    local procedure PurchReqNotifyAdd1()
    var
        Resptxt: Label 'Notify Approver';
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        workflowresponsehandling.AddResponseToLibrary(PaymentReqNotifyCode1, 454, Resptxt, 'Group 0');
    end;


    local procedure RunWorkflowOnSendPaymentReqForApprovalCode1(): Code[128]//Event
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendPaymentReqForApprovalCode'));
    end;

    [EventSubscriber(ObjectType::Page, 70175, 'OnAfterActionEvent', 'Send Approval Request', false, false)]//Handle the Event
    local procedure RPurchAppEvent(var Rec: Record "Payment Line")
    var
        WorkflowManagment: Codeunit "Workflow Management";
        Appentry: Record "Approval Entry";
        // PReqH: Record "Purch. Request Header";
        Request: Code[50];
        Admin: Record "User Setup";
    begin
        WorkflowManagment.HandleEvent(RunWorkflowOnSendPaymentReqForApprovalCode1(), Rec);
        Message('Sent');
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Events to library
    local procedure RPurchAppAdd()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        EventText: Label 'Payment Line Request, Ask For Approval';//Changed event name 
        PurchaseReqApprReqCancelledEventDescTxt: Label 'An Approval Request for Payment Line Request is Canceled';//Changed event name 
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPaymentReqForApprovalCode1, 70139, EventText, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPaymentReqApprovalRequestCode1, DATABASE::"Payment Line",
          PurchaseReqApprReqCancelledEventDescTxt, 0, FALSE);
    end;

    local procedure SetAppCode1(): Code[128]//Response
    begin
        EXIT(UPPERCASE('SetAppRes'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]//add Response to library
    local procedure SetAppAdd1()
    var
        Resptxt: Label 'Set the Approver';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetAppCode1, 91, Resptxt, 'Group 0');
    end;



    local procedure RunWorkflowOnCancelPaymentReqApprovalRequestCode1(): Code[128]//Event
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelPaymentReqApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Page, 70175, 'OnAfterActionEvent', 'CancelApprovalRequest', false, false)]
    local procedure PurchaseReqPageOnCancelApprovalRequestAction(var Rec: Record "Payment Line")//Handle the Event
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentReqApprovalRequestCode1, Rec);
    end;

    //To register workflow event/response combinations needed for the new workflow response
    /*
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddMyworkflowEventOnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        MyWorkflowEvents: Codeunit MyWorkflowEvents;
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        Case ResponseFunctionName of
            MyWorkflowResponseCode():
                WorkflowResponseHandling.AddResponsePredecessor(MyWorkflowResponseCode(), MyWorkflowEvents.MyWorkflowEventCode());
        End

        //MyWorkflowResponseCode new reponse
        // MyWorkflowEvents.MyWorkflowEventCode() new event
    end;*/
    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    //  JrnlExpWorkflowFunctions: Codeunit "Jrnl. Exp. Workflow Functions";
    begin
        //Workflow Event/Response Combinations page on BC  manuall to link the event and response in BC
        CASE ResponseFunctionName OF
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                BEGIN

                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, RunWorkflowOnSendPaymentReqForApprovalCode1);
                    //EDM.PayReq-
                END;
            WorkflowResponseHandling.CreateApprovalRequestsCode://response
                BEGIN
                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, RunWorkflowOnSendPaymentReqForApprovalCode1);//1 is response 2 is event
                    //EDM.PayReq-
                END;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                BEGIN
                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnSendPaymentReqForApprovalCode1);
                    //EDM.PayReq-
                END;
            WorkflowResponseHandling.OpenDocumentCode:
                BEGIN
                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, RunWorkflowOnCancelPaymentReqApprovalRequestCode1());
                    //EDM.PayReq-
                END;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                BEGIN
                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, RunWorkflowOnCancelPaymentReqApprovalRequestCode1());
                    //EDM.PayReq-
                END;
            PaymentReqAppCode1():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(PaymentReqAppCode1(), RunWorkflowOnSendPaymentReqForApprovalCode1());
                    WorkflowResponseHandling.AddResponsePredecessor(PaymentReqAppCode1(), WorkflowResponseHandling.CreateApprovalRequestsCode());

                end;
            PaymentReqCancelCode1():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(PaymentReqCancelCode1(), RunWorkflowOnCancelPaymentReqApprovalRequestCode1());
                end;
            PaymentReqRejectCode1():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(PaymentReqRejectCode1(), WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode());
                end;
            PaymentReqApprovedCode1():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(PaymentReqApprovedCode1(), WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode());
                end;
            PaymentReqSendEmailCode1():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(PaymentReqSendEmailCode1(), RunWorkflowOnSendPaymentReqForApprovalCode1());
                end;
            WorkflowResponseHandling.CreateApprovalRequestsCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode(), RunWorkflowOnSendPaymentReqForApprovalCode1());

                end;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), RunWorkflowOnSendPaymentReqForApprovalCode1());

                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), RunWorkflowOnCancelPaymentReqApprovalRequestCode1());
                end;
            WorkflowResponseHandling.OpenDocumentCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), RunWorkflowOnCancelPaymentReqApprovalRequestCode1());
                end;



        END;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]//add relation with other table new table --> approval entry relation cane be done mnanuale from BC
    local procedure AddWorkflowTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(Database::"Payment Line", 1, Database::"Approval Entry", 22);//link the pk to approval entry
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]// add the event predecessor to the event
    local procedure AddWorkflowEventHierarchiesToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: codeunit "Workflow Event Handling";
    begin
        Case EventFunctionName of
            // RunWorkflowOnSendPaymentReqForApprovalCode1():
            //     begin
            //         //WorkflowEventHandling.AddEventPredecessor(MyWorkflowEventCode(), WorkflowEventHandling./*[Add your predecessor event code]*/);
            //         WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnSendPaymentReqForApprovalCode1(), WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode());
            //         WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnSendPaymentReqForApprovalCode1(), WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode());
            //         WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnSendPaymentReqForApprovalCode1(), WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode());
            //     end;
            // RunWorkflowOnCancelPaymentReqApprovalRequestCode():
            //     BEGIN
            //         WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelPaymentReqApprovalRequestCode(), WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode());
            //         WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnSendPaymentReqForApprovalCode1(), WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode());
            //         WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnSendPaymentReqForApprovalCode1(), WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode());
            //     END;

            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode():
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendPaymentReqForApprovalCode1());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnCancelPaymentReqApprovalRequestCode1());
                end;

            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode():
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendPaymentReqForApprovalCode1());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnCancelPaymentReqApprovalRequestCode1());
                end;


            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode():
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendPaymentReqForApprovalCode1());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnCancelPaymentReqApprovalRequestCode1());
                end;

            RunWorkflowOnCancelPaymentReqApprovalRequestCode1():
                begin
                    WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelPaymentReqApprovalRequestCode1(), RunWorkflowOnSendPaymentReqForApprovalCode1());

                end;

        End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]//needed in case we have an error in BC the Response for table x is not supported
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    begin
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]//needed in case we have an error in BC the Response for table x is not supported
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    begin
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        PaymentRequest: Record "Payment Line";
        Vendor: Record Vendor;
    begin
        //TRANSFER FIELDS
        case RecRef.Number of
            DATABASE::"Payment Line":
                begin
                    RecRef.SetTable(PaymentRequest);
                    ApprovalEntryArgument."Document No." := PaymentRequest.Number;
                    ApprovalEntryArgument.Amount := PaymentRequest."PO Value";

                    ApprovalEntryArgument."Currency Code" := PaymentRequest.Currency;
                    ApprovalEntryArgument."Supplier Number" := PaymentRequest.Supplier;
                    Clear(Vendor);
                    IF Vendor.Get(ApprovalEntryArgument."Supplier Number") then
                        ApprovalEntryArgument."Supplier Name" := Vendor.Name;

                    ApprovalEntryArgument."PO Number" := PaymentRequest."PO#";
                    ApprovalEntryArgument."Project Code" := PaymentRequest."Project Name";
                    ApprovalEntryArgument."RFP Line No." := PaymentRequest."Line No";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure OnBeforeApprovalEntryInsert(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepArgument: Record "Workflow Step Argument"; ApproverId: Code[50]; var IsHandled: Boolean)
    begin
        ApprovalEntry."Supplier Number" := ApprovalEntryArgument."Supplier Number";
        ApprovalEntry."Supplier Name" := ApprovalEntryArgument."Supplier Name";
        ApprovalEntry."PO Number" := ApprovalEntryArgument."PO Number";
        ApprovalEntry."Project Code" := ApprovalEntryArgument."Project Code";
        ApprovalEntry."RFP Line No." := ApprovalEntryArgument."RFP Line No.";
    end;
    //to send emails for senders of approvals upon creation approval reject on cancelation
    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCreateApprovalEntryNotification', '', false, false)]
     local procedure OnAfterCreateApprovalEntryNotification(var ApprovalEntryArgument: Record "Approval Entry"; var WorkflowStepArgument: Record "Workflow Step Argument")
     var
         NotificationEntry: Record "Notification Entry";
     begin
         if WorkflowStepArgument."Notify Sender" then
             NotificationEntry.CreateNotificationEntry(
                 NotificationEntry.Type::Approval, ApprovalEntryArgument."Sender ID",
                 ApprovalEntryArgument, WorkflowStepArgument."Link Target Page", WorkflowStepArgument."Custom Link", CopyStr(UserId(), 1, 50));

     end;*/


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCreateApprovalEntryNotification', '', false, false)]
    local procedure OnBeforeCreateApprovalEntryNotification(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean; WorkflowStepInstance: Record "Workflow Step Instance")
    begin
        IF ApprovalEntry."Table ID" = 70139 then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterModifyEvent', '', false, false)]//to be removed
    local procedure OnAfterModifyEvent(var Rec: record "Approval Entry"; var xRec: record "Approval Entry"; RunTrigger: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        Firstapproved: Boolean;
        secondApproved: Boolean;
        thirdCreated: Boolean;
        secondCreated: Boolean;
    begin
        Firstapproved := false;
        secondApproved := false;
        thirdCreated := false;
        secondCreated := false;

        Clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", 70139);
        ApprovalEntry.SetRange("Document No.", Rec."Document No.");
        if ApprovalEntry.FindSet() then
            repeat
                IF ApprovalEntry."Sequence No." = 1 then
                    IF ApprovalEntry.Status = ApprovalEntry.Status::Approved then
                        Firstapproved := true;

                IF ApprovalEntry."Sequence No." = 2 then
                    IF ApprovalEntry.Status = ApprovalEntry.Status::Approved then
                        secondApproved := true;

                IF ApprovalEntry."Sequence No." = 3 then
                    IF ApprovalEntry.Status = ApprovalEntry.Status::Created then
                        thirdCreated := true;

                IF Firstapproved and secondApproved and thirdCreated then
                    IF (ApprovalEntry."Sequence No." = 3) and (ApprovalEntry.Status = ApprovalEntry.Status::Created) then begin
                        ApprovalEntry.Status := ApprovalEntry.Status::Open;
                        ApprovalEntry.Modify();
                    end;


                IF ApprovalEntry."Sequence No." = 1 then
                    IF ApprovalEntry.Status = ApprovalEntry.Status::Approved then
                        Firstapproved := true;

                IF ApprovalEntry."Sequence No." = 2 then
                    IF ApprovalEntry.Status = ApprovalEntry.Status::Created then
                        secondCreated := true;

                IF ApprovalEntry."Sequence No." = 3 then
                    IF ApprovalEntry.Status = ApprovalEntry.Status::Created then
                        thirdCreated := true;


                IF Firstapproved and secondCreated and thirdCreated then
                    IF (ApprovalEntry."Sequence No." = 2) and (ApprovalEntry.Status = ApprovalEntry.Status::Created) then begin
                        ApprovalEntry.Status := ApprovalEntry.Status::Open;
                        ApprovalEntry.Modify();
                    end;

            until ApprovalEntry.Next() = 0;
    end;

    procedure LogDebug(TextToLog: Text)
    begin
        Message('DEBUG: %1', TextToLog);
    end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnEvaluateEventCondition', '', false, false)]
    // local procedure OnEvaluateEventCondition(EventFunctionName: Code[128]; var RecRef: RecordRef; var IsConditionMet: Boolean; WorkflowStepInstance: Record "Workflow Step Instance")
    // var
    //     PaymentLine: Record "Payment Line";
    //     Vendor: Record Vendor;
    // begin
    //     // Optional: narrow down to your specific workflow event
    //     if EventFunctionName <> RunWorkflowOnSendPaymentReqForApprovalCode1() then
    //         exit;

    //     // Make sure record type is correct
    //     if RecRef.Number <> DATABASE::"Payment Line" then
    //         exit;

    //     // Get the Payment Line
    //     RecRef.SetTable(PaymentLine);

    //     // Example: read related vendor record
    //     if Vendor.Get(PaymentLine."Supplier") then begin
    //         if Vendor."Blocked" = Vendor."Blocked"::All then begin
    //             // Reject the workflow condition if vendor is blocked
    //             IsConditionMet := false;
    //             exit;
    //         end;
    //     end;

    //     // All custom checks passed
    //     IsConditionMet := true;
    // end;


}

