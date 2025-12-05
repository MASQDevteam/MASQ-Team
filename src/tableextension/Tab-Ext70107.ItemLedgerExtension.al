tableextension 70107 "Item Ledger Extension" extends "Item Ledger Entry"
{
    fields
    {
        // Add changes to table fields here

        field(70100; "Item Type Purch. Rcpt."; Code[50])
        {
            Caption = 'Item Type Purchase Rcpt.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70101; "Item Type Purch. Inv."; Code[50])
        {
            Caption = 'Item Type Purchase Inv.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }

        field(70102; "Item Type Sales Shipment"; Code[50])
        {
            Caption = 'Item Type Sales Shipment.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Shipment Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70103; "Item Type Sales Invoice"; Code[50])
        {
            Caption = 'Item Type Sales Inv.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70104; "Item Type Purch. CM"; Code[50])
        {
            Caption = 'Item Type Purchase CM';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Cr. Memo Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70105; "Item Type Sales CM"; Code[50])
        {
            Caption = 'Item Type Sales CM';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Line"."Meg Item Type" where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), "Line No." = field("Document Line No."), Type = const(Item), "No." = field("Item No.")));
        }
        field(70106; "MASQ Item Type"; Code[50])
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
        field(70110; "Warehouse Category"; enum "Warehouse categories")
        {
            //  DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup(Location."Warehouse Category" where(Code = field("Location Code")));
        }
        field(70111; "Subjob ID"; Integer)//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Subjob ID';
        }
        field(70112; "Job#"; Code[20])//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Job ID';
        }

        //NB MASQ Start
        field(70113; Family; Code[2048])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Meg Family" where("No." = field("Item No.")));
            Editable = false;
        }
        field(70114; "Item Subcategory Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Meg Item Subcategory Code" where("No." = field("Item No.")));
            Editable = false;
        }
        field(70115; "Source Order No."; Code[20]) //MASQ FQ
        {
            Caption = 'Source Order No.';
            DataClassification = ToBeClassified;
        }
        //NB MASQ End

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