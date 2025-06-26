page 70106 "Hidden COA"
{
    ApplicationArea = All;
    Caption = 'Hidden COA';
    PageType = List;
    SourceTable = "G/L Account";
    SourceTableView = sorting("No.")
        where(Hide_MASQ = filter(true)); // Filter to show only hidden accounts
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the general ledger account.';
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the type of general ledger account.';
                    Editable = false;
                }
                field(Hide_MASQ; Rec.Hide_MASQ)
                {
                    ToolTip = 'Specifies whether the G/L account should be hidden.';
                    Editable = HideCOA;
                }
            }
        }
    }
    // actions
    // {
    //     area(Navigation)
    //     {
    //         action(UnhideSelected)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Unhide Selected Accounts';
    //             Image = RemoveLine;
    //             ToolTip = 'Unhide the selected accounts in the chart of accounts.';
    //             Visible = HideCOA;

    //             trigger OnAction()
    //             begin
    //                 UnhideSelectedAccounts();
    //             end;
    //         }
    // }
    // }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        HideCOA := UserSetup."Hide/Unhide Accounts in COA";
    end;

    // local procedure UnhideSelectedAccounts()
    // var
    //     GLAccount: Record "G/L Account";
    //     HiddenCOA: Page "Hidden COA";
    // begin
    //     //Clear(HiddenCOA);
    //     //GLAccount.SetRange("No.", Rec."No.");
    //     CurrPage.SetSelectionFilter(Rec);
    //     if Rec.FindSet() then
    //         repeat
    //             Rec.Hide_MASQ := false; // Unhide the account
    //             Rec.Modify(true);
    //         until Rec.Next() = 0;
    //     CurrPage.Update();
    // end;

    var
        UserSetup: Record "User Setup";
        HideCOA: Boolean;
}
