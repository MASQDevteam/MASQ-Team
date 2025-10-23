pageextension 70173 "Sales Order List Custom" extends "Sales Order List"
{
    layout
    {
        addafter(Status)
        {
            field("Custom Status"; Rec."Custom Status")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Shows the custom status based on shipping and invoicing progress';
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
                Caption = 'Update All  sales Custom Status';
                ApplicationArea = all;
                Image = UpdateDescription;
                ToolTip = 'Update all custom status for all Sales orders';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    UpdateAllCustomStatusMgmt: Codeunit "Migrate Custom Status";
                begin
                    UpdateAllCustomStatusMgmt.UpdateAllSalesOrders();
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
        CustomStatusStyle := CustomStatusStyleMgmt.GetStyleForSalesStatus(Rec."Custom Status");
    end;

    var
        CustomStatusStyle: Text;
}