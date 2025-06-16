
table 70130 "Requirement"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Truck Type"; enum "Truck Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Truck Load CBM"; enum "Truck Load CBM")
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Tonnage"; enum Tonnage)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Qty of Truck"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Fitting"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const(Fitting));
        }
        field(6; "Qty of CTR"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Comparison ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Quotation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Clearance,Sea,Air,Inlnand;//added Inland on 17/01/2025
            //   FieldClass = FlowField;
            //   CalcFormula = lookup("Shipping Quotation"."Quotation Type" where("Comparison ID" = field("Comparison ID")));
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
    begin
        // Add your code here
    end;

    trigger OnModify()
    begin
        // Add your code here
    end;

    trigger OnDelete()
    begin
        // Add your code here
    end;
}