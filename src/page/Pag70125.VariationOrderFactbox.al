page 70125 "Variation Order Factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    //   UsageCategory = Lists;
    SourceTable = "Variation Order";
    // Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.', Comment = '%';
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order Line No. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Item Number"; Rec."Item Number")
                {
                    ToolTip = 'Specifies the value of the Item Number field.', Comment = '%';
                }
                field("Variation Action(Add Item)"; Rec."Variation Action(Add Item)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Add Item) field.', Comment = '%';
                }
                field("New Item Number"; Rec."New Item Number")
                {
                    ToolTip = 'Specifies the value of the New Itew Number field.', Comment = '%';
                }
                field("Variation Action(Change Price)"; Rec."Variation Action(Change Price)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Change Price) field.', Comment = '%';
                }
                field("New Price"; Rec."New Price")
                {
                    ToolTip = 'Specifies the value of the New Price field.', Comment = '%';
                }
                field("Variation Action(Change Qty)"; Rec."Variation Action(Change Qty)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Change Qty) field.', Comment = '%';
                }
                field("New Qty"; Rec."New Qty")
                {
                    ToolTip = 'Specifies the value of the New Qty field.', Comment = '%';
                }
                field("Variation Action(Change UOM)"; Rec."Variation Action(Change UOM)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Change UOM) field.', Comment = '%';
                }
                field("New UOM"; Rec."New UOM")
                {
                    ToolTip = 'Specifies the value of the New UOM field.', Comment = '%';
                }
                field("Variation Action(Replace Item)"; Rec."Variation Action(Replace Item)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Replace Item) field.', Comment = '%';
                }

                field(Executed; Rec.Executed)
                {
                    ToolTip = 'Specifies the value of the Executed field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}