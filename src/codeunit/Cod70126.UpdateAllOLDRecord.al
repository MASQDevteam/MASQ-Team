//FQ MASQ **START**
codeunit 70126 "Migrate Custom Status"
{
    // Run this codeunit once to update all existing purchase orders with custom status
    trigger OnRun()
    begin
        UpdateAllPurchaseOrders();
        UpdateAllSalesOrders();
    end;

    procedure UpdateAllPurchaseOrders()
    var
        PurchHeader: Record "Purchase Header";
        UpdatePurchStatusMgmt: Codeunit "Update Purchase Custom Status";
        TotalRecords: Integer;
        ProcessedRecords: Integer;
        Window: Dialog;
    begin
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
        TotalRecords := PurchHeader.Count;

        if not Confirm('Do you want to update custom status for %1 purchase orders?', false, TotalRecords) then
            exit;

        Window.Open('Processing Purchase Orders\' +
                   'Progress: #1########## of #2##########');

        if PurchHeader.FindSet() then
            repeat
                ProcessedRecords += 1;
                Window.Update(1, ProcessedRecords);
                Window.Update(2, TotalRecords);

                UpdatePurchStatusMgmt.UpdateCustomStatus(PurchHeader);
                Commit();
            until PurchHeader.Next() = 0;

        Window.Close();
        Message('Successfully updated %1 purchase orders.', ProcessedRecords);
    end;

    procedure UpdateAllSalesOrders()
    var
        SalesHeader: Record "Sales Header";
        UpdateSalesStatusMgmt: Codeunit "Update Sales Custom Status";
        TotalRecords: Integer;
        ProcessedRecords: Integer;
        Window: Dialog;
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        TotalRecords := SalesHeader.Count;

        if not Confirm('Do you want to update custom status for %1 sales orders?', false, TotalRecords) then
            exit;

        Window.Open('Processing Sales Orders\' +
                   'Progress: #1########## of #2##########');

        if SalesHeader.FindSet() then
            repeat
                ProcessedRecords += 1;
                Window.Update(1, ProcessedRecords);
                Window.Update(2, TotalRecords);

                UpdateSalesStatusMgmt.UpdateCustomStatus(SalesHeader);
                Commit();
            until SalesHeader.Next() = 0;

        Window.Close();
        Message('Successfully updated %1 sales orders.', ProcessedRecords);
    end;
}
//FQ MASQ **END**