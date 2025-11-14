tableextension 70126 "unplanned demand extension" extends "Unplanned Demand"
{
    fields
    {
        // Add changes to table fields here
        field(50002; "Meg Item Type"; Code[50])
        {
            Caption = 'Item Type';
            Description = 'Used in Delivery Order report';
        }
        field(70101; "MASQ Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "MASQ Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70103; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70104; "Sent to PO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70105; "Job No."; Code[20])
        {
            Caption = 'Project No.';
            Editable = false;
            TableRelation = Job;
        }
        field(70106; "Job Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(70107; "Job Planning Line No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            BlankZero = true;
            Caption = 'Project Planning Line No.';
        }
        field(70108; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }

        field(70109; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(70110; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                          Blocked = const(false));
        }
        field(70111; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                          Blocked = const(false));
        }
        field(70112; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                          Blocked = const(false));
        }
        field(70113; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                          Blocked = const(false));
        }
        field(70114; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                          Blocked = const(false));
        }
        field(70115; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                          Blocked = const(false));
        }
        field(70132; "Apollo Job Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70133; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Purchase Header";
        }
        field(70134; "PO Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70135; "Meg Vendor Item Code"; Code[200])
        {
            DataClassification = CustomerContent;
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