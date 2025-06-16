namespace MASQ.MASQ;

page 70164 "cost variation"
{
    ApplicationArea = All;
    Caption = 'cost variation';
    PageType = List;
    SourceTable = "Cost PR Log";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("PR Number"; Rec."PR Number")
                {
                    ToolTip = 'Specifies the value of the PR Number field.', Comment = '%';
                }
                field("PR Line Number"; Rec."PR Line Number")
                {
                    ToolTip = 'Specifies the value of the PO Line Number field.', Comment = '%';
                }
                field("Item Number"; Rec."Item Number")
                {
                    ToolTip = 'Specifies the value of the Item Number field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Old Cost"; Rec."Old Cost")
                {
                    ToolTip = 'Specifies the value of the Old Cost field.', Comment = '%';
                }
                field("New Cost"; Rec."New Cost")
                {
                    ToolTip = 'Specifies the value of the New Cost field.', Comment = '%';
                }
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.', Comment = '%';
                }
                field("Project planning Line No."; Rec."Project planning Line No.")
                {
                    ToolTip = 'Specifies the value of the Project planning Line No. field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
            }
        }
    }
}
