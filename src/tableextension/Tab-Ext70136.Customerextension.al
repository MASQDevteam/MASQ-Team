tableextension 70136 "Customer extension" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Apollo Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70101; "Apollo Customer No."; Code[50])
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