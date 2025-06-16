page 70142 "shipping Quote Factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    //   UsageCategory = Lists;
    SourceTable = "Comment Line";
    //   Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;



    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a code for the comment.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the comment itself.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
            }

        }
    }

}