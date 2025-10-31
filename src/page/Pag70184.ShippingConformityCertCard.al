//FQ MASQ **START
page 70184 "Shipping Conformity Cert. Card"
{
    ApplicationArea = All;
    Caption = 'Shipping Conformity Certificate';
    PageType = Card;
    SourceTable = "Shipping Conformity Cert";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group("Certificate Details")
            {
                Caption = 'Certificate Details';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the certificate.';
                    Caption = 'MASQ Document No';
                    Importance = Promoted;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document creation date.';
                    Importance = Promoted;
                    Caption = 'MASQ Document Date';
                }
                field("SCC Number"; Rec."SCC Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shipment conformity certificate number. Enter NA for rejected, leave blank for in process.';
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field("SCC Issuance Date"; Rec."SCC Issuance Date")
                {
                    ApplicationArea = All;
                }
                field("SCC Expiry Date"; Rec."SCC Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Certificate Status"; Rec."Certificate Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the certificate.';
                    Importance = Promoted;
                    StyleExpr = StatusStyle;
                    Editable = false;
                }
            }
            group("Agent Information")
            {
                Caption = 'Agent Information';

                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the agent handling the certificate.';
                    ShowMandatory = true;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the agent name.';
                }
                field("Agent Invoice No."; Rec."Agent Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the agent invoice number.';
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the agent invoice date.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the request was sent to the agent.';
                }
                field("Country of Loading"; Rec."Country of Loading")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country where goods are loaded.';
                    ShowMandatory = true;
                }
                field(CountryName; Rec.CountryName)
                {
                    ApplicationArea = All;
                }
                field("Shipment Mode"; Rec."Shipment Mode")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }

            group("Saber Information")
            {
                Caption = 'SABER Information';

                field("SABER App. No"; Rec."SABER App. No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the application number from SABER platform.';
                }
                field("SABER Issuance Date"; Rec."SABER Issuance Date")
                {
                    ApplicationArea = All;
                }
                field("SABER Expiry Date"; Rec."SABER Expiry Date")
                {
                    ApplicationArea = All;
                }


            }
            group("Sadad Information")
            {
                Caption = 'Sadad Information';
                field("Sadad Reference"; Rec."Sadad Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reference from SADAD platform.';
                }

                field("Sadad Issuance Date"; Rec."Sadad Issuance Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date from SADAD platform.';
                }

                field("Sadad Expiry Date"; Rec."Sadad Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the certificate date from SABER platform.';
                }
            }
            group(PurchaseOrders)
            {
                Caption = 'Purchase Orders';

                part(SCCOrderLines; "SCC Order Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Orders';
                    SubPageLink = "SCC No." = field("No.");
                    UpdatePropagation = Both;
                    ShowFilter = true;
                }
            }
            group(HSCodes)
            {
                Caption = 'HS Code Information';

                field("HS Code Sadad"; Rec."HS Code Sadad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HS Code as submitted for SADAD.';
                }

                field("HS Code Supplier"; Rec."HS Code Supplier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HS Code as per supplier documents.';
                }
            }

            group(AdditionalInfo)
            {
                Caption = 'Additional Information';

                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any additional comments or notes.';
                    MultiLine = true;
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

            part(DocumentAttachmentFactBox; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(70140),
                              "No." = field("No.");
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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

            action(ManageAttachments)
            {
                ApplicationArea = All;
                Caption = 'Manage Attachments';
                ToolTip = 'Add, view, or delete attachments for this certificate.';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DocumentAttachment: Record "Document Attachment";
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                begin
                    DocumentAttachment.Reset();
                    DocumentAttachment.SetRange("Table ID", Database::"Shipping Conformity Cert");
                    DocumentAttachment.SetRange("No.", Rec."No.");
                    DocumentAttachmentDetails.SetTableView(DocumentAttachment);
                    DocumentAttachmentDetails.RunModal();
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
                PromotedIsBig = true;
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

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Create Direct SCC" then
            Error('There is no permission for you to create a direct SCC. However, you can create a direct SCC from a PO instead');
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