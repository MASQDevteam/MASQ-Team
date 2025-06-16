tableextension 70119 "Sales Setup extension" extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here.
        field(70110; "MASQ Delivery Order Nos."; Code[20])
        {
            Caption = 'MASQ Delivery Order Nos.';
            Description = 'Used to auto fill Delivery Order No. in Sales pages';
            TableRelation = "No. Series";
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