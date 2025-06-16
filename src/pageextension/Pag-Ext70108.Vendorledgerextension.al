pageextension 70108 "Vendor ledger extension" extends "Vendor Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Amount (LCY)")
        {
            field("Purchase (LCY)"; Rec."Purchase (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase (LCY) field.', Comment = '%';
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