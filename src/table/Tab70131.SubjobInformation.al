table 70131 "Subjob Information"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Subjob ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Subjob ID';
        }
        field(2; "Job#"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job ID';
        }
        field(3; "Subjob Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subjob Name';
        }
        field(4; "Status"; Option)
        {
            OptionCaption = 'Open, Win, Lose';
            OptionMembers = Open,Win,Lose;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            begin
                IF Rec.Status = Rec.Status::Win then begin
                    Rec.TestField("Project Code");
                end;
            end;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(7; "Assigned To"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Assigned To';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
        }
        field(8; "Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Notes';
        }
        field(12; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = job;

            trigger OnValidate()
            var
                JobRec: Record Job;
            begin
                IF "Project Code" = '' then begin
                    Clear(JobRec);
                    JobRec.Get("Project Code");
                    "Project Name" := JobRec.Description;
                end;

                IF Rec."Project Code" <> '' then begin//added on 04/03/2025 only put the project Code if the Job Status is Won
                    Rec.TestField(Status, Rec.Status::Win);
                end;
            end;
        }
        field(10; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
        field(11; "Phases"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "SubJob Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Subjob Expenses"; Decimal)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Job Expense Allocation".Amount where("Subjob ID" = field("Subjob ID")));
        }
    }

    keys
    {
        key(PK; "Job#", "Subjob ID")
        {
            Clustered = true;
        }
    }
}