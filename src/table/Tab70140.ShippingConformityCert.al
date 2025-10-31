//FQ MASQ**START**
table 70140 "Shipping Conformity Cert"
{
    Caption = 'Shipping Conformity Certificate';
    DataClassification = CustomerContent;
    LookupPageId = "Shipping Conformity Cert. List";
    DrillDownPageId = "Shipping Conformity Cert. List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            var
                PurchaseSetup: Record "Purchases & Payables Setup";
            begin
                if "No." <> xRec."No." then begin
                    PurchaseSetup.Get();
                    NoSeriesNew.TestManual(PurchaseSetup."SCC Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
            Editable = false;
        }



        field(3; "Agent Code"; Code[20])
        {
            Caption = 'Agent Code';
            DataClassification = CustomerContent;
            TableRelation = Vendor where("No." = const('VL00116'));

            trigger OnValidate()
            begin
                if "Agent Code" <> '' then begin
                    Agent.Get("Agent Code");
                    "Agent Name" := Agent.Name;
                end else
                    "Agent Name" := '';
            end;
        }

        field(4; "Agent Name"; Text[100])
        {
            Caption = 'Agent Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(5; "Country of Loading"; Code[10])
        {
            Caption = 'Country of Loading';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
            trigger OnValidate()
            begin
                if "Country of Loading" <> '' then begin
                    Country.Get("Country of Loading");
                    CountryName := Country.Name;
                end else
                    CountryName := '';
            end;
        }

        field(6; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
            ToolTip = 'Request date sent to agent';
        }

        field(7; "Sadad Reference"; Code[50])
        {
            Caption = 'Sadad Reference';
            DataClassification = CustomerContent;
            ToolTip = 'Reference from SADAD platform';
        }

        field(8; "Sadad Issuance Date"; Date)
        {
            Caption = 'Sadad Issuance Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date from SADAD platform';
        }
        field(9; "Sadad Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Sadad Expiry Date';
        }

        field(10; "SABER App. No"; Code[50])
        {
            Caption = 'SABER App. No';
            DataClassification = CustomerContent;
            ToolTip = 'Application number from SABER platform';
        }

        field(11; "SABER Issuance Date"; Date)
        {
            Caption = 'SABER Issuance Date';
            DataClassification = CustomerContent;
            ToolTip = 'SABER Issuance Date from SABER platform';
        }
        field(12; "SABER Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'SABER Expiry Date';
            ToolTip = 'SABER Expiry Date from SABER platform';
        }

        field(13; "SCC Number"; Code[50])
        {
            Caption = 'Shipment Conformity Certificate No.';
            DataClassification = CustomerContent;
            ToolTip = 'Certificate number from SABER platform. Enter NA for rejected, leave blank for in process';

            trigger OnValidate()
            begin
                UpdateCertificateStatus();
                ValidateApprovedCertificate();
            end;
        }

        field(14; "SCC Issuance Date"; Date)
        {
            Caption = 'SCC Issuance Date';
            DataClassification = CustomerContent;
            ToolTip = 'SCC Issuance Date from SABER platform';
        }
        field(15; "SCC Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Agent Invoice No."; Code[50])
        {
            Caption = 'Agent Invoice No.';
            DataClassification = CustomerContent;
        }

        field(17; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = CustomerContent;
        }

        field(18; "HS Code Sadad"; Code[50])
        {
            Caption = 'HS Code Sadad';
            DataClassification = CustomerContent;
            ToolTip = 'HS Code as submitted for SADAD';
        }

        field(19; "HS Code Supplier"; Code[50])
        {
            Caption = 'HS Code Supplier';
            DataClassification = CustomerContent;
            ToolTip = 'HS Code as per supplier documents';
        }

        field(20; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }

        field(21; "Certificate Status"; Option)
        {
            Caption = 'Certificate Status';
            DataClassification = CustomerContent;
            OptionMembers = "In Process",Completed,Rejected;
            OptionCaption = 'In Process,Completed,Rejected';
            Editable = false;
        }

        field(22; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Editable = false;
        }
        field(23; CountryName; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'COL Name';
            Editable = false;
        }
        field(24; "Shipment Mode"; Enum "SCC Shipment Mode")
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
        key(Status; "Certificate Status", "Document Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Certificate Status")
        {
        }
        fieldgroup(Brick; "No.", "Certificate Status", "SCC Number")
        {
        }
    }

    trigger OnInsert()
    var
        PurchaseSetup: Record "Purchases & Payables Setup";
    begin
        if "No." = '' then begin
            PurchaseSetup.Get();
            PurchaseSetup.TestField("SCC Nos.");
            if NoSeriesNew.AreRelated(PurchaseSetup."SCC Nos.", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := PurchaseSetup."SCC Nos.";

            Rec."No." := NoSeriesNew.GetNextNo(Rec."No. Series");
        end;
        InitRecord();
    end;

    trigger OnDelete()
    begin
        if "Certificate Status" = "Certificate Status"::Completed then
            Error(CannotDeleteCompletedErr);
    end;

    var

        PurchaseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        Agent: Record Vendor;

        Country: Record "Country/Region";
        NoSeriesNew: Codeunit "No. Series";
        CannotDeleteCompletedErr: Label 'Cannot delete a completed certificate.';
        OnlyOneApprovedErr: Label 'Only one completed certificate is allowed per Purchase Order. Certificate %1 is already completed for this order.';

    local procedure InitRecord()
    begin
        if "Document Date" = 0D then
            "Document Date" := Today;

        UpdateCertificateStatus();
    end;

    local procedure UpdateCertificateStatus()
    begin
        case true of
            "SCC Number" = '':
                "Certificate Status" := "Certificate Status"::"In Process";
            UpperCase("SCC Number") = 'NA':
                "Certificate Status" := "Certificate Status"::Rejected;
            else
                "Certificate Status" := "Certificate Status"::Completed;
        end;
    end;

    local procedure ValidateApprovedCertificate()
    var
        SCCOrderLine: Record "SCC Order Line";
        ExistingSCCOrderLine: Record "SCC Order Line";
        SCCMgt: Codeunit "SCC Management";
    begin
        if "Certificate Status" <> "Certificate Status"::Completed then
            exit;

        // Check all POs in this certificate
        SCCOrderLine.SetRange("SCC No.", "No.");
        if SCCOrderLine.FindSet() then
            repeat
                // Check if there are any existing completed certificates for the same PO
                ExistingSCCOrderLine.SetRange("Purchase Order No.", SCCOrderLine."Purchase Order No.");
                ExistingSCCOrderLine.SetFilter("SCC No.", '<>%1', "No.");

                if ExistingSCCOrderLine.FindSet() then begin
                    repeat
                        if SCCMgt.IsCertificateCompleted(ExistingSCCOrderLine."SCC No.") then
                            Error(OnlyOneApprovedErr, ExistingSCCOrderLine."SCC No.");
                    until ExistingSCCOrderLine.Next() = 0;
                end;
            until SCCOrderLine.Next() = 0;
    end;

    /// <summary>
    /// Validates if a new SCC can be created for the purchase order
    /// </summary>
    procedure ValidateNewCertificate(PurchaseOrderNo: Code[20])
    begin
        if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderNo) then
            Error('Purchase Order %1 does not exist.', PurchaseOrderNo);

        if PurchaseHeader.Status <> PurchaseHeader.Status::Released then
            Error('Purchase Order must be Released to create a Shipping Conformity Certificate.');
    end;

}
//FQ MASQ**END**