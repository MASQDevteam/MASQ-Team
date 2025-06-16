tableextension 70124 "Project Extension" extends Job
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70101; "Document Attachment ID"; Integer)
        {

        }
        field(70102; "Document Attachment Table ID"; Integer)
        {

        }
        field(70103; "Document Attachment No."; Code[20])
        {

        }
        field(70104; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(70105; "Document Attachment Line No."; Integer)
        {
        }
        field(70106; "Delivery Location Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(70107; "Sales Rep"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('SALESPERSON'));
        }
        // field(70108; "Project Manager"; Code[10])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
        // }
        field(70109; "Developer"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
        }
        field(70110; "Apollo Project Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70111; "Box Mover"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70108; "Apollo Project Manager"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70112; "Apollo Total Offer Value"; Decimal)
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