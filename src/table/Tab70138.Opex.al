table 70138 Opex
{
    Caption = 'Opex';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "GL Account No"; Code[20])
        {
            Caption = 'GL Account No';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "GL Account Name"; Text[100])
        {
            Caption = 'GL Account Name';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account".Name where("No." = field("GL Account No")));
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            FieldClass = FlowField;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("GL Account No"), "Global Dimension 1 Code" = field("Shortcut Dimension 1")));
        }
        field(5; "Shortcut Dimension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(6; Total; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = filter('62..699'), "Global Dimension 1 Code" = field("Shortcut Dimension 1")));
        }
    }
    keys
    {
        key(PK; "GL Account No", "Line No.")
        {
            Clustered = true;
        }
    }
}
