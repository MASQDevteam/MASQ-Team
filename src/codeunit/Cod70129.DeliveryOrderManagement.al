//FQ **START**
codeunit 70129 "Update Delivery Order No."
{
    Permissions =
        tabledata "Sales Shipment Line" = rimd,
        tabledata "Sales Shipment Header" = rimd;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesShptLineInsert', '', false, false)]
    local procedure OnAfterSalesShptLineInsert(var SalesShipmentLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header")
    var
        DeliveryOrderNo: Code[20];
    begin
        // Get Delivery Order No. from header
        DeliveryOrderNo := GetDeliveryOrderFromHeader(SalesShptHeader);

        if DeliveryOrderNo = '' then
            exit;

        // Only update if quantity > 0 and not an undo shipment
        if (SalesShipmentLine.Quantity > 0) and (not IsUndoShipment(SalesShipmentLine)) then begin
            SalesShipmentLine."Delivery Order No." := DeliveryOrderNo;
            SalesShipmentLine.Modify();
        end;
    end;

    local procedure UpdateDeliveryOrderOnLines(SalesShipmentHeader: Record "Sales Shipment Header")
    var
        SalesShipmentLine: Record "Sales Shipment Line";
        DeliveryOrderNo: Code[20];
    begin
        // Get Delivery Order No. from header (assuming field exists from Megateck extension)
        // Field ID might be different - adjust as needed
        DeliveryOrderNo := GetDeliveryOrderFromHeader(SalesShipmentHeader);

        if DeliveryOrderNo = '' then
            exit;

        // Filter shipment lines for this document
        SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
        SalesShipmentLine.SetFilter(Quantity, '>0'); // Only lines with quantity > 0

        if SalesShipmentLine.FindSet() then
            repeat
                // Check if this is not an undo shipment
                if not IsUndoShipment(SalesShipmentLine) then begin
                    SalesShipmentLine."Delivery Order No." := DeliveryOrderNo;
                    SalesShipmentLine.Modify();
                end;
            until SalesShipmentLine.Next() = 0;
    end;

    local procedure GetDeliveryOrderFromHeader(SalesShipmentHeader: Record "Sales Shipment Header"): Code[20]
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        DeliveryOrderNo: Code[20];
    begin
        // Use RecordRef to access the custom field from Megateck extension
        RecRef.GetTable(SalesShipmentHeader);

        // Try to find the Delivery Order No. field
        // Field name might be different - common variations:
        if RecRef.FieldExist(50008) then begin // Adjust field ID as needed
            FldRef := RecRef.Field(50008);
            DeliveryOrderNo := FldRef.Value;
        end;

        exit(DeliveryOrderNo);
    end;

    local procedure IsUndoShipment(SalesShipmentLine: Record "Sales Shipment Line"): Boolean
    var
        SalesShipmentLine2: Record "Sales Shipment Line";
    begin
        // Check if there's a matching line with same Order Line No. and opposite quantity (undo shipment)
        // When a shipment is undone, BC creates two lines with same Order Line No. but opposite quantities

        // Skip if Order Line No. is 0 (shouldn't happen, but safety check)
        if SalesShipmentLine."Order Line No." = 0 then
            exit(false);

        SalesShipmentLine2.SetRange("Document No.", SalesShipmentLine."Document No.");
        SalesShipmentLine2.SetRange("Order Line No.", SalesShipmentLine."Order Line No."); // Same order line
        SalesShipmentLine2.SetFilter("Line No.", '<>%1', SalesShipmentLine."Line No."); // Different shipment line

        if SalesShipmentLine2.FindSet() then
            repeat
                // If we find a line with same Order Line No. and opposite quantity, it's an undo shipment
                if SalesShipmentLine2.Quantity = -SalesShipmentLine.Quantity then
                    exit(true);
            until SalesShipmentLine2.Next() = 0;

        exit(false);
    end;

    // Method to update a single shipment (callable from page actions)
    procedure UpdateSingleShipment(ShipmentNo: Code[20])
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if SalesShipmentHeader.Get(ShipmentNo) then
            UpdateDeliveryOrderOnLines(SalesShipmentHeader);
    end;

    // Alternative method: Use this if you want to run manually on existing records
    procedure UpdateExistingShipments()
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        UpdateCount: Integer;
        TotalCount: Integer;
        ProgressDialog: Dialog;
    begin
        TotalCount := SalesShipmentHeader.Count;

        if TotalCount = 0 then begin
            Message('No sales shipments found.');
            exit;
        end;

        ProgressDialog.Open('Updating Delivery Order Numbers...\Progress: #1#### of #2####');

        if SalesShipmentHeader.FindSet() then
            repeat
                UpdateCount += 1;
                ProgressDialog.Update(1, UpdateCount);
                ProgressDialog.Update(2, TotalCount);
                UpdateDeliveryOrderOnLines(SalesShipmentHeader);
            until SalesShipmentHeader.Next() = 0;

        ProgressDialog.Close();
        Message('Delivery Order Numbers updated successfully on %1 shipment(s).', UpdateCount);
    end;
}
//FQ **END**