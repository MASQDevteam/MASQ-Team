table 70134 "Cost Variation LOG"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(4; "PO Number"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "PO Line Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "SO Number"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "SO Line Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Item Number"; Code[20])//for batch posting
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where(Blocked = const(false));
        }
        field(26; "Location Code"; Code[50])//for batch posting
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code where("Use As In-Transit" = const(false));
        }
        field(27; "Batch Number"; Code[50])//for batch posting
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Old Cost"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "New Cost"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Project No."; Code[50])//added on 27/03/2025
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Project planning Line No."; Integer)//added on 27/03/2025
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Old Price"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "New Price"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "old Item number"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "new Item number"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "old Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "new Quantity"; Decimal)
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