table 70116 "Intermediate Customers"
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

        field(8; "Contact"; Text[100])
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

        field(13; "Customer Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group";
        }

        field(14; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }

        field(15; "Payment Terms Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }

        field(16; "Salesperson Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }

        field(17; "Shipment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method";
        }

        field(18; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }

        field(19; "Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }

        field(20; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }

        field(21; "Gen. Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
        }

        field(22; "Post Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }

        field(23; "County"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "VAT Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }

        field(26; "Mobile Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }

        field(28; "Road"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Street"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "District"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "PO BOX"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(32; "Building Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Building NO."; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(34; "CR"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(35; "Road Name Arabic"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(36; "Street Arabic"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(37; "District Arabic"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(38; "Building Name Arabic"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(39; "Contact Name Arabic"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(40; "Arabic Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(41; "Apollo Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(42; "CompanySubType"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(43; "Classification"; enum Classifications)
        {
            DataClassification = ToBeClassified;
        }

        field(44; "Area"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(45; "Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(46; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Dynamics Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "API Status"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Apollo User Name"; Text[50])
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
        MASQEmail.SendEmailIntermediateCust(Rec);
    end;

    // trigger OnModify()
    // var
    //     myInt: Integer;
    // begin
    //     MASQEmail.SendEmailIntermediateCust(Rec);
    // end;

    var
        MASQEmail: Codeunit "MASQ Email";
}
