codeunit 70120 ProjectEvent

//FQ MASQ **Start**
{
    SingleInstance = true;
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"job", 'OnBeforeCheckBillToCustomerAssosEntriesExist', '', false, false)]
    local procedure OnBeforeCheckBillToCustomerAssosEntriesExist(var Job: Record Job; var xJob: Record Job; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        SalesLine: Record "Sales Line";
        CanBypass: Boolean;

    begin
        if IsHandled then
            exit;
        CanBypass := false;
        if UserSetup.Get(UserId) then
            CanBypass := UserSetup.BypassCustOnProject;

        if not CanBypass then
            if (Job."Bill-to Customer No." = '') or (Job."Bill-to Customer No." <> xJob."Bill-to Customer No.") then begin
                if Job.SalesJobLedgEntryExist() then
                    ThrowAssociatedEntriesExistError(Job, xJob, Job.FieldNo("Bill-to Customer No."), Job.FieldCaption("Bill-to Customer No."));
                if Job.SalesLineExist() then
                    ThrowAssociatedEntriesExistError(Job, xJob, Job.FieldNo("Bill-to Customer No."), Job.FieldCaption("Bill-to Customer No."));
            end;

        // Additional validation: Check if sales orders are shipped or invoiced
        if CanBypass then
            if (Job."Bill-to Customer No." = '') or (Job."Bill-to Customer No." <> xJob."Bill-to Customer No.") then begin
                if Job.SalesJobLedgEntryExist() then
                    ThrowAssociatedEntriesExistError(Job, xJob, Job.FieldNo("Bill-to Customer No."), Job.FieldCaption("Bill-to Customer No."));
                if HasShippedOrInvoicedSalesOrders(Job) then
                    ThrowAssociatedEntriesExistError(Job, xJob, Job.FieldNo("Bill-to Customer No."), Job.FieldCaption("Bill-to Customer No."))
                else begin
                    UpdateAssociatedSalesOrdersBillTo(Job);
                    // Flag that we are processing a customer change so we can bypass currency update on planning lines
                    SkipCurrencyUpdateOnCustomerChange := true;
                    IsHandled := true;

                end;
            end;
    end;



    local procedure ThrowAssociatedEntriesExistError(var Job: Record Job; var xJob: Record Job; FieldNo: Integer; FieldCaption: Text)
    var
        ErrorText: Text;
    begin
        ErrorText := 'You cant change %1 because its linked to a project with delivered or invoiced sales orders.';
        Error(ErrorText, FieldCaption);
    end;

    local procedure HasShippedOrInvoicedSalesOrders(var Job: Record Job): Boolean
    var
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        // Open Sales Orders with shipped or invoiced quantities
        SalesLine.SetRange("Job No.", Job."No.");
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetFilter("Quantity Shipped", '>0');
        if not SalesLine.IsEmpty then
            exit(true);

        SalesLine.SetRange("Quantity Shipped");
        SalesLine.SetFilter("Quantity Invoiced", '>0');
        if not SalesLine.IsEmpty then
            exit(true);

        // Posted documents: Sales Shipments
        /*   SalesShipmentLine.Reset();
          SalesShipmentLine.SetRange("Job No.", Job."No.");
          if SalesShipmentLine.FindFirst() then
              exit(true);

          // Posted documents: Sales Invoices
          SalesInvoiceLine.Reset();
          SalesInvoiceLine.SetRange("Job No.", Job."No.");
          if SalesInvoiceLine.FindFirst() then
              exit(true); */
        exit(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnBeforeValidateCurrencyCode', '', false, false)]
    local procedure OnBeforeCurrencyUpdatePlanningLines(var Job: Record Job; var IsHandled: Boolean; xJob: Record Job)
    var
        UserSetup: Record "User Setup";
        CanBypass: Boolean;
        Customer: Record Customer;
    begin
        // bypass just for this customer change
        if SkipCurrencyUpdateOnCustomerChange then begin
            // Do not trigger field validation; assign directly and save
            if (Job."Currency Code" = '') then begin
                if (Job."Bill-to Customer No." <> '') and Customer.Get(Job."Bill-to Customer No.") then begin
                    if Customer."Currency Code" <> '' then begin
                        Job."Currency Code" := Customer."Currency Code";
                        Job.Modify();
                    end;
                end;
            end;
            IsHandled := true;
            SkipCurrencyUpdateOnCustomerChange := false;
            exit;
        end;
        /*  CanBypass := false;
         if UserSetup.Get(UserId) then
             CanBypass := UserSetup.BypassCustOnProject;
         if CanBypass then begin
             IsHandled := true; 
             CanBypass := false;
             exit;
         end; */

    end;


    local procedure UpdateAssociatedSalesOrdersBillTo(var Job: Record Job)
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        SalesLineToUpdate: Record "Sales Line";
        LastDocumentNo: Code[20];
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        WasReleased: Boolean;
        Customer: Record Customer;
        CurrencyCodeToUse: Code[10];
    begin
        LastDocumentNo := '';
        SalesLine.Reset();
        SalesLine.SetCurrentKey("Document Type", "Document No.");
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Job No.", Job."No.");
        if SalesLine.FindSet() then
            repeat
                if SalesLine."Document No." <> LastDocumentNo then begin
                    if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesLine."Document No.") then begin
                        WasReleased := SalesHeader.Status = SalesHeader.Status::Released;
                        if WasReleased then
                            ReleaseSalesDoc.Reopen(SalesHeader);

                        // Ensure currency and factor are consistent
                        if SalesHeader."Currency Code" <> '' then
                            // Re-validate existing currency to force recalculation of factor based on dates
                            SalesHeader.Validate("Currency Code", SalesHeader."Currency Code")
                        else
                            if Job."Currency Code" <> '' then
                                // Set currency from Job when missing on the order
                                SalesHeader.Validate("Currency Code", Job."Currency Code")
                            else begin
                                // LCY scenario: make sure factor is not left as 0
                                if SalesHeader."Currency Factor" = 0 then
                                    SalesHeader."Currency Factor" := 1;
                            end;

                        // Now update customer fields
                        if SalesHeader."Bill-to Customer No." <> Job."Bill-to Customer No." then
                            SalesHeader.Validate("Bill-to Customer No.", Job."Bill-to Customer No.");

                        if SalesHeader."Sell-to Customer No." <> Job."Bill-to Customer No." then
                            SalesHeader.Validate("Sell-to Customer No.", Job."Bill-to Customer No.");

                        SalesHeader.Modify(true);
                        // Ensure all lines on the order reflect the updated customer as well
                        // This aligns line-level customer fields with the header after the Job change
                        SalesLineToUpdate.Reset();
                        SalesLineToUpdate.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLineToUpdate.SetRange("Document No.", SalesHeader."No.");
                        if SalesLineToUpdate.FindSet() then
                            repeat
                                if SalesLineToUpdate."Bill-to Customer No." <> Job."Bill-to Customer No." then
                                    SalesLineToUpdate.Validate("Bill-to Customer No.", Job."Bill-to Customer No.");

                                if SalesLineToUpdate."Sell-to Customer No." <> Job."Bill-to Customer No." then
                                    SalesLineToUpdate.Validate("Sell-to Customer No.", Job."Bill-to Customer No.");

                                SalesLineToUpdate.Modify(true);
                            until SalesLineToUpdate.Next() = 0;

                        if WasReleased then
                            ReleaseSalesDoc.Run(SalesHeader);
                    end;
                    LastDocumentNo := SalesLine."Document No.";
                end;
            until SalesLine.Next() = 0;
    end;
    //FQ MASQ **End**

    var

        SkipCurrencyUpdateOnCustomerChange: Boolean;


}