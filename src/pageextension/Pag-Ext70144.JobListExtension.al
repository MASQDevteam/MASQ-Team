pageextension 70144 "Job List Extension" extends "Job List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bill-to Customer No.")
        {
            field("Bill-to Name"; Rec."Bill-to Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the name of the customer that you send or sent the invoice or credit memo to.';
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
            }
        }
        addbefore("Job Details")
        {
            part("Variation Order"; "Variation Order Factbox")
            {
                ApplicationArea = All;
                Caption = 'Variation Order';
                // Provider = SalesLines;
                SubPageLink = "Project Code" = field("No.");
                // "Document Type" = field("Document Type");
            }
        }
        addafter("Project Manager")
        {
            field("Apollo Project Manager"; Rec."Apollo Project Manager")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Apollo Project Manager field.', Comment = '%';
            }
            field("Shipping Quotation No."; Rec."Shipping Quotation No.")
            {
                ApplicationArea = All;
                DrillDownPageId = "Shipping Quotation Projects";
            }
        }


        addafter(Description)
        {
            field("Apollo Project Number"; Rec."Apollo Project Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Apollo Project Number field.', Comment = '%';
            }
            field("Total Exported Quantity"; Rec."Total Exported Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Exported Quantity field.', Comment = '%';
                DrillDownPageId = "Job Planning Lines";
            }
            // field("Box Mover"; Rec."Box Mover")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Box Mover field.', Comment = '%';
            // }
            field("Apollo Total Offer Value"; Rec."Apollo Total Offer Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Apollo Total Offer Value field.', Comment = '%';
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the location code of the project.';
            }
            field("Delivery Location Code"; Rec."Delivery Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Location Code field.', Comment = '%';
            }
            field("Starting Date"; Rec."Starting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date on which the project actually starts.';
            }
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date on which the project is expected to be completed.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}