pageextension 70103 "PO Extension" extends "Purchase Order"
{
    layout
    {
        addafter(PurchLines)
        {
            //AN 07/04/2025
            group("Additional Charges")
            {
                field("Freight Charges"; Rec."Freight Charges")
                {
                    ApplicationArea = All;
                }
                field("Freight Charges Value"; Rec."Freight Charges Value")
                {
                    ApplicationArea = All;
                }
                field("Documentation Charges"; Rec."Documentation Charges")
                {
                    ApplicationArea = All;
                }
                field("Documentation Charges Value"; Rec."Documentation Charges Value")
                {
                    ApplicationArea = All;

                }
                //FQ MASQ ** Start
                field("Other Charges"; Rec."Other Charges")
                {
                    ApplicationArea = All;
                }
                field("Other Charges Value"; Rec."Other Charges Value")
                {
                    ApplicationArea = All;
                }
                // FQ MASQ ** END

                field(TotalWithCharges; Rec.TotalWithCharges)
                {
                    ApplicationArea = All;
                    Caption = 'Total';
                }
            }
        }

        modify("Invoice Received Date")
        {
            ShowMandatory = true;
        }
        //FQ MASQ ** Start
        modify("Responsibility Center")
        {
            ShowMandatory = false;
            Visible = false;
        }
        modify("Assigned User ID")
        {
            ShowMandatory = true;
        }
        addafter(Status)
        {
            field("Custom Status"; Rec."Custom Status")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Shows the custom status based on receiving and invoicing progress';
                StyleExpr = CustomStatusStyle;

                trigger OnDrillDown()
                begin
                    ShowStatusDetails();
                end;
            }

        }
        addafter("Shipment Method Code")
        {
            field("Shipment Mode"; Rec."Shipment Mode")
            {
                ApplicationArea = All;
                Caption = 'Shipment Mode';
                trigger OnValidate()
                var
                    SCCLine: Record "SCC Order Line";
                    ConfirmTxt: Label 'Changing shipment mode to Express will remove this Purchase Order from any Shipping Conformity Certificates. Continue?';
                begin
                    if Rec."Shipment Mode" = Rec."Shipment Mode"::Express then begin
                        SCCLine.SetRange("Purchase Order No.", Rec."No.");
                        if not SCCLine.IsEmpty() then begin
                            if Confirm(ConfirmTxt, false) then begin
                                SCCLine.DeleteAll(true);
                            end else
                                Error('Operation cancelled by user.');
                        end;
                    end;
                    UpdateSCCStatus();
                    CurrPage.Update(false);
                end;
            }
            field("SCC Count"; Rec."SCC Count")
            {
                ApplicationArea = All;
                Caption = 'Shipping Conformity Certificates';
                ToolTip = 'Shows the total number of shipping conformity certificates for this purchase order.';
                StyleExpr = SCCStyle;
                DrillDown = true;
                Enabled = ShowSCCField;
                trigger OnDrillDown()
                var
                    SCCMgt: Codeunit "SCC Management";
                begin
                    SCCMgt.OpenSCCListForPO(Rec."No.");
                end;
            }

        }
        modify("Buy-from Vendor Name")
        {
            Editable = false;
        }
        modify("Buy-from Address")
        {
            Editable = false;
        }
        modify("Buy-from Address 2")
        {
            Editable = false;
        }
        modify("Buy-from City")
        {
            Editable = false;
        }
        modify("Buy-from Post Code")
        {
            Editable = false;
        }
        modify("Buy-from Country/Region Code")
        {
            Editable = false;
        }
        modify("Buy-from Contact No.")
        {
            Editable = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Editable = false;
        }
        modify("Vendor Posting Group")
        {
            Editable = false;
        }
        // FQ MASQ ** END

        // Add changes to page layout here
        addafter(Status)
        {
            field("PO Type"; Rec."PO Type")
            {
                ApplicationArea = All;
            }
            field("Shipping Quotation No."; Rec."Shipping Quotation No.")
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                    ShippingQuotation: Record "Shipping Quotation";
                    ShippingQuotationsList: Page "Shipping Quotations List";
                    FilterValue: Text;
                    QuotationId: Text;
                    IdArray: List of [Text];
                begin
                    Clear(FilterValue);
                    IdArray := Rec."Shipping Quotation No.".Split(',');

                    foreach QuotationId in IdArray do begin
                        QuotationId := DelChr(QuotationId, '=', ' '); // Trim spaces

                        if FilterValue = '' then
                            FilterValue := QuotationId
                        else
                            FilterValue := FilterValue + '|' + QuotationId;
                    end;

                    if FilterValue <> '' then begin
                        ShippingQuotation.SetFilter("Comparison ID", FilterValue);
                        ShippingQuotationsList.SetTableView(ShippingQuotation);
                        ShippingQuotationsList.Run();
                    end;
                end;

            }
            field("Request for Payments"; Rec."Request for Payments")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Request for Payments field.', Comment = '%';

                trigger OnDrillDown()
                var
                    RequestforPayment: Record "SUPPLIER PAYMENT REQUEST";
                begin
                    Clear(RequestforPayment);
                    RequestforPayment.SetRange("PO#", Rec."No.");
                    // RequestforPayment.SetRange(Status, RequestforPayment.Status::Released);
                    page.Run(page::"Request for Payments", RequestforPayment);
                end;
            }
            field("Initial ETR"; Rec."Initial ETR")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETR field.', Comment = '%';
            }
            field("Initial ETD"; Rec."Initial ETD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETD field.', Comment = '%';
            }
            field("Initial ETA"; Rec."Initial ETA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETA field.', Comment = '%';
            }
            field("Initial ETAW"; Rec."Initial ETAW")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETAW field.', Comment = '%';
            }


            field("MASQ Sales Order No."; Rec."MASQ Sales Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Sales Order No. field.', Comment = '%';
            }
            //NB MASQ Start
            field("Logistics Coordinator"; Rec."Logistics Coordinator")
            {
                ApplicationArea = All;
            }
            //NB MASQ End
            //FQ MASQ ** Start

            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Due Date")
        {
            field("Acknowledgement Date"; Rec."Acknowledgement Date")
            {
                ApplicationArea = All;
                Caption = 'PO Acknowledgement Date';
            }
        }
        // FQ MASQ ** END
        addafter("Attached Documents")
        {
            part("BL Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'BL Attachments';
                Provider = PurchLines;
                SubPageLink = //"Table ID" = const(Database::"BL Details"),
                              "No." = field("BL/AWB ID");
                // "Document Type" = field("Document Type");
            }
            part("Cost LOGs Factbox"; "Cost LOGs Factbox")
            {
                ApplicationArea = All;
                Caption = 'Cost/Price Variation LOG';
                Provider = PurchLines;
                SubPageLink = "PO Number" = field("Document No."), "PO Line Number" = field("Line No.");
            }
            part("Variation Order LOG"; "Variation Order LOGs Factbox")
            {
                ApplicationArea = All;
                Caption = 'Variation Order LOG';
                Provider = PurchLines;
                SubPageLink = "PO Number" = field("Document No."), "PO Line Number" = field("Line No."), "VO Number" = filter('<> ''''');
                // "Document Type" = field("Document Type");
            }
            part("Shipping Dates"; "Shipping Dates LOG Factbox")
            {
                ApplicationArea = All;
                Caption = 'Shipping Dates Log';
                Provider = PurchLines;
                SubPageLink = "PO Number" = field("Document No."), "PO Line Number" = field("Line No."), "Batch Number" = const(''), "VO Number" = const('');
                // "Document Type" = field("Document Type");
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        // FQ MASQ ** Start
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                rec.TestField("Assigned User ID");
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                if rec."Custom Status" = rec."Custom Status"::"Fully Received/Fully Invoiced" then begin
                    Error('You cannot reopen a PO once it has been fully received and fully invoiced.');
                end;
            end;
        }
        addfirst(Processing)
        {
            action(RefreshData)
            {
                ApplicationArea = All;
                Caption = 'Refresh Data';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Refresh the current page data to reflect any changes made in other tabs.';

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
            action(updateCustomerdata)
            {
                ApplicationArea = All;
                Caption = 'Update Vendor Fields';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Update Vendor Field in Purchase header';
                trigger OnAction()
                var
                    Vendor: Record Vendor;
                begin
                    if Rec."Buy-from Vendor No." <> '' then begin
                        if Vendor.Get(Rec."Buy-from Vendor No.") then begin
                            Rec."Buy-from Vendor Name" := Vendor.Name;
                            Rec."Buy-from Address" := Vendor.Address;
                            Rec."Buy-from Address 2" := Vendor."Address 2";
                            Rec."Buy-from City" := Vendor.City;
                            Rec."Buy-from Post Code" := Vendor."Post Code";
                            Rec."Buy-from Country/Region Code" := Vendor."Country/Region Code";
                            Rec."Buy-from Contact No." := Vendor.Contact;
                            Rec."VAT Bus. Posting Group" := Vendor."VAT Bus. Posting Group";
                            Rec."Vendor Posting Group" := Vendor."Vendor Posting Group";
                            Rec.Modify();
                            Message('The vendor fields has been updated successfully');
                            CurrPage.Update(false);
                        end;
                    end;
                end;
            }
            // FQ MASQ ** End

            //NB MASQ Start
            action("Open RFP")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Open;
                trigger OnAction()
                var
                    SUPPLIERPAYMENTREQUEST: Record "SUPPLIER PAYMENT REQUEST";
                begin
                    SUPPLIERPAYMENTREQUEST.Reset();
                    SUPPLIERPAYMENTREQUEST.SetRange("PO#", Rec."No.");
                    if SUPPLIERPAYMENTREQUEST.FindFirst() then
                        Page.RunModal(Page::"Request for Payment", SUPPLIERPAYMENTREQUEST)
                    else
                        Message('RFP is not created for this PO');
                end;
            }
            action("Create RFP")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = CreateDocument;
                trigger OnAction()
                var
                    SUPPLIERPAYMENTREQUEST: Record "SUPPLIER PAYMENT REQUEST";
                    NoSeries: Codeunit "No. Series";
                    GeneralLedgerSetup: Record "General Ledger Setup";
                    Vendor: Record Vendor;
                begin
                    SUPPLIERPAYMENTREQUEST.Reset();
                    SUPPLIERPAYMENTREQUEST.SetRange("PO#", Rec."No.");
                    if SUPPLIERPAYMENTREQUEST.FindFirst() then
                        Message('RFP %1 is already created for PO %2', SUPPLIERPAYMENTREQUEST.Number, Rec."No.")
                    else begin
                        GeneralLedgerSetup.Get();
                        SUPPLIERPAYMENTREQUEST.Init();
                        SUPPLIERPAYMENTREQUEST.Validate(Number, NoSeries.GetNextNo(GeneralLedgerSetup."Request for Payment No. Series"));
                        SUPPLIERPAYMENTREQUEST.Validate(Supplier, Rec."Buy-from Vendor No.");
                        if Vendor.Get(Rec."Buy-from Vendor No.") then //NB MASQ
                            SUPPLIERPAYMENTREQUEST.Validate("RFP Type", Vendor."RFP Type");
                        SUPPLIERPAYMENTREQUEST.Validate("PO#", Rec."No.");
                        SUPPLIERPAYMENTREQUEST.Validate("Payment Terms", Rec."Payment Terms Code");
                        //NB MASQ Start 30-Sep-25
                        SUPPLIERPAYMENTREQUEST.Validate("Good Readiness Date", Rec."Initial ETR");
                        Rec.CalcFields(Rec."MASQ Sales Order No.");
                        SUPPLIERPAYMENTREQUEST.Validate("SO#", Rec."MASQ Sales Order No.");
                        SUPPLIERPAYMENTREQUEST.Validate("Requested By (Person)", UserId());
                        SUPPLIERPAYMENTREQUEST.Validate(Date, Today());
                        SUPPLIERPAYMENTREQUEST.Validate("Assigned User ID", Rec."Assigned User ID");
                        //NB MASQ End 30-Sep-25
                        SUPPLIERPAYMENTREQUEST.Insert(true);
                        Message('RFP %1 is successfully created for PO %2', SUPPLIERPAYMENTREQUEST.Number, Rec."No.");
                    end;
                end;
            }
            //NB MASQ End

            //FQ MASQ **START**
            action(CreateSCC)
            {
                ApplicationArea = All;
                Caption = 'Create SCC';
                ToolTip = 'Create a new Shipping Conformity Certificate for this purchase order.';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = CanCreateSCC and ShowSCCField;

                trigger OnAction()
                var
                    SCCMgt: Codeunit "SCC Management";
                    NewSCC: Record "Shipping Conformity Cert";
                begin
                    if (rec."Shipment Mode" = rec."Shipment Mode"::Express) or (rec."Shipment Mode" = rec."Shipment Mode"::" ") then begin
                        error('The shipment mode is express or empty, so SCC cannot be created')
                    end
                    else begin
                        NewSCC := SCCMgt.CreateSCCFromPO(Rec."No.");
                        Page.Run(Page::"Shipping Conformity Cert. Card", NewSCC);
                        CurrPage.Update(false);
                    end;
                end;
            }
            //FQ MASQ **END**

        }

        addafter(Receipts)
        {
            action("Open SO")
            {
                Image = Purchase;
                ApplicationArea = All;
                trigger OnAction()
                var
                    //SalesLine: Record "Sales Line";
                    SalesHeader: Record "Sales Header";
                begin
                    rec.CalcFields("MASQ Sales Order No.");
                    Clear(SalesHeader);
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetRange("No.", Rec."MASQ Sales Order No.");
                    Page.Run(page::"Sales Order List", SalesHeader);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        SalesHeader: Record "Sales Header";
    begin
        Rec.CalcFields("MASQ Sales Order No.");
        if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."MASQ Sales Order No.") then begin
            Rec.Validate("Logistics Coordinator", SalesHeader."Logistics Coordinator");
            if Rec."Assigned User ID" = '' then
                Rec.Validate("Assigned User ID", SalesHeader."Assigned User ID");
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        PurchaseLine: Record "Purchase Line";
        text001: Label 'Please do Fill the Item Type field in the purchase lines';
        text002: Label 'Please do Fill the Brand Code field in the purchase lines';
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", Rec."No.");
        PurchaseLine.SetRange("Meg Item Type", '');
        IF PurchaseLine.FindFirst() then
            Error(text001);


        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", Rec."No.");
        PurchaseLine.SetRange("Shortcut Dimension 3 Code", '');
        IF PurchaseLine.FindFirst() then
            Error(text002);

    end;

    trigger OnAfterGetRecord()
    var
        ShipQuote: Record "Shipping Quotation";
        ResultList: Text;
        SalesHeader: Record "Sales Header";
    begin
        Clear(Rec."Shipping Quotation No.");
        ResultList := '';

        if ShipQuote.FindSet() then
            repeat
                if ShipQuote."Document Reference".Contains(Rec."No.") then begin
                    if ResultList = '' then
                        ResultList := ShipQuote."Comparison ID"
                    else
                        ResultList := ResultList + ', ' + ShipQuote."Comparison ID";
                end;
            until ShipQuote.Next() = 0;

        Rec."Shipping Quotation No." := ResultList;

        UpdateStatusStyle();// FQ MASQ
        UpdateSCCStatus();//FQ MASQ

        Rec.CalcFields("MASQ Sales Order No.");
        if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."MASQ Sales Order No.") then begin
            Rec.Validate("Logistics Coordinator", SalesHeader."Logistics Coordinator");
            if Rec."Assigned User ID" = '' then
                Rec.Validate("Assigned User ID", SalesHeader."Assigned User ID");
        end;

        CurrPage.Update(false);
    end;


    //FQ MASQ **START

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        SalesHeader: Record "Sales Header";
    begin
        UpdateStatusStyle();//FQ MASQ
        UpdateSCCStatus();//FQ MASQ

        Rec.CalcFields("MASQ Sales Order No.");
        if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."MASQ Sales Order No.") then begin
            Rec.Validate("Logistics Coordinator", SalesHeader."Logistics Coordinator");
            if Rec."Assigned User ID" = '' then
                Rec.Validate("Assigned User ID", SalesHeader."Assigned User ID");
        end;

        CurrPage.Update(false);
    end;

    local procedure UpdateStatusStyle()
    var
        CustomStatusStyleMgmt: Codeunit "Custom Status Style";
    begin
        CustomStatusStyle := CustomStatusStyleMgmt.GetStyleForPurchaseStatus(Rec."Custom Status");
    end;

    local procedure ShowStatusDetails()
    var
        PurchLine: Record "Purchase Line";
        StatusDetails: Text;
        TotalQty: Decimal;
        ReceivedQty: Decimal;
        InvoicedQty: Decimal;
    begin
        PurchLine.SetRange("Document Type", Rec."Document Type");
        PurchLine.SetRange("Document No.", Rec."No.");
        PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");

        if PurchLine.FindSet() then
            repeat
                TotalQty += PurchLine.Quantity;
                ReceivedQty += PurchLine."Quantity Received";
                InvoicedQty += PurchLine."Quantity Invoiced";
            until PurchLine.Next() = 0;

        StatusDetails := StrSubstNo(
            'Status Details:\' +
            'Total Quantity: %1\' +
            'Quantity Received: %2 (%3%)\' +
            'Quantity Invoiced: %4 (%5%)',
            TotalQty,
            ReceivedQty,
            GetPercentage(ReceivedQty, TotalQty),
            InvoicedQty,
            GetPercentage(InvoicedQty, TotalQty));

        Message(StatusDetails);
    end;

    local procedure GetPercentage(PartialQty: Decimal; TotalQty: Decimal): Text
    var
        Percentage: Decimal;
    begin
        if TotalQty = 0 then
            exit('0');

        Percentage := Round((PartialQty / TotalQty) * 100, 1);
        exit(Format(Percentage, 0, '<Precision,2:2><Standard Format,0>'));
    end;



    local procedure UpdateSCCStatus()
    var
        SCCMgt: Codeunit "SCC Management";
        SCC: Record "Shipping Conformity Cert";

    begin
        Rec.CalcFields("SCC Count");
        // Set style based on certificate status
        SCCStyle := 'Favorable';
        // Determine if user can create a new SCC
        CompInfo.Get();
        if CompInfo."SCC Module Enabled" then begin
            if (rec."Shipment Mode" = rec."Shipment Mode"::Air) or (rec."Shipment Mode" = rec."Shipment Mode"::Sea) or (rec."Shipment Mode" = rec."Shipment Mode"::Land) then
                ShowSCCField := true;
            CanCreateSCC := SCCMgt.CanCreateNewSCC(Rec."No.");
        end else begin
            ShowSCCField := false;
            CanCreateSCC := false;
        end;
    end;

    //FQ MASQ **END
    var
        myInt: Integer;
        CustomStatusStyle: Text;
        SCCStyle: Text;
        CanCreateSCC, ShowSCCField : Boolean;
        CompInfo: Record "Company Information"; //FQ MASQ
}