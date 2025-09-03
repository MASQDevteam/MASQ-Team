codeunit 70119 "Approval Entries Event"
//FQ MASQ Start
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeApprovalEntryInsert, '', false, false)]
    local procedure MyProcedure(ApprovalEntryArgument: Record "Approval Entry"; var ApprovalEntry: Record "Approval Entry"; ApproverId: Code[50]; WorkflowStepArgument: Record "Workflow Step Argument"; var IsHandled: Boolean)
    var
        RecRef: RecordRef;
        PaymentLine: record "Payment Line";
    begin

        // check if the approval entry is for payment line
        if (ApprovalEntry."Table ID" = Database::"Payment Line") then begin
            RecRef.get(ApprovalEntry."Record ID to Approve");
            if RecRef.Number = Database::"Payment Line" then begin
                RecRef.SetTable(PaymentLine);
                ApprovalEntry."RFP Line No." := PaymentLine."Line No";
            end;
        end;
    end;

    //FQ MASQ End

    var
        myInt: Integer;

}