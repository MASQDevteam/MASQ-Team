tableextension 70101 "Purchg inv line extensi9on" extends "Purch. Inv. Line"
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
            CalcFormula = lookup("Purch. Inv. Header"."Currency Code" where("No." = field("Document No.")));
        }
        field(70102; "Currency Factor"; Decimal)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Currency Factor" where("No." = field("Document No.")));
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
        field(70134; "GROSS Weight in KG"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."GROSS Weight in KG" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70135; "VOLUMETRIC Weight in KG"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."VOLUMETRIC Weight in KG" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70136; "NET Weight in KG"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."NET Weight in KG" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70137; "AirPort of Loading"; Code[50])
        {
            Caption = 'AirPort of Loading';
            // Set up a lookup to your port master table here    
            TableRelation = "MASQ Lookup".Code where(Type = const("Air Port"));
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."Port of Loading" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70138; "AirPort of Discharge"; Code[50])
        {
            Caption = 'AirPort of Discharge';
            // Set up a lookup to your port master table here    
            TableRelation = "MASQ Lookup".Code where(Type = const("Air Port"));
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."Port of Discharge" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70139; "Port of Loading"; Code[50])
        {
            Caption = 'Port of Loading';
            // Set up a lookup to your port master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
            FieldClass = FlowField;
            CalcFormula = lookup("BL Details"."Port of Loading" where("BL ID" = field("BL/AWB ID")));
        }
        field(70140; "Port of Discharge"; Code[50])
        {
            Caption = 'Port of Discharge';
            // Set up a lookup to your port master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
            FieldClass = FlowField;
            CalcFormula = lookup("BL Details"."Port of Discharge" where("BL ID" = field("BL/AWB ID")));
        }

        // field(70141; "Buy-from Vendor Name"; Code[100])
        // {
        //     Caption = 'Buy-from Vendor Name';
        //     //  Editable = false;
        //     //  TableRelation = Vendor;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Vendor.Name where("No." = field("Buy-from Vendor No.")));
        // }
        field(70142; "Liner"; Code[50])
        {
            // DataClassification = ToBeClassified;
            //           TableRelation = "MASQ Lookup".Code where(Type = const(Port));
            FieldClass = FlowField;
            CalcFormula = lookup("BL Details".Liner where("BL ID" = field("BL/AWB ID")));
        }
        field(70143; "Airline"; Code[50])
        {
            // DataClassification = ToBeClassified;
            //           TableRelation = "MASQ Lookup".Code where(Type = const(Port));
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details".Airline where("AWB ID" = field("BL/AWB ID")));
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
        field(70146; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(4)));
        }
        field(70147; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(5)));
        }
        field(70148; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(6)));
        }
        field(70149; "CHARGABLE Weight in KG"; Decimal)//added on 02/04/2025
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."CHARGABLE Weight in KG" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70150; "InLand ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70151; "Inland Details Line No"; Integer)
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