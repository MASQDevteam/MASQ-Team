table 70104 "Company Attachments"
{
    Caption = 'Company Attachments';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(2; "Company Information ID"; Code[20])
        {
            Caption = 'Company Information ID';
            TableRelation = "Company Information"."Primary Key";
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(3; "File Name"; Text[250])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(4; "File Content"; Blob)
        {
            Caption = 'File Content';
            SubType = Memo;
            DataClassification = CustomerContent;
        }

        field(5; "File Extension"; Text[10])
        {
            Caption = 'File Extension';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(6; "Uploaded By"; Code[50])
        {
            Caption = 'Uploaded By';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(7; "Uploaded DateTime"; DateTime)
        {
            Caption = 'Uploaded DateTime';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
