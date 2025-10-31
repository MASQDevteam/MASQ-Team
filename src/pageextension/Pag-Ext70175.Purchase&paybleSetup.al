
pageextension 70175 "Purchase&PaybleExt" extends "Purchases & Payables Setup"
{
    layout
    {

        //FQ MASQ **START
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("SCC Nos."; Rec."SCC Nos.")
            {
                ApplicationArea = All;
            }

        }
        //FQ MASQ **END
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}