table 70121 "Shipping Quotation Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(3; "Comparison ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(1; "Agent"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const("Agent"));
        }

        field(2; "Liner"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const(Liner));
        }

        field(10; "Inland Transport Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }

        field(4; "Export Declaration Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }

        field(5; "Ocean Freight"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }

        field(6; "Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }

        field(7; "Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Transit Time"; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Free Demurrage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "number Free Demurrage"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Airline"; Code[50])
        {
            Caption = 'Airline';
            // Set up a lookup to your airline master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Airline));
        }
        field(14; "Quotation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Clearance,Sea,Air,Inlnand;//added Inland on 17/01/2025
            //   FieldClass = FlowField;
            //   CalcFormula = lookup("Shipping Quotation"."Quotation Type" where("Comparison ID" = field("Comparison ID")));
        }
        field(13; "Air Freight"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(15; StyleExprTxt; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Payment Terms"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(18; "Decision"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Reason Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(20; "currency Code"; Code[50])//added on 19/03/2025 AI
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(21; "D to D"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Total in LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Payment Terms Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Terms".Description where(Code = field("Payment Terms")));
        }

    }

    keys
    {
        key(PK; "Comparison ID", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        SQ: Record "Shipping Quotation";
        SQDetails: Record "Shipping Quotation Details";
    begin
        //added on 19/03/2025
        Clear(SQDetails);
        SQDetails.SetRange("Comparison ID", Rec."Comparison ID");
        Clear(SQ);
        SQ.Get(Rec."Comparison ID");
        SQ.Option := SQDetails.Count + 1;
        SQ.Modify();
    end;

}
