page 70162 "Cost PR LOGs Factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    //   UsageCategory = Lists;
    SourceTable = "Cost PR Log";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item Number"; Rec."Item Number")
                {
                    ApplicationArea = All;
                }
                field("Old Cost"; Rec."Old Cost")
                {
                    ApplicationArea = All;
                }
                field("New Cost"; Rec."New Cost")
                {
                    ApplicationArea = All;
                }
                field("Old Qty"; Rec."Old Qty")
                {
                    ApplicationArea = All;
                }
                field("New Qty"; Rec."New Qty")
                {
                    ApplicationArea = All;
                }
                field("old Item number"; Rec."old Item number")
                {
                    ToolTip = 'Specifies the value of the old Item number field.', Comment = '%';
                }
                field("new Item number"; Rec."new Item number")
                {
                    ToolTip = 'Specifies the value of the new Item number field.', Comment = '%';
                }

                // field("PR Number"; Rec."PR Number")
                // {
                //     ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
                // }
                field("PR Line Number"; Rec."PR Line Number")
                {
                    ToolTip = 'Specifies the value of the PO Line Number field.', Comment = '%';
                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
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