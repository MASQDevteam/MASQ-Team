page 70161 "Cost LOGs Factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    //   UsageCategory = Lists;
    SourceTable = "Cost Variation LOG";
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
                field("Old Price"; Rec."Old Price")
                {
                    ApplicationArea = All;
                }
                field("New Price"; Rec."New Price")
                {
                    ApplicationArea = All;
                }
                field("old Quantity"; Rec."old Quantity")
                {
                    ToolTip = 'Specifies the value of the old Quantity field.', Comment = '%';
                }
                field("new Quantity"; Rec."new Quantity")
                {
                    ToolTip = 'Specifies the value of the new Quantity field.', Comment = '%';
                }
                field("old Item number"; Rec."old Item number")
                {
                    ToolTip = 'Specifies the value of the old Item number field.', Comment = '%';
                }
                field("new Item number"; Rec."new Item number")
                {
                    ToolTip = 'Specifies the value of the new Item number field.', Comment = '%';
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