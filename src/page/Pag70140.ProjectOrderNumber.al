page 70140 "Project Order Number"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Job Planning Line Invoice";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.', Comment = '%';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ToolTip = 'Specifies the value of the Project Task No. field.', Comment = '%';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the information about the type of document. There are four options:';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the number associated with the document. For example, if you have created an invoice, the field Specifies the invoice number.';
                }
                field("Item no."; Rec."Item no.")
                {
                    ToolTip = 'Specifies the value of the Item no. field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

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