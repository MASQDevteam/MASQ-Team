//NB MASQ Start
pageextension 70168 "Purch. Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("AWB Number"; Rec."AWB Number")
            {
                ApplicationArea = All;
            }
            field("AWB PO No."; Rec."AWB PO No.")
            {
                ApplicationArea = All;
            }
            field("PO No."; Rec."PO No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
//NB MASQ End