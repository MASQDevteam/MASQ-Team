page 70120 "Variation Order LOGs Factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    //   UsageCategory = Lists;
    SourceTable = "Supply Chain LOG";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("VO Number"; Rec."VO Number")
                {
                    ToolTip = 'Specifies the value of the VO Number field.', Comment = '%';
                }
                field("SO Number"; Rec."SO Number")
                {
                    ToolTip = 'Specifies the value of the SO Number field.', Comment = '%';
                }
                field("SO Line Number"; Rec."SO Line Number")
                {
                    ToolTip = 'Specifies the value of the SO Line Number field.', Comment = '%';
                }
                field("PO Number"; Rec."PO Number")
                {
                    ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
                }
                field("PO Line Number"; Rec."PO Line Number")
                {
                    ToolTip = 'Specifies the value of the PO Line Number field.', Comment = '%';
                }
                field("Old Item"; Rec."Old Item")
                {
                    ToolTip = 'Specifies the value of the Old Item field.', Comment = '%';
                }
                field("New Item"; Rec."New Item")
                {
                    ToolTip = 'Specifies the value of the New Item field.', Comment = '%';
                }
                field("Old Price"; Rec."Old Price")
                {
                    ToolTip = 'Specifies the value of the Old Price field.', Comment = '%';
                }
                field("New Price"; Rec."New Price")
                {
                    ToolTip = 'Specifies the value of the New Price field.', Comment = '%';
                }
                field("Old UOM"; Rec."Old UOM")
                {
                    ToolTip = 'Specifies the value of the Old UOM field.', Comment = '%';
                }
                field("New UOM"; Rec."New UOM")
                {
                    ToolTip = 'Specifies the value of the New UOM field.', Comment = '%';
                }
                field("Old Qty"; Rec."Old Qty")
                {
                    ToolTip = 'Specifies the value of the Old Qty field.', Comment = '%';
                }
                field("New Qty"; Rec."New Qty")
                {
                    ToolTip = 'Specifies the value of the New Qty field.', Comment = '%';
                }
                field("Old Cost"; Rec."Old Cost")
                {
                    ApplicationArea = All;
                }
                field("New Cost"; Rec."New Cost")
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
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