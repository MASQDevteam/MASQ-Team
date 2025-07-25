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
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = filter('EXPENSE CATEGORY'),
                                                                Code = field("Shortcut Dimension 7 Code")));
        }
        field(70102; "Employee Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = filter('EMPLOYEE'),
                                                                Code = field("Shortcut Dimension 8 Code")));
        }
        field(70103; "Project Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = const('PROJECT'), "Code" = field("Global Dimension 1 Code")));
        }
        field(70104; "GL Account Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account".Name where("No." = field("G/L Account No.")));
        }

    }
}
