//NB MASQ Start
tableextension 70149 "Vendor Ledger Entry Ext" extends "Vendor Ledger Entry"
{
    fields
    {
        field(70100; "Employee Description"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = filter('EMPLOYEE'),
                                                                Code = field("Shortcut Dimension 8 Code")));
            Editable = false;
        }
        //FQ MASQ**Start
        field(70101; "Related PO No."; Code[20])
        {
            Caption = 'Related PO No.';
            DataClassification = CustomerContent;
        }
        //FQ MASQ**END
    }
}
//NB MASQ End