page 70135 "Transitory Reference List"
{
    PageType = List;
    SourceTable = "Transitory Reference";
    ApplicationArea = All;

    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transitory Reference"; Rec."Transitory Reference")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("PO #"; Rec."PO #")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                }

                field("Item #"; Rec."Item #")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("QTY"; Rec."QTY")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Supplier Claim Reference"; Rec."Supplier Claim Reference")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Supplier"; Rec."Supplier")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
            }
        }

        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;

                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Transitory Reference"),
                              "No." = field("Transitory Reference");
                // "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {
        area(processing)
        {
            // You can add actions like new, delete, or refresh here.

            action("Add Lines")
            {
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseOrderLinepage: page "Purchase Lines";
                    PurchaseOrderLine: Record "Purchase Line";
                    "AWB Card": Page "AWB Card";
                    BLAWBNumber: Code[20];
                    ContainerNumber: Code[50];
                    ContainerLineNumber: Integer;
                    ContainerDetails: Record "Container Details";
                    AWBDetails: Record "AWB Details";
                begin
                    rec.FilterGroup(4);
                    Rec.TestField("Transitory Reference");

                    Clear(PurchaseOrderLine);
                    PurchaseOrderLine.SetRange("Document Type", PurchaseOrderLine."Document Type"::Order);
                    PurchaseOrderLine.SetRange(Type, PurchaseOrderLine.Type::Item);
                    PurchaseOrderLine.SetFilter("Quantity", '<> %1', 0);

                    Clear(PurchaseOrderLinepage);
                    PurchaseOrderLinepage.SetTableView(PurchaseOrderLine);
                    PurchaseOrderLinepage.LookupMode(true);
                    IF PurchaseOrderLinepage.RunModal() = Action::LookupOK then begin

                        PurchaseOrderLinepage.SetSelectionFilter(PurchaseOrderLine);
                        if PurchaseOrderLine.FindFirst() then begin
                            Rec."PO #" := PurchaseOrderLine."Document No.";
                            Rec."Item #" := PurchaseOrderLine."No.";
                            Rec.QTY := PurchaseOrderLine.Quantity - PurchaseOrderLine."Quantity Received";
                            Rec."Unit Price" := PurchaseOrderLine."Direct Unit Cost";
                            Rec."Total Value" := PurchaseOrderLine."Line Amount";
                            Rec.Supplier := PurchaseOrderLine."Buy-from Vendor No.";
                            Rec.Modify();
                        end;
                    end;
                end;
            }

            action("Open PO")
            {
                trigger OnAction()
                var

                    PurchaseHeader: Record "Purchase Header";
                begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, Rec."PO #");
                    page.Run(page::"Purchase Order", PurchaseHeader);
                end;
            }


        }

        area(navigation)
        {
            // Optional navigation actions.
        }


    }

    trigger OnAfterGetRecord()
    var
    begin

        GetStyle();
    end;

    Local procedure GetStyle()
    var
    begin
        IF rec."Status" = Rec."Status"::Rejected then
            StyleExprTxt := 'Unfavorable'
        else
            If rec."Status" = Rec."Status"::Accepted then
                StyleExprTxt := 'Favorable'
            else
                StyleExprTxt := 'None'
    end;

    var
        StyleExprTxt: Text;


}
