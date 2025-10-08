codeunit 70122 "MASQ Recalc Job Costs"
{
    Permissions = tabledata "Job Ledger Entry" = m, tabledata "Value Entry" = r;

    procedure RunForFilteredSet(var SourceJLE: Record "Job Ledger Entry")
    var
        JobLedgerEntry: Record "Job Ledger Entry";
    begin
        JobLedgerEntry.Reset();
        JobLedgerEntry.CopyFilters(SourceJLE);
        if JobLedgerEntry.FindSet(false) then
            repeat
                RecalculateChargesOnEntry(JobLedgerEntry);
            until JobLedgerEntry.Next() = 0;
    end;

    local procedure RecalculateChargesOnEntry(var JobLedgerEntry: Record "Job Ledger Entry")
    var
        ValueEntryGoods: Record "Value Entry";
        ValueEntryCharges: Record "Value Entry";
        ClearingCost: Decimal;
        CustomsCost: Decimal;
        FreightCost: Decimal;
        OtherCost: Decimal;
        InsuranceCost: Decimal;
    begin
        ClearingCost := 0;
        CustomsCost := 0;
        FreightCost := 0;
        OtherCost := 0;
        InsuranceCost := 0;

        if JobLedgerEntry."Entry Type" = JobLedgerEntry."Entry Type"::Usage then begin
            Clear(ValueEntryGoods);
            ValueEntryGoods.SetRange("Job No.", JobLedgerEntry."Job No.");
            ValueEntryGoods.SetRange("Job Task No.", JobLedgerEntry."Job Task No.");
            ValueEntryGoods.SetRange("Posting Date", JobLedgerEntry."Posting Date");
            ValueEntryGoods.SetRange("Document No.", JobLedgerEntry."Document No.");
            ValueEntryGoods.SetRange("Item No.", JobLedgerEntry."No.");
            if ValueEntryGoods.FindFirst() then begin
                Clear(ValueEntryCharges);
                ValueEntryCharges.SetRange("Item Ledger Entry No.", ValueEntryGoods."Item Ledger Entry No.");
                if ValueEntryCharges.FindSet() then
                    repeat
                        if ValueEntryCharges."Gen. Prod. Posting Group" = 'CLEARING' then
                            ClearingCost += ValueEntryCharges."Cost Amount (Actual)"
                        else
                            if ValueEntryCharges."Gen. Prod. Posting Group" = 'CUSTOMS' then
                                CustomsCost += ValueEntryCharges."Cost Amount (Actual)"
                            else
                                if ValueEntryCharges."Gen. Prod. Posting Group" = 'FREIGHT' then
                                    FreightCost += ValueEntryCharges."Cost Amount (Actual)"
                                else
                                    if ValueEntryCharges."Gen. Prod. Posting Group" = 'INSURANCE' then
                                        InsuranceCost += ValueEntryCharges."Cost Amount (Actual)"
                                    else
                                        if ValueEntryCharges."Gen. Prod. Posting Group" = 'OTHEREXP TAXABLE' then
                                            OtherCost += ValueEntryCharges."Cost Amount (Actual)";
                    until ValueEntryCharges.Next() = 0;

                JobLedgerEntry."Actual (Total Cost) Freight" := FreightCost;
                JobLedgerEntry."Actual (Total Cost) Custom" := CustomsCost;
                JobLedgerEntry."Actual (Total Cost) Clearance" := ClearingCost;
                JobLedgerEntry."Actual (Total Cost) Others" := OtherCost;
                JobLedgerEntry."Actual (Total Cost) Insurance" := InsuranceCost;
                JobLedgerEntry.Modify();
            end;
        end;
    end;
}


