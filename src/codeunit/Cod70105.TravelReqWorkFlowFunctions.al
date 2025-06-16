codeunit 70105 "Travel Req. WorkFlow Functions"
{
    // Workflow Functions for Purchase Request Object

    Permissions = TableData 91 = rimd,
                  TableData 454 = rimd,
                  TableData 70103 = rimd,
                  TableData 2000000068 = rimd;

    trigger OnRun()
    var
        Detailedvendor: Record "Detailed Vendor Ledg. Entry";
    begin
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";

    local procedure TravelReqAppCode(): Code[128]//Response
    begin
        EXIT(UPPERCASE('TravelReqRes'));
    end;



    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Response library
    local procedure TravelReqAppAdd()
    var
        Resptxt: Label 'Change Status of the Travel Request';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(TravelReqAppCode, 70103, Resptxt, 'Group 0');
    end;

    local procedure TravelReqCancelCode(): Code[128]//Response
    begin
        EXIT(UPPERCASE('TravelReqCancel'));
    end;



    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Response library
    local procedure TravelReqCancel()
    var
        Resptxt: Label 'Change Status of the Travel Request Cancel';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(TravelReqCancelCode, 70103, Resptxt, 'Group 2');
    end;

    local procedure TravelReqRejectCode(): Code[128]//Response
    begin
        EXIT(UPPERCASE('TravelReqResReject'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Response library
    local procedure TravelReqAppAddReject()
    var
        Resptxt: Label 'Change Status of the Travel Request Reject';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(TravelReqRejectCode, 70103, Resptxt, 'Group 0');
    end;

    local procedure TravelReqApprovedCode(): Code[128]//Response
    begin
        EXIT(UPPERCASE('TravelReqResApproved'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Response library
    local procedure TravelReqApprovedAdd()
    var
        Resptxt: Label 'Change Status of the Travel Request Approved';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(TravelReqApprovedCode, 70103, Resptxt, 'Group 0');
    end;

    local procedure TravelReqSendEmailCode(): Code[128]//Response
    begin
        EXIT(UPPERCASE('TravelReqSendEmailRes'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Response library
    local procedure TravelReqSendEmailAdd()
    var
        Resptxt: Label 'Send Email to Approver Travel Request';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(TravelReqSendEmailCode, 70103, Resptxt, 'Group 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnExecuteWorkflowResponse', '', false, false)]//execute the Response WHAT TO DO
    local procedure PurchReqAppRes(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
        Admin: Record "User Setup";
        ReqNo: Code[50];
        Request: Code[50];
        Appentry: Record "Approval Entry";
        PRref: RecordRef;
        TravelRequest: Record "Travel Request";
        ApprovalEntry: Record "Approval Entry";
        MASQEmail: Codeunit "MASQ Email";
        User: Record User;
        ApprovalEntry2: Record "Approval Entry";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            CASE WorkflowResponse."Function Name" OF
                TravelReqAppCode://Response
                    BEGIN

                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            TravelRequest.GET(PRref.RECORDID);
                        TravelRequest.Status := TravelRequest.Status::"Pending Approval";
                        TravelRequest.Modify();
                        ResponseExecuted := true;

                    END;
                TravelReqCancelCode()://Response
                    BEGIN
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            TravelRequest.GET(PRref.RECORDID);
                        TravelRequest.Status := TravelRequest.Status::Open;
                        TravelRequest.Modify();
                        ResponseExecuted := true;
                    END;
                TravelReqRejectCode(): //Response
                    BEGIN
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            ApprovalEntry.GET(PRref.RECORDID);
                        TravelRequest.Reset();
                        TravelRequest.Get(ApprovalEntry."Document No.");
                        TravelRequest.Status := TravelRequest.Status::Declined;
                        TravelRequest.Modify();
                        ResponseExecuted := true;
                    END;
                TravelReqApprovedCode(): //Response
                    BEGIN
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            ApprovalEntry.GET(PRref.RECORDID);
                        TravelRequest.Reset();
                        TravelRequest.Get(ApprovalEntry."Document No.");
                        TravelRequest.Status := TravelRequest.Status::Released;
                        TravelRequest.Modify();
                        ResponseExecuted := true;
                    END;
                TravelReqSendEmailCode(): //Response
                    begin
                        IF PRref.GET(ResponseWorkflowStepInstance."Record ID") THEN
                            TravelRequest.GET(PRref.RECORDID);
                        Clear(ApprovalEntry2);
                        ApprovalEntry2.SetRange("Document No.", TravelRequest.Number);
                        IF ApprovalEntry2.FindSet() then
                            repeat
                                Clear(User);
                                User.SetRange("User Name", ApprovalEntry2."Approver ID");
                                User.FindFirst();
                                MASQEmail.SendEmailTravelRequest(User, TravelRequest, ApprovalEntry2);//SendEmail
                            until ApprovalEntry2.Next() = 0;
                        ResponseExecuted := true;
                    end;
            END;
    end;

    local procedure TravelReqNotifyCode(): Code[128]//Response
    begin
        EXIT(UPPERCASE('NotifyApp'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Response library
    local procedure PurchReqNotifyAdd()
    var
        Resptxt: Label 'Notify the Approver';
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        workflowresponsehandling.AddResponseToLibrary(TravelReqNotifyCode, 454, Resptxt, 'Group 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnExecuteWorkflowResponse', '', false, false)]//Execute the Response
    local procedure PurchReqNotifyResponse(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
        AppEntry: Record "Approval Entry";
        AppP: Page "Requests to Approve";
        UID: Code[50];
        AppUS: Record "User Setup";
        DNO: Code[50];
        ntNo: Integer;
        // PRH: Record "Purch. Request Header";
        RecL: Record "Record Link";
        link: Label 'CRONUS International Ltd./Departments/Purchase/Order Processing/Requests to Approve';
        txtnoti: Label 'A Travel Request Approval sent from ';
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            CASE WorkflowResponse."Function Name" OF
                TravelReqNotifyCode:
                    BEGIN
                        /*     AppUS."User ID" := USERID;
                             AppUS.FIND('=');
                             IF NOT AppUS."Approval Administrator" THEN BEGIN
                                 IF RecL.FINDLAST THEN
                                     ntNo := RecL."Link ID"
                                 ELSE
                                     ntNo := 0;
                                 CLEAR(RecL);
                                 RecL."Link ID" := ntNo + 1;
                                 RecL."Record ID" := RecL.RECORDID;
                                 RecL.Description := txtnoti + AppUS."User ID";
                                 RecL.Type := RecL.Type::Link;
                                 RecL.Created := CURRENTDATETIME;
                                 RecL.URL1 := link;
                                 RecL."User ID" := AppUS."User ID";
                                 RecL.Notify := TRUE;
                                 RecL."To User ID" := AppUS."Approver ID";
                                 RecL.INSERT(TRUE);
                                 ResponseExecuted := TRUE;
                             END ELSE
                                 ResponseExecuted := TRUE;*/
                    END;
            END;
    end;

    local procedure RunWorkflowOnSendTravelReqForApprovalCode(): Code[128]//Event
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendTravelReqForApprovalCode'));
    end;

    [EventSubscriber(ObjectType::Page, 70104, 'OnAfterActionEvent', 'Send Approval Request', false, false)]//Handle the Event
    local procedure RPurchAppEvent(var Rec: Record "Travel Request")
    var
        WorkflowManagment: Codeunit "Workflow Management";
        Appentry: Record "Approval Entry";
        // PReqH: Record "Purch. Request Header";
        Request: Code[50];
        Admin: Record "User Setup";
    begin
        WorkflowManagment.HandleEvent(RunWorkflowOnSendTravelReqForApprovalCode(), Rec);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Events to library
    local procedure RPurchAppAdd()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        EventText: Label 'Travel Request, Ask For Approval';
        PurchaseReqApprReqCancelledEventDescTxt: Label 'An Approval Request for Travel Request is Canceled';
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTravelReqForApprovalCode, 70103, EventText, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTravelReqApprovalRequestCode, DATABASE::"Travel Request",
          PurchaseReqApprReqCancelledEventDescTxt, 0, FALSE);
    end;

    local procedure SetAppCode(): Code[128]//Response
    begin
        EXIT(UPPERCASE('SetAppRes'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]//add Response to library
    local procedure SetAppAdd()
    var
        Resptxt: Label 'Set Approver';
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetAppCode, 91, Resptxt, 'Group 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnExecuteWorkflowResponse', '', false, false)]//Execute the Response
    local procedure SetAppResponse(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
        Admin: Record "User Setup";
        //     PReqH: Record "Purch. Request Header";
        // PRH: Page "Purchase Request Card";
        ReqNo: Code[50];
        Request: Code[50];
        // PReqH1: Record "Purch. Request Header";
        Appentry: Record "Approval Entry";
        IUser: Code[50];
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            CASE WorkflowResponse."Function Name" OF
                SetAppCode:
                    BEGIN
                        /*  IUser := USERID;
                          Admin.SETRANGE("User ID", IUser);
                          IF Admin.FINDFIRST THEN BEGIN
                              IF Admin."Set Approver" THEN BEGIN
                                  Admin."Approver ID" := '';
                                  Admin.MODIFY;
                              END;
                          END;
                          ResponseExecuted := TRUE;*/
                    END;
            END;
    end;

    local procedure RunWorkflowOnCancelTravelReqApprovalRequestCode(): Code[128]//Event
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelTravelReqApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Page, 70104, 'OnAfterActionEvent', 'CancelApprovalRequest', false, false)]
    local procedure PurchaseReqPageOnCancelApprovalRequestAction(var Rec: Record "Travel Request")//Handle the Event
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTravelReqApprovalRequestCode, Rec);
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
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, RunWorkflowOnSendTravelReqForApprovalCode);
                    //EDM.PayReq-
                END;
            WorkflowResponseHandling.CreateApprovalRequestsCode:
                BEGIN
                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, RunWorkflowOnSendTravelReqForApprovalCode);
                    //EDM.PayReq-
                END;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                BEGIN
                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(
                      WorkflowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnSendTravelReqForApprovalCode);
                    //EDM.PayReq-
                END;
            WorkflowResponseHandling.OpenDocumentCode:
                BEGIN
                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, RunWorkflowOnCancelTravelReqApprovalRequestCode());
                    //EDM.PayReq-
                END;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                BEGIN
                    //EDM.PayReq+
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, RunWorkflowOnCancelTravelReqApprovalRequestCode());
                    //EDM.PayReq-
                END;
            TravelReqAppCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(TravelReqAppCode(), RunWorkflowOnSendTravelReqForApprovalCode());
                end;
            TravelReqCancelCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(TravelReqCancelCode(), RunWorkflowOnCancelTravelReqApprovalRequestCode());
                end;
            TravelReqRejectCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(TravelReqRejectCode(), WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode());
                end;
            TravelReqApprovedCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(TravelReqApprovedCode(), WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode());
                end;
            TravelReqSendEmailCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(TravelReqSendEmailCode(), RunWorkflowOnSendTravelReqForApprovalCode());
                end;
            WorkflowResponseHandling.CreateApprovalRequestsCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode(), RunWorkflowOnSendTravelReqForApprovalCode());

                end;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), RunWorkflowOnSendTravelReqForApprovalCode());

                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), RunWorkflowOnCancelTravelReqApprovalRequestCode());
                end;
            WorkflowResponseHandling.OpenDocumentCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), RunWorkflowOnCancelTravelReqApprovalRequestCode());
                end;




        END;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowTableRelationsToLibrary', '', false, false)]//add relation with other table new table --> approval entry relation cane be done mnanuale from BC
    local procedure AddWorkflowTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(Database::"Travel Request", 21, Database::"Approval Entry", 22);//link the pk to approval entry
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddWorkflowEventHierarchiesToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: codeunit "Workflow Event Handling";
    begin
        Case EventFunctionName of
            RunWorkflowOnSendTravelReqForApprovalCode():
                //WorkflowEventHandling.AddEventPredecessor(MyWorkflowEventCode(), WorkflowEventHandling./*[Add your predecessor event code]*/);
                ;
            RunWorkflowOnCancelTravelReqApprovalRequestCode():
                //WorkflowEventHandling.AddEventPredecessor(MyWorkflowEventCode(), WorkflowEventHandling./*[Add your predecessor event code]*/);
                ;
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
        TravelRequest: Record "Travel Request";
    begin
        //TRANSFER FIELDS
        case RecRef.Number of
            DATABASE::"Travel Request":
                begin
                    RecRef.SetTable(TravelRequest);
                    ApprovalEntryArgument."Document No." := TravelRequest.Number;
                    ApprovalEntryArgument.Amount := TravelRequest."Travel Advance Required";

                end;
        end;
    end;

}

