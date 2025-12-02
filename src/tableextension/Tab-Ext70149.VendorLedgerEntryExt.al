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
            TableRelation = "Purchase Header"."No." WHERE("No." = field("Related PO No."));
            Editable = false;
        }
        field(70102; "Project Name"; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = const('PROJECT'),
                                                            Code = field("Global Dimension 1 Code"),
                                                            "Global Dimension No." = const(1)));
        }
        //FQ MASQ**END
    }
}
//NB MASQ End