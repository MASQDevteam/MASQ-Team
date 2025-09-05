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
    }
}
//NB MASQ End