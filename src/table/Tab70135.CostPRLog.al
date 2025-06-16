table 70135 "Cost PR Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(4; "PR Number"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "PR Line Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Item Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where(Blocked = const(false));
        }
        field(26; "Location Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code where("Use As In-Transit" = const(false));
        }

        field(29; "Old Cost"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "New Cost"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Project No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Project planning Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Old Qty"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "New Qty"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "old Item number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "new Item number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}