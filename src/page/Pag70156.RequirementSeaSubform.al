page 70156 "Requirement Sea Subform"
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
                field("Qty of CTR"; Rec."Qty of CTR")
                {
                    ToolTip = 'Specifies the value of the Qty of CTR field.', Comment = '%';
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
        Rec."Quotation Type" := Rec."Quotation Type"::Sea;
    end;
}