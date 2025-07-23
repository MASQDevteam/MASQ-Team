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
        field(70101; "Expense Category Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
