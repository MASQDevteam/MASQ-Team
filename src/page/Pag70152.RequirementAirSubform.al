page 70152 "Requirement Air Subform"
{
    PageType = ListPart;
    SourceTable = "Requirement";
    ApplicationArea = All;
    AutoSplitKey = true;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Editable = false;
                }
                field("Fitting"; Rec."Fitting")
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
            // Add actions here if needed
        }
    }

    trigger OnOpenPage()
    begin
        // Add your code here
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        Rec."Quotation Type" := Rec."Quotation Type"::Air;
    end;
}