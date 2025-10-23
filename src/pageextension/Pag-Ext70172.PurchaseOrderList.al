pageextension 70172 "Purchase Order List Custom" extends "Purchase Order List"
{
    layout
    {
        addafter(Status)
        {
            field("Custom Status"; Rec."Custom Status")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Shows the custom status based on receiving and invoicing progress';
                StyleExpr = CustomStatusStyle;
            }
        }
    }

    actions
    {
        addafter(Post)
        {
            action(UpdateAllCustomStatus)
            {
                Caption = 'Update All Custom Status';
                ApplicationArea = all;
                Image = UpdateDescription;
                ToolTip = 'Update all custom status for all purchase orders';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    UpdateAllCustomStatusMgmt: Codeunit "Migrate Custom Status";
                begin
                    UpdateAllCustomStatusMgmt.UpdateAllPurchaseOrders();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateStatusStyle();
    end;

    local procedure UpdateStatusStyle()
    var
        CustomStatusStyleMgmt: Codeunit "Custom Status Style";
    begin
        CustomStatusStyle := CustomStatusStyleMgmt.GetStyleForPurchaseStatus(Rec."Custom Status");
    end;

    var
        CustomStatusStyle: Text;
}