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
                field(JobTaskNo; JobTaskNo) { Editable = false; }
            }
        }
    }
    var
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

}
