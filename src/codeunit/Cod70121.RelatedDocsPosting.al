//FQ MASQ **Start
codeunit 70121 "Related Docs Posting"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure OnAfterInitVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry.Validate("Related PO No.", GenJournalLine."Related PO No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnAfterInitCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry.Validate("Related SO No.", GenJournalLine."Related SO No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertGlEntry, '', true, true)]
    local procedure OnBeforeInsertGlEntrys(var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean)
    var
    begin
        GLEntry.Validate("Related PO No.", GenJnlLine."Related PO No.");
        GLEntry.Validate("Related SO No.", GenJnlLine."Related SO No.");
    end;

}
//FQ MASQ **END