tableextension 70142 SalesPersonExt extends "Salesperson/Purchaser"
{
    fields
    {
        field(70100; Target; Decimal)
        {
            Caption = 'Target';
            DataClassification = ToBeClassified;
        }
        field(70101; "Target Start Date"; Date)
        {
            Caption = 'Target Start Date';
            DataClassification = ToBeClassified;
        }
        field(70102; "Target End Date"; Date)
        {
            Caption = 'Target End Date';
            DataClassification = ToBeClassified;
        }
    }
}
