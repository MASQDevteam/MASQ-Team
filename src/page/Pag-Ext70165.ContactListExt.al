pageextension 70165 "Contact List Ext" extends "Contact List"
{
    layout
    {
        addlast(Control1)
        {
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
        }
    }
}
