tableextension 70113 "Dimension Value extension " extends "Dimension Value"

{
    fields
    {
        // Add changes to table fields here
        field(70100; "Moonlight Item Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70101; "Moonlight Brand"; Code[50])
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