//FQ MASQ **START**
codeunit 70124 "Update Purchase Custom Status"
{
    // Event Subscribers for Purchase Line changes
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        PurchHeader: Record "Purchase Header";
    begin
        if Rec.IsTemporary then
            exit;

        // Check if quantity fields changed
        if (Rec."Quantity Received" <> xRec."Quantity Received") or
           (Rec."Quantity Invoiced" <> xRec."Quantity Invoiced") or
           (Rec.Quantity <> xRec.Quantity) then
            if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
                UpdateCustomStatus(PurchHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertPurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        PurchHeader: Record "Purchase Header";
    begin
        if Rec.IsTemporary then
            exit;

        if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
            UpdateCustomStatus(PurchHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        PurchHeader: Record "Purchase Header";
    begin
        if Rec.IsTemporary then
            exit;

        if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
            UpdateCustomStatus(PurchHeader);
    end;

    // Event Subscriber for posting
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        PurchHeader: Record "Purchase Header";
    begin
        // After posting, check if document still exists (partial posting) and update status
        if PurchHeader.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then
            UpdateCustomStatus(PurchHeader);
    end;

    // Event Subscriber for Release/Reopen
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    begin
        if not PreviewMode then
            UpdateStatusOnRelease(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReopenPurchaseDoc', '', false, false)]
    local procedure OnAfterReopenPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        if not PreviewMode then
            UpdateStatusOnReopen(PurchaseHeader);
    end;

    // Main procedure to calculate and update custom status
    procedure UpdateCustomStatus(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        TotalQuantity: Decimal;
        TotalReceived: Decimal;
        TotalInvoiced: Decimal;
        NewStatus: Enum "Custom Purchase Status";
        HasLines: Boolean;
    begin
        // Only process Purchase Orders
        if PurchHeader."Document Type" <> PurchHeader."Document Type"::Order then
            exit;

        // Calculate totals from lines
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" "); // Exclude comment lines

        if PurchLine.FindSet() then begin
            HasLines := true;
            repeat
                TotalQuantity += PurchLine.Quantity;
                TotalReceived += PurchLine."Quantity Received";
                TotalInvoiced += PurchLine."Quantity Invoiced";
            until PurchLine.Next() = 0;
        end;

        // If no lines or no quantity, maintain basic status based on document status
        if (not HasLines) or (TotalQuantity = 0) then begin
            case PurchHeader.Status of
                PurchHeader.Status::Open:
                    NewStatus := NewStatus::Open;
                PurchHeader.Status::Released:
                    NewStatus := NewStatus::Released;
                else
                    NewStatus := NewStatus::Open;
            end;
        end else
            // Determine status based on quantities
            NewStatus := CalculateStatusFromQuantities(TotalQuantity, TotalReceived, TotalInvoiced, PurchHeader.Status);

        // Update if changed
        if PurchHeader."Custom Status" <> NewStatus then begin
            PurchHeader."Custom Status" := NewStatus;
            PurchHeader.Modify(true);
        end;
    end;

    local procedure CalculateStatusFromQuantities(TotalQty: Decimal; ReceivedQty: Decimal; InvoicedQty: Decimal; DocStatus: Enum "Purchase Document Status"): Enum "Custom Purchase Status"
    var
        StatusResult: Enum "Custom Purchase Status";
        IsFullyReceived: Boolean;
        IsPartiallyReceived: Boolean;
        IsFullyInvoiced: Boolean;
        IsPartiallyInvoiced: Boolean;
    begin
        // Determine receiving status
        IsFullyReceived := (ReceivedQty >= TotalQty) and (ReceivedQty > 0);
        IsPartiallyReceived := (ReceivedQty > 0) and (ReceivedQty < TotalQty);

        // Determine invoicing status
        IsFullyInvoiced := (InvoicedQty >= TotalQty) and (InvoicedQty > 0);
        IsPartiallyInvoiced := (InvoicedQty > 0) and (InvoicedQty < TotalQty);

        // Determine combined status
        if IsFullyReceived and IsFullyInvoiced then
            exit(StatusResult::"Fully Received/Fully Invoiced");

        if IsFullyReceived and IsPartiallyInvoiced then
            exit(StatusResult::"Fully Received/Partially Invoiced");

        if IsPartiallyReceived and IsFullyInvoiced then
            exit(StatusResult::"Partially Received/Fully Invoiced");

        if IsPartiallyReceived and IsPartiallyInvoiced then
            exit(StatusResult::"Partially Received/Partially Invoiced");

        if IsFullyReceived and (InvoicedQty = 0) then
            exit(StatusResult::"Fully Received");

        if IsPartiallyReceived and (InvoicedQty = 0) then
            exit(StatusResult::"Partially Received");

        if (ReceivedQty = 0) and IsFullyInvoiced then
            exit(StatusResult::"Fully Invoiced");

        if (ReceivedQty = 0) and IsPartiallyInvoiced then
            exit(StatusResult::"Partially Invoiced");

        // No receiving or invoicing activity - use document status
        case DocStatus of
            DocStatus::Open:
                exit(StatusResult::Open);
            DocStatus::Released:
                exit(StatusResult::Released);
            else
                exit(StatusResult::Open);
        end;
    end;

    local procedure UpdateStatusOnRelease(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        HasActivity: Boolean;
    begin
        if PurchHeader."Document Type" <> PurchHeader."Document Type"::Order then
            exit;

        // Check if there's any receiving/invoicing activity
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetFilter("Quantity Received", '<>0');
        HasActivity := not PurchLine.IsEmpty;

        if not HasActivity then begin
            PurchLine.SetRange("Quantity Received");
            PurchLine.SetFilter("Quantity Invoiced", '<>0');
            HasActivity := not PurchLine.IsEmpty;
        end;

        // If no activity, update to Released
        if not HasActivity then begin
            if PurchHeader."Custom Status" <> PurchHeader."Custom Status"::Released then begin
                PurchHeader."Custom Status" := PurchHeader."Custom Status"::Released;
                PurchHeader.Modify(true);
            end;
        end else
            // If there's activity, recalculate full status
            UpdateCustomStatus(PurchHeader);
    end;

    local procedure UpdateStatusOnReopen(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        HasActivity: Boolean;
    begin
        if PurchHeader."Document Type" <> PurchHeader."Document Type"::Order then
            exit;

        // Check if there's any receiving/invoicing activity
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetFilter("Quantity Received", '<>0');
        HasActivity := not PurchLine.IsEmpty;

        if not HasActivity then begin
            PurchLine.SetRange("Quantity Received");
            PurchLine.SetFilter("Quantity Invoiced", '<>0');
            HasActivity := not PurchLine.IsEmpty;
        end;

        // If no activity, update to Open
        if not HasActivity then begin
            if PurchHeader."Custom Status" <> PurchHeader."Custom Status"::Open then begin
                PurchHeader."Custom Status" := PurchHeader."Custom Status"::Open;
                PurchHeader.Modify(true);
            end;
        end else
            // If there's activity, recalculate full status
            UpdateCustomStatus(PurchHeader);
    end;
}
//FQ MASQ **END**