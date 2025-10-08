pageextension 70142 "job ledger entries extension" extends "Job Ledger Entries"
{

    layout
    {
        // Add changes to page layout here
        addafter("Total Cost (LCY)")
        {
            field("Actual (Total Cost) Freight"; Rec."Actual (Total Cost) Freight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Freight field.', Comment = '%';
            }
            field("Actual (Total Cost) Clearance"; Rec."Actual (Total Cost) Clearance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Clearance field.', Comment = '%';
            }
            field("Actual (Total Cost) Custom"; Rec."Actual (Total Cost) Custom")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Custom field.', Comment = '%';
            }
            field("Actual (Total Cost) Others"; Rec."Actual (Total Cost) Others")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Others field.', Comment = '%';
            }
            field("Actual (Total Cost) Insurance"; Rec."Actual (Total Cost) Insurance")//added on 10022025
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Insurance field.', Comment = '%';
            }
            field("Project Plannig Line No."; Rec."Project Plannig Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Project Plannig Line No. field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Transfer To Planning Lines")
        {
            //FQ MASQ **Start**
            action("update Charges")
            {
                ApplicationArea = All;
                Caption = 'Update Charges';
                Image = AdjustItemCost;
                ToolTip = 'Update Charges on Job Ledger Entry single line';
                trigger OnAction()
                var
                    MASQSubscribers: Codeunit "MASQ Subs & Functions";
                begin
                    MASQSubscribers.UpdateChargesonJobLedgerEntry(Rec);
                end;
            }

            action("Recalculate Costs (All)")
            {
                ApplicationArea = All;
                Image = Recalculate;
                ToolTip = 'Recalculate Actual Total Cost fields on current filtered Job Ledger Entries.';
                trigger OnAction()
                var
                    Recalc: Codeunit "MASQ Recalc Job Costs";
                    JobLedgEntry: Record "Job Ledger Entry";
                    ProcessedCount: Integer;
                begin
                    // Count records in the current filtered set for user feedback
                    JobLedgEntry.Reset();
                    JobLedgEntry.CopyFilters(Rec);
                    if JobLedgEntry.FindSet() then begin
                        repeat
                            ProcessedCount += 1;
                        until JobLedgEntry.Next() = 0;
                    end;

                    Recalc.RunForFilteredSet(Rec);
                    Message('Recalculation Actual total cost fields completed for %1 Job Ledger Entries.', ProcessedCount);
                end;
            }

            action("update Price")
            {
                ApplicationArea = All;
                Caption = 'Update Price';
                Image = PriceAdjustment;
                ToolTip = 'Update Price';
                trigger OnAction()
                var
                    MASQSubscribers: Codeunit "MASQ Subs & Functions";
                    JobLedgEntry: Record "Job Ledger Entry";
                    UpdatedCount: Integer;
                begin
                    // Apply to all records in the current filtered set
                    JobLedgEntry.Reset();
                    JobLedgEntry.CopyFilters(Rec);
                    if JobLedgEntry.FindSet() then begin
                        repeat
                            MASQSubscribers.updatepriceandAmount(JobLedgEntry);
                            UpdatedCount += 1;
                        until JobLedgEntry.Next() = 0;
                    end;

                    Message('Updated price and amount on %1 Job Ledger Entries.', UpdatedCount);
                end;
            }
            //FQ MASQ **End**
        }
    }

    var
        myInt: Integer;
}