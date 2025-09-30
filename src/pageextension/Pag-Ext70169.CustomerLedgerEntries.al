pageextension 70169 "Customer ledger extension" extends "Customer Ledger Entries"
{
    layout
    {

        //FQ MASQ** Start
        addafter("Customer No.")
        {
            field("Related SO No."; Rec."Related SO No.")
            {
                ApplicationArea = All;
                Caption = 'Related SO No.';
                Editable = false;
            }
            //FQ MASQ** End
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}