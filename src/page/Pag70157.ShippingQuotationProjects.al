page 70157 "Shipping Quotation Projects"
{
    PageType = ListPart;
    SourceTable = "Shipping Quotation Project";
    ApplicationArea = All;
    // AutoSplitKey = true;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Comparison ID"; Rec."Comparison ID")
                {
                    ToolTip = 'Specifies the value of the Comparison ID field.', Comment = '%';
                    Editable = false;
                }
                field("Quotation Type"; Rec."Quotation Type")
                {
                    ToolTip = 'Specifies the value of the Quotation Type field.', Comment = '%';
                    Editable = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Specifies the value of the Project Name field.', Comment = '%';

                    trigger OnValidate()
                    var
                        Project: Record Job;
                    begin
                        Clear(Project);
                        IF Rec."Project Name" <> '' then begin
                            project.Get(Rec."Project Name");
                            Rec.Description := Project.Description;
                        end;

                    end;
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // Add actions here if needed
        }
    }

    trigger OnOpenPage()
    begin
        // Add your code here
    end;

}