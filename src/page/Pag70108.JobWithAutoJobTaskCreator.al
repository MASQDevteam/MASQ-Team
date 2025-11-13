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
                field(JobTaskNo; ProjectTaskNo) { Editable = false; }
                field("SelltoCustomerNo"; Rec."Sell-to Customer No.")
                {
                    trigger OnValidate()
                    var

                        //NoSeriesMgt: Codeunit NoSeriesManagement;
                        NoSeriesNew: Codeunit "No. Series";
                        NoSeriesCode: Code[20];
                        JobsSetup: Record "Jobs Setup";
                    begin
                        ProjectTaskNo := '';
                        JobsSetup.Get();
                        NoSeriesCode := JobsSetup."Job Nos.";
                        Rec."No." := NoSeriesNew.GetNextNo(NoSeriesCode, Today(), true);//FQ MASQ
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
                field("ApplyUsageLink"; Rec."Apply Usage Link")
                {

                }
            }
        }
    }
    var
        ProjectTasks: Record "Job Task";
        ProjectTaskNo: Code[20];
}
