pageextension 70167 "Item List" extends "Item List"
{
    layout
    {
        addafter("Meg Item Subcategory Code")
        {
            field("Meg Brand"; Rec."Meg Brand")
            {
                ApplicationArea = All;
            }
            field("Meg Family"; Rec."Meg Family")
            {
                ApplicationArea = All;
            }
        }
        modify("Item Category Code")
        {
            Visible = true;
        }
    }
}
