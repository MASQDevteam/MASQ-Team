pageextension 70171 "Custom Cleanup Action" extends "Integration Synch. Job List"
{
    actions
    {
        addafter(Delete0days)
        {
            action(FastCleanupCustom)
            {
                ApplicationArea = All;
                Caption = 'Fast Cleanup (Custom)';
                ToolTip = 'Delete old entries with custom settings.';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    FastSynchJobCleanup: Codeunit "Fast Synch. Job Cleanup";
                    CleanupRequestPage: Page "Fast Cleanup Request";
                    DaysOld: Integer;
                    UseBatching: Boolean;
                    BatchSize: Integer;
                begin
                    if CleanupRequestPage.RunModal() = Action::OK then begin
                        DaysOld := CleanupRequestPage.GetDaysOld();
                        UseBatching := CleanupRequestPage.GetUseBatching();
                        BatchSize := CleanupRequestPage.GetBatchSize();

                        if Confirm('Delete all entries older than %1 days?', false, DaysOld) then begin
                            if UseBatching then
                                FastSynchJobCleanup.DeleteEntriesWithProgress(DaysOld, BatchSize)
                            else
                                FastSynchJobCleanup.DeleteOldEntries(DaysOld);
                            CurrPage.Update(false);
                            Message('Cleanup completed successfully. Check Activity Log for details.');
                        end;
                    end;
                end;
            }
        }
    }
}