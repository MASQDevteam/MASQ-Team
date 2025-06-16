tableextension 70117 "purch. inv. header extension" extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(70110; "posted Receipts"; Code[20])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Header"."No." where("Order No." = field("Order No.")));
        }
        field(70122; "Shipping Quotation No."; Text[250])
        {
            Editable = false;
        }
        field(70123; "Actual (Total Cost) Freight"; Decimal)
        {
            Caption = 'Actual (Total Cost) Freight';
            Editable = false;
        }
        field(70124; "Actual (Total Cost) Custom"; Decimal)
        {
            Caption = 'Actual (Total Cost) Custom';
            Editable = false;
        }
        field(70125; "Actual (Total Cost) Clearance"; Decimal)
        {
            Caption = 'Actual (Total Cost) Clearance';
            Editable = false;
        }
        field(70126; "Actual (Total Cost) Others"; Decimal)
        {
            Caption = 'Actual (Total Cost) Others';
            Editable = false;
        }
        field(70127; "Actual (Total Cost) Insurance"; Decimal)
        {
            Caption = 'Actual (Total Cost) Insurance';
            Editable = false;
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