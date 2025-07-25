tableextension 70103 "Sales inv line extensi9on" extends "Sales Invoice Line"
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(3)));
        }

        field(70101; "Currency Code"; Code[10])
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Currency Code" where("No." = field("Document No.")));
        }
        field(70102; "Currency Factor"; Decimal)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Currency Factor" where("No." = field("Document No.")));
        }
        field(70103; "Pre-Assigned No."; Code[20])
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Pre-Assigned No." where("No." = field("Document No.")));
        }
        field(70104; "MoonLight Item Type"; Code[50])
        {
            Caption = 'MoonLight Item Type';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value"."Moonlight Item Type" where("Dimension Code" = const('ITEMTYPE'), Code = field("Meg Item Type")));
        }
        field(70105; "MoonLight Brand"; Code[50])
        {
            Caption = 'MoonLight Brand';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value"."Moonlight Brand" where("Dimension Code" = const('BRAND'), Code = field("Shortcut Dimension 3 Code")));
        }
        field(70106; "Batch Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70107; "MASQ Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70108; "MASQ Purchase Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70109; "Line is Splitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "Splitted Line No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70111; "Original PO Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70112; "Original Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70113; "VO Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70114; "Sent to PO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70115; "Job Planning Line No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            BlankZero = true;
            Caption = 'Project Planning Line No.';
        }
        field(70132; "Apollo Job Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70133; "Sales Credit Memo No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."No." where("Applies-to Doc. No." = field("Document No.")));
        }
        field(70134; "Sales Cr Memo Line No."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Line"."Line No." where("Document No." = field("Sales Credit Memo No."), "No." = field("No.")));
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