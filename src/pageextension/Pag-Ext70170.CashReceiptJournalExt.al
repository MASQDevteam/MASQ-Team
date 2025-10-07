//NB MASQ Start
pageextension 70170 "Cash Receipt Journal Ext" extends "Cash Receipt Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Related PO No."; Rec."Related PO No.")
            {
                ApplicationArea = All;
            }
            field("Related SO No."; Rec."Related SO No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
//NB MASQ End