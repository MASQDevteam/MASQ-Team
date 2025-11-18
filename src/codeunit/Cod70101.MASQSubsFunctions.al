codeunit 70101 "MASQ Subs & Functions"
{
    Permissions = tabledata "Value Entry" = m, tabledata "Job Ledger Entry" = m, tabledata "Supply Chain LOG" = RIMD; //NB MASQ
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnRecreatePurchLinesOnBeforePurchLinesExists', '', false, false)]
    local procedure OnRecreatePurchLinesOnBeforePurchLinesExists(var PurchHeader: Record "Purchase Header"; xPurchHeader: Record "Purchase Header"; ChangedFieldName: Text[100]; var IsHandled: Boolean)
    begin
        IsHandled := True;
    end;

    [EventSubscriber(ObjectType::Table, 36, OnBeforeRecreateSalesLinesHandler, '', false, false)]
    local procedure OnBeforeRecreateSalesLinesHandler(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; ChangedFieldName: Text[100]; var IsHandled: Boolean)
    begin
        IsHandled := True;
    end;





    //prevent posting any sales credit memo in case the item type field is empty
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        SalesLine: Record "Sales Line";
        txt001: Label 'Please do Fill the item type field in the lines before posting this Document';
        txt002: Label 'Please check and confirm the posting date before proceeding with shipment posting.\\Posting Date: %1\\Do you want to continue?';
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then begin
            Clear(SalesLine);
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            SalesLine.SetRange("Meg Item Type", '');
            IF SalesLine.FindFirst() then
                Error(txt001);
        end;
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            //FQ MASQ **START
            // Display alert to check and confirm posting date before shipment posting
            if not Confirm(StrSubstNo(txt002, SalesHeader."Posting Date")) then
                Error('Posting cancelled by user.');
            //FQ MASQ **END

            if SalesHeader."Shipment Date" <> SalesHeader."Posting Date" then
                if Confirm('The Shipment Date is not equal to the Posting Date, do you want to update the shipment date?') = true then begin
                    SalesHeader.Validate("Shipment Date", SalesHeader."Posting Date");
                    SalesHeader.Modify();
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    begin

        ItemJnlLine."MASQ Item Type" := SalesLine."Meg Item Type";
        ItemJnlLine."Batch Number" := SalesLine."Batch Number";//12112024 //for batch posting
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(PurchLine: Record "Purchase Line"; var ItemJnlLine: Record "Item Journal Line")
    var

    begin
        // if Rec."LC Number" = '' then begin
        //for batch posting

        ItemJnlLine."Batch Number" := PurchLine."Batch Number";

        ItemJnlLine."MASQ Item Type" := PurchLine."Meg Item Type";
        //added on 25/02/2025
        ItemJnlLine."Job#" := PurchLine."Job#";
        ItemJnlLine."Subjob ID" := PurchLine."Subjob ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]//for batch posting
    local procedure OnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    begin
        ItemJournalLine."Batch Number" := TransferLine."Batch Number";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforePostItemJournalLine', '', false, false)]//for batch posting
    local procedure OnBeforePostItemJournalLineShipment(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line"; CommitIsSuppressed: Boolean)
    begin
        ItemJournalLine."Batch Number" := TransferLine."Batch Number";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        ItemLedgerEntry."MASQ Item Type" := ItemJournalLine."MASQ Item Type";
        ItemLedgerEntry."Batch Number" := ItemJournalLine."Batch Number";//12112024 //for batch posting
        //added on 25/02/2025
        ItemLedgerEntry."Job#" := ItemJournalLine."Job#";
        ItemLedgerEntry."Subjob ID" := ItemJournalLine."Subjob ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertPhysInvtLedgEntry', '', false, false)]
    local procedure OnBeforeInsertPhysInvtLedgEntry(var PhysInventoryLedgerEntry: Record "Phys. Inventory Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        PhysInventoryLedgerEntry."MASQ Item Type" := ItemJournalLine."MASQ Item Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', false, false)]
    local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean; var OldItemLedgEntry: Record "Item Ledger Entry"; var Item: Record Item; TransferItem: Boolean; var GlobalValueEntry: Record "Value Entry")
    var
        JobLedgerEntryTempData: Record "Job Ledger Entry" temporary;
    begin
        ValueEntry."MASQ Item Type" := ItemJournalLine."MASQ Item Type";
        ValueEntry."Batch Number" := ItemJournalLine."Batch Number";//12112024 //for batch posting

        //added on 25/02/2025
        ValueEntry."Job#" := ItemJournalLine."Job#";
        ValueEntry."Subjob ID" := ItemJournalLine."Subjob ID";
    end;

    //AN 03/06/25
    //Modify Ledger Entry No in JLE
    //To be Edited
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", OnAfterJobLedgEntryInsert, '', false, false)]
    // local procedure OnAfterInsertJobLedgerEntry(var JobLedgerEntry: Record "Job Ledger Entry")
    // var
    //     ValueEntry: Record "Value Entry";
    // begin
    //     ValueEntry.SetRange("Job Ledger Entry No.", JobLedgerEntry."Entry No.");
    //     if ValueEntry.FindFirst() then
    //         JobLedgerEntry."Ledger Entry No." := ValueEntry."Item Ledger Entry No.";
    // end;
    //Attach documents subscribers


    [EventSubscriber(ObjectType::Page, 1174, 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        PurchaseRequestHeader: Record "SUPPLIER PAYMENT REQUEST";
        //   PaymentRequestHeader: Record "Payment Request Header";
        BankAccount: Record "Bank Account";
        FinanceDetails: Record "Finance Details";
        BLDetails: Record "BL Details";
        AWBDetails: Record "AWB Details";
        ShippingQuote: Record "Shipping Quotation";
        ShippingQuoteDetails: Record "Shipping Quotation Details";
        Insurance: Record "Insurance/Claim";
        TransitoryReference: Record "Transitory Reference";
        VariationOrder: Record "Variation Order";
        TravelRequest: Record "Travel Request";
        TruckWayBill: Record "Truck WayBill";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"SUPPLIER PAYMENT REQUEST":
                begin
                    RecRef.Open(DATABASE::"SUPPLIER PAYMENT REQUEST");
                    if PurchaseRequestHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(PurchaseRequestHeader);
                end;

            DATABASE::"Bank Account":
                begin
                    RecRef.Open(DATABASE::"Bank Account");
                    if BankAccount.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(BankAccount);
                end;
            Database::"Finance Details":
                begin
                    RecRef.Open(DATABASE::"Finance Details");
                    if FinanceDetails.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(FinanceDetails);

                end;
            Database::"BL Details":
                begin
                    RecRef.Open(DATABASE::"BL Details");
                    if BLDetails.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(BLDetails);

                end;
            Database::"AWB Details":
                begin
                    RecRef.Open(DATABASE::"AWB Details");
                    if AWBDetails.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(AWBDetails);

                end;
            Database::"Shipping Quotation":
                begin
                    RecRef.Open(DATABASE::"Shipping Quotation");
                    if ShippingQuote.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ShippingQuote);
                end;

            Database::"Shipping Quotation Details":
                begin
                    RecRef.Open(DATABASE::"Shipping Quotation Details");
                    if ShippingQuoteDetails.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ShippingQuoteDetails);
                end;
            Database::"Insurance/Claim":
                begin
                    RecRef.Open(DATABASE::"Insurance/Claim");
                    if Insurance.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(Insurance);
                end;

            Database::"Transitory Reference":
                begin
                    RecRef.Open(DATABASE::"Transitory Reference");
                    if TransitoryReference.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(TransitoryReference);
                end;
            //AN 03/06/25
            DATABASE::"Variation Order":
                begin
                    RecRef.Open(DATABASE::"Variation Order");
                    VariationOrder.SetRange(Number, DocumentAttachment."No.");
                    //if VariationOrder.Get(DocumentAttachment."No.") then
                    if VariationOrder.FindFirst() then
                        RecRef.GetTable(VariationOrder);
                end;
            //AN 03/11/25
            DATABASE::"Travel Request":
                begin
                    RecRef.Open(DATABASE::"Travel Request");
                    TravelRequest.SetRange(Number, DocumentAttachment."No.");
                    if TravelRequest.FindFirst() then
                        RecRef.GetTable(TravelRequest);
                end;
            DATABASE::"Truck WayBill":
                begin
                    RecRef.Open(DATABASE::"Truck WayBill");
                    TruckWayBill.SetRange("Truck WayBill ID", DocumentAttachment."No.");
                    if TruckWayBill.FindFirst() then
                        RecRef.GetTable(TruckWayBill);
                end;
        end;


    end;


    [EventSubscriber(ObjectType::Table, 1173, 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        LineNo: Integer;
    begin

        case RecRef.Number of
            DATABASE::"SUPPLIER PAYMENT REQUEST":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            DATABASE::"Bank Account":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            DATABASE::"Finance Details":
                begin
                    FieldRef := RecRef.Field(22);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            DATABASE::"BL Details":
                begin
                    FieldRef := RecRef.Field(25);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            DATABASE::"AWB Details":
                begin
                    FieldRef := RecRef.Field(25);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            Database::"Shipping Quotation":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            Database::"Shipping Quotation Details":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            Database::"Insurance/Claim":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

            Database::"Transitory Reference":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            //AN 03/06/25
            DATABASE::"Variation Order":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            //AN 03/11/25
            DATABASE::"Travel Request":
                begin
                    FieldRef := RecRef.Field(21);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            DATABASE::"Truck WayBill":
                begin
                    FieldRef := RecRef.Field(20);
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
        LineNo: Integer;
    begin
        case RecRef.Number of
            DATABASE::"SUPPLIER PAYMENT REQUEST":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;

            DATABASE::"Bank Account":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;

            DATABASE::"Finance Details":
                begin
                    FieldRef := RecRef.Field(22);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;
            DATABASE::"BL Details":
                begin
                    FieldRef := RecRef.Field(25);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;
            DATABASE::"AWB Details":
                begin
                    FieldRef := RecRef.Field(25);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;
            Database::"Shipping Quotation":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;

            Database::"Shipping Quotation Details":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;
            Database::"Insurance/Claim":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;

            Database::"Transitory Reference":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;
            //AN 03/06/25
            DATABASE::"Variation Order":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;
            //AN 03/11/25
            DATABASE::"Travel Request":
                begin
                    FieldRef := RecRef.Field(21);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;
            DATABASE::"Truck WayBill":
                begin
                    FieldRef := RecRef.Field(20);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    // FieldRef := RecRef.Field(4);
                    // LineNo := FieldRef.Value;
                    // DocumentAttachment.SetRange("Line No.", LineNo);

                    FlowFieldsEditable := false;
                end;
        end
    end;
    //Atatchment default
    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventProject(var Rec: Record Job)
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
    begin
        AttachmentID[1] := 'Clients Conditions';
        AttachmentID[2] := 'Subcontractor Invoice';
        AttachmentID[3] := 'Travel and Lodging';
        AttachmentID[4] := 'Licensing and permits Fees';
        AttachmentID[5] := 'Insurance';
        AttachmentID[6] := 'Miscellaneous Supplies and Consumables';
        AttachmentID[7] := 'Clients Offer';
        AttachmentID[8] := 'Clients Contact Info';
        LastDocumentAttchamentID := GETLastDocumentAttchamentIDProject(Rec);

        for I := 1 to 8 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::Job);
            DocumentAttchament.Validate("No.", Rec."No.");
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;


    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventPurchaseOrder(var Rec: Record "Purchase Header")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
    begin
        IF Rec."Document Type" = Rec."Document Type"::Order then begin
            //AttachmentID[1] := 'Supplier Invoice';//moved to the BL and AWB
            //  AttachmentID[2] := 'Packing List';
            AttachmentID[1] := 'Proforma Invoice';
            LastDocumentAttchamentID := GETLastDocumentAttchamentIDPO(Rec);

            for I := 1 to 1 do begin
                DocumentAttchament.Init();
                DocumentAttchament.Validate("Table ID", Database::"Purchase Header");
                DocumentAttchament.Validate("No.", Rec."No.");
                DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
                DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
                DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
                DocumentAttchament."Attachment ID" := AttachmentID[I];
                DocumentAttchament."to be removed" := true;
                // DocumentAttchament.Validate("File Name", AttachmentID[I]);
                DocumentAttchament.Insert();
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Finance Details", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventFinanceDetails(var Rec: Record "Finance Details")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
        v: Page "Item List";
    begin
        // IF Rec."Document Type" = Rec."Document Type"::Order then begin
        AttachmentID[1] := 'Signed LC Application';
        AttachmentID[2] := 'Issuing LC Swift';
        AttachmentID[3] := 'Amendments';
        LastDocumentAttchamentID := GETLastDocumentAttchamentIDLC(Rec);

        for I := 1 to 3 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::"Finance Details");
            DocumentAttchament.Validate("No.", Rec."LC Number");
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;
        // end;

    end;
    //AN 03/06/25
    [EventSubscriber(ObjectType::Table, Database::"Variation Order", OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterInsertEventVariationOrders(var Rec: Record "Variation Order")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
        v: Page "Sales Order List";
    begin
        AttachmentID[1] := Rec.Number;
        LastDocumentAttchamentID := GETLastDocumentAttchamentVO(Rec);
        for I := 1 to 1 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::"Variation Order");
            DocumentAttchament.Validate("No.", Rec.Number);
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;
    end;
    //AN 03/11/25
    [EventSubscriber(ObjectType::Table, Database::"Travel Request", OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterInsertEventTROrders(var Rec: Record "Travel Request")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
    begin
        AttachmentID[1] := Rec.Number;
        LastDocumentAttchamentID := GETLastDocumentAttchamentTR(Rec);
        for I := 1 to 1 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::"Travel Request");
            DocumentAttchament.Validate("No.", Rec.Number);
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"BL Details", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventBLDetails(var Rec: Record "BL Details")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
    begin
        // IF Rec."Document Type" = Rec."Document Type"::Order then begin
        AttachmentID[1] := 'Agent Invoice';
        AttachmentID[2] := 'Duty Receipts';
        AttachmentID[3] := 'Bill of Lading';
        // AttachmentID[4] := 'AWB "in Case of Air Shipment"';
        AttachmentID[4] := 'Shipping Line invoice';
        AttachmentID[5] := 'Sasso';
        AttachmentID[6] := 'Saber Fees';
        AttachmentID[7] := 'Supplier Invoice';
        AttachmentID[8] := 'Packing List';
        LastDocumentAttchamentID := GETLastDocumentAttchamentIDBL(Rec);

        for I := 1 to 8 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::"BL Details");
            DocumentAttchament.Validate("No.", Rec."BL ID");
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;
        // end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"AWB Details", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventBAWBDetails(var Rec: Record "AWB Details")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
    begin
        // IF Rec."Document Type" = Rec."Document Type"::Order then begin
        AttachmentID[1] := 'Agent Invoice';
        AttachmentID[2] := 'Duty Receipts';
        AttachmentID[3] := 'AWB';
        // AttachmentID[4] := 'AWB "in Case of Air Shipment"';
        AttachmentID[4] := 'Shipping Line invoice';
        AttachmentID[5] := 'Sasso';
        AttachmentID[6] := 'Saber Fees';
        AttachmentID[7] := 'Supplier Invoice';
        AttachmentID[8] := 'Packing List';
        LastDocumentAttchamentID := GETLastDocumentAttchamentIDAWB(Rec);

        for I := 1 to 8 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::"AWB Details");
            DocumentAttchament.Validate("No.", Rec."AWB ID");
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;
        // end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Shipping Quotation", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventShippingQuotation(var Rec: Record "Shipping Quotation")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
    begin
        //updated on 20/03/2025 AI
        // IF Rec."Document Type" = Rec."Document Type"::Order then begin
        AttachmentID[1] := 'Packing List';
        AttachmentID[2] := 'Quotation 1';
        AttachmentID[3] := 'Quotation 2';
        AttachmentID[4] := 'Quotation 3';
        LastDocumentAttchamentID := GETLastDocumentAttchamentIDLSQ(Rec);

        for I := 1 to 4 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::"Shipping Quotation");
            DocumentAttchament.Validate("No.", Rec."Comparison ID");
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;
        // end;

    end;
    //AN 04/03/2025
    Local procedure GETLastDocumentAttchamentIDTRuck(TruckWayBill: Record "Truck WayBill"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Truck WayBill");
        DocumentAttchament.SetRange("No.", TruckWayBill."Truck WayBill ID");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;
    //AN 04/03/2025
    [EventSubscriber(ObjectType::Table, Database::"Truck WayBill", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventTruckWayBill(var Rec: Record "Truck WayBill")
    var
        DocumentAttchament: Record "Document Attachment";
        LastDocumentAttchamentID: Integer;
        AttachmentID: array[10] of Text[50];
        I: Integer;
    begin

        AttachmentID[1] := 'Truck WayBill';
        LastDocumentAttchamentID := GETLastDocumentAttchamentIDTRuck(Rec);

        for I := 1 to 1 do begin
            DocumentAttchament.Init();
            DocumentAttchament.Validate("Table ID", Database::"Truck WayBill");
            DocumentAttchament.Validate("No.", Rec."Truck WayBill ID");
            DocumentAttchament.Validate("Document Type", DocumentAttchament."Document Type"::Order);
            DocumentAttchament.Validate("Line No.", LastDocumentAttchamentID + I);
            DocumentAttchament.Validate(ID, LastDocumentAttchamentID + I);
            DocumentAttchament."Attachment ID" := AttachmentID[I];
            DocumentAttchament."to be removed" := true;
            // DocumentAttchament.Validate("File Name", AttachmentID[I]);
            DocumentAttchament.Insert();
        end;


    end;

    Local procedure GETLastDocumentAttchamentIDProject(Job: Record Job): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::Job);
        DocumentAttchament.SetRange("No.", Job."No.");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    Local procedure GETLastDocumentAttchamentIDPO(PurchaseOrder: Record "Purchase Header"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Purchase Header");
        DocumentAttchament.SetRange("Document Type", DocumentAttchament."Document Type"::Order);
        DocumentAttchament.SetRange("No.", PurchaseOrder."No.");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    Local procedure GETLastDocumentAttchamentIDLC(LC: Record "Finance Details"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Finance Details");
        DocumentAttchament.SetRange("No.", LC."LC Number");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    Local procedure GETLastDocumentAttchamentIDBL(BL: Record "BL Details"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"BL Details");
        DocumentAttchament.SetRange("No.", BL."BL ID");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    Local procedure GETLastDocumentAttchamentIDAWB(AWB: Record "AWB Details"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"AWB Details");
        DocumentAttchament.SetRange("No.", AWB."AWB ID");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;
    //AN 03/06/25
    Local procedure GETLastDocumentAttchamentVO(VO: Record "Variation Order"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Variation Order");
        DocumentAttchament.SetRange("No.", VO.Number);
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;
    //AN 03/11/25
    Local procedure GETLastDocumentAttchamentTR(TR: Record "Travel Request"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Travel Request");
        DocumentAttchament.SetRange("No.", TR.Number);
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    Local procedure GETLastDocumentAttchamentIDLSQ(LC: Record "Shipping Quotation"): Integer
    var
        DocumentAttchament: Record "Document Attachment";
    begin

        Clear(DocumentAttchament);
        DocumentAttchament.SetRange("Table ID", Database::"Shipping Quotation");
        DocumentAttchament.SetRange("No.", LC."Comparison ID");
        IF DocumentAttchament.FindLast() then
            exit(DocumentAttchament.ID);
    end;

    [EventSubscriber(ObjectType::Table, database::"Document Attachment", 'OnBeforeInsertAttachment', '', false, false)]
    local procedure OnBeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        Project: Record Job;
        DocumentAttachmentTemp: Record "Document Attachment";
        PurchaseOrder: Record "Purchase Header";
        FinanceDetail: Record "Finance Details";
        BLDetails: Record "BL Details";
        AWBDetails: Record "AWB Details";
        VariationOrder: Record "Variation Order";
        ShippingQuotation: Record "Shipping Quotation";
        TravelRequest: Record "Travel Request";
        TruckWayBill: Record "Truck WayBill";
    begin
        IF DocumentAttachment."Table ID" = Database::Job then begin
            Clear(Project);
            Project.Get(DocumentAttachment."No.");
            IF Project."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := Project."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(Project."Document Attachment Table ID", Project."Document Attachment No.", Project."Document Attachment Doc. Type", Project."Document Attachment Line No.", Project."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;

        IF (DocumentAttachment."Table ID" = Database::"Purchase Header") AND (DocumentAttachment."Document Type" = DocumentAttachment."Document Type"::Order) then begin
            Clear(PurchaseOrder);
            PurchaseOrder.Get(DocumentAttachment."Document Type", DocumentAttachment."No.");
            IF PurchaseOrder."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := PurchaseOrder."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(PurchaseOrder."Document Attachment Table ID", PurchaseOrder."Document Attachment No.", PurchaseOrder."Document Attachment Doc. Type", PurchaseOrder."Document Attachment Line No.", PurchaseOrder."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;
        IF (DocumentAttachment."Table ID" = Database::"Finance Details") then begin
            Clear(FinanceDetail);
            FinanceDetail.Get(DocumentAttachment."No.");
            IF FinanceDetail."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := FinanceDetail."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(FinanceDetail."Document Attachment Table ID", FinanceDetail."Document Attachment No.", FinanceDetail."Document Attachment Doc. Type", FinanceDetail."Document Attachment Line No.", FinanceDetail."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;


        IF (DocumentAttachment."Table ID" = Database::"BL Details") then begin
            Clear(BLDetails);
            BLDetails.Get(DocumentAttachment."No.");
            IF BLDetails."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := BLDetails."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(BLDetails."Document Attachment Table ID", BLDetails."Document Attachment No.", BLDetails."Document Attachment Doc. Type", BLDetails."Document Attachment Line No.", BLDetails."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;

        IF (DocumentAttachment."Table ID" = Database::"AWB Details") then begin
            Clear(AWBDetails);
            AWBDetails.Get(DocumentAttachment."No.");
            IF AWBDetails."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := AWBDetails."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(AWBDetails."Document Attachment Table ID", AWBDetails."Document Attachment No.", AWBDetails."Document Attachment Doc. Type", AWBDetails."Document Attachment Line No.", AWBDetails."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;

        IF (DocumentAttachment."Table ID" = Database::"Shipping Quotation") then begin
            Clear(ShippingQuotation);
            ShippingQuotation.Get(DocumentAttachment."No.");
            IF ShippingQuotation."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := ShippingQuotation."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(ShippingQuotation."Document Attachment Table ID", ShippingQuotation."Document Attachment No.", ShippingQuotation."Document Attachment Doc. Type", ShippingQuotation."Document Attachment Line No.", ShippingQuotation."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;

        //AN 03/06/25
        IF (DocumentAttachment."Table ID" = Database::"Variation Order") then begin
            Clear(VariationOrder);
            // VariationOrder.Get(DocumentAttachment."No.");
            VariationOrder.SetRange(Number, DocumentAttachment."No.");
            VariationOrder.FindFirst();
            IF VariationOrder."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := VariationOrder."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(VariationOrder."Document Attachment Table ID", VariationOrder."Document Attachment No.", VariationOrder."Document Attachment Doc. Type", VariationOrder."Document Attachment Line No.", VariationOrder."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;

        //AN 03/11/25
        IF (DocumentAttachment."Table ID" = Database::"Travel Request") then begin
            Clear(TravelRequest);
            // VariationOrder.Get(DocumentAttachment."No.");
            TravelRequest.SetRange(Number, DocumentAttachment."No.");
            TravelRequest.FindFirst();
            IF TravelRequest."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := TravelRequest."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(TravelRequest."Document Attachment Table ID", TravelRequest."Document Attachment No.", TravelRequest."Document Attachment Doc. Type", TravelRequest."Document Attachment Line No.", TravelRequest."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;
        IF (DocumentAttachment."Table ID" = Database::"Truck WayBill") then begin
            Clear(TruckWayBill);
            TruckWayBill.SetRange("Truck WayBill ID", DocumentAttachment."No.");
            TruckWayBill.FindFirst();
            IF TruckWayBill."Attachment ID" <> '' then begin
                DocumentAttachment."Attachment ID" := TruckWayBill."Attachment ID";
                DocumentAttachment."Attachment Mandatory" := true;
                Clear(DocumentAttachmentTemp);
                DocumentAttachmentTemp.Get(TruckWayBill."Document Attachment Table ID", TruckWayBill."Document Attachment No.", TruckWayBill."Document Attachment Doc. Type", TruckWayBill."Document Attachment Line No.", TruckWayBill."Document Attachment ID");
                DocumentAttachmentTemp.Delete();

            end;
        end;

    end;

    //AN 03/07/25
    //Save file size in KB or MB 
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", OnBeforeSaveAttachment, '', false, false)]
    local procedure OnBeforeSaveAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FileName: Text; var TempBlob: Codeunit "Temp Blob")
    begin
        DocumentAttachment.FileSizeTxt := FormatFileSize(TempBlob.Length());
    end;

    var
        FileSizeTxt: Label '%1 %2', Comment = '%1 = File Size, %2 = Unit of measurement', Locked = true;

    local procedure FormatFileSize(SizeInBytes: Integer): Text
    var
        FileSizeConverted: Decimal;
        FileSizeUnit: Text;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        FileSizeConverted := SizeInBytes / 1024; // The smallest size we show is KB
        if FileSizeConverted < 1024 then begin
            FileSizeUnit := 'KB';
            if UserSetup."Can AttachFilesGreaterthan3MB" = false then
                if FileSizeConverted > 3000 then
                    Error('Please choose file less than 3000 KB!');
        end
        else begin
            FileSizeConverted := FileSizeConverted / 1024; // The largest size we show is MB
            FileSizeUnit := 'MB';
            if UserSetup."Can AttachFilesGreaterthan3MB" = false then
                if FileSizeConverted > 3 then
                    Error('Please choose file less than 3 MB!')
        end;
        exit(StrSubstNo(FileSizeTxt, Round(FileSizeConverted, 0.01, '>'), FileSizeUnit));

    end;


    //AN 03/26/2025
    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "Sent to PO", false, false)]
    // local procedure OnAfterValidateSenttoPO(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)

    // var
    //     UnplannedDemand: Record "Unplanned Demand";
    // begin
    //     UnplannedDemand.SetRange("MASQ Sales Order No.", Rec."Document No.");
    //     UnplannedDemand.SetRange("MASQ Sales Order Line No.", Rec."Line No.");
    //     // if UnplannedDemand.FindFirst() then begin
    //     UnplannedDemand.Validate("Sent to PO", Rec."Sent to PO");
    //     UnplannedDemand.Modify();
    // //end;
    // end;

    //transfer the fields from the sales line to pucrhase line case of create po from so//direct delivery
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Unplanned Demand", 'OnInsertSalesLineOnBeforeInsert', '', false, false)]
    local procedure OnInsertSalesLineOnBeforeInsert(var UnplannedDemand: Record "Unplanned Demand"; SalesLine: Record "Sales Line")

    var
        ProjectPlanningLines: Record "Job Planning Line";
        SalesHeader: Record "Sales Header";
        Project: Record Job;
    begin
        UnplannedDemand."Meg Item Type" := SalesLine."Meg Item Type";
        UnplannedDemand."MASQ Sales Order No." := SalesLine."Document No.";
        UnplannedDemand."MASQ Sales Order Line No." := SalesLine."Line No.";
        UnplannedDemand."Sent to PO" := SalesLine."Sent to PO";

        //Project Module
        UnplannedDemand."Job No." := SalesLine."Job No.";
        UnplannedDemand."Job Task No." := SalesLine."Job Task No.";
        UnplannedDemand."Job Planning Line No." := SalesLine."Job Planning Line No.";


        //Dimensiion and item type from so lines to PO lines
        // UnplannedDemand."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        // UnplannedDemand."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        // UnplannedDemand."Shortcut Dimension 3 Code" := SalesLine."Shortcut Dimension 3 Code1";
        // UnplannedDemand."Shortcut Dimension 4 Code" := SalesLine."Shortcut Dimension 4 Code";
        // UnplannedDemand."Shortcut Dimension 5 Code" := SalesLine."Shortcut Dimension 5 Code";
        // UnplannedDemand."Shortcut Dimension 6 Code" := SalesLine."Shortcut Dimension 6 Code";

        Clear(ProjectPlanningLines);
        IF ProjectPlanningLines.Get(SalesLine."Job No.", SalesLine."Job Task No.", SalesLine."Job Planning Line No.") then begin
            UnplannedDemand."Shortcut Dimension 1 Code" := ProjectPlanningLines."Shortcut Dimension 1 Code";
            UnplannedDemand."Shortcut Dimension 2 Code" := ProjectPlanningLines."Shortcut Dimension 2 Code";
            UnplannedDemand."Shortcut Dimension 3 Code" := ProjectPlanningLines."Shortcut Dimension 3 Code";
            UnplannedDemand."Shortcut Dimension 4 Code" := ProjectPlanningLines."Shortcut Dimension 4 Code";
            UnplannedDemand."Shortcut Dimension 5 Code" := ProjectPlanningLines."Shortcut Dimension 5 Code";
            UnplannedDemand."Shortcut Dimension 6 Code" := ProjectPlanningLines."Shortcut Dimension 6 Code";
        end;
        UnplannedDemand."Meg Item Type" := SalesLine."Meg Item Type";
        UnplannedDemand."Apollo Job Unit Cost" := SalesLine."Apollo Job Unit Cost";      //31/12/2024

        //AN 03/26/2025
        // if PurchaseOrderNo <> '' then
        //     UnplannedDemand."PO No." := PurchaseOrderNo
        // else
        UnplannedDemand."PO No." := SalesLine."MASQ Purchase Order No.";
        UnplannedDemand."Meg Vendor Item Code" := SalesLine."Meg Vendor Item Code";
        UnplannedDemand."PO Line No" := SalesLine."MASQ Purchase Order Line No.";
    end;


    [EventSubscriber(ObjectType::Table, database::"Requisition Line", OnAfterTransferFromUnplannedDemand, '', false, false)]
    local procedure OnAfterTransferFromUnplannedDemand(var RequisitionLine: Record "Requisition Line"; UnplannedDemand: Record "Unplanned Demand")
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ProjectPlanningLines: Record "Job Planning Line";
        SalesHeader: Record "Sales Header";
        project: Record Job;
    begin
        RequisitionLine."Meg Item Type" := UnplannedDemand."Meg Item Type";
        RequisitionLine."Vendor Item No." := CopyStr(UnplannedDemand."Meg Vendor Item Code", 1, MaxStrLen(RequisitionLine."Vendor Item No."));

        //AN 06/19/2025
        //RequisitionLine."Meg Vendor Item Code" := UnplannedDemand."Meg Vendor Item Code";
        RequisitionLine."MASQ Sales Order No." := UnplannedDemand."MASQ Sales Order No.";
        RequisitionLine."MASQ Sales Order Line No." := UnplannedDemand."MASQ Sales Order Line No.";
        RequisitionLine."Sent to PO" := UnplannedDemand."Sent to PO";
        //Project Module
        RequisitionLine."Job No." := UnplannedDemand."Job No.";
        RequisitionLine."Job Task No." := UnplannedDemand."Job Task No.";
        RequisitionLine."Job Planning Line No." := UnplannedDemand."Job Planning Line No.";


        RequisitionLine."PO No." := UnplannedDemand."PO No.";
        RequisitionLine."PO Line No" := UnplannedDemand."PO Line No";
        //unit cost from prpoject lines in LCY convert to the currency on the list

        Clear(ProjectPlanningLines);
        IF ProjectPlanningLines.Get(RequisitionLine."Job No.", RequisitionLine."Job Task No.", RequisitionLine."Job Planning Line No.") then begin
            RequisitionLine."Shortcut Dimension 1 Code MASQ" := ProjectPlanningLines."Shortcut Dimension 1 Code";
            RequisitionLine."Shortcut Dimension 2 Code MASQ" := ProjectPlanningLines."Shortcut Dimension 2 Code";
            RequisitionLine."Shortcut Dimension 3 Code" := ProjectPlanningLines."Shortcut Dimension 3 Code";
            RequisitionLine."Shortcut Dimension 4 Code" := ProjectPlanningLines."Shortcut Dimension 4 Code";
            RequisitionLine."Shortcut Dimension 5 Code" := ProjectPlanningLines."Shortcut Dimension 5 Code";
            RequisitionLine."Shortcut Dimension 6 Code" := ProjectPlanningLines."Shortcut Dimension 6 Code";
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInitPurchOrderLine', '', false, false)]
    local procedure OnAfterInitPurchOrderLine(var PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    var

        SalesLine: Record "Sales Line";
        PurchaseRequestLine: Record "Purchase Request Line";
    begin
        PurchaseLine."Meg Item Type" := RequisitionLine."Meg Item Type";
        PurchaseLine."MASQ Sales Order No." := RequisitionLine."MASQ Sales Order No.";
        PurchaseLine."MASQ Sales Order Line No." := RequisitionLine."MASQ Sales Order Line No.";

        //Project Module
        PurchaseLine.Validate("Job No.", RequisitionLine."Job No.");
        PurchaseLine.Validate("Job Task No.", RequisitionLine."Job Task No.");
        PurchaseLine.Validate("Job Planning Line No.", RequisitionLine."Job Planning Line No.");
        //  PurchaseLine."Sent to PO" := RequisitionLine."Sent to PO";


        //Dimensiion and item type from so lines to PO lines
        PurchaseLine.Validate("Shortcut Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code MASQ");
        PurchaseLine.Validate("Shortcut Dimension 2 Code", RequisitionLine."Shortcut Dimension 2 Code MASQ");
        PurchaseLine.ValidateShortcutDimCode(3, RequisitionLine."Shortcut Dimension 3 Code");
        PurchaseLine.ValidateShortcutDimCode(4, RequisitionLine."Shortcut Dimension 4 Code");
        PurchaseLine.ValidateShortcutDimCode(5, RequisitionLine."Shortcut Dimension 5 Code");
        PurchaseLine.ValidateShortcutDimCode(6, RequisitionLine."Shortcut Dimension 6 Code");

        PurchaseLine."Meg Item Type" := RequisitionLine."Meg Item Type";

        Clear(SalesLine);
        IF SalesLine.Get(SalesLine."Document Type"::Order, PurchaseLine."MASQ Sales Order No.", PurchaseLine."MASQ Sales Order Line No.") then begin
            SalesLine."MASQ Purchase Order No." := PurchaseLine."Document No.";
            SalesLine."MASQ Purchase Order Line No." := PurchaseLine."Line No.";
            IF SalesLine."Sent to PO" = false then
                SalesLine."Sent to PO" := true;//if sent once dont send it twice or more
            SalesLine.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnAfterInsertPurchOrderHeader, '', false, false)]
    local procedure OnAfterInsertPurchOrderHeader(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; SpecialOrder: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseRequestLine: Record "Purchase Request Line";
        PurchaseRequestHeader: Record "Purchase Request Header";
    begin
        PurchaseOrderHeader.Validate("Shortcut Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code");//01012025
        PurchaseOrderHeader.ValidateShortcutDimCode(4, RequisitionLine."Shortcut Dimension 4 Code");
        PurchaseOrderHeader.ValidateShortcutDimCode(5, RequisitionLine."Shortcut Dimension 5 Code");
        PurchaseOrderHeader.ValidateShortcutDimCode(6, RequisitionLine."Shortcut Dimension 6 Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnAfterInsertPurchOrderLine, '', false, false)]
    local procedure OnAfterInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; var NextLineNo: Integer; var RequisitionLine: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header")
    var
        PurchaseRequestLine: Record "Purchase Request Line";
        PurchaseRequestHeader: Record "Purchase Request Header";
        PurchLine: Record "Purchase Line";
        PurchaseRequestLine2: Record "Purchase Request Line";
    begin
        //AN 04/04/25
        Clear(PurchaseRequestHeader);
        Clear(PurchaseRequestLine);
        Clear(PurchLine);
        PurchLine.SetRange("Document Type", PurchOrderHeader."Document Type"::Order);
        PurchLine.SetRange("Document No.", PurchOrderHeader."No.");
        if PurchLine.FindFirst() then
            repeat
                // PurchaseRequestHeader.SetRange("Vendor No.", PurchOrderLine."Buy-from Vendor No.");
                // if PurchaseRequestHeader.FindFirst() then //repeat to be checked
                //     repeat
                PurchaseRequestLine.SetRange("Item No.", PurchLine."No.");
                PurchaseRequestLine.SetRange("MASQ Sales Order No.", PurchLine."MASQ Sales Order No.");
                PurchaseRequestLine.SetRange("Document Reference", PurchLine."Buy-from Vendor No.");
                if PurchaseRequestLine.FindFirst() then
                    repeat
                        PurchaseRequestLine."PO No." := PurchLine."Document No.";
                        PurchaseRequestLine."PO Line No" := PurchLine."Line No.";
                        PurchaseRequestLine."PO Status" := PurchaseRequestLine."PO Status"::Created;
                        PurchaseRequestLine.Modify();
                    until PurchaseRequestLine.Next() = 0;
            //until PurchaseRequestHeader.Next() = 0;

            until PurchLine.Next() = 0;
        Clear(PurchaseRequestLine2);
        PurchaseRequestLine2.SetRange("PO No.", PurchOrderLine."Document No.");
        PurchaseRequestLine2.SetRange("PO Line No", PurchOrderLine."Line No.");
        if PurchaseRequestLine2.FindFirst() then begin
            if PurchaseRequestLine2."Discount %" <> 0 then
                PurchOrderLine.Validate("Line Discount %", PurchaseRequestLine2."Discount %");
            PurchOrderLine.Modify();
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnBeforeCarryOutBatchActionCode, '', false, false)]
    local procedure OnBeforeCarryOutBatchActionCode(var RequisitionLine: Record "Requisition Line"; var ReqLine2: Record "Requisition Line"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        PurchaseRequest: Record "Purchase Request Header";
    begin

        RequisitionLine.SetRange(Include, true);//only included req lines will be sent to the PO lines


        Clear(PurchaseRequest);//15/01/2025
        PurchaseRequest.SetRange("Global Dimension 1 Code", ReqLine2."Shortcut Dimension 1 Code MASQ");
        PurchaseRequest.SetRange(Assigned, true);
        IF PurchaseRequest.FindFirst() then begin//IF exist Purchase Request assigned add this filter
            RequisitionLine.SetRange("PO from PR", true);////case create the PO from the PR only include the the lines from the PR
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnInsertPurchOrderLineOnBeforeUpdateAssociatedSalesLine, '', false, false)]//need to check
    local procedure OnAfterCarryOutBatchAction(var RequisitionLine: Record "Requisition Line")
    var
        PurchaseRequest: Record "Purchase Request Header";
    begin
        Clear(PurchaseRequest);//this is oonly used if the  yopu want to create the PO from THe PR case the the user assigned the PR to create a PO only create the lines that are assigned from this PR
        PurchaseRequest.SetRange("Global Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code MASQ");//get all the PR for this project
        PurchaseRequest.SetRange("Vendor No.", RequisitionLine."Vendor No.");
        if PurchaseRequest.FindSet() then
            repeat
                PurchaseRequest.Assigned := false;
                PurchaseRequest.Modify();
            until PurchaseRequest.Next() = 0;
    end;


    //remove comment on go live
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchLine', '', false, false)]//for batch posting
    local procedure OnBeforePostPurchLine(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
        NoSeries: Codeunit "No. Series";
        BatchNumber: code[50];
        BatchLOG: Record "Supply Chain LOG";
        Purchaseinvoice: Record "Purch. Inv. Header";
    begin
        //AN 06/26/2025
        IF (PurchLine.Type = PurchLine.Type::Item) AND (PurchLine."Document Type" = PurchLine."Document Type"::Order) then begin
            // no post receive if not linked to bl/awb if it is an order
            IF PurchHeader.Receive then begin
                if PurchHeader."Gen. Bus. Posting Group" = 'FOREIGN' then begin
                    IF PurchLine."Qty. to Receive" <> 0 then begin
                        IF (PurchLine."Shipping By" = PurchLine."Shipping By"::Air) OR (PurchLine."Shipping By" = PurchLine."Shipping By"::Sea) then//added on 27/05/2025
                            PurchLine.TestField("BL/AWB ID");

                        IF PurchLine."Shipping By" = PurchLine."Shipping By"::InLand then//added on 27/05/2025
                            PurchLine.TestField("Truck WayBill ID");//added on 27/05/2025
                    end;
                end;
            end;
        end;
        //for credit memos only
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeTestUnitOfMeasureCode', '', false, false)]//for batch posting
    local procedure OnPostSalesLineOnBeforeTestUnitOfMeasureCode(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TempSalesLineGlobal: Record "Sales Line" temporary; var IsHandled: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        BatchLog: Record "Supply Chain LOG";
        Purchaseline2: Record "Purchase Line";
    begin
        //  Clear(PurchaseLine);
        IF (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine."Document Type" = SalesLine."Document Type"::Order) then begin

            // no post ship if po is not received yet
            //    IF SalesHeader.Ship then begin//need to check
            //        IF (SalesLine."Qty. to Ship" <> 0) and (SalesLine."Qty. Shipped (Base)" = 0) then begin//skip lines not being posted
            //            IF Purchaseline2.Get(Purchaseline2."Document Type"::Order, SalesLine."MASQ Purchase Order No.", SalesLine."MASQ Purchase Order Line No.") then begin
            //                Purchaseline2.TestField("Quantity Received");
            //            end;
            //        end;

            //    end;
            IF SalesLine."Batch Number" = '' then begin


                IF (SalesLine."MASQ Purchase Order No." <> '') and (SalesLine."MASQ Purchase Order Line No." <> 0) then begin
                    Clear(BatchLog);
                    BatchLog.SetRange("PO Number", SalesLine."MASQ Purchase Order No.");
                    BatchLog.SetRange("PO Line Number", SalesLine."MASQ Purchase Order Line No.");
                    BatchLog.SetFilter("Batch Number", '<> %1', '');
                    IF BatchLog.FindFirst() then begin
                        SalesLine."Batch Number" := BatchLog."Batch Number";
                    end;
                end;
            end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforePostItem', '', false, false)]//for batch posting
    local procedure OnBeforePostItem(var TransferShipmentHeader: Record "Transfer Shipment Header"; var IsHandled: Boolean; var TransferLine: Record "Transfer Line"; TransShptLine2: Record "Transfer Shipment Line"; WhseShip: Boolean; WhseShptHeader2: Record "Warehouse Shipment Header"; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var
                                                                                                                                                                                                                                                                                                                                                        WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line")
    var
        BatchLog: Record "Supply Chain LOG";
    begin
        IF TransferLine."Batch Number" = '' then begin


            IF (TransferLine."MASQ Purchase Order No." <> '') and (TransferLine."MASQ Purchase Order Line No." <> 0) then begin
                Clear(BatchLog);
                BatchLog.SetRange("PO Number", TransferLine."MASQ Purchase Order No.");
                BatchLog.SetRange("PO Line Number", TransferLine."MASQ Purchase Order Line No.");
                BatchLog.SetFilter("Batch Number", '<> %1', '');
                IF BatchLog.FindFirst() then begin
                    TransferLine."Batch Number" := BatchLog."Batch Number";
                end;
            end;
        end;
    end;

    //Transfer Sales Order from Project Module(previosuly was Sales invoice)
    //project module
    //skip error check if invoice or credit memo
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTestSalesLineJob', '', false, false)]
    local procedure OnBeforeTestSalesLineJob(SalesLine: Record "Sales Line"; var SkipTestJobNo: Boolean)
    begin
        SkipTestJobNo := true;
    end;
    //skip error check if invoice or credit memo
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeTestJobNo', '', false, false)]

    local procedure OnPostSalesLineOnBeforeTestJobNo(SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //Create Sales order not Sales invoice
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceJobTaskOnBeforeCreateSalesLine', '', false, false)]
    local procedure OnCreateSalesInvoiceJobTaskOnBeforeCreateSalesLine(var JobPlanningLine: Record "Job Planning Line"; SalesHeader: Record "Sales Header"; SalesHeader2: Record "Sales Header"; var NoOfSalesLinesCreated: Integer)
    var
        JobPlanningLineInvoice: Record "Job Planning Line Invoice";

    begin
        IF SalesHeader2."Document Type" = SalesHeader2."Document Type"::Invoice then
            SalesHeader2."Document Type" := SalesHeader2."Document Type"::Order;

        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            JobPlanningLineInvoice."Document Type" := JobPlanningLineInvoice."Document Type"::Order
    end;
    //Create Sales order not Sales invoice
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeCreateSalesLine', '', false, false)]
    local procedure OnBeforeCreateSalesLine(var JobPlanningLine: Record "Job Planning Line"; var SalesHeader: Record "Sales Header"; var SalesHeader2: Record "Sales Header"; var JobInvCurrency: Boolean)
    begin
        IF SalesHeader2."Document Type" = SalesHeader2."Document Type"::Invoice then
            SalesHeader2."Document Type" := SalesHeader2."Document Type"::Order;
    end;
    //Create Sales order not Sales invoice
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeCreateSalesHeader', '', false, false)]
    local procedure OnBeforeCreateSalesHeader(Job: Record Job; PostingDate: Date; var SalesHeader2: Record "Sales Header"; var JobPlanningLine: Record "Job Planning Line")
    begin
        IF SalesHeader2."Document Type" = SalesHeader2."Document Type"::Invoice then
            SalesHeader2."Document Type" := SalesHeader2."Document Type"::Order;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", OnBeforeModifySalesHeader, '', false, false)]
    local procedure OnBeforeModifySalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    begin
        SalesHeader.Validate("Shortcut Dimension 1 Code", JobPlanningLine."Shortcut Dimension 1 Code");//01012025
        SalesHeader.ValidateShortcutDimCode(4, JobPlanningLine."Shortcut Dimension 4 Code");
        SalesHeader.ValidateShortcutDimCode(5, JobPlanningLine."Shortcut Dimension 5 Code");
        SalesHeader.ValidateShortcutDimCode(6, JobPlanningLine."Shortcut Dimension 6 Code");
    end;
    //tranfser posted invocie number to the project ledger entries
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostJobContractLineBeforeTestFields', '', false, false)]
    local procedure OnPostJobContractLineBeforeTestFields(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        IsHandled := true;
        IF SalesHeader.Invoice then begin
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
                Clear(SalesInvHeader);
                if SalesInvHeader.Get(SalesHeader."Posting No.") then //NB MASQ
                    SalesLine."Document No." := SalesInvHeader."No.";
            end;
        end;
    end;



    //transfer quantity to project ledger entry since condition to validate quantity is on level of invoice and credit memo only
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnFromPlanningSalesLineToJnlLineOnBeforeInitAmounts', '', false, false)]
    local procedure OnFromPlanningSalesLineToJnlLineOnBeforeInitAmounts(var JobJournalLine: Record "Job Journal Line"; var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin

        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                // IF SalesLine."Qty. to Invoice" <> 0 then//AI_03/01/2025
                JobJournalLine.Validate(Quantity, SalesLine."Qty. to Invoice");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", OnPostInvoiceContractLineOnBeforePostJobOnSalesLine, '', false, false)]
    local procedure OnPostInvoiceContractLineOnBeforePostJobOnSalesLine(JobPlanningLine: Record "Job Planning Line"; JobPlanningLineInvoice: Record "Job Planning Line Invoice"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        //case 1 sales order 2 lines 1 line fully invoiced second not will show error quantity on project journal liine must not equal to zero becase of the posted sale line
        IF SalesLine."Qty. to Invoice" = 0 then//if qty to invocie = 0 then lines is all invoiced to need to post a project ledger entry
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeInsertSalesLine', '', false, false)]
    local procedure OnBeforeInsertSalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line"; JobInvCurrency: Boolean)
    begin
        SalesLine."Job Planning Line No." := JobPlanningLine."Line No.";//transfer Project planning to Sales Lines --> purchase line

        //Dimensiion and item type from project planning to SO lines
        SalesLine.Validate("Shortcut Dimension 1 Code", JobPlanningLine."Shortcut Dimension 1 Code");
        SalesLine.Validate("Shortcut Dimension 2 Code", JobPlanningLine."Shortcut Dimension 2 Code");
        SalesLine.ValidateShortcutDimCode(3, JobPlanningLine."Shortcut Dimension 3 Code");
        SalesLine.ValidateShortcutDimCode(4, JobPlanningLine."Shortcut Dimension 4 Code");
        SalesLine.ValidateShortcutDimCode(5, JobPlanningLine."Shortcut Dimension 5 Code");
        SalesLine.ValidateShortcutDimCode(6, JobPlanningLine."Shortcut Dimension 6 Code");

        SalesLine."Meg Item Type" := JobPlanningLine."Meg Item Type";
        SalesLine."Apollo Job Unit Cost" := JobPlanningLine."Unit Cost (LCY)";//in LCY//31/12/2024
    end;



    [EventSubscriber(ObjectType::Table, database::"Job Planning Line Invoice", 'OnAfterInitFromJobPlanningLine', '', false, false)]
    local procedure OnAfterInitFromJobPlanningLine(var JobPlanningLineInvoice: Record "Job Planning Line Invoice"; JobPlanningLine: Record "Job Planning Line")
    begin
        //by default type = order it will be validated again other wise in the InitFromSales functionn in the same table "Job Planning Line Invoice"
        JobPlanningLineInvoice."Document Type" := JobPlanningLineInvoice."Document Type"::Order;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnAfterOpenSalesInvoice', '', false, false)]//to open sales order page instead of sale invoice
    local procedure OnAfterOpenSalesInvoice(var JobPlanningLineInvoice: Record "Job Planning Line Invoice")
    var
        SalesHeader: Record "Sales Header";
    begin
        case JobPlanningLineInvoice."Document Type" of
            JobPlanningLineInvoice."Document Type"::Order:
                begin
                    SalesHeader.Get(SalesHeader."Document Type"::Order, JobPlanningLineInvoice."Document No.");
                    PAGE.RunModal(PAGE::"Sales Order", SalesHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeRestoreSalesDocument', '', false, false)]
    local procedure OnBeforeRestoreSalesDocument(var SalesHeaderArchive: Record "Sales Header Archive"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        IF NOT UserSetup."Can Restore Sales Order" then
            Error('No Permission to Restore a Sales order');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnBeforeTestSalesLine', '', false, false)]
    local procedure OnBeforeTestSalesLine(var SalesLine: Record "Sales Line"; var Handled: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        IF UserId = 'ABDALLAH' then
            Handled := true;

        Clear(UserSetup);
        IF UserSetup.Get(UserId) then begin
            IF UserSetup."Can Edit SO/PO Details" then
                Handled := true;
        end;

        IF SalesLine."Skip Line Checking " then//skip the checking done on the sales line if the line linked to a job case only spliiting po lines and VO//commented on 29/11/2024 need to check
            Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostJobContractLine', '', false, false)]//to be checked
    local procedure OnBeforePostJobContractLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean; var JobContractLine: Boolean; var InvoicePostingInterface: Interface "Invoice Posting"; SalesLineACY: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        IF SalesHeader.Ship AND (NOT SalesHeader.Invoice) then begin//post contarct on post invoice only
            IsHandled := true;
        end;
        //qty to ship and qty to ship base are always = 0 on sales credit mempo
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order then//added on 28/02/2025//this is added to post the sale cr memo job contract line since after the below condition no preject ledger entries is inserted on post sales cr memo
            IF (SalesLine."Qty. to Ship" = 0) and (SalesLine."Qty. Shipped (Base)" = 0) then begin//dont post a contract line if the sale line is not being posted yet only post cotyract if the lines being posted
                IsHandled := true;
            end;
    end;

    //FQ MASQ **Start

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnPostInvoiceContractLineBeforeCheckJobLine', '', false, false)]
    local procedure OnPostInvoiceContractLineBeforeCheckJobLine(var JobLineChecked: Boolean; SalesHeader: Record "Sales Header"; var JobPlanningLine: Record "Job Planning Line"; var SalesLine: Record "Sales Line")
    var
        usersetup: Record "User Setup";
    begin
        // CRITICAL: Skip validation for credit memos - they create new planning lines with zero Qty. Transferred to Invoice
        usersetup.Get(UserId);
        if usersetup."Skip Project Qty.trans Inv" = true then begin
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then begin
                JobLineChecked := true;
                exit;
            end;
        end;
    end;
    //FQ MASQ **END

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", OnBeforePostInvoiceContractLine, '', false, false)]
    // local procedure OnBeforePostInvoiceContractLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    // begin
    //     IF SalesHeader.ship then begin
    //         IsHandled := true;
    //     end;
    // end;

    //commented on 12/04/2024
    //user may need to create several sales order from the same project
    // [EventSubscriber(ObjectType::Codeunit, CODEUNIT::"Job Create-Invoice", 'OnCreateSalesInvoiceOnBeforeRunReport', '', false, false)]
    // local procedure OnCreateSalesInvoiceOnBeforeRunReport(var JobPlanningLine: Record "Job Planning Line"; var Done: Boolean; var NewInvoice: Boolean; var PostingDate: Date; var InvoiceNo: Code[20]; var IsHandled: Boolean; CrMemo: Boolean)
    // var
    //     jobplanningLines2: Record "Job Planning Line";
    //     text001: label 'please do select all the lines to create the Sales Order,currently selected %1 out of %2';
    // begin
    //     //make sure that all project planning lines are selected to be converted to a sales order
    //     Clear(jobplanningLines2);
    //     jobplanningLines2.SetRange("Job No.", JobPlanningLine."Job No.");
    //     jobplanningLines2.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
    //     jobplanningLines2.SetFilter("Line Type", '%1 | %2', JobPlanningLine."Line Type"::Billable, JobPlanningLine."Line Type"::"Both Budget and Billable");
    //     IF jobplanningLines2.Count <> JobPlanningLine.Count then
    //         Error(text001, JobPlanningLine.Count, jobplanningLines2.Count);
    // end;


    [EventSubscriber(ObjectType::Table, database::"Job Planning Line", 'OnBeforeValidateModification', '', false, false)]
    local procedure OnBeforeValidateModification(var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean; xJobPlanningLine: Record "Job Planning Line"; FieldNo: Integer)
    begin
        IsHandled := true;// to be checked
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnBeforeValidateRelationship', '', false, false)]
    local procedure OnBeforeValidateRelationship(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;//to be checked
    end;

    [EventSubscriber(ObjectType::Table, database::"Job Planning Line", 'OnAfterDeleteAmounts', '', false, false)]//commented on 29/11/2024 need to check//do it for vo onlyyyyy//to be checked case partail shipment and receipt for remainig impact
    local procedure OnAfterDeleteAmounts(var JobPlanningLine: Record "Job Planning Line")
    begin
        JobPlanningLine.CalcFields("Qty. Transferred to Invoice");
        //  Message(Format(JobPlanningLine."Qty. Transferred to Invoice"));
        JobPlanningLine.Quantity := JobPlanningLine."Qty. Transferred to Invoice";
        JobPlanningLine."Quantity (Base)" := JobPlanningLine."Qty. Transferred to Invoice";
        JobPlanningLine."Remaining Qty." := JobPlanningLine."Qty. Transferred to Invoice";
        JobPlanningLine."Remaining Qty. (Base)" := JobPlanningLine."Qty. Transferred to Invoice";
        // JobPlanningLine.Validate("Unit Cost");
        // JobPlanningLine.Validate("Unit Price", 1000);
        //cost update automatically  price will be updated manual for now at the project planning lines on after VO Repalce the item
    end;

    // [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnBeforeValidateJobContractEntryNo', '', false, false)]//to be removed
    // local procedure OnBeforeValidateJobContractEntryNo(xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    // begin
    //     IsHandled := true;//to be removed
    // end;

    // [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnValidateJobPlanningLineNoOnBeforeTestFields', '', false, false)]
    // local procedure OnValidateJobPlanningLineNoOnBeforeTestFields(var PurchaseLine: Record "Purchase Line"; var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean)//to be removed
    // begin
    //     IsHandled := true;
    // end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Link Usage", 'OnBeforeMatchUsageSpecified', '', false, false)]
    // local procedure OnBeforeMatchUsageSpecified(var JobPlanningLine: Record "Job Planning Line"; var JobJournalLine: Record "Job Journal Line"; var JobLedgerEntry: Record "Job Ledger Entry"; var IsHandled: Boolean);//to be removed
    // begin
    //     IsHandled := true;
    // end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", 'OnBeforeJobLedgEntryInsert', '', false, false)]//add charges cost to the project ledger entries
    local procedure OnBeforeJobLedgEntryInsert(var JobLedgerEntry: Record "Job Ledger Entry"; JobJournalLine: Record "Job Journal Line")
    var
        ValueEntryGoods: Record "Value Entry";
        ValueEntryCharges: Record "Value Entry";
        CLEARING: Decimal;
        CUSTOMS: Decimal;
        FREIGHT: Decimal;
        OTHERS: Decimal;
        INSURANCE: Decimal;
    begin
        FREIGHT := 0;
        CUSTOMS := 0;
        CLEARING := 0;
        OTHERS := 0;
        INSURANCE := 0;
        IF JobLedgerEntry."Entry Type" = JobLedgerEntry."Entry Type"::Usage then begin
            Clear(ValueEntryGoods);
            ValueEntryGoods.SetRange("Job No.", JobLedgerEntry."Job No.");
            ValueEntryGoods.SetRange("Job Task No.", JobLedgerEntry."Job Task No.");
            ValueEntryGoods.SetRange("Posting Date", JobLedgerEntry."Posting Date");
            ValueEntryGoods.SetRange("Document No.", JobLedgerEntry."Document No.");
            ValueEntryGoods.SetRange("Item No.", JobLedgerEntry."No.");
            IF ValueEntryGoods.FindFirst() then begin
                Clear(ValueEntryCharges);
                ValueEntryCharges.SetRange("Item Ledger Entry No.", ValueEntryGoods."Item Ledger Entry No.");
                if ValueEntryCharges.FindSet() then
                    repeat

                        IF ValueEntryCharges."Gen. Prod. Posting Group" = 'CLEARING' then
                            CLEARING += ValueEntryCharges."Cost Amount (Actual)" else

                            IF ValueEntryCharges."Gen. Prod. Posting Group" = 'CUSTOMS' then
                                CUSTOMS += ValueEntryCharges."Cost Amount (Actual)" else

                                IF ValueEntryCharges."Gen. Prod. Posting Group" = 'FREIGHT' then
                                    FREIGHT += ValueEntryCharges."Cost Amount (Actual)" else

                                    IF ValueEntryCharges."Gen. Prod. Posting Group" = 'INSURANCE' then
                                        INSURANCE += ValueEntryCharges."Cost Amount (Actual)" else

                                        IF ValueEntryCharges."Gen. Prod. Posting Group" = 'OTHEREXP TAXABLE' then
                                            OTHERS += ValueEntryCharges."Cost Amount (Actual)";

                    until ValueEntryCharges.Next() = 0;


                JobLedgerEntry."Actual (Total Cost) Freight" := FREIGHT;
                JobLedgerEntry."Actual (Total Cost) Custom" := CUSTOMS;
                JobLedgerEntry."Actual (Total Cost) Clearance" := CLEARING;
                JobLedgerEntry."Actual (Total Cost) Others" := OTHERS;
                JobLedgerEntry."Actual (Total Cost) Insurance" := INSURANCE;//all cost related to insurance is added on 10/02/2025


            end;

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Calculate WIP", 'OnCreateWIPEntriesOnBeforeJobWIPEntryInsert', '', false, false)]//ADD CHARGES COST TO THE reCOGN COST IN THE PROJECT
    local procedure OnCreateWIPEntriesOnBeforeJobWIPEntryInsert(var JobWIPEntry: Record "Job WIP Entry")
    var
        Job: Record JOB;
        JobTask: Record "Job Task";
        ChargesCost: Decimal;
    begin
        ChargesCost := 0;
        if JobWIPEntry.Type = JobWIPEntry.Type::"Recognized Costs" THEN begin

            JobTask.SetRange("Job No.", JobWIPEntry."Job No.");
            IF JobTask.FindSet() then
                repeat
                    JobTask.CalcFields("Usage (Total Cost) Clearance", "Usage (Total Cost) Freight", "Usage (Total Cost) Customs", "Usage (Total Cost) Others", "Usage (Total Cost) Insurance");//updated on 10022025
                    ChargesCost += JobTask."Usage (Total Cost) Clearance" + JobTask."Usage (Total Cost) Customs" + JobTask."Usage (Total Cost) Freight" + JobTask."Usage (Total Cost) Others" + JobTask."Usage (Total Cost) Insurance";
                until JobTask.Next() = 0;

            JobWIPEntry."WIP Entry Amount" := JobWIPEntry."WIP Entry Amount" + ChargesCost;
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::Job, OnAfterCalcRecognizedProfitAmount, '', false, false)]//Add the charges cost to the profit in the jobs
    local procedure OnAfterCalcRecognizedProfitAmount(var Result: Decimal; sender: Record Job)
    var
        JobTask: Record "Job Task";
        ChargesCost: Decimal;
    begin
        ChargesCost := 0;
        JobTask.SetRange("Job No.", sender."No.");
        IF JobTask.FindSet() then
            repeat
                JobTask.CalcFields("Usage (Total Cost) Clearance", "Usage (Total Cost) Freight", "Usage (Total Cost) Customs", "Usage (Total Cost) Others", "Usage (Total Cost) Insurance");//updated on 10022025
                ChargesCost += JobTask."Usage (Total Cost) Clearance" + JobTask."Usage (Total Cost) Customs" + JobTask."Usage (Total Cost) Freight" + JobTask."Usage (Total Cost) Others" + JobTask."Usage (Total Cost) Insurance";
            until JobTask.Next() = 0;


        Result := Result - ChargesCost;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", OnAfterValidateEvent, 'No.', false, false)]//dimension management
    local procedure OnAfterValidateEventJobPlanningLineNo(var Rec: Record "Job Planning Line"; var xRec: Record "Job Planning Line")
    var
        ITemRec: Record Item;
    begin
        IF Rec."No." <> '' then begin

            Clear(ITemRec);
            IF Rec.Type = Rec.Type::Item then begin
                ITemRec.Get(rec."No.");
            end;


            rec."Shortcut Dimension 3 Code" := ITemRec."Meg Brand";
            Rec."Shortcut Dimension 2 Code" := ITemRec."Global Dimension 2 Code";
            Rec.Modify();

        end;
    end;
    //for project lines dimensions
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterInsertEvent', '', false, false)]//dimension management
    local procedure OnAfterInsertEventJobPlanningLine(var Rec: Record "Job Planning Line")
    var

    begin
        if CompanyName() = 'NEW MASQ-KSA' then begin
            Rec."Shortcut Dimension 4 Code" := 'SA-02';
        end
        else begin
            Rec."Shortcut Dimension 4 Code" := 'QR';
        end;
        Rec."Shortcut Dimension 5 Code" := 'PROJECT MANAGMENT';
        rec."Shortcut Dimension 6 Code" := 'SP001';
        Rec."Shortcut Dimension 1 Code" := Rec."Location Code";
        rec.Modify();

    end;


    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", OnAfterValidateEvent, 'Location Code', false, false)]//dimension management
    local procedure OnAfterValidateEventJobPlanningLinLocationCode(var Rec: Record "Job Planning Line"; var xRec: Record "Job Planning Line")
    var
        ITemRec: Record Item;
    begin
        Rec."Shortcut Dimension 1 Code" := Rec."Location Code";
        rec.Modify();
    end;



    //Inventory and Jobs
    //by Default post the purchase linked to a job will insert 2 lines purchase and negative adjustment
    //posting a sales wil not post any item ledger
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostItemJnlLineOnBeforeIsJobContactLineCheck, '', false, false)]//do post item ledger after posting sales linked to a job
    local procedure OnPostItemJnlLineOnBeforeIsJobContactLineCheck(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var ShouldPostItemJnlLine: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; QtyToBeShipped: Decimal)
    begin
        ShouldPostItemJnlLine := true;
        //AN 03/04/25
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Sale then begin
            ItemJnlLine."Job No." := SalesLine."Job No.";
            ItemJnlLine."Job Task No." := SalesLine."Job Task No.";
            ItemJnlLine."Order Line No." := SalesLine."Job Contract Entry No.";
        end;
    end;

    //AN 03/06/25
    // Modify Order Line No in ILE
    //To be Edited
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertItemLedgEntry, '', false, false)]
    local procedure OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        ItemLedgerEntry."Order Line No." := ItemJournalLine."Order Line No.";
    end;

    //AN 03/05/25
    // Modify Job Ledger Entry No in VE and Ledger Entry No in JLE
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInsertPostValueEntryToGL, '', false, false)]
    local procedure OnAfterInsertPostValueEntryToGL(ValueEntry: Record "Value Entry")
    var
        JobLedgerEntry: Record "Job Ledger Entry";
    begin
        if ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale then begin
            Clear(JobLedgerEntry);
            JobLedgerEntry.SetRange("Job No.", ValueEntry."Job No.");
            JobLedgerEntry.SetRange("Job Task No.", ValueEntry."Job Task No.");
            JobLedgerEntry.SetRange("Posting Date", ValueEntry."Posting Date");
            JobLedgerEntry.SetRange(Type, JobLedgerEntry.Type::Item);
            JobLedgerEntry.SetRange("Document No.", ValueEntry."Document No.");
            JobLedgerEntry.SetRange("No.", ValueEntry."Item No.");
            //JobLedgerEntry.SetRange("Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
            if JobLedgerEntry.FindFirst() then begin
                ValueEntry."Job Ledger Entry No." := JobLedgerEntry."Entry No.";
                ValueEntry.Modify();
            end;
        end;
        //AN 03/06/25
        Clear(JobLedgerEntry);
        JobLedgerEntry.SetRange("Entry No.", ValueEntry."Job Ledger Entry No.");
        if JobLedgerEntry.FindFirst() then begin
            JobLedgerEntry."Ledger Entry No." := ValueEntry."Item Ledger Entry No.";
            JobLedgerEntry.Modify();
        end;
    end;


    //from here check

    //is hanlded = true to no post negative adjustment usage but it will not post the project ledger entries so we needded to add the JobPostLine.PostJobOnPurchaseLine
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnPostItemJnlLineJobConsumption, '', false, false)]
    local procedure OnPostItemJnlLineJobConsumption(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; ItemJournalLine: Record "Item Journal Line"; var TempPurchReservEntry: Record "Reservation Entry" temporary; QtyToBeInvoiced: Decimal; QtyToBeReceived: Decimal; var TempTrackingSpecification: Record "Tracking Specification" temporary; PurchItemLedgEntryNo: Integer; var IsHandled: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; SrcCode: Code[10])
    begin
        //value entries are posted before project ledger entries
        //need to check
        IsHandled := true;
        IF PurchHeader.Invoice then
            IF PurchLine."Job No." <> '' then
                JobPostLine.PostJobOnPurchaseLine(PurchHeader, PurchInvHeader, PurchCrMemoHeader, PurchLine, SrcCode);
    end;



    //by default it will take valaue entry of neg adjustment but since we removed it replace it with value entry of the entry type = purchase
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", OnBeforeGetJobConsumptionValueEntry, '', false, false)]
    local procedure OnBeforeGetJobConsumptionValueEntry(var JobJournalLine: Record "Job Journal Line"; var Result: Boolean; var IsHandled: Boolean; var ValueEntry: Record "Value Entry")
    var
    begin
        IsHandled := true;

        ValueEntry.SetCurrentKey("Job No.", "Job Task No.", "Document No.");
        ValueEntry.SetRange("Item No.", JobJournalLine."No.");
        ValueEntry.SetRange("Job No.", JobJournalLine."Job No.");
        ValueEntry.SetRange("Job Task No.", JobJournalLine."Job Task No.");
        ValueEntry.SetRange("Document No.", JobJournalLine."Document No.");
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Purchase);
        ValueEntry.SetRange("Job Ledger Entry No.", 0);
        //  OnGetJobConsumptionValueEntryFilter(ValueEntry, JobJnlLine, JobJournalLine);

        Result := ValueEntry.FindSet();

    end;

    //here to prevent PostJobConsumptionBeforePurch (for CREDIT MEMOS ONLY)   since  the value entry of the purch is still not inserted the above publisher is returning false
    //since the value entry is still not created so the above conditions are not met
    //we had to insert the job ledger after the purchase to fix this issue
    //PostJobConsumptionBeforePurch only is true if the docment type is return and credit memo
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeItemJnlPostLine, '', false, false)]//added on 04/03/2025
    local procedure OnBeforeItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; var IsHandled: Boolean; WhseReceiptHeader: Record "Warehouse Receipt Header"; WhseShipmentHeader: Record "Warehouse Shipment Header"; TempItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)" temporary; TempWarehouseReceiptHeader: Record "Warehouse Receipt Header" temporary; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    begin
        IsHandled := true;
    end;

    // quantity of usage must be positive and not negative
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", OnPostItemOnBeforeUpdateTotalAmounts, '', false, false)]
    local procedure OnPostItemOnBeforeUpdateTotalAmounts(var JobJournalLine: Record "Job Journal Line"; ItemLedgerEntry: Record "Item Ledger Entry"; ValueEntry: Record "Value Entry")
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        JobJournalLine.Quantity := ValueEntry."Invoiced Quantity" / JobJournalLine."Qty. per Unit of Measure";
        JobJournalLine."Quantity (Base)" :=
            Round(JobJournalLine.Quantity * JobJournalLine."Qty. per Unit of Measure", UOMMgt.QtyRndPrecision());
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Link Usage", OnHandleMatchUsageSpecifiedJobPlanningLineOnBeforeUpdateQuantity, '', false, false)]
    local procedure OnHandleMatchUsageSpecifiedJobPlanningLineOnBeforeUpdateQuantity(var JobPlanningLine: Record "Job Planning Line"; JobJournalLine: Record "Job Journal Line"; var UpdateQuantity: Boolean)
    begin
        UpdateQuantity := false;//DONT UPDATE QUANTITY if QUANTITYT IS CHANGED FROM THE VARIATION ORDER CHANGE QUANTITY
                                //I WILL HANDLE CHANGING THE QUANTITY ON THE PROEJCT PLANNNING LINES with the variation
                                //this caused  the issue of the quantity being change to double on project planning linesAI 28/04/2025
    end;


    //AN 03/13/25
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertGlEntry, '', true, true)]
    local procedure OnBeforeInsertGlEntry(var GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean)
    var
        DimensionSetEntry: Record "Dimension Set Entry";
    begin
        GLEntry."Travel Request Code" := GenJnlLine."Travel Request Code";

        //AN 06/90/2025
        // Clear(DimensionSetEntry);
        // DimensionSetEntry.SetRange("Dimension Code", 'EXPENSE CATEGORY');
        // DimensionSetEntry.SetRange("Dimension Value Code", GLEntry."Shortcut Dimension 7 Code");
        // if DimensionSetEntry.FindFirst() then begin
        //     DimensionSetEntry.CalcFields("Dimension Value Name");
        //     GLEntry."Expense Category Description" := DimensionSetEntry."Dimension Value Name";
        // end;
        // //AN 07/01/2025
        // Clear(DimensionSetEntry);
        // DimensionSetEntry.SetRange("Dimension Code", 'EMPLOYEE');
        // DimensionSetEntry.SetRange("Dimension Value Code", GLEntry."Shortcut Dimension 8 Code");
        // if DimensionSetEntry.FindFirst() then begin
        //     DimensionSetEntry.CalcFields("Dimension Value Name");
        //     GLEntry."Employee Name" := DimensionSetEntry."Dimension Value Name";
        // end
    end;

    //AN 03/17/25
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", OnAfterCreateSalesInvoiceLines, '', true, true)]
    local procedure OnAfterCreateSalesInvoiceLines(SalesHeader: Record "Sales Header"; NewInvoice: Boolean)
    begin
        SalesHeader.CalcFields(Amount);
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and (SalesHeader.Amount <> 0) then
            MASQEmail.SendEmailSalesOrder(SalesHeader);
    end;

    //AN 03/17/25
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", OnCreatePurchaseOrderOnAfterPurchaseHeaderSetFilters, '', true, true)]
    local procedure OnCreatePurchaseOrderOnAfterPurchaseHeaderSetFilters(var PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header")
    begin
        PurchaseHeader.CalcFields(Amount);
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) and (PurchaseHeader.Amount <> 0) then
            MASQEmail.SendEmailPurchOrder(PurchaseHeader);
    end;

    //AN 03/28/25
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Req. Wksh.-Make Order", OnBeforeInsertPurchOrderLine, '', true, true)]
    local procedure OnBeforeInsertPurchOrderLine(var RequisitionLine: Record "Requisition Line";
     var PurchaseHeader: Record "Purchase Header";
      var NextLineNo: Integer; var IsHandled: Boolean; var PrevPurchCode: Code[10]; var PrevShipToCode: Code[10]; var PlanningResiliency: Boolean;
       TempDocumentEntry: Record "Document Entry" temporary; var SuppressCommit: Boolean;
        var PostingDateReq: Date; var ReferenceReq: Text[35]; var OrderDateReq: Date;
         var ReceiveDateReq: Date; var OrderCounter: Integer;
          var HideProgressWindow: Boolean; var PrevLocationCode: Code[10]; var LineCount: Integer; var PurchOrderHeader: Record "Purchase Header";
           PurchasingCode: Record Purchasing; var PurchOrderLine: Record "Purchase Line")
    var
        PurchaseRequestLine: Record "Purchase Request Line";
        PurchaseHeader2: Record "Purchase Header";
        PurchLine2: Record "Purchase Line";
    begin
        Clear(PurchaseRequestLine);
        Clear(PurchaseHeader2);
        Clear(PurchLine2);
        if RequisitionLine."Append to PO No." <> '' then begin
            if ((RequisitionLine.Include = true) or (RequisitionLine."PO from PR" = true)) and (RequisitionLine."PO No." = '') and (RequisitionLine."Append to PO No." <> '') then begin
                PurchaseHeader2.SetRange("Document Type", PurchaseHeader2."Document Type"::Order);
                PurchaseHeader2.SetRange("No.", RequisitionLine."Append to PO No.");
                if PurchaseHeader2.FindFirst() then begin
                    InsertPurchOrderLineUpdated(RequisitionLine, PurchaseHeader2);
                    PurchLine2.SetRange("Document Type", PurchaseHeader2."Document Type"::Order);
                    PurchLine2.SetRange("Document No.", PurchaseHeader2."No.");
                    if PurchLine2.FindFirst() then
                        repeat
                            if PurchLine2."Document No." = RequisitionLine."Append to PO No." then begin
                                PurchaseRequestLine.SetRange("Item No.", PurchLine2."No.");
                                PurchaseRequestLine.SetRange("MASQ Sales Order No.", PurchLine2."MASQ Sales Order No.");
                                if PurchaseRequestLine.FindFirst() then
                                    repeat
                                        PurchaseRequestLine."PO No." := PurchLine2."Document No.";
                                        PurchaseRequestLine."PO Line No" := PurchLine2."Line No.";
                                        PurchaseRequestLine."PO Status" := PurchaseRequestLine."PO Status"::Created;
                                        PurchaseRequestLine.Modify();
                                    until PurchaseRequestLine.Next() = 0;
                            end;
                        until PurchLine2.Next() = 0;
                end;
            end;
            RequisitionLine.SetRange("No.");
            IsHandled := true;
        end
        else
            if RequisitionLine."Append to PO No." = '' then begin
                IsHandled := false;
                RequisitionLine.SetRange("No.");
            end;
    end;

    procedure InitPurchOrderLine2(var
                                      PurchOrderLine: Record "Purchase Line";
                                      PurchOrderHeader: Record "Purchase Header";
                                      RequisitionLine: Record "Requisition Line")
    var
        IsHandled: Boolean;
    begin
        NextLineNo := 0;
        Clear(PurchOrderLine);
        PurchOrderLine.Init();
        PurchOrderLine.BlockDynamicTracking(true);
        PurchOrderLine."Document Type" := PurchOrderLine."Document Type"::Order;
        PurchOrderLine."Buy-from Vendor No." := RequisitionLine."Vendor No.";
        PurchOrderLine."Document No." := PurchOrderHeader."No.";
        NextLineNo := GetLastPOLineNo(PurchOrderHeader."No.");
        PurchOrderLine."Line No." := NextLineNo;
        PurchOrderLine.Validate(Type, RequisitionLine.Type);
        PurchOrderLine.Validate("No.", RequisitionLine."No.");
        PurchOrderLine.Validate("Variant Code", RequisitionLine."Variant Code");
        PurchOrderLine.Validate("Location Code", RequisitionLine."Location Code");
        PurchOrderLine.Validate("Unit of Measure Code", RequisitionLine."Unit of Measure Code");
        PurchOrderLine."Qty. per Unit of Measure" := RequisitionLine."Qty. per Unit of Measure";
        PurchOrderLine."Prod. Order No." := RequisitionLine."Prod. Order No.";
        PurchOrderLine."Prod. Order Line No." := RequisitionLine."Prod. Order Line No.";
        InitPurchOrderLineUpdateQuantity2(RequisitionLine);

        CopyOrderDateFromPurchHeader2(RequisitionLine, PurchOrderHeader, PurchOrderLine);
        if PurchOrderHeader."Prices Including VAT" then
            PurchOrderLine.Validate("Direct Unit Cost", RequisitionLine."Direct Unit Cost" * (1 + PurchOrderLine."VAT %" / 100))
        else
            PurchOrderLine.Validate("Direct Unit Cost", RequisitionLine."Direct Unit Cost");

        PurchOrderLine.Validate("Line Discount %", RequisitionLine."Line Discount %");

        PurchOrderLine."Vendor Item No." := RequisitionLine."Vendor Item No.";
        //AN 06/19/2025
        //PurchOrderLine."Meg Vendor Item Code" := RequisitionLine."Meg Vendor Item Code";
        PurchOrderLine.Description := RequisitionLine.Description;
        PurchOrderLine."Description 2" := RequisitionLine."Description 2";
        PurchOrderLine."Sales Order No." := RequisitionLine."Sales Order No.";
        PurchOrderLine."Sales Order Line No." := RequisitionLine."Sales Order Line No.";
        PurchOrderLine."Prod. Order No." := RequisitionLine."Prod. Order No.";
        PurchOrderLine."Bin Code" := RequisitionLine."Bin Code";
        PurchOrderLine."Item Category Code" := RequisitionLine."Item Category Code";
        PurchOrderLine.Nonstock := RequisitionLine.Nonstock;
        PurchOrderLine.Validate("Planning Flexibility", RequisitionLine."Planning Flexibility");
        PurchOrderLine.Validate("Purchasing Code", RequisitionLine."Purchasing Code");
        if RequisitionLine."Due Date" <> 0D then begin
            PurchOrderLine.Validate("Expected Receipt Date", RequisitionLine."Due Date");
            PurchOrderLine."Requested Receipt Date" := PurchOrderLine."Planned Receipt Date";
        end;

        OnAfterInitPurchOrderLine(PurchOrderLine, RequisitionLine);
    end;

    local procedure InitPurchOrderLineUpdateQuantity2(var RequisitionLine: Record "Requisition Line")
    var
        IsHandled: Boolean;
    begin

        PurchOrderLine.Validate(Quantity, RequisitionLine.Quantity);
    end;

    local procedure CopyOrderDateFromPurchHeader2(var RequisitionLine: Record "Requisition Line"; PurchOrderHeader: Record "Purchase Header"; PurchOrderLine: Record "Purchase Line")
    var
        IsHandled: Boolean;
    begin
        if PurchOrderLine.CountPrice(true) > 0 then
            RequisitionLine.Validate("Order Date", PurchOrderHeader."Order Date");
    end;

    procedure InsertPurchOrderLineUpdated(var ReqLine2: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header")
    var
        PurchOrderLine2: Record "Purchase Line";
        AddOnIntegrMgt: Codeunit AddOnIntegrManagement;
        DimensionSetIDArr: array[10] of Integer;
        IsHandled: Boolean;
        ReqWkshMakeOrder: Codeunit "Req. Wksh.-Make Order";
    begin
        PrevPurchCode := ReqLine2."Purchasing Code";
        PrevShipToCode := ReqLine2."Ship-to Code";
        PrevLocationCode := ReqLine2."Location Code";

        InitPurchOrderLine2(PurchOrderLine, PurchOrderHeader, ReqLine2);

        AddOnIntegrMgt.TransferFromReqLineToPurchLine(PurchOrderLine, ReqLine2);

        PurchOrderLine."Drop Shipment" := ReqLine2."Sales Order Line No." <> 0;



        UpdateJobLink(PurchOrderLine, ReqLine2);

        DimensionSetIDArr[1] := PurchOrderLine."Dimension Set ID";
        DimensionSetIDArr[2] := ReqLine2."Dimension Set ID";
        PurchOrderLine."Dimension Set ID" :=
          DimMgt.GetCombinedDimensionSetID(
            DimensionSetIDArr, PurchOrderLine."Shortcut Dimension 1 Code", PurchOrderLine."Shortcut Dimension 2 Code");


        PurchOrderLine.Insert();
    end;


    local procedure UpdateJobLink(var PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        if RequisitionLine.Reserve then  //if reserve not set job link
            exit;

        if (RequisitionLine."Planning Line Origin" = RequisitionLine."Planning Line Origin"::"Order Planning") and
           (RequisitionLine."Demand Type" = Database::"Job Planning Line")
        then begin
            JobPlanningLine.SetRange("Job Contract Entry No.", RequisitionLine."Demand Line No.");
            JobPlanningLine.FindFirst();

            PurchaseLine.Validate("Job No.", JobPlanningLine."Job No.");
            PurchaseLine.Validate("Job Task No.", JobPlanningLine."Job Task No.");
            PurchaseLine.Validate("Job Planning Line No.", JobPlanningLine."Line No.");
        end;


    end;


    local procedure GetLastPOLineNo(DocNo: code[20]): Integer
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(PurchaseLine);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetFilter("Document No.", DocNo);
        if PurchaseLine.FindLast() then
            LastLineNo := PurchaseLine."Line No." + 10000
        else
            LastLineNo := 10000;

        exit(LastLineNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, OnBeforeCheckDocuments, '', false, false)]//to change item card
    local procedure OnBeforeCheckDocuments(Item: Record Item; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF UserId = 'ABDALLAH' then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, OnBeforeCheckReqLine, '', false, false)]//to change item card
    local procedure OnBeforeCheckReqLine(Item: Record Item; CurrentFieldNo: Integer; CheckFieldNo: Integer; CheckFieldCaption: Text; var IsHandled: Boolean)
    begin
        IF UserId = 'ABDALLAH' then
            IsHandled := true;
    end;

    //AN 03/27/2025+
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterValidateEvent, "Responsibility Center", false, false)]
    local procedure OnAfterValidateRC(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        PurchaseLine: Record "Purchase Line";
        Branch: Code[20];
        Department: Code[20];
        Salesperson: Code[20];
        ProjectCode: Code[20];
        xDimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        // Check if the "Responsibility Center" field has changed.
        GeneralLedgerSetup.Get();
        Rec.SetHideValidationDialog(true);
        Clear(xDimensionSetEntry);
        if xDimensionSetEntry.Get(xRec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 4 Code") then begin
            Branch := xDimensionSetEntry."Dimension Value Code";
            Rec.ValidateShortcutDimCode(4, Branch);
        end;
        Clear(xDimensionSetEntry);
        if xDimensionSetEntry.Get(xRec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 5 Code") then begin
            Department := xDimensionSetEntry."Dimension Value Code";
            Rec.ValidateShortcutDimCode(5, Department);
        end;
        Clear(xDimensionSetEntry);
        if xDimensionSetEntry.Get(xRec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 6 Code") then begin
            Salesperson := xDimensionSetEntry."Dimension Value Code";
            Rec.ValidateShortcutDimCode(6, Salesperson);
        end;
        Clear(xDimensionSetEntry);
        if xDimensionSetEntry.Get(xRec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 1 Code") then begin
            ProjectCode := xDimensionSetEntry."Dimension Value Code";
            Rec.ValidateShortcutDimCode(1, ProjectCode);
        end;
        Rec.Validate("Location Code", xRec."Location Code");
        Rec.Validate("Assigned User ID", xRec."Assigned User ID");
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterValidateEvent, "Location Code", false, false)]
    local procedure OnAfterValidateLocation(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        PurchaseLine: Record "Purchase Line";
        Branch: Code[20];
        Department: Code[20];
        Salesperson: Code[20];
        ProjectCode: Code[20];
        xDimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        // Check if the "Location Code" field has changed.
        GeneralLedgerSetup.Get();
        Rec.SetHideValidationDialog(true);
        Clear(xDimensionSetEntry);
        if xDimensionSetEntry.Get(xRec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 4 Code") then begin
            Branch := xDimensionSetEntry."Dimension Value Code";
            Rec.ValidateShortcutDimCode(4, Branch);
            Rec.Modify();
        end;
        Clear(xDimensionSetEntry);
        if xDimensionSetEntry.Get(xRec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 5 Code") then begin
            Department := xDimensionSetEntry."Dimension Value Code";
            Rec.ValidateShortcutDimCode(5, Department);
            Rec.Modify();
        end;
        Clear(xDimensionSetEntry);
        if xDimensionSetEntry.Get(xRec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 6 Code") then begin
            Salesperson := xDimensionSetEntry."Dimension Value Code";
            Rec.ValidateShortcutDimCode(6, Salesperson);
            Rec.Modify();
        end;

        if xRec."Shortcut Dimension 1 Code" <> '' then begin
            // Rec.Validate("Shortcut Dimension 1 Code", xRec."Shortcut Dimension 1 Code");
            // Rec.Modify();
            Clear(xDimensionSetEntry);
            if xDimensionSetEntry.Get(xRec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 1 Code") then begin
                ProjectCode := xDimensionSetEntry."Dimension Value Code";
                Rec.ValidateShortcutDimCode(1, ProjectCode);
                Rec.Modify();
            end;
        end;
        // if xRec."Shortcut Dimension 2 Code" <> '' then begin
        //     Rec.Validate("Shortcut Dimension 2 Code", xRec."Shortcut Dimension 2 Code");
        //     Rec.Modify();
        // end;

    end;
    //AN 04/09/2025
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterValidateEvent, "Buy-from Vendor No.", false, false)]
    local procedure OnAfterValidateVend(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        Rec.Validate("Responsibility Center", xRec."Responsibility Center");
        Rec.Modify();
    end;
    //below 3 subscribers to prevet from adding the negative adjustmenr line of the job consumption after undo the receipt in the posted purchase receipt
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnPostItemJnlLineOnBeforeUndoValuePostingWithJob, '', false, false)]
    local procedure OnPostItemJnlLineOnBeforeUndoValuePostingWithJob(PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchRcptLine: Record "Purch. Rcpt. Line"; var ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Posting Management", OnPostItemJnlLineOnBeforePostItemJnlLineForJob, '', false, false)]
    local procedure OnPostItemJnlLineOnBeforePostItemJnlLineForJob(var ItemJnlLine2: Record "Item Journal Line"; var IsHandled: Boolean; var ItemJnlLine: Record "Item Journal Line"; var PostJobConsumptionBeforePurch: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Posting Management", OnPostItemJnlLineOnBeforePostJobConsumption, '', false, false)]
    local procedure OnPostItemJnlLineOnBeforePostJobConsumption(var ItemJnlLine2: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, 'Salesperson Code', false, false)]
    local procedure OnSalesHeaderOnAfterValidateSalesperson(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        PurchaseLine: Record "Purchase Line";
        Branch: Code[20];
        Department: Code[20];
        Salesperson: Code[20];
        ProjectCode: Code[20];
        DimensionSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        Rec.SetHideValidationDialog(true);
        IF (Rec."Salesperson Code" <> xRec."Salesperson Code") and (Rec."Salesperson Code" <> '') then begin
            Clear(DimensionSetEntry);
            IF DimensionSetEntry.Get(xRec."Dimension Set ID", GLSetup."Shortcut Dimension 1 Code") then
                Rec.Validate("Shortcut Dimension 1 Code", DimensionSetEntry."Dimension Value Code");

            Clear(DimensionSetEntry);
            IF DimensionSetEntry.Get(xRec."Dimension Set ID", GLSetup."Shortcut Dimension 4 Code") then
                Rec.ValidateShortcutDimCode(4, DimensionSetEntry."Dimension Value Code");

            Clear(DimensionSetEntry);
            IF DimensionSetEntry.Get(xRec."Dimension Set ID", GLSetup."Shortcut Dimension 5 Code") then
                Rec.ValidateShortcutDimCode(5, DimensionSetEntry."Dimension Value Code");

            Rec.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Intermediate Customers", OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterInsertIC(var Rec: Record "Intermediate Customers")

    begin
        Rec."Apollo Number" := Rec."No.";
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Intermediate Vendors", OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterInsertIV(var Rec: Record "Intermediate Vendors")

    begin
        Rec."Apollo Number" := Rec."No.";
        Rec.Modify();
    end;

    procedure UpdateChargesonJobLedgerEntry(var JobLedgerEntry: Record "Job Ledger Entry")
    var
        ValueEntryGoods: Record "Value Entry";
        ValueEntryCharges: Record "Value Entry";
        CLEARING: Decimal;
        CUSTOMS: Decimal;
        FREIGHT: Decimal;
        OTHERS: Decimal;
        INSURANCE: Decimal;
    begin
        FREIGHT := 0;
        CUSTOMS := 0;
        CLEARING := 0;
        OTHERS := 0;
        INSURANCE := 0;
        IF JobLedgerEntry."Entry Type" = JobLedgerEntry."Entry Type"::Usage then begin
            Clear(ValueEntryGoods);
            ValueEntryGoods.SetRange("Job No.", JobLedgerEntry."Job No.");
            ValueEntryGoods.SetRange("Job Task No.", JobLedgerEntry."Job Task No.");
            ValueEntryGoods.SetRange("Posting Date", JobLedgerEntry."Posting Date");
            ValueEntryGoods.SetRange("Document No.", JobLedgerEntry."Document No.");
            ValueEntryGoods.SetRange("Item No.", JobLedgerEntry."No.");
            IF ValueEntryGoods.FindFirst() then begin
                Clear(ValueEntryCharges);
                ValueEntryCharges.SetRange("Item Ledger Entry No.", ValueEntryGoods."Item Ledger Entry No.");
                if ValueEntryCharges.FindSet() then
                    repeat

                        IF ValueEntryCharges."Gen. Prod. Posting Group" = 'CLEARING' then
                            CLEARING += ValueEntryCharges."Cost Amount (Actual)" else

                            IF ValueEntryCharges."Gen. Prod. Posting Group" = 'CUSTOMS' then
                                CUSTOMS += ValueEntryCharges."Cost Amount (Actual)" else

                                IF ValueEntryCharges."Gen. Prod. Posting Group" = 'FREIGHT' then
                                    FREIGHT += ValueEntryCharges."Cost Amount (Actual)" else

                                    IF ValueEntryCharges."Gen. Prod. Posting Group" = 'INSURANCE' then
                                        INSURANCE += ValueEntryCharges."Cost Amount (Actual)" else

                                        IF ValueEntryCharges."Gen. Prod. Posting Group" = 'OTHEREXP TAXABLE' then
                                            OTHERS += ValueEntryCharges."Cost Amount (Actual)";

                    until ValueEntryCharges.Next() = 0;


                JobLedgerEntry."Actual (Total Cost) Freight" := FREIGHT;
                JobLedgerEntry."Actual (Total Cost) Custom" := CUSTOMS;
                JobLedgerEntry."Actual (Total Cost) Clearance" := CLEARING;
                JobLedgerEntry."Actual (Total Cost) Others" := OTHERS;

                JobLedgerEntry."Actual (Total Cost) Insurance" := INSURANCE;//all cost related to insurance is added on 10/02/2025
                JobLedgerEntry.Modify();

            end;

        end;

    end;

    procedure updatepriceandAmount(var JobLedgerEntry: Record "Job Ledger Entry")
    var
        SalesinvLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        Clear(SalesinvLine);
        SalesinvLine.SetRange("Document No.", JobLedgerEntry."Document No.");
        SalesinvLine.SetRange("Posting Date", JobLedgerEntry."Posting Date");
        SalesinvLine.SetRange("No.", JobLedgerEntry."No.");
        IF SalesinvLine.FindFirst() then begin
            JobLedgerEntry.Validate("Unit Price", SalesinvLine."Unit Price");
            JobLedgerEntry.Modify();
        end;

        Clear(SalesCrMemoLine);
        SalesCrMemoLine.SetRange("Document No.", JobLedgerEntry."Document No.");
        SalesCrMemoLine.SetRange("Posting Date", JobLedgerEntry."Posting Date");
        SalesCrMemoLine.SetRange("No.", JobLedgerEntry."No.");
        IF SalesCrMemoLine.FindFirst() then begin
            JobLedgerEntry.Validate("Unit Price", SalesCrMemoLine."Unit Price");
            JobLedgerEntry.Modify();
        end;

    end;

    //take the unit price from the sales line to the job journal line and not from the project planning line lines for accurate reporting of the project
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", OnAfterFromPlanningSalesLineToJnlLine, '', false, false)]
    local procedure OnAfterFromPlanningSalesLineToJnlLine(var JobJnlLine: Record "Job Journal Line"; JobPlanningLine: Record "Job Planning Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; EntryType: Enum "Job Journal Line Entry Type")
    begin
        JobJnlLine.Validate("Unit Price", SalesLine."Unit Price");
    end;

    var
        FilterText: Text;
        UOMMgt: Codeunit "Unit of Measure Management";
        EmailHasAttachment: Boolean;
        JobPostLine: Codeunit "Job Post-Line";
        MASQEmail: Codeunit "MASQ Email";
        LastLineNo: Integer;
        PurchaseOrderNo: Code[20];
        LineCount: Integer;
        PrevChangedDocOrderNo: Code[20];
        PrevLocationCode: Code[10];
        PrevPurchCode: Code[10];
        PrevShipToCode: Code[10];
        PurchOrderLine: Record "Purchase Line";
        DimMgt: Codeunit DimensionManagement;
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        NextLineNo: Integer;
        Text006: Label '%1 on sales order %2 is already associated with purchase order %3.', Comment = '%1 = number of item, %2 = number of document, %3 = number of purchase order';
}