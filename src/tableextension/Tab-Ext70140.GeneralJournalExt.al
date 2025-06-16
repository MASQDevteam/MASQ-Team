tableextension 70140 "General Journal Ext " extends "Gen. Journal Line"
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
