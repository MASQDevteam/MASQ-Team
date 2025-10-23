page 70181 "Fast Cleanup Request"
{
    PageType = StandardDialog;
    Caption = 'Fast Cleanup Settings';


    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Cleanup Options';

                field(DaysOld; DaysOld)
                {
                    ApplicationArea = All;
                    Caption = 'Delete entries older than (days)';
                    ToolTip = 'Specify how many days old the entries should be before deletion.';
                    MinValue = 0;

                    trigger OnValidate()
                    var
                        IntegrationSynchJob: Record "Integration Synch. Job";
                        CutoffDateTime: DateTime;
                    begin
                        if DaysOld < 0 then
                            Error('Days must be 0 or greater.');
                        CutoffDateTime := CreateDateTime(Today - DaysOld, 0T);
                        IntegrationSynchJob.SetFilter("Finish Date/Time", '<=%1', CutoffDateTime);
                        RecordsToDelete := IntegrationSynchJob.Count;
                        CurrPage.Update(false);

                    end;
                }

                field(UseBatching; UseBatching)
                {
                    ApplicationArea = All;
                    Caption = 'Use Batched Processing';
                    ToolTip = 'Enable this for large datasets (>50,000 records) to avoid database locks.';

                    trigger OnValidate()
                    begin
                        BatchSizeEditable := UseBatching;
                    end;
                }

                field(BatchSize; BatchSize)
                {
                    ApplicationArea = All;
                    Caption = 'Batch Size';
                    ToolTip = 'Number of records to process in each batch (recommended: 1000).';
                    MinValue = 100;
                    Editable = BatchSizeEditable;
                }

                group(Preview_1)
                {
                    Caption = 'Preview';

                    field(RecordsToDelete; RecordsToDelete)
                    {
                        ApplicationArea = All;
                        Caption = 'Estimated Records to Delete';
                        ToolTip = 'Approximate number of records that will be deleted.';
                        Editable = false;
                        Style = Attention;
                    }
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        DaysOld := 30; // Default
        UseBatching := false;
        BatchSize := 1000;
        BatchSizeEditable := false;
        RecordsToDelete := 0;
    end;


    var
        DaysOld: Integer;
        UseBatching: Boolean;
        BatchSize: Integer;
        RecordsToDelete: Integer;
        BatchSizeEditable: Boolean;

    procedure GetDaysOld(): Integer
    begin
        exit(DaysOld);
    end;

    procedure GetUseBatching(): Boolean
    begin
        exit(UseBatching);
    end;

    procedure GetBatchSize(): Integer
    begin
        exit(BatchSize);
    end;
}