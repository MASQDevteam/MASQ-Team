tableextension 70141 GlEntry extends "G/L Entry"
{
    fields
    {
        field(70100; "Travel Request Code"; Code[20])
        {
            Caption = 'Travel Request Code';
            DataClassification = ToBeClassified;
            TableRelation = "Travel Request".Number;
        }
        field(70101; "Expense Category Description"; Text[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Default Dimension"."Dimension Value Name"
            //     where("Dimension Code" = const('EXPENSE CATEGORY'), "Dimension Value Code" = field("Shortcut Dimension 7 Code")));
        }
        field(70102; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
