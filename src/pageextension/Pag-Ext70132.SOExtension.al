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
            ShowMandatory = true;
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

    var
        myInt: Integer;
}