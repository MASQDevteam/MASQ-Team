tableextension 70127 "Location Extension" extends Location
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Code 2"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70101; "Warehouse Category"; Enum "Warehouse categories")
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