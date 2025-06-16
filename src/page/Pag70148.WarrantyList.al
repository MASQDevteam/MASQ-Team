page 70148 "Warranty List"
{
    PageType = List;
    SourceTable = "Insurance/Claim";
    ApplicationArea = All;
    Caption = 'Warranty List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }
                field("Reference Number"; Rec."Reference Number")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
                    trigger OnValidate()
                    var
                    begin
                        Rec."Item #" := '';
                        Rec.QTY := 0;

                        Rec.Cost := 0;


                    end;
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

                field("Cost"; Rec."Cost")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Warranty Start Date"; Rec."Warranty Start Date")
                {
                    ApplicationArea = All;
                }

                field("Warranty End Date"; Rec."Warranty End Date")
                {
                    ApplicationArea = All;
                }

                field("Warranty Provider"; Rec."Warranty Provider")
                {
                    ApplicationArea = All;
                }

                field("Warranty Type"; Rec."Warranty Type")
                {
                    ApplicationArea = All;
                }

                field("Item Condition"; Rec."Item Condition")
                {
                    ApplicationArea = All;
                }

                field("Repair Status"; Rec."Repair Status")
                {
                    ApplicationArea = All;
                }
                field("Warranty Status"; Rec."Warranty Status")
                {
                    ToolTip = 'Specifies the value of the Warranty Status field.', Comment = '%';
                }
                field("Notes / Comments"; Rec."Notes / Comments")
                {
                    ToolTip = 'Specifies the value of the Notes / Comments field.', Comment = '%';
                }



            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Insurance/Claim"),
                              "No." = field(ID);
                // "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {
        area(processing)
        {
            // You can add actions like new, delete, or refresh here.

            action("Add Lines PO")
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
                    Rec.TestField(ID);

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
                            Rec."Reference Number" := PurchaseOrderLine."Document No.";
                            Rec."Item #" := PurchaseOrderLine."No.";
                            Rec.QTY := PurchaseOrderLine.Quantity;
                            Rec.Cost := PurchaseOrderLine."Line Amount";
                            Rec.Modify();
                        end;
                    end;
                end;
            }

            action("Add Lines TO")
            {
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                var
                    TransferOrderLinepage: page "Transfer Lines";
                    TransferOrderLine: Record "Transfer Line";
                    "AWB Card": Page "AWB Card";
                    BLAWBNumber: Code[20];
                    ContainerNumber: Code[50];
                    ContainerLineNumber: Integer;
                    ContainerDetails: Record "Container Details";
                    AWBDetails: Record "AWB Details";
                begin
                    rec.FilterGroup(4);
                    Rec.TestField(ID);

                    Clear(TransferOrderLine);
                    TransferOrderLine.SetFilter("Transfer-to Code", 'LOC013|LOC014');
                    TransferOrderLine.SetFilter("Quantity", '<> %1', 0);
                    TransferOrderLine.SetFilter("item No.", '<> %1', '');

                    Clear(TransferOrderLinepage);
                    TransferOrderLinepage.SetTableView(TransferOrderLine);
                    TransferOrderLinepage.LookupMode(true);
                    IF TransferOrderLinepage.RunModal() = Action::LookupOK then begin

                        TransferOrderLinepage.SetSelectionFilter(TransferOrderLine);
                        if TransferOrderLine.FindFirst() then begin
                            Rec."Reference Number" := TransferOrderLine."Document No.";
                            Rec."Item #" := TransferOrderLine."Item No.";
                            Rec.QTY := TransferOrderLine.Quantity;

                            Rec.Modify();
                        end;
                    end;
                end;
            }


            action("Add Lines Transitory")
            {
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                var
                    Transitorypage: page "Transitory Reference List";
                    Transitory: Record "Transitory Reference";
                    "AWB Card": Page "AWB Card";
                    BLAWBNumber: Code[20];
                    ContainerNumber: Code[50];
                    ContainerLineNumber: Integer;
                    ContainerDetails: Record "Container Details";
                    AWBDetails: Record "AWB Details";
                begin
                    rec.FilterGroup(4);
                    Rec.TestField(ID);
                    Clear(Transitory);
                    Transitory.SetRange(Status, Transitory.Status::Accepted);

                    Clear(Transitorypage);
                    Transitorypage.SetTableView(Transitory);
                    Transitorypage.LookupMode(true);
                    IF Transitorypage.RunModal() = Action::LookupOK then begin

                        Transitorypage.SetSelectionFilter(Transitory);
                        if Transitory.FindFirst() then begin
                            //  Rec."PO Number" := PurchaseOrderLine."Document No.";
                            Rec."Reference Number" := Transitory."Transitory Reference";
                            Rec."Item #" := Transitory."Item #";
                            Rec.QTY := Transitory.QTY;
                            Rec.Cost := Transitory."Total Value";
                            Rec.Modify();
                        end;
                    end;
                end;
            }


        }

        area(navigation)
        {
            // Optional navigation actions.
        }


    }
    trigger OnOpenPage()
    var
    begin
        rec.SetRange(Type, Rec.Type::Warranty);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        Rec.Type := Rec.Type::Warranty;
    end;

    trigger OnAfterGetRecord()
    var
    begin

        //     GetStyle();
    end;


    Local procedure GetStyle()
    var
    begin
        IF rec."Claim Status" = Rec."Claim Status"::Unclaimed then
            StyleExprTxt := 'Unfavorable'
        else
            If rec."Claim Status" = Rec."Claim Status"::Claimed then
                StyleExprTxt := 'Favorable'
            else
                StyleExprTxt := 'None'
    end;


    var
        StyleExprTxt: Text;
}
