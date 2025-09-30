tableextension 70150 "Cust. Ledger-Related Docs" extends "Cust. Ledger Entry"
{
    fields
    {
        field(70160; "Related SO No."; Code[20])
        {
            Caption = 'Related SO No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." WHERE("No." = field("Related SO No."));
            Editable = false;
        }
    }
}