tableextension 70111 "Item journal extension" extends "Item Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(70106; "MASQ Item Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70109; "Batch Number";
        Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "Subjob ID"; Integer)//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Subjob ID';
        }
        field(70111; "Job#"; Code[20])//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Job ID';
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