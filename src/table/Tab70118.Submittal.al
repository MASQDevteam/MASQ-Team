table 70118 "Submittal"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SubmittalId"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "ProjectId"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "SubmittalDate"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "SubmittalRevisionNumber"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "GeneralComment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "CreatedDate"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "CurrentStatus"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "isGenerated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Deleted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "SubmittalProjectRevisionNumber"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Dynamics Project Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
        }
    }

    keys
    {
        key(PK; "SubmittalId")
        {
            Clustered = true;
        }
    }
}
