pageextension 70103 "PO Extension" extends "Purchase Order"
{
    layout
    {
        addafter(PurchLines)
        {
            //AN 07/04/2025
            // group("Additional Charges")
            // {
            //     field("Freight Charges"; Rec."Freight Charges")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Freight Charges Value"; Rec."Freight Charges Value")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Documentation Charges"; Rec."Documentation Charges")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Documentation Charges Value"; Rec."Documentation Charges Value")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field(TotalWithCharges; Rec.TotalWithCharges)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Total';
            //     }
            // }
        }

        modify("Invoice Received Date")
        {
            ShowMandatory = true;
        }
        // Add changes to page layout here
        addafter(Status)
        {
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

        }
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
    end;


    var
        myInt: Integer;
}