pageextension 70118 "Sales setup extension" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Meg Delivery Order Nos.")
        {
            field("MASQ Delivery Order Nos."; Rec."MASQ Delivery Order Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Delivery Order Nos. field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}