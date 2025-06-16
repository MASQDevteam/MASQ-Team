tableextension 70106 "Value Entry Extension" extends "Value Entry"
{
    fields
    {
        // Add changes to table fields here

        field(70100; "Item Type Purch. Rcpt."; Code[20])
        {
            Caption = 'Item Type Purchase Rcpt.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70101; "Item Type Purch. Inv."; Code[20])
        {
            Caption = 'Item Type Purchase Inv.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }

        field(70102; "Item Type Sales Shipment"; Code[20])
        {
            Caption = 'Item Type Sales Shipment.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Shipment Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70103; "Item Type Sales Invoice"; Code[20])
        {
            Caption = 'Item Type Sales Inv.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70104; "Item Type Purch. CM"; Code[20])
        {
            Caption = 'Item Type Purchase CM';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Cr. Memo Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70105; "Item Type Sales CM"; Code[20])
        {
            Caption = 'Item Type Sales CM';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70106; "MASQ Item Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70107; "MoonLight Item Type"; Code[50])
        {
            Caption = 'MoonLight Item Type';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value"."Moonlight Item Type" where("Dimension Code" = const('ITEMTYPE'), Code = field("MASQ Item Type")));
        }
        field(70108; "MoonLight Brand"; Code[50])
        {
            Caption = 'MoonLight Brand';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value"."Moonlight Brand" where("Dimension Code" = const('BRAND'), Code = field("Shortcut Dimension 3 Code")));
        }
        field(70109; "Batch Number";
        Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "Freight Air"; Code[50])
        {
            //   DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Value Entry"."Item Charge No." where("Item Ledger Entry No." = field("Item Ledger Entry No."), "Item Charge No." = filter('FREIGHT - AIR'), "Item Ledger Entry Type" = const(Purchase)));
        }
        field(70111; "Freight Sea"; Code[50])
        {
            //   DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Value Entry"."Item Charge No." where("Item Ledger Entry No." = field("Item Ledger Entry No."), "Item Charge No." = filter('FREIGHT - SEA'), "Item Ledger Entry Type" = const(Purchase)));
        }
        field(70121; "Subjob ID"; Integer)//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Subjob ID';
        }
        field(70122; "Job#"; Code[20])//added on 27/01/2025
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