tableextension 70148 "Contact Ext" extends Contact
{
    fields
    {
        field(70108; Department; Code[20])
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
            TableRelation = "Data MASQ Lookup".Code where(Type = const(Department));
        }
    }
}
