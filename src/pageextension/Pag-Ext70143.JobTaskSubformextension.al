pageextension 70143 "Job Task Subform extension" extends "Job Task Lines Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Usage (Total Price)")
        {
            field("Usage (Total Cost) Freight"; Rec."Usage (Total Cost) Freight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Freight field.', Comment = '%';
            }
            field("Usage (Total Cost) Customs"; Rec."Usage (Total Cost) Customs")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Customs field.', Comment = '%';
            }
            field("Usage (Total Cost) Clearance"; Rec."Usage (Total Cost) Clearance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Clearance field.', Comment = '%';
            }
            field("Usage (Total Cost) Insurance"; Rec."Usage (Total Cost) Insurance")//added on 10022025
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Insurance field.', Comment = '%';
            }
            field("Usage (Total Cost) Others"; Rec."Usage (Total Cost) Others")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Others field.', Comment = '%';
            }
            field("Usage (Total Landed Cost)"; Rec."Usage (Total Landed Cost)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Landed Cost) field.', Comment = '%';
            }
            field("Usage (Total Quantity)"; Rec."Usage (Total Quantity)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Quantity) field.', Comment = '%';
            }
            field("Allocated Job Expenses"; Rec."Allocated Job Expenses")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allocated Job Expenses field.', Comment = '%';
                Editable = false;
                // Enabled = false;
            }
        }
        addafter("Schedule (Total Price)")
        {
            field("Schedule (Total Cost) Freight"; Rec."Schedule (Total Cost) Freight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Cost) Freight field.', Comment = '%';
            }
            field("Schedule (Total Cost) C & C"; Rec."Schedule (Total Cost) C & C")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Cost) C & C field.', Comment = '%';
            }
            field("Schedule (Total Cost) COF"; Rec."Schedule (Total Cost) COF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Cost) COF field.', Comment = '%';
            }
            field("Schedule (Total Landed Cost)"; Rec."Schedule (Total Landed Cost)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Landed Cost) field.', Comment = '%';
            }
            field("Recognized Costs Amount"; Rec."Recognized Costs Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Recognized Costs Amount field.', Comment = '%';
            }
            field("Recognized Sales Amount"; Rec."Recognized Sales Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Recognized Sales Amount field.', Comment = '%';
            }
            field("Schedule (Total Cost) Insurance"; Rec."Schedule (Total Cost) Insurance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Cost) Insurance field.', Comment = '%';
            }
            field("Ordered PO"; Rec."Ordered PO")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ordered PO field.', Comment = '%';
            }
            field("Ordered PO Qty"; Rec."Ordered PO Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ordered PO Qty field.', Comment = '%';
            }

        }
        addafter("Contract (Invoiced Price)")
        {
            field("Contract (Invoiced Quantity)"; Rec."Contract (Invoiced Quantity)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoiced (Total Quantity) field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        modify(Documents)
        {
            Visible = false;
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        REc.CalcFields("Schedule (Total Cost)", "Schedule (Total Cost) C & C", "Schedule (Total Cost) Freight", "Schedule (Total Cost) COF", "Schedule (Total Cost) Insurance");
        Rec."Schedule (Total Landed Cost)" := rec."Schedule (Total Cost)" +
        Rec."Schedule (Total Cost) C & C" + Rec."Schedule (Total Cost) Freight" + Rec."Schedule (Total Cost) COF" + Rec."Schedule (Total Cost) Insurance";
        Rec.CalcFields("Usage (Total Cost)", "Usage (Total Cost) Clearance", "Usage (Total Cost) Customs", "Usage (Total Cost) Freight", "Usage (Total Cost) Others", "Usage (Total Cost) Insurance");//added on 10022025
        Rec."Usage (Total Landed Cost)" := Rec."Usage (Total Cost)" + rec."Usage (Total Cost) Freight" + Rec."Usage (Total Cost) Clearance"
        + Rec."Usage (Total Cost) Customs" + Rec."Usage (Total Cost) Others" + Rec."Usage (Total Cost) Insurance";//updated on 10022025
    end;

    var
        myInt: Integer;
}