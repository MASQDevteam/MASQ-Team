page 70167 "Project Invoice API"
{
    Caption = 'Project Invoice';
    APIGroup = 'MASQ';
    APIPublisher = 'MASQ';
    APIVersion = 'beta';
    DelayedInsert = true;
    EntityName = 'ProjectInvoice';
    EntitySetName = 'ProjectInvoice1';
    PageType = API;
    SourceTable = "Job Planning Line Invoice";

    layout
    {
        area(content)
        {
            // Add fields to expose via the API

            // Add more fields as needed
            field(jobNo; Rec."Job No.")
            {
                Caption = 'Project No.';
            }
            field(jobTaskNo; Rec."Job Task No.")
            {
                Caption = 'Project Task No.';
            }
            field(documentNo; Rec."Document No.")
            {
                Caption = 'Document No.';
            }
            field(itemNo; Rec."Item no.")
            {
                Caption = 'Item no.';
            }
        }
    }

    // Add any additional properties or triggers if required
}