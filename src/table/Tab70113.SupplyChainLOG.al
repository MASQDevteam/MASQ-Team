table 70113 "Supply Chain LOG"
{
    DataClassification = ToBeClassified;
    LookupPageId = "PO Batch LOG";
    DrillDownPageId = "PO Batch LOG";


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "BL/AWB ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Container Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Container Details";
        }
        field(4; "PO Number"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "PO Line Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Initial ETR"; Date)//Created on 28/10/2024 with Nathalie
        {
            Caption = 'Initial ETR';
        }
        field(7; "Initial ETD"; Date)
        {
            Caption = 'Initial ETD';
        }
        field(8; "Initial ETA"; Date)
        {
            Caption = 'Initial ETA';
        }
        field(9; "Initial ETAW"; Date)
        {
            Caption = 'Initial ETAW';
        }
        field(10; "Final ETR"; Date)
        {
            Caption = 'Final ETR';
        }
        field(11; "Final ETD"; Date)
        {
            Caption = 'Final ETD';
        }
        field(12; "Final ETA"; Date)
        {
            Caption = 'Final ETA';
        }
        field(13; "ATA"; Date)
        {
            Caption = 'ATA';
        }
        field(14; "Final ETAW"; Date)
        {
            Caption = 'Final ETAW';
        }
        field(15; "Old Item"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "New Item"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Old UOM"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "New UOM"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Old Price"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "New Price"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Old Qty"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "New Qty"; decimal)
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
        field(28; "VO Number"; Code[50])
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
        field(31; "Truck WayBill ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Truck Details ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            //     TableRelation = "Container Details";
        }
        field(33; "Project No."; Code[50])//added on 27/03/2025
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Project planning Line No."; Integer)//added on 27/03/2025
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