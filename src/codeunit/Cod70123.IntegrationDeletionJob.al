// ------------------------------------------------------------------------------------------------
// Fast Integration Synch Job Cleanup Codeunit
// Optimized for BC 26.5 - Bulk deletion without UI prompts
// ------------------------------------------------------------------------------------------------
//FQ MASQ **START
codeunit 70123 "Fast Synch. Job Cleanup"
{
    TableNo = "Integration Synch. Job";

    trigger OnRun()
    begin
        DeleteOldEntries(30);
    end;

    procedure DeleteOldEntries(DaysOld: Integer)
    var
        IntegrationSynchJob: Record "Integration Synch. Job";
        IntegrationSynchJobErrors: Record "Integration Synch. Job Errors";
        CutoffDateTime: DateTime;
        TotalDeleted: Integer;
        StartTime: DateTime;
        Duration: Duration;
    begin
        if DaysOld < 0 then
            Error('Days old must be a positive number.');

        StartTime := CurrentDateTime;
        CutoffDateTime := CreateDateTime(Today - DaysOld, 0T);
        TotalDeleted := 0;

        // Step 1: Delete associated errors first (faster bulk delete)
        IntegrationSynchJobErrors.SetFilter("Integration Synch. Job ID", '<>%1', GetNullGuid());
        if IntegrationSynchJobErrors.FindSet() then begin
            IntegrationSynchJob.SetFilter("Finish Date/Time", '<=%1', CutoffDateTime);
            IntegrationSynchJob.SetRange(Failed, 0);
            if IntegrationSynchJob.FindSet() then
                repeat
                    IntegrationSynchJobErrors.SetRange("Integration Synch. Job ID", IntegrationSynchJob.ID);
                    IntegrationSynchJobErrors.DeleteAll(false); // No triggers for speed
                until IntegrationSynchJob.Next() = 0;
        end;

        // Step 2: Bulk delete jobs without failures (fastest method)
        IntegrationSynchJob.Reset();
        IntegrationSynchJob.SetFilter("Finish Date/Time", '<=%1', CutoffDateTime);
        IntegrationSynchJob.SetRange(Failed, 0);

        if IntegrationSynchJob.FindSet() then begin
            TotalDeleted := IntegrationSynchJob.Count;
            IntegrationSynchJob.DeleteAll(false); // Skip OnDelete trigger for speed
        end;

        // Step 3: Handle jobs with failures (check if removable)
        IntegrationSynchJob.Reset();
        IntegrationSynchJob.SetFilter("Finish Date/Time", '<=%1', CutoffDateTime);
        IntegrationSynchJob.SetFilter(Failed, '>%1', 0);

        if IntegrationSynchJob.FindSet() then
            repeat
                if CanBeRemoved(IntegrationSynchJob) then begin
                    // Delete errors first
                    IntegrationSynchJobErrors.SetRange("Integration Synch. Job ID", IntegrationSynchJob.ID);
                    IntegrationSynchJobErrors.DeleteAll(false);

                    // Delete job
                    IntegrationSynchJob.Delete(false);
                    TotalDeleted += 1;
                end;
            until IntegrationSynchJob.Next() = 0;

        Duration := CurrentDateTime - StartTime;
    end;

    procedure DeleteAllOldEntries(DaysOld: Integer)
    var
        IntegrationSynchJob: Record "Integration Synch. Job";
        IntegrationSynchJobErrors: Record "Integration Synch. Job Errors";
        CutoffDateTime: DateTime;
        JobIDs: List of [Guid];
        JobID: Guid;
        TotalDeleted: Integer;
        StartTime: DateTime;
        Duration: Duration;
    begin
        if DaysOld < 0 then
            Error('Days old must be a positive number.');

        StartTime := CurrentDateTime;
        CutoffDateTime := CreateDateTime(Today - DaysOld, 0T);

        // Collect all job IDs to delete
        IntegrationSynchJob.SetFilter("Finish Date/Time", '<=%1', CutoffDateTime);
        if IntegrationSynchJob.FindSet() then
            repeat
                JobIDs.Add(IntegrationSynchJob.ID);
            until IntegrationSynchJob.Next() = 0;

        TotalDeleted := JobIDs.Count;

        // Delete all errors in bulk
        IntegrationSynchJobErrors.SetFilter("Integration Synch. Job ID", '<>%1', GetNullGuid());
        foreach JobID in JobIDs do begin
            IntegrationSynchJobErrors.SetRange("Integration Synch. Job ID", JobID);
            IntegrationSynchJobErrors.DeleteAll(false);
        end;

        // Delete all jobs in bulk
        IntegrationSynchJob.Reset();
        IntegrationSynchJob.SetFilter("Finish Date/Time", '<=%1', CutoffDateTime);
        IntegrationSynchJob.DeleteAll(false);

        Duration := CurrentDateTime - StartTime;
    end;

    procedure DeleteEntriesWithProgress(DaysOld: Integer; BatchSize: Integer)
    var
        IntegrationSynchJob: Record "Integration Synch. Job";
        IntegrationSynchJobErrors: Record "Integration Synch. Job Errors";
        CutoffDateTime: DateTime;
        TotalDeleted: Integer;
        BatchCount: Integer;
        StartTime: DateTime;
    begin
        if DaysOld < 0 then
            Error('Days old must be a positive number.');

        if BatchSize <= 0 then
            BatchSize := 1000; // Default batch size

        StartTime := CurrentDateTime;
        CutoffDateTime := CreateDateTime(Today - DaysOld, 0T);
        TotalDeleted := 0;
        BatchCount := 0;

        // Process in batches to avoid locking issues
        IntegrationSynchJob.SetFilter("Finish Date/Time", '<=%1', CutoffDateTime);
        IntegrationSynchJob.SetRange(Failed, 0);

        while IntegrationSynchJob.FindSet() do begin
            BatchCount := 0;
            repeat
                IntegrationSynchJobErrors.SetRange("Integration Synch. Job ID", IntegrationSynchJob.ID);
                IntegrationSynchJobErrors.DeleteAll(false);
                IntegrationSynchJob.Delete(false);
                TotalDeleted += 1;
                BatchCount += 1;
            until (IntegrationSynchJob.Next() = 0) or (BatchCount >= BatchSize);

            Commit(); // Commit each batch

            // Progress tracking (optional)
            if BatchCount > 0 then
                Message('Processed batch: %1 records deleted', BatchCount);
        end;

    end;

    local procedure CanBeRemoved(IntegrationSynchJob: Record "Integration Synch. Job"): Boolean
    var
        AllowRemoval: Boolean;
    begin
        AllowRemoval := true;
        OnCanBeRemoved(IntegrationSynchJob, AllowRemoval);
        exit(AllowRemoval);
    end;

    local procedure GetNullGuid(): Guid
    var
        NullGuid: Guid;
    begin
        exit(NullGuid);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCanBeRemoved(IntegrationSynchJob: Record "Integration Synch. Job"; var AllowRemoval: Boolean)
    begin
    end;
}
//FQ MASQ **END