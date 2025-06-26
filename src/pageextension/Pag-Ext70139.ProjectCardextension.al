pageextension 70139 "Project Card extension" extends "Job Card"
{
    layout
    {
        modify(Description)
        {
            ShowMandatory = true;
        }
        // Add changes to page layout here
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
        addafter("Location Code")
        {
            field("Delivery Location Code"; Rec."Delivery Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Location Code field.', Comment = '%';
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
            field("Box Mover"; Rec."Box Mover")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Box Mover field.', Comment = '%';
            }
            field("Apollo Total Offer Value"; Rec."Apollo Total Offer Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Apollo Total Offer Value field.', Comment = '%';
            }
        }

        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                ProjectTasks: Record "Job Task";
            begin
                Clear(ProjectTasks);
                IF NOT ProjectTasks.Get(Rec."No.", Rec."No." + '.1') then begin
                    Clear(ProjectTasks);
                    ProjectTasks.Init();
                    ProjectTasks.Validate("Job No.", Rec."No.");
                    ProjectTasks.Validate("Job Task No.", Rec."No." + '.1');
                    ProjectTasks.Insert(true);
                end;
            end;

        }
        addafter("Project Manager")
        {
            field("Apollo Project Manager"; Rec."Apollo Project Manager")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Apollo Project Manager field.', Comment = '%';
            }
        }
    }
    //AN 03/27/2025
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        Rec.TestField(Description);
    end;

    var
        myInt: Integer;
}