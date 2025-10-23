//FQ MASQ **START**
codeunit 70127 "Update Sales Custom Status"
{
    // Event Subscribers for Sales Line changes
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifySalesLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        if Rec.IsTemporary then
            exit;

        // Check if quantity fields changed
        if (Rec."Quantity Shipped" <> xRec."Quantity Shipped") or
           (Rec."Quantity Invoiced" <> xRec."Quantity Invoiced") or
           (Rec.Quantity <> xRec.Quantity) then
            if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
                UpdateCustomStatus(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertSalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        if Rec.IsTemporary then
            exit;

        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
            UpdateCustomStatus(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteSalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        if Rec.IsTemporary then
            exit;

        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
            UpdateCustomStatus(SalesHeader);
    end;

    // Event Subscriber for posting
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean)
    var
        SalesHdr: Record "Sales Header";
    begin
        // After posting, check if document still exists (partial posting) and update status
        if SalesHdr.Get(SalesHeader."Document Type", SalesHeader."No.") then
            UpdateCustomStatus(SalesHdr);
    end;

    // Event Subscriber for Release/Reopen
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    begin
        if not PreviewMode then
            UpdateStatusOnRelease(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReopenSalesDoc', '', false, false)]
    local procedure OnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    begin
        if not PreviewMode then
            UpdateStatusOnReopen(SalesHeader);
    end;

    // Main procedure to calculate and update custom status
    procedure UpdateCustomStatus(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        TotalQuantity: Decimal;
        TotalShipped: Decimal;
        TotalInvoiced: Decimal;
        NewStatus: Enum "Custom Sales Status";
        HasLines: Boolean;
    begin
        // Only process Sales Orders
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        // Calculate totals from lines
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter(Type, '<>%1', SalesLine.Type::" "); // Exclude comment lines

        if SalesLine.FindSet() then begin
            HasLines := true;
            repeat
                TotalQuantity += SalesLine.Quantity;
                TotalShipped += SalesLine."Quantity Shipped";
                TotalInvoiced += SalesLine."Quantity Invoiced";
            until SalesLine.Next() = 0;
        end;

        // If no lines or no quantity, maintain basic status based on document status
        if (not HasLines) or (TotalQuantity = 0) then begin
            case SalesHeader.Status of
                SalesHeader.Status::Open:
                    NewStatus := NewStatus::Open;
                SalesHeader.Status::Released:
                    NewStatus := NewStatus::Released;
                else
                    NewStatus := NewStatus::Open;
            end;
        end else
            // Determine status based on quantities
            NewStatus := CalculateStatusFromQuantities(TotalQuantity, TotalShipped, TotalInvoiced, SalesHeader.Status);

        // Update if changed
        if SalesHeader."Custom Status" <> NewStatus then begin
            SalesHeader."Custom Status" := NewStatus;
            SalesHeader.Modify(true);
        end;
    end;

    local procedure CalculateStatusFromQuantities(TotalQty: Decimal; ShippedQty: Decimal; InvoicedQty: Decimal; DocStatus: Enum "Sales Document Status"): Enum "Custom Sales Status"
    var
        StatusResult: Enum "Custom Sales Status";
        IsFullyShipped: Boolean;
        IsPartiallyShipped: Boolean;
        IsFullyInvoiced: Boolean;
        IsPartiallyInvoiced: Boolean;
    begin
        // Determine shipping status
        IsFullyShipped := (ShippedQty >= TotalQty) and (ShippedQty > 0);
        IsPartiallyShipped := (ShippedQty > 0) and (ShippedQty < TotalQty);

        // Determine invoicing status
        IsFullyInvoiced := (InvoicedQty >= TotalQty) and (InvoicedQty > 0);
        IsPartiallyInvoiced := (InvoicedQty > 0) and (InvoicedQty < TotalQty);

        // Determine combined status
        if IsFullyShipped and IsFullyInvoiced then
            exit(StatusResult::"Fully Delivered/Fully Invoiced");

        if IsFullyShipped and IsPartiallyInvoiced then
            exit(StatusResult::"Fully Delivered/Partially Invoiced");

        if IsPartiallyShipped and IsFullyInvoiced then
            exit(StatusResult::"Partially Delivered/Fully Invoiced");

        if IsPartiallyShipped and IsPartiallyInvoiced then
            exit(StatusResult::"Partially Delivered/Partially Invoiced");

        if IsFullyShipped and (InvoicedQty = 0) then
            exit(StatusResult::"Fully Delivered");

        if IsPartiallyShipped and (InvoicedQty = 0) then
            exit(StatusResult::"Partially Delivered");

        if (ShippedQty = 0) and IsFullyInvoiced then
            exit(StatusResult::"Fully Invoiced");

        if (ShippedQty = 0) and IsPartiallyInvoiced then
            exit(StatusResult::"Partially Invoiced");

        // No shipping or invoicing activity - use document status
        case DocStatus of
            DocStatus::Open:
                exit(StatusResult::Open);
            DocStatus::Released:
                exit(StatusResult::Released);
            else
                exit(StatusResult::Open);
        end;
    end;

    local procedure UpdateStatusOnRelease(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        HasActivity: Boolean;
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        // Check if there's any shipping/invoicing activity
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter("Quantity Shipped", '<>0');
        HasActivity := not SalesLine.IsEmpty;

        if not HasActivity then begin
            SalesLine.SetRange("Quantity Shipped");
            SalesLine.SetFilter("Quantity Invoiced", '<>0');
            HasActivity := not SalesLine.IsEmpty;
        end;

        // If no activity, update to Released
        if not HasActivity then begin
            if SalesHeader."Custom Status" <> SalesHeader."Custom Status"::Released then begin
                SalesHeader."Custom Status" := SalesHeader."Custom Status"::Released;
                SalesHeader.Modify(true);
            end;
        end else
            // If there's activity, recalculate full status
            UpdateCustomStatus(SalesHeader);
    end;

    local procedure UpdateStatusOnReopen(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        HasActivity: Boolean;
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        // Check if there's any shipping/invoicing activity
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter("Quantity Shipped", '<>0');
        HasActivity := not SalesLine.IsEmpty;

        if not HasActivity then begin
            SalesLine.SetRange("Quantity Shipped");
            SalesLine.SetFilter("Quantity Invoiced", '<>0');
            HasActivity := not SalesLine.IsEmpty;
        end;

        // If no activity, update to Open
        if not HasActivity then begin
            if SalesHeader."Custom Status" <> SalesHeader."Custom Status"::Open then begin
                SalesHeader."Custom Status" := SalesHeader."Custom Status"::Open;
                SalesHeader.Modify(true);
            end;
        end else
            // If there's activity, recalculate full status
            UpdateCustomStatus(SalesHeader);
    end;
}
//FQ MASQ **END**