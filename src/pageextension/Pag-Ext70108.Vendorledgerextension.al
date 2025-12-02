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
        //NB MASQ Start
        addafter("Shortcut Dimension 8 Code")
        {
            field("Employee Description"; Rec."Employee Description")
            {
                ApplicationArea = All;
                ToolTip = 'Displays the name of the employee associated with this entry.';
            }
        }
        addafter("Global Dimension 1 Code")
        {
            field("Project Name"; Rec."Project Name")
            {
                ApplicationArea = All;
            }
        }
        //NB MASQ End

        //FQ MASQ** Start
        addafter("External Document No.")
        {
            field("Related PO No."; Rec."Related PO No.")
            {
                ApplicationArea = All;
                Caption = 'Related PO No.';
                Editable = false;
                //Visible = (Rec."Account Type" = Rec."Account Type"::Vendor);
            }
            //FQ MASQ** End
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}