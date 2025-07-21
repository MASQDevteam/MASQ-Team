pageextension 70166 "Contact Card Ext" extends "Contact Card"
{
    layout
    {
        addlast(General)
        {
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
        }
    }
}
