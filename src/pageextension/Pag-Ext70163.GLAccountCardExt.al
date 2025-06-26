pageextension 70163 "G/L Account Card Ext" extends "G/L Account Card"
{
    layout
    {
        addafter(Blocked)
        {
            field(Hide_MASQ; Rec.Hide_MASQ)
            {
                ApplicationArea = All;
                Caption = 'Hide';
                Editable = HideCOA;
                ToolTip = 'Specifies whether the G/L account should be hidden.';
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        HideCOA := UserSetup."Hide/Unhide Accounts in COA";
    end;



    var
        UserSetup: Record "User Setup";
        HideCOA: Boolean;
}
