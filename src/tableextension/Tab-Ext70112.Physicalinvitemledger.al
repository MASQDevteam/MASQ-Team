tableextension 70112 "Physical inv item ledger" extends "Phys. Inventory Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(70106; "MASQ Item Type"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}