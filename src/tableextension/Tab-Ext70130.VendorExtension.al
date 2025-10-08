tableextension 70130 "Vendor Extension" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Category"; Option)
        {
            DataClassification = ToBeClassified;
            //    TableRelation = "MASQ Lookup".Code where(Type = const("Vendor Category"));
            OptionMembers = " ","SHIPPING & CLEARING";
        }
        field(70101; "Apollo Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Apollo Vendor No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70103; "Payment Terms Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Terms".Description where(Code = field("Payment Terms Code")));
        }
        field(70104; "Masq Remainig AmountNotZero"; Boolean)
        {
            Caption = 'Remaining Amount Not Zero';
            FieldClass = FlowField;
            CalcFormula = exist("Vendor Ledger Entry"
                where("Vendor No." = field("No."), "Remaining Amount" = filter(<> 0)));
        }
        field(70105; "Credit Limit"; Decimal)
        {
            Caption = 'Credit Limit';
            DataClassification = ToBeClassified;
        }
        field(70106; "Contact per Departments"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(70107; "MASQ Group"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70108; "RFP Type"; Option) //NB MASQ
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Facility Supplier Via Insurance","Supplier Without Insurance"; //NB MASQ 30-Sep-25
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