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
            // FQ MASQ Start
            field("Project Status"; Rec."Project Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the status of the project.';
                StyleExpr = ProjectColor;
            }
            // FQ MASQ End
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
    // FQ MASQ Start
    trigger OnAfterGetRecord()
    var
        JobPlanningLine: Record "Job Planning Line";
        SalesLine: Record "Sales Line";
        AllLinesFullyDeliveredAndInvoiced: Boolean;
        NewStatus: Enum "Project Status";

    begin
        // Decide project status from Sales Lines linked to this Job via planning lines
        /*    AllLinesFullyDeliveredAndInvoiced := true;
           SalesLine.Reset();
           SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
           SalesLine.SetRange("Job No.", Rec."No.");
           //SalesLine.SetFilter("Job Planning Line No.", '<>%1', 0);
           if SalesLine.FindSet() then
               repeat
                   if (SalesLine.Quantity <> SalesLine."Quantity Shipped") or
                      (SalesLine.Quantity <> SalesLine."Quantity Invoiced") then begin
                       AllLinesFullyDeliveredAndInvoiced := false;
                       break;
                   end;
               until SalesLine.Next() = 0;

           if AllLinesFullyDeliveredAndInvoiced then
               NewStatus := NewStatus::Closed
           else
               NewStatus := NewStatus::Open;

           if Rec."Project Status" <> NewStatus then begin
               Rec."Project Status" := NewStatus;
               Rec.Modify(true);
           end; */
        ProjectColor := ColorCodeunit.ChangeColorbasedonCustomStatusProject(rec);
        CurrPage.Update(false);
    end;

    // FQ MASQ End

    var
        myInt: Integer;

        ProjectColor: Text[50];

        ColorCodeunit: Codeunit StatusColorChange;
}