tableextension 70137 "Purchase setup extension" extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Purchase Request Nos."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        //AN 04/11/2025
        field(70101; "Local Vendor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
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