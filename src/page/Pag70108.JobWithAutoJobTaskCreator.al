page 70108 JobWithAutoJobTaskCreator
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = Job;
    APIPublisher = 'masq';
    APIGroup = 'apollo';
    APIVersion = 'v1.0';
    EntityName = 'jobwithautojobtaskcreator';
    EntitySetName = 'jobwithautojobtaskcreators';
    layout
    {
        area(content)
        {
            group(Group)
            {
                field(ApolloProjectNumber; Rec."Apollo Project Number") { }
                field(ProjectName; Rec.Description) { }
                field(JobNo; Rec."No.") { Editable = false; }
<<<<<<< HEAD
                field(JobTaskNo; JobTaskNo) { Editable = false; }
=======
                field(JobTaskNo; ProjectTaskNo) { Editable = false; }
                field("SelltoCustomerNo"; Rec."Sell-to Customer No.")
                {
                    trigger OnValidate()
                    var

                        NoSeriesMgt: Codeunit NoSeriesManagement;
                        NoSeriesCode: Code[20];
                        JobsSetup: Record "Jobs Setup";
                    begin
                        ProjectTaskNo := '';
                        JobsSetup.Get();
                        NoSeriesCode := JobsSetup."Job Nos.";
                        Rec."No." := NoSeriesMgt.GetNextNo(NoSeriesCode, Today(), true);
                        Rec.Insert();
                        Clear(ProjectTasks);
                        IF NOT ProjectTasks.Get(Rec."No.", Rec."No." + '.1') then begin
                            Clear(ProjectTasks);
                            ProjectTasks.Init();
                            ProjectTasks.Validate("Job No.", Rec."No.");
                            ProjectTasks.Validate("Job Task No.", Rec."No." + '.1');
                            ProjectTasks.Insert(true);
                            ProjectTaskNo := ProjectTasks."Job Task No.";
                        end;
                    end;
                }
                field(ProjectType; Rec."Project Type")
                {

                }
                field(ProjectSubmittalType; Rec."Project Submittal Type")
                {

                }
>>>>>>> origin
            }
        }
    }
    var
<<<<<<< HEAD
        JobTask: Record "Job Task";
        JobTaskNo: Code[20];

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Insert();
        JobTask.Init();
        JobTask."Job No." := Rec."No.";
        JobTask.Description := 'Main Task';
        JobTask.Insert(true);
        JobTaskNo := JobTask."Job Task No.";
        exit(true);
    end;

=======
        ProjectTasks: Record "Job Task";
        ProjectTaskNo: Code[20];
>>>>>>> origin
}
