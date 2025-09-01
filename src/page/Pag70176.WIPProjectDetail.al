//NB MASQ Start
page 70176 "WIP Project Detail"
{
    ApplicationArea = All;
    Caption = 'WIP Project Detail';
    PageType = ListPart;
    SourceTable = "WIP Project Detail";
    Editable = false;
    AutoSplitKey = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.', Comment = '%';
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Cost; Rec.Cost)
                {
                    ToolTip = 'Specifies the value of the Cost field.', Comment = '%';
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("MarkUp %"; Rec."MarkUp %")
                {
                    ToolTip = 'Specifies the value of the MarkUp % field.', Comment = '%';
                }
                field(Profitability; Rec.Profitability)
                {
                    ToolTip = 'Specifies the value of the Profitability field.', Comment = '%';
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Completion; Rec.Completion)
                {
                    ToolTip = 'Specifies the value of the Completion field.', Comment = '%';
                }
            }
        }
    }
}
//NB MASQ End