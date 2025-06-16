pageextension 70154 SalesPerson extends "Salesperson/Purchaser Card"
{
    layout
    {
        addlast(General)
        {
            field(Target; Rec.Target)
            {
                ApplicationArea = All;
            }
            field("Target Start Date"; Rec."Target Start Date")
            {
                ApplicationArea = All;
            }
            field("Target End Date"; Rec."Target End Date")

            {
                ApplicationArea = All;
            }
        }
    }
}
