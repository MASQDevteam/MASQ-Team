table 70137 "Data MASQ Lookup"
{
    Caption = 'Data MASQ Lookup';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Data MASQ Lookup";
    LookupPageId = "Data MASQ Lookup";
    fields
    {
        field(1; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ","Documentation","Freight","Department";
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Type", "Code")
        {
            Clustered = true;
        }
    }
}
