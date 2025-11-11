pageextension 70132 "SO Extension" extends "Sales Order"
{
    layout
    {
        modify("Requested Delivery Date")
        {
            ShowMandatory = true;
        }
        modify("Promised Delivery Date")
        {
            ShowMandatory = true;
        }
        modify("Your Reference")
        {
            ShowMandatory = true;
        }
        modify("Salesperson Code")
        {
            ShowMandatory = true;
        }
        modify("Responsibility Center")
        {
            ShowMandatory = false;//FQ MASQ 
            Visible = false;//FQ MASQ 

        }
        modify("Assigned User ID")
        {
            ShowMandatory = true;
        }
        modify("Payment Terms Code")
        {
            ShowMandatory = true;
        }
        modify("Payment Method Code")
        {
            ShowMandatory = true;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ShowMandatory = true;
        }
        modify("Location Code")
        {
            ShowMandatory = true;
        }
        modify("Shipment Method Code")
        {
            ShowMandatory = true;
        }
        modify("Meg OC No.")
        {
            ShowMandatory = true;
        }
        modify("Meg Incoterms")
        {
            ShowMandatory = true;
        }
        modify("Meg Client PO #")
        {
            ShowMandatory = true;
        }
        modify("Meg Delivery Schedule")
        {
            ShowMandatory = true;
        }
        modify("Meg Warranty")
        {
            ShowMandatory = true;
        }
        //FQ MASQ **START**
        modify("Sell-to Customer Name")
        {
            Editable = false;
        }
        modify("Sell-to Address")
        {
            Editable = false;
        }
        modify("Sell-to Address 2")
        {
            Editable = false;
        }
        modify("Sell-to City")
        {
            Editable = false;
        }
        modify("Sell-to Post Code")
        {
            Editable = false;
        }
        modify("Sell-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Sell-to Contact No.")
        {
            Editable = false;
        }

        modify("VAT Registration No.")
        {
            Editable = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Editable = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Editable = false;
        }
        modify("Sell-to Phone No.")
        {
            Editable = false;
        }
        modify("Sell-to E-Mail")
        {
            Editable = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        //FQ MASQ **END**
        addlast(General)
        {
            field("Pro-Forma Description"; Rec."Pro-Forma Description")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Apollo Total Offer Value"; Rec."Apollo Total Offer Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Apollo Total Offer Value field.', Comment = '%';
                Editable = false;
            }
            field("SO Type"; Rec."SO Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of the Sales Order.';
                Caption = 'SO Type';
            }

            //NB MASQ Start
            field("Logistics Coordinator"; Rec."Logistics Coordinator")
            {
                ApplicationArea = All;
            }
            //NB MASQ End

        }
        // FQ MASQ **Start

        addafter(Status)
        {
            field("Custom Status"; Rec."Custom Status")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Shows the custom status based on shipping and invoicing progress';
                StyleExpr = CustomStatusStyle;

                trigger OnDrillDown()
                begin
                    ShowStatusDetails();
                end;
            }
        }

        // FQ MASQ **END
        // Add changes to page layout here
        addafter("Attached Documents")
        {
            part("Cost LOGs Factbox"; "Cost LOGs Factbox")
            {
                ApplicationArea = All;
                Caption = 'Cost/Price Variation LOG';
                Provider = SalesLines;
                SubPageLink = "SO Number" = field("Document No."), "SO Line Number" = field("Line No.");
            }
            part("Variation Order LOG"; "Variation Order LOGs Factbox")
            {
                ApplicationArea = All;
                Caption = 'Variation Order LOG';
                Provider = SalesLines;
                SubPageLink = "SO Number" = field("Document No."), "SO Line Number" = field("Line No."), "VO Number" = filter('<> ''''');
                // "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {   // FQ MASQ ** Start

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
                if rec."Custom Status" = rec."Custom Status"::"Fully Delivered/Fully Invoiced" then begin
                    Error('You cannot reopen a SO once it has been fully Delivered and fully invoiced.');
                end;
            end;
        }
        addfirst(Processing)
        {
            action("Print Label")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", Rec."Document Type");
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then
                        Report.RunModal(Report::"Print Labels For Items", true, true, SalesHeader);
                end;
            }
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
                Caption = 'Update customer Fields';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Update Customer Field in sales header';
                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    if Rec."Sell-to Customer No." <> '' then begin
                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            Rec."Sell-to Customer Name" := Customer.Name;
                            Rec."Sell-to Address" := Customer.Address;
                            Rec."Sell-to Address 2" := Customer."Address 2";
                            Rec."Sell-to City" := Customer.City;
                            Rec."Sell-to Post Code" := Customer."Post Code";
                            Rec."Sell-to Country/Region Code" := Customer."Country/Region Code";
                            Rec."Sell-to Contact No." := Customer."Phone No.";
                            Rec."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group";
                            Rec."VAT Registration No." := Customer."VAT Registration No.";
                            Rec."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
                            Rec."Sell-to E-Mail" := Customer."E-Mail";
                            Rec."Sell-to Phone No." := Customer."Mobile Phone No.";
                            Rec.Modify();
                            Message('The Customer fields has been updated successfully');
                            CurrPage.Update(false);
                        end;
                    end;
                end;
            }
            // FQ MASQ ** End
        }
        addafter("Print Confirmation")
        {
            action(PrintDeliveryOrder)
            {
                ApplicationArea = All;
                Caption = 'Print Delivery Order';
                Promoted = true;
                Image = Print;
                ToolTip = 'Print or view the new Delivery Order report';

                trigger OnAction()
                var
                    CompanyInfo: Record "Company Information";
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Rec.SetRange("Bill-to Customer No.", Rec."Bill-to Customer No.");

                    // CompanyInfo.Get();

                    // if (CompanyInfo."Country/Region Code" = 'KSA') then
                    Report.Run(Report::"Delivery Order before posting", true, false, Rec);
                end;
            }
        }
        // Add changes to page actions here
        addafter("S&hipments")
        {
            action("Open POs")
            {
                Image = Purchase;
                ApplicationArea = All;
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    PurchaseHeader: Record "Purchase Header";
                begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.SetRange("MASQ Sales Order No.", Rec."No.");
                    Page.Run(page::"Purchase Order List", PurchaseHeader);
                end;
            }

        }

        modify(CreatePurchaseOrder)
        {
            Caption = 'Create Purchase Requests';
            ApplicationArea = All;
            Visible = false;
            // Promoted = true;
            // PromotedCategory = Report;
        }
        addafter(CreatePurchaseOrder)
        {
            action(CreatePurchaseOrder2)
            {
                ApplicationArea = Suite;
                Caption = 'Create Purchase Requests';
                Image = Document;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category8;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                ToolTip = 'Create one or more new purchase Requests to buy the items that are required by this sales document, minus any quantity that is already available.';

                trigger OnAction()
                var
                    PurchDocFromSalesDoc: Codeunit "Purch. Doc. From Sales Doc.";
                begin
                    PurchDocFromSalesDoc.CreatePurchaseOrder(Rec);
                end;
            }
        }
    }


    //FQ MASQ **START

    trigger OnAfterGetRecord()
    begin
        UpdateStatusStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateStatusStyle();
    end;

    local procedure UpdateStatusStyle()
    var
        CustomStatusStyleMgmt: Codeunit "Custom Status Style";
    begin
        CustomStatusStyle := CustomStatusStyleMgmt.GetStyleForSalesStatus(Rec."Custom Status");
    end;

    local procedure ShowStatusDetails()
    var
        SalesLine: Record "Sales Line";
        StatusDetails: Text;
        TotalQty: Decimal;
        ShippedQty: Decimal;
        InvoicedQty: Decimal;
    begin
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter(Type, '<>%1', SalesLine.Type::" ");

        if SalesLine.FindSet() then
            repeat
                TotalQty += SalesLine.Quantity;
                ShippedQty += SalesLine."Quantity Shipped";
                InvoicedQty += SalesLine."Quantity Invoiced";
            until SalesLine.Next() = 0;

        StatusDetails := StrSubstNo(
            'Status Details:\' +
            'Total Quantity: %1\' +
            'Quantity Shipped: %2 (%3%)\' +
            'Quantity Invoiced: %4 (%5%)',
            TotalQty,
            ShippedQty,
            GetPercentage(ShippedQty, TotalQty),
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
    //FQ MASQ **END

    var
        myInt: Integer;
        CustomStatusStyle: Text; //FQ MASQ
}