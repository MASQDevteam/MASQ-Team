//NB MASQ Start
codeunit 70103 "Modify Approval Entry"
{
    Permissions = tabledata "Workflow Webhook Entry" = RIMD;
    procedure DeleteWebhookEntry(Rec: Record "Workflow Webhook Entry")
    begin
        Rec.Delete();
    end;
}
//NB MASQ End