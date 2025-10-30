//NB MASQ Start
pageextension 70174 "Workflow Webhook Entries Ext" extends "Workflow Webhook Entries"
{
    actions
    {
        addfirst(Processing)
        {
            action(Delete)
            {
                AccessByPermission = tabledata "Workflow Webhook Entry" = RIMD;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Edit;
                trigger OnAction()
                var
                    ModifyApprovalEntry: Codeunit "Modify Approval Entry";
                begin
                    ModifyApprovalEntry.DeleteWebhookEntry(Rec);
                end;
            }
        }
    }
}
//NB MASQ End