pageextension 70164 "Chart of Accounts Ext" extends "Chart of Accounts"
{
    actions
    {
        addafter("A&ccount")
        {
            //aya+
            action(ShowHiddenAccounts)
            {
                ApplicationArea = All;
                Caption = 'Show Hidden Accounts';
                Image = ShowChart;
                ToolTip = 'Show hidden accounts in the Chart of Accounts.';
                Enabled = HideCOA;
                trigger OnAction()
                var
                    HiddenCOA: Page "Hidden COA";
                begin
                    HiddenCOA.Run();
                end;
            }
            action(HideEmptyDebitandCredit)
            {
                ApplicationArea = All;
                Caption = 'Hide Empty Debit and Credit';
                Image = Cancel;
                ToolTip = 'Hide accounts with zero balance in the Chart of Accounts.';
                Enabled = HideCOA;
                trigger OnAction()
                var
                // GLAcc: Record "G/L Account";
                begin
                    if not Confirm('This will hide all accounts with zero Debit and Credit. Do you want to continue?', false) then
                        exit;

                    // GLAcc.Reset();
                    // if GLAcc.FindSet() then begin
                    repeat
                        Rec.CalcFields("Debit Amount", "Credit Amount");
                        if (Rec."Debit Amount" = 0) and (Rec."Credit Amount" = 0) then begin
                            Rec.Hide_MASQ := true;
                            Rec.Modify();
                        end else begin
                            Rec.Hide_MASQ := false;
                            Rec.Modify();
                        end;
                    until Rec.Next() = 0;
                    // end;
                    Message('Accounts updated based on Debit and Credit values.');
                end;
            }
            //aya-
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.FilterGroup(4);
        Rec.SetRange(Hide_MASQ, false);
        UserSetup.Get(UserId);
        HideCOA := UserSetup."Hide/Unhide Accounts in COA";
    end;

    var
        UserSetup: Record "User Setup";
        HideCOA: Boolean;
}
