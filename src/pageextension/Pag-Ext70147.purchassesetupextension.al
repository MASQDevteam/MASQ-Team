pageextension 70147 "purchasse setup extension" extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Order Nos.")
        {
            field("Purchase Request Nos."; Rec."Purchase Request Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Request Nos. field.', Comment = '%';
            }
        }
        addlast(General)
        {
            field("Local Vendor"; Rec."Local Vendor")
            {
                ApplicationArea = All;
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