//Start NB MASQ
table 70101 "WIP Project Detail"
{
    Caption = 'WIP Project Detail';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Project No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Name; Enum "WIP Name")
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(4; Value; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; Cost; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "MarkUp %"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; Profitability; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; Completion; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Project No.", Name, "Line No.")
        {
            Clustered = true;
        }
    }
}
//End NB MASQ