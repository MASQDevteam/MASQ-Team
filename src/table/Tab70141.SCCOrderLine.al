//FQ MASQ**START**
table 70141 "SCC Order Line"
{
    Caption = 'SCC Order Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "SCC No."; Code[20])
        {
            Caption = 'SCC No.';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Conformity Cert"."No.";
            NotBlank = true;

            trigger OnValidate()
            begin
                if "SCC No." <> xRec."SCC No." then
                    PopulateFields();
            end;
        }

        field(2; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Purchase Order No." <> xRec."Purchase Order No." then begin
                    PopulateFields();
                    ValidateVendorConsistency();
                end;
            end;
        }

        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
            Editable = false;
        }

        field(4; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
        }

        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(6; "Apollo Project No."; Code[20])
        {
            Caption = 'Apollo Project No.';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK; "SCC No.", "Line No.")
        {
            Clustered = true;
        }
        key(PO; "Purchase Order No.")
        {
        }
    }

    trigger OnInsert()
    var
        SCC: Record "Shipping Conformity Cert";
    begin
        PopulateFields();
        ValidateVendorConsistency();

        /*  // Update the main SCC record
         if SCC.Get("SCC No.") then
             SCC.UpdateFromOrderLines(); */


    end;

    trigger OnModify()
    var
        SCC: Record "Shipping Conformity Cert";
    begin
        ValidateVendorConsistency();

        /*   // Update the main SCC record
          if SCC.Get("SCC No.") then
              SCC.UpdateFromOrderLines(); */
    end;

    trigger OnDelete()
    var
        SCC: Record "Shipping Conformity Cert";
    begin
        /* // Update the main SCC record
        if SCC.Get("SCC No.") then
            SCC.UpdateFromOrderLines(); */
    end;

    var
        PurchaseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        VendorMismatchErr: Label 'All Purchase Orders in certificate %1 must have the same vendor.\Purchase Order %2 has vendor %3 (%4).\Purchase Order %5 has vendor %6 (%7).\Please create a separate certificate for different vendors.';
        PONotFoundErr: Label 'Purchase Order %1 does not exist.';

    local procedure PopulateFields()
    begin
        if "Purchase Order No." = '' then
            exit;

        if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, "Purchase Order No.") then
            Error(PONotFoundErr, "Purchase Order No.");

        "Vendor No." := PurchaseHeader."Buy-from Vendor No.";
        "Document Date" := PurchaseHeader."Document Date";

        // Assuming Apollo Project No. is stored in a custom field on PO
        if PurchaseHeader."Apollo Location Code" <> '' then
            "Apollo Project No." := PurchaseHeader."Apollo Location Code";
    end;

    local procedure ValidateVendorConsistency()
    var
        ExistingSCCLine: Record "SCC Order Line";
        ExistingVendor: Record Vendor;
        CurrentVendor: Record Vendor;
        ShipmentModeErr: Label 'Purchase Order %1 cannot be added because its shipment mode is Express.';
        begin
            if "SCC No." = '' then
                exit;

            if "Vendor No." = '' then
                exit;

            // Check shipment mode of the current PO
            if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, "Purchase Order No.") then begin
                if PurchaseHeader."Shipment Mode" = PurchaseHeader."Shipment Mode"::Express then
                    Error(ShipmentModeErr, "Purchase Order No.");
            end;

            // Get current vendor name
            if not CurrentVendor.Get("Vendor No.") then
                exit;

            // Check if all other POs in this SCC have the same vendor
            ExistingSCCLine.SetRange("SCC No.", "SCC No.");
            ExistingSCCLine.SetFilter("Line No.", '<>%1', "Line No.");

            if ExistingSCCLine.FindSet() then
                repeat
                    if ExistingSCCLine."Vendor No." <> "Vendor No." then begin
                        // Get the existing vendor name
                        if ExistingVendor.Get(ExistingSCCLine."Vendor No.") then
                            Error(VendorMismatchErr,
                                "SCC No.",
                                ExistingSCCLine."Purchase Order No.",
                                ExistingSCCLine."Vendor No.",
                                ExistingVendor.Name,
                                "Purchase Order No.",
                                "Vendor No.",
                                CurrentVendor.Name);
                    end;
                until ExistingSCCLine.Next() = 0;
        end;
}
//FQ MASQ**END**