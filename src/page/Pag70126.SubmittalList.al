page 70126 "Submittal List"
{
    PageType = List;
    SourceTable = "Submittal";
    ApplicationArea = All;
    Caption = 'Submittals';
    UsageCategory = Lists;
    CardPageId = "Submittal Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SubmittalId"; Rec."SubmittalId")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("ProjectId"; Rec."ProjectId")
                {
                    ApplicationArea = All;
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
        }
    }

    actions
    {
        area(processing)
        {
            action(New)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PAGE.RunModal(PAGE::"Submittal Card");
                end;
            }
        }
    }
}
