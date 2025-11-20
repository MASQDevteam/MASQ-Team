pageextension 70136 "posted sales shipments extens" extends "Posted Sales Shipments"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.', Comment = '%';
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action(UpdateAllDeliveryOrderNo)
            {
                ApplicationArea = All;
                Caption = 'Update All Delivery Order No.';
                Image = RefreshLines;
                ToolTip = 'Updates the Delivery Order No. on all shipment lines for all posted shipments.';

                trigger OnAction()
                var
                    UpdateDeliveryOrderNo: Codeunit "Update Delivery Order No.";
                begin
                    if Confirm('Do you want to update Delivery Order No. on all shipment lines for ALL posted shipments? This may take some time.', false) then begin
                        UpdateDeliveryOrderNo.UpdateExistingShipments();
                    end;
                end;
            }
            action(UpdateSelectedDeliveryOrderNo)
            {
                ApplicationArea = All;
                Caption = 'Update Selected Shipments';
                Image = RefreshLines;
                ToolTip = 'Updates the Delivery Order No. on all shipment lines for selected shipments.';

                trigger OnAction()
                var
                    SalesShipmentHeader: Record "Sales Shipment Header";
                    UpdateDeliveryOrderNo: Codeunit "Update Delivery Order No.";
                    UpdateCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(SalesShipmentHeader);

                    if SalesShipmentHeader.Count = 0 then begin
                        Message('No shipments selected.');
                        exit;
                    end;

                    if Confirm('Do you want to update Delivery Order No. for %1 selected shipment(s)?', false, SalesShipmentHeader.Count) then begin
                        if SalesShipmentHeader.FindSet() then
                            repeat
                                UpdateDeliveryOrderNo.UpdateSingleShipment(SalesShipmentHeader."No.");
                                UpdateCount += 1;
                            until SalesShipmentHeader.Next() = 0;

                        Message('Delivery Order No. has been updated on %1 shipment(s).', UpdateCount);
                    end;
                end;
            }
        }

    }

    var
        myInt: Integer;
}