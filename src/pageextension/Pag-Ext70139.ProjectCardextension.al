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
            field("Project Type"; Rec."Project Type")
            {
                ApplicationArea = All;
            }
            field("Project Submittal Type"; Rec."Project Submittal Type")
            {
                ApplicationArea = All;
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
        addbefore("WIP and Recognition")
        {
            group(Opex)
            {
                part("Opex List"; "Opex ")
                {
                    ApplicationArea = All;
                    SubPageLink = "Shortcut Dimension 1" = field("Global Dimension 1 Code");
                }
            }
        }
    }
    actions
    {
        addafter("&Job")
        {
            action("Insert Opex")
            {
                ApplicationArea = All;
                Image = Add;
                trigger OnAction()
                begin
                    InsertOpex(Rec."Global Dimension 1 Code");
                end;
            }
        }

    }

    //AN 07/25/2025
    procedure InsertOpex(ProjectCode: Code[20])
    var
        GLEntry: Record "G/L Entry";
        LineNo: Integer;
        Opex: Record Opex;
        CurrentGLAcc: Code[20];
    begin
        Clear(GLEntry);
        Clear(Opex);
        CurrentGLAcc := '';

        // Get the last Entry No. from Opex table
        if Opex.FindLast() then
            LineNo := Opex."Line No."
        else
            LineNo := 0;

        GLEntry.Reset();
        GLEntry.SetCurrentKey("G/L Account No.");
        GLEntry.SetFilter("G/L Account No.", '62..699');
        GLEntry.SetRange("Global Dimension 1 Code", ProjectCode);

        if GLEntry.FindSet() then
            repeat
                if GLEntry."G/L Account No." <> CurrentGLAcc then begin
                    CurrentGLAcc := GLEntry."G/L Account No.";

                    // Check if this G/L Account No. already exists in Opex
                    Opex.Reset();
                    Opex.SetRange("GL Account No", CurrentGLAcc);
                    Opex.SetRange("Shortcut Dimension 1", ProjectCode);
                    if not Opex.FindFirst() then begin
                        LineNo += 10000;
                        Opex.Init();
                        Opex."Line No." := LineNo;
                        Opex."GL Account No" := CurrentGLAcc;
                        Opex."Shortcut Dimension 1" := ProjectCode;
                        Opex.Insert();
                    end;
                end;
            until GLEntry.Next() = 0;
    end;


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