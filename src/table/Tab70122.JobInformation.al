table 70122 "Job Information"
{
    DataClassification = ToBeClassified;

    fields
    {
        // New Fields as requested
        field(2; "Job#"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Sales Rep"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('SALESPERSON'));
        }

        field(4; "Job Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Status"; Option)
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

        field(6; "Project Manager"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
        }

        field(7; "Job Currency"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }

        field(8; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Developer"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
        }

        field(10; "Total Expense Allocated"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = sum("Job Expense Allocation".Amount where("Job#" = field("Job#")));
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;


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


            end;
        }

        // Foreign key to the Shipping Quotation Table
    }





    keys
    {
        key(PK; "Job#")
        {
            Clustered = true;
        }


    }
    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        GLSetup: Record "General Ledger Setup";

    //  NoSeries: Codeunit "No. Series";
    begin
        if Rec."Job#" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("Job No. Series");
            if NoSeries.AreRelated(GLSetup."Job No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."Job No. Series";

            Rec."Job#" := NoSeries.GetNextNo(Rec."No. Series");


        end;
    end;
}
