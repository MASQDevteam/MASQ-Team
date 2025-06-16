table 70117 "Intermediate Vendors"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Search Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Name 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Address 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "City"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Contact"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Telex No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECT'));
        }

        field(12; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('LOB'));
        }

        field(13; "Vendor Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }

        field(14; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Currency";
        }

        field(15; "Payment Terms Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }

        field(16; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }

        field(17; "Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }

        field(18; "Fax No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Gen. Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
        }

        field(20; "Post Code"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "County"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "VAT Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }

        field(24; "Mobile Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }

        field(26; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Location";
        }

        field(27; "Apollo Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "CompanySubType"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = CompanySubType;
        }

        field(29; "Classification"; Enum Classifications)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Area"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(32; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Dynamics Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "API Status"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Apollo User Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Comments to Apollo"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Apollo Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    //AN 03/05/25 
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        MASQEmail.SendEmailIntermediateVend(Rec);
    end;

    // trigger OnModify()
    // var
    //     myInt: Integer;
    // begin
    //     MASQEmail.SendEmailIntermediateVend(Rec);
    // end;

    var
        MASQEmail: Codeunit "MASQ Email";
}
