tableextension 70131 "Activities Cue extension" extends "Activities Cue"
{
    fields
    {
        field(70100; "Intermediate Items"; Integer)
        {
            CalcFormula = count("Intermediate Items" where(Processed = const(false)));
            //  Caption = 'Ongoing Sales Quotes';
            FieldClass = FlowField;
        }
        field(70101; "Intermediate Vendors"; Integer)
        {
            CalcFormula = count("Intermediate Vendors" where(Processed = const(false)));
            // Caption = 'Ongoing Sales Quotes';
            FieldClass = FlowField;
        }
        field(70102; "Intermediate Customers"; Integer)
        {
            CalcFormula = count("Intermediate Customers" where(Processed = const(false)));
            // Caption = 'Ongoing Sales Quotes';
            FieldClass = FlowField;
        }
        field(70103; "Variation Orders"; Integer)
        {
            CalcFormula = count("Variation Order" where(Executed = const(false)));
            // Caption = 'Ongoing Sales Quotes';
            FieldClass = FlowField;
        }
    }
}
