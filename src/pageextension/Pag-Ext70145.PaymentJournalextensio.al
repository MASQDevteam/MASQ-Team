pageextension 70145 "Payment Journal extensio" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here

        addafter(IncomingDocAttachFactBox)
        {
            systempart(Control1905767508; Notes)
            {
                ApplicationArea = Notes;
            }
        }
        //FQ MASQ** Start
        addafter(Description)
        {
            field("Related PO No."; Rec."Related PO No.")
            {
                ApplicationArea = All;
                Caption = 'Related PO No.';
                ToolTip = 'Select the related Purchase Order for this Vendor payment. Value is copied to the Vendor Ledger Entry on posting.';
                //Visible = (Rec."Account Type" = Rec."Account Type"::Vendor);
            }

            field("Related SO No."; Rec."Related SO No.")
            {
                ApplicationArea = All;
                Caption = 'Related SO No.';
                ToolTip = 'Select the related Sales Order for this Customer payment. Value is copied to the Customer Ledger Entry on posting.';
                //Visible = (Rec."Account Type" = Rec."Account Type"::Customer);
            }
        }
        //FQ MASQ**END
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}