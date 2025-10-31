//FQ MASQ **START**
codeunit 70128 "SCC Management"
{

    // Creates a new SCC from a Purchase Order or adds PO to existing certificate for same vendor
    procedure CreateSCCFromPO(PurchaseOrderNo: Code[20]): Record "Shipping Conformity Cert"
    var
        PurchaseHeader: Record "Purchase Header";
        SCC: Record "Shipping Conformity Cert";
        SCCOrderLine: Record "SCC Order Line";
        LineNo: Integer;
    begin
        // Validate Purchase Order exists
        if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderNo) then
            Error(PONotFoundErr, PurchaseOrderNo);

        // Validate PO Status
        ValidatePOStatus(PurchaseHeader);

        // Check if this PO is already in a certificate
        if IsPOInAnyCertificate(PurchaseOrderNo) then
            Error(POAlreadyInCertErr, PurchaseOrderNo);

        // Check if there's already a completed certificate for this PO
        if HasCompletedCertificateForPO(PurchaseOrderNo) then
            Error(AlreadyCompletedErr, PurchaseOrderNo);

        // Check if there's an existing IN PROCESS certificate for the same vendor
        SCC := FindExistingCertificateForVendor(PurchaseHeader."Buy-from Vendor No.");

        if SCC."No." = '' then begin
            // Create new SCC record
            SCC.Init();
            scc.Validate("Shipment Mode", PurchaseHeader."Shipment Mode");
            SCC.Insert(true);

            LineNo := 10000;
        end else begin
            // Get next line number for existing certificate
            SCCOrderLine.SetRange("SCC No.", SCC."No.");
            if SCCOrderLine.FindLast() then
                LineNo := SCCOrderLine."Line No." + 10000
            else
                LineNo := 10000;
        end;

        // Add the PO to the certificate
        SCCOrderLine.Init();
        SCCOrderLine."SCC No." := SCC."No.";
        SCCOrderLine."Line No." := LineNo;
        SCCOrderLine."Purchase Order No." := PurchaseOrderNo;
        SCCOrderLine.Insert(true);

        Commit();

        // Send notification
        SendCreatedNotification(SCC, PurchaseOrderNo);

        exit(SCC);
    end;

    local procedure ValidatePOStatus(var PurchaseHeader: Record "Purchase Header")
    begin
        // Check if PO is released
        if PurchaseHeader.Status <> PurchaseHeader.Status::Released then
            Error(PONotReleasedErr, PurchaseHeader."No.");
    end;


    local procedure IsPOInAnyCertificate(PurchaseOrderNo: Code[20]): Boolean
    var
        SCCOrderLine: Record "SCC Order Line";
    begin
        SCCOrderLine.SetRange("Purchase Order No.", PurchaseOrderNo);
        exit(not SCCOrderLine.IsEmpty());
    end;

    /// <summary>
    /// Validates if multiple approved certificates exist for a PO
    /// </summary>
    procedure ValidateOneApprovedPerPO(var SCC: Record "Shipping Conformity Cert")
    var
        SCCOrderLine: Record "SCC Order Line";
        ExistingSCCOrderLine: Record "SCC Order Line";
    begin
        if SCC."Certificate Status" <> SCC."Certificate Status"::Completed then
            exit;

        // Check all POs in this certificate
        SCCOrderLine.SetRange("SCC No.", SCC."No.");
        if SCCOrderLine.FindSet() then
            repeat
                // Check if there are any existing completed certificates for the same PO
                ExistingSCCOrderLine.SetRange("Purchase Order No.", SCCOrderLine."Purchase Order No.");
                ExistingSCCOrderLine.SetFilter("SCC No.", '<>%1', SCC."No.");

                if ExistingSCCOrderLine.FindSet() then begin
                    repeat
                        if IsCertificateCompleted(ExistingSCCOrderLine."SCC No.") then
                            Error(MultipleApprovedErr, ExistingSCCOrderLine."SCC No.", SCCOrderLine."Purchase Order No.");
                    until ExistingSCCOrderLine.Next() = 0;
                end;
            until SCCOrderLine.Next() = 0;
    end;

    /// <summary>
    /// Opens the SCC list filtered by Purchase Order
    /// </summary>
    procedure OpenSCCListForPO(PurchaseOrderNo: Code[20])
    var
        SCC: Record "Shipping Conformity Cert";
        SCCOrderLine: Record "SCC Order Line";
        FilterText: Text;
    begin
        // Find all SCCs that contain this PO
        SCCOrderLine.SetRange("Purchase Order No.", PurchaseOrderNo);
        if SCCOrderLine.FindSet() then begin
            FilterText := '';
            repeat
                if FilterText = '' then
                    FilterText := SCCOrderLine."SCC No."
                else
                    FilterText := FilterText + '|' + SCCOrderLine."SCC No.";
            until SCCOrderLine.Next() = 0;

            if FilterText <> '' then
                SCC.SetFilter("No.", FilterText);
            Page.Run(Page::"Shipping Conformity Cert. List", SCC);
        end
        else begin
            SCC.SetRange("No.", '');
            Page.Run(Page::"Shipping Conformity Cert. List", SCC);
        end;
    end;

    /// <summary>
    /// Checks if new SCC can be created for a PO
    /// </summary>
    procedure CanCreateNewSCC(PurchaseOrderNo: Code[20]): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderNo) then
            exit(false);

        if PurchaseHeader.Status <> PurchaseHeader.Status::Released then
            exit(false);

        // Don't allow if PO is already in a certificate
        if IsPOInAnyCertificate(PurchaseOrderNo) then
            exit(false);

        exit(true);
    end;

    /// <summary>
    /// Gets count of SCCs for a Purchase Order
    /// </summary>
    procedure GetSCCCountForPO(PurchaseOrderNo: Code[20]): Integer
    var
        SCCOrderLine: Record "SCC Order Line";
        SCCNumbers: List of [Code[20]];
        SCCNo: Code[20];
    begin
        SCCOrderLine.SetRange("Purchase Order No.", PurchaseOrderNo);
        if SCCOrderLine.FindSet() then
            repeat
                if not SCCNumbers.Contains(SCCOrderLine."SCC No.") then
                    SCCNumbers.Add(SCCOrderLine."SCC No.");
            until SCCOrderLine.Next() = 0;

        exit(SCCNumbers.Count());
    end;

    /// <summary>
    /// Gets count of completed SCCs for a Purchase Order
    /// </summary>
    procedure GetCompletedSCCCountForPO(PurchaseOrderNo: Code[20]): Integer
    var
        SCCOrderLine: Record "SCC Order Line";
        SCC: Record "Shipping Conformity Cert";
        SCCNumbers: List of [Code[20]];
        CompletedCount: Integer;
    begin
        CompletedCount := 0;
        SCCOrderLine.SetRange("Purchase Order No.", PurchaseOrderNo);

        if SCCOrderLine.FindSet() then
            repeat
                if not SCCNumbers.Contains(SCCOrderLine."SCC No.") then begin
                    SCCNumbers.Add(SCCOrderLine."SCC No.");

                    if SCC.Get(SCCOrderLine."SCC No.") then
                        if SCC."Certificate Status" = SCC."Certificate Status"::Completed then
                            CompletedCount += 1;
                end;
            until SCCOrderLine.Next() = 0;

        exit(CompletedCount);
    end;

    /// <summary>
    /// Sends notification when certificate is created
    /// </summary>
    local procedure SendCreatedNotification(var SCC: Record "Shipping Conformity Cert"; PurchaseOrderNo: Code[20])
    var
        Notification: Notification;
    begin
        Notification.Message := StrSubstNo(SCCCreatedMsg, SCC."No.", PurchaseOrderNo);
        Notification.Scope := NotificationScope::LocalScope;
        Notification.SetData('SCCNo', SCC."No.");
        Notification.Send();
    end;

    /// <summary>
    /// Checks if a certificate is completed
    /// </summary>
    procedure IsCertificateCompleted(SCCNo: Code[20]): Boolean
    var
        SCC: Record "Shipping Conformity Cert";
    begin
        if not SCC.Get(SCCNo) then
            exit(false);

        exit(SCC."Certificate Status" = SCC."Certificate Status"::Completed);
    end;

    /// <summary>
    /// Checks if there's already a completed certificate for a PO
    /// </summary>
    local procedure HasCompletedCertificateForPO(PurchaseOrderNo: Code[20]): Boolean
    var
        SCCOrderLine: Record "SCC Order Line";
    begin
        SCCOrderLine.SetRange("Purchase Order No.", PurchaseOrderNo);
        if SCCOrderLine.FindSet() then
            repeat
                if IsCertificateCompleted(SCCOrderLine."SCC No.") then
                    exit(true);
            until SCCOrderLine.Next() = 0;

        exit(false);
    end;

    /// <summary>
    /// Finds an existing IN PROCESS certificate for the same vendor
    /// </summary>
    local procedure FindExistingCertificateForVendor(VendorNo: Code[20]): Record "Shipping Conformity Cert"
    var
        SCC: Record "Shipping Conformity Cert";
        SCCOrderLine: Record "SCC Order Line";
    begin
        // Look for existing IN PROCESS certificates that have this vendor in their order lines
        SCCOrderLine.SetRange("Vendor No.", VendorNo);
        if SCCOrderLine.FindSet() then
            repeat
                if SCC.Get(SCCOrderLine."SCC No.") then
                    if SCC."Certificate Status" = SCC."Certificate Status"::"In Process" then
                        exit(SCC);
            until SCCOrderLine.Next() = 0;

        // Return empty record if not found
        Clear(SCC);
        exit(SCC);
    end;

    /// <summary>
    /// Gets the vendor for a certificate
    /// </summary>
    procedure GetCertificateVendor(SCCNo: Code[20]): Code[20]
    var
        SCCOrderLine: Record "SCC Order Line";
    begin
        SCCOrderLine.SetRange("SCC No.", SCCNo);
        if SCCOrderLine.FindFirst() then
            exit(SCCOrderLine."Vendor No.");

        exit('');
    end;

    //Attachment Event

    [EventSubscriber(ObjectType::Page, 1174, 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        SCCHeader: Record "Shipping Conformity Cert";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Shipping Conformity Cert":
                begin
                    RecRef.Open(Database::"Shipping Conformity Cert");
                    if SCCHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(SCCHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 1173, 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::"Shipping Conformity Cert":
                begin
                    FieldRef := RecRef.Field(1); // "No." field
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, 1173, 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::"Shipping Conformity Cert":
                begin
                    FieldRef := RecRef.Field(1); // "No." field
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    var
        PONotFoundErr: Label 'Purchase Order %1 does not exist.';
        PONotReleasedErr: Label 'Purchase Order %1 must be Released to create a Shipping Conformity Certificate.';
        POClosedErr: Label 'Cannot create a new certificate for Purchase Order %1 because it is closed.';
        MultipleApprovedErr: Label 'Only one completed certificate is allowed per Purchase Order. Certificate %1 is already completed for Purchase Order %2.';
        AlreadyCompletedErr: Label 'Purchase Order %1 already has a completed certificate.';
        POAlreadyInCertErr: Label 'Purchase Order %1 is already included in a certificate.';
        SCCCreatedMsg: Label 'Purchase Order %2 has been added to Shipping Conformity Certificate %1.';
}
//FQ MASQ **END**