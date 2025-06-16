tableextension 70105 "purch cm inv line extensi9on" extends "Purch. Cr. Memo Line"
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
            CalcFormula = lookup("Purch. Cr. Memo Hdr."."Currency Code" where("No." = field("Document No.")));
        }
        field(70102; "Currency Factor"; Decimal)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Cr. Memo Hdr."."Currency Factor" where("No." = field("Document No.")));
        }
        field(70103; "MoonLight Item Type"; Code[50])
        {
            Caption = 'MoonLight Item Type';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value"."Moonlight Item Type" where("Dimension Code" = const('ITEMTYPE'), Code = field("Meg Item Type")));
        }
        field(70104; "MoonLight Brand"; Code[50])
        {
            Caption = 'MoonLight Brand';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value"."Moonlight Brand" where("Dimension Code" = const('BRAND'), Code = field("Shortcut Dimension 3 Code")));
        }
        field(70105; "Initial ETR"; Date)//Created on 28/10/2024 with Nathalie
        {
            Caption = 'Initial ETR';
        }
        field(70106; "Initial ETD"; Date)
        {
            Caption = 'Initial ETD';
        }
        field(70107; "Initial ETA"; Date)
        {
            Caption = 'Initial ETA';
        }
        field(70108; "Initial ETAW"; Date)
        {
            Caption = 'Initial ETAW';
        }
        field(70109; "BL/AWB ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "Container ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70111; "MASQ Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70112; "MASQ Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70113; "Quantity Shipped"; Decimal)//from the vendor's country
        {
            DataClassification = ToBeClassified;
        }
        field(70114; "Remaining Quantity Shipped"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70115; "Line is Splitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70116; "Splitted Line No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70117; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70118; "Original Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70119; "Disable fields after Shipping"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70120; "Final ETR"; Date)
        {
            Caption = 'Final ETR';
        }
        field(70121; "Final ETD"; Date)
        {
            Caption = 'Final ETD';
        }
        field(70122; "Final ETA"; Date)
        {
            Caption = 'Final ETA';
        }
        field(70123; "ATA"; Date)
        {
            Caption = 'ATA';
        }
        field(70124; "Final ETAW"; Date)
        {
            Caption = 'Final ETAW';
        }
        field(70125; "Container Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70126; "VO Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70127; "Batch Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70128; "Truck WayBill ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70129; "Truck Details ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70130; "Truck Details Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70131; "Subjob ID"; Integer)//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Subjob ID';
        }
        field(70132; "Job#"; Code[20])//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Job ID';
        }
        field(70133; "Shipping By"; Option)//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Sea,Air,InLand;
        }
        field(70144; "Line Amount LCY"; Decimal)
        {
            //   AutoFormatExpression = Rec."Currency Code";
            //  AutoFormatType = 1;
            //  CaptionClass = GetCaptionClass(FieldNo("Line Amount"));
            Caption = 'Line Amount';
        }


        field(70145; "Direct Unit Cost LCY"; Decimal)
        {
            //  AutoFormatExpression = Rec."Currency Code";
            //    AutoFormatType = 2;
            //   CaptionClass = GetCaptionClass(FieldNo("Direct Unit Cost"));
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