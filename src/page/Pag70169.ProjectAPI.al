page 70169 "Project API"
{
    Caption = 'Project API';
    APIGroup = 'MASQ';
    APIPublisher = 'MASQ';
    APIVersion = 'beta';
    DelayedInsert = true;
    EntityName = 'ProjectAPT';
    EntitySetName = 'ProjectAPI';
    PageType = API;
    SourceTable = Job;

    layout
    {
        area(content)
        {
            // Add fields to expose via the API

            // Add more fields as needed
            field(JobNo; Rec."No.")
            {
                Caption = 'Project No.';
            }
            field(ApolloProjectNumber; Rec."Apollo Project Number")
            {
                Caption = 'Apollo Project Number';
            }
        }
    }

    // Add any additional properties or triggers if required
}