/* codeunit 70117 "Item Journal Line Approval"
{
    TableNo = "Item Journal Line";

    trigger OnRun()
    var
        ItemJournalWorkflow: Codeunit "Custom Workflow Payment Line";
    begin
        ItemJournalWorkflow.TrySendJournalLineApprovalRequests(Rec);
    end;
} */