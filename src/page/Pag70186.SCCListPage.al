//FQ MASQ **START
page 70186 "Shipping Conformity Cert. List"
{
    ApplicationArea = All;
    Caption = 'Shipping Conformity Certificates List';
    AdditionalSearchTerms = 'SCC List';
    PageType = List;
    SourceTable = "Shipping Conformity Cert";
    UsageCategory = Lists;
    CardPageId = "Shipping Conformity Cert. Card";
    Editable = false;
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the certificate.';
                    StyleExpr = StatusStyle;
                }
                field("Certificate Status"; Rec."Certificate Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the certificate.';
                    StyleExpr = StatusStyle;
                }

                field("SCC Number"; Rec."SCC Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shipment conformity certificate number. NA indicates rejection.';
                }

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document creation date.';
                }

                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the request was sent to the agent.';
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the agent handling the certificate.';
                }

                field("Country of Loading"; Rec."Country of Loading")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country where goods are loaded.';
                }
            }
        }

        area(factboxes)
        {
            part(Details; "SCC Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }

            systempart(Links; Links)
            {
                ApplicationArea = All;
            }

            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {

            action(ShowPurchaseOrders)
            {
                ApplicationArea = All;
                Caption = 'Show Purchase Orders';
                ToolTip = 'View the related purchase orders.';
                Image = Document;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SCCOrderLine: Record "SCC Order Line";
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseOrderList: Page "Purchase Order List";
                begin
                    SCCOrderLine.SetRange("SCC No.", Rec."No.");
                    if SCCOrderLine.FindSet() then begin
                        // Filter the purchase order list to show only the POs in this certificate
                        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.SetFilter("No.", '');
                        repeat
                            if PurchaseHeader.GetFilter("No.") = '' then
                                PurchaseHeader.SetRange("No.", SCCOrderLine."Purchase Order No.")
                            else
                                PurchaseHeader.SetFilter("No.", PurchaseHeader.GetFilter("No.") + '|' + SCCOrderLine."Purchase Order No.");
                        until SCCOrderLine.Next() = 0;

                        PurchaseOrderList.SetTableView(PurchaseHeader);
                        PurchaseOrderList.Run();
                    end;
                end;
            }
        }

        area(reporting)
        {
            action(PrintCertificate)
            {
                ApplicationArea = All;
                Caption = 'Print Certificate';
                ToolTip = 'Print the shipping conformity certificate.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    SCCHeader: Record "Shipping Conformity Cert";
                begin
                    SCCHeader.Reset();
                    SCCHeader.SetRange("No.", rec."No.");
                    if SCCHeader.FindFirst() then begin
                        report.Run(70117, true, true, SCCHeader);
                    end;
                end;


            }
        }


    }
    trigger OnOpenPage()
    var
        CompInfo: Record "Company Information";
    begin
        CompInfo.Get();
        if not CompInfo."SCC Module Enabled" then
            Error('Shipping Conformity Certificate module is not enabled for this company.');
    end;

    trigger OnAfterGetRecord()
    begin
        SetStatusStyle();
    end;

    var
        StatusStyle: Text;

    local procedure SetStatusStyle()
    begin
        case Rec."Certificate Status" of
            Rec."Certificate Status"::"In Process":
                StatusStyle := 'Ambiguous';
            Rec."Certificate Status"::Completed:
                StatusStyle := 'Favorable';
            Rec."Certificate Status"::Rejected:
                StatusStyle := 'Unfavorable';
        end;
    end;
}
//FQ MASQ **END