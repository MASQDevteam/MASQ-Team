pageextension 70137 "Posted sales ship Subform " extends "Posted Sales Shpt. Subform"
{//Abdallah10102024
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {

            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.', Comment = '%';
            }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}