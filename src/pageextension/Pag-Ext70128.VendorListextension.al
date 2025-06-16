pageextension 70128 "Vendor List extension" extends "Vendor List"
{
    layout
    {

        addafter("Payment Terms Code")
        {
            field("Payment Terms Description"; Rec."Payment Terms Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Terms Description field.', Comment = '%';
                DrillDownPageId = "Payment Terms";
            }

        }
        // Add changes to page layout here
        addafter(Name)
        {
            field("Purchases (LCY)"; Rec."Purchases (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchases (LCY) field.', Comment = '%';
            }
            field("Refunds (LCY)"; Rec."Refunds (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sum of refunds paid to the vendor.';
            }
            field("Outstanding Orders (LCY)"; Rec."Outstanding Orders (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sum of outstanding orders (in LCY) to this vendor.';
            }
            field("Outstanding Invoices (LCY)"; Rec."Outstanding Invoices (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sum of the vendor''s outstanding purchase invoices in LCY.';
            }
            field("Other Amounts (LCY)"; Rec."Other Amounts (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Other Amounts (LCY) field.', Comment = '%';
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Change (LCY) field.', Comment = '%';
            }
            field("Inv. Amounts (LCY)"; Rec."Inv. Amounts (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inv. Amounts (LCY) field.', Comment = '%';
            }

        }
        //AN 03/07/25
        addafter(Contact)
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field(Address2; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field("Primary Contact No."; Rec."Primary Contact No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Payment Terms Code")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}