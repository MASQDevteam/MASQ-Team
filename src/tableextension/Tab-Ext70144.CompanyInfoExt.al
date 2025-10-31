tableextension 70144 "Company Info Ext" extends "Company Information"
{
    fields
    {
        field(70100; "MOF #"; Integer)
        {
            Caption = 'MOF #';
            DataClassification = ToBeClassified;
        }
        //FQ MASQ **START
        field(70101; "SCC Module Enabled"; Boolean)
        {
            Caption = 'SCC Module Enabled';
            DataClassification = ToBeClassified;
        }
        //FQ MASQ **END
    }
}
