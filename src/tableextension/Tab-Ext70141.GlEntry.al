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
    }
}
