page 70153 "Requirement Inland Subform"
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
                field("Truck Type"; Rec."Truck Type")
                {
                    ApplicationArea = All;
                }
                field("Truck Load CBM"; Rec."Truck Load CBM")
                {
                    ApplicationArea = All;
                }
                field("Tonnage"; Rec."Tonnage")
                {
                    ApplicationArea = All;
                }
                field("Qty of Truck"; Rec."Qty of Truck")
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
        Rec."Quotation Type" := Rec."Quotation Type"::Inlnand;
    end;
}