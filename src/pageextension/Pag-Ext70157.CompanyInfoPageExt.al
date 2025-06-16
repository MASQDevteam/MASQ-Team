pageextension 70157 "Company Info Page Ext" extends "Company Information"
{
    layout
    {
        addafter("VAT Registration No.")
        {
            field("MOF #"; Rec."MOF #")
            {
                ApplicationArea = All;
            }
        }
    }
}
