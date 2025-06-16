page 70127 "Submittal Card"
{
    PageType = Card;
    SourceTable = "Submittal";
    ApplicationArea = All;
    Caption = 'Submittal Card';
    UsageCategory = Administration;
    //  Editable = false;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("SubmittalId"; Rec."SubmittalId")
                {
                    ApplicationArea = All;
                    //  Editable = false;
                }

                field("ProjectId"; Rec."ProjectId")
                {
                    ApplicationArea = All;
                }
                field("Dynamics Project Number"; Rec."Dynamics Project Number")
                {
                    ToolTip = 'Specifies the value of the Dynamics Project Number field.', Comment = '%';
                }

                field("SubmittalDate"; Rec."SubmittalDate")
                {
                    ApplicationArea = All;
                }

                field("SubmittalRevisionNumber"; Rec."SubmittalRevisionNumber")
                {
                    ApplicationArea = All;
                }

                field("GeneralComment"; Rec."GeneralComment")
                {
                    ApplicationArea = All;
                }

                field("CreatedDate"; Rec."CreatedDate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("CurrentStatus"; Rec."CurrentStatus")
                {
                    ApplicationArea = All;
                }

                field("isGenerated"; Rec."isGenerated")
                {
                    ApplicationArea = All;
                }

                field("Deleted"; Rec."Deleted")
                {
                    ApplicationArea = All;
                }

                field("SubmittalProjectRevisionNumber"; Rec."SubmittalProjectRevisionNumber")
                {
                    ApplicationArea = All;
                }



            }
            part(SubmittalCommentPart; "SubmittalComment Subform")
            {
                ApplicationArea = All;
                SubPageLink = "SubmittalId" = field("SubmittalId");
                Visible = true;
                UpdatePropagation = Both;
            }
        }
    }


    actions
    {
        area(processing)
        {
            action(Activate)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // You can add custom logic here for actions like Activate, Delete, etc.
                end;
            }
        }
    }

}
