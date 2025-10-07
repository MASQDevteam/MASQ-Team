//NB MASQ Start
page 70101 "Request for Payment"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "SUPPLIER PAYMENT REQUEST";
    layout
    {
        area(Content)
        {
            group("Request Payment")
            {
                Enabled = (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Pending Approval");
                field(Number; Rec."Number")
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                }
                field(Supplier; Rec.Supplier)
                {
                    ToolTip = 'Specifies the value of the Supplier field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ToolTip = 'Specifies the value of the Supplier Name field.', Comment = '%';
                }
                field("RFP Type"; Rec."RFP Type") //NB MASQ 30-Sep-25
                {
                    ApplicationArea = All;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ToolTip = 'Specifies the value of the Payment Terms field.', Comment = '%';
                }
                field("Requested By / Department"; Rec."Requested By / Department")
                {
                    ToolTip = 'Specifies the value of the Requested By / Department field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field("PPI#"; Rec."PPI#")
                {
                    ApplicationArea = All;
                }
                field("PO#"; Rec."PO#")
                {
                    ToolTip = 'Specifies the value of the PO# field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                    trigger OnValidate()
                    var
                    begin
                        IF Rec."PO#" <> '' then
                            Rec."PPI#" := '';
                    end;
                }
                field(Project; Rec.Project) //NB MASQ
                {
                    ToolTip = 'Specifies the value of the Project Name field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field("Project Name"; Rec."Project Name") //NB MASQ
                {
                    ApplicationArea = All;
                }
                field("SO#"; Rec."SO#")
                {
                    ToolTip = 'Specifies the value of the SO# field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Details; Rec.Details)
                {
                    ToolTip = 'Specifies the value of the Details field.', Comment = '%';
                }
                field("Good Readiness Date"; Rec."Good Readiness Date")
                {
                    ToolTip = 'Specifies the value of the Good Readiness Date field.', Comment = '%';
                    Caption = 'Initial ETR'; //NB MASQ
                }
                field("Approval Entries"; Rec."Approval Entries")
                {
                    ToolTip = 'Specifies the value of the Approval Entries field.', Comment = '%';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ApprovalEntries: Record "Approval Entry";
                    begin
                        Clear(ApprovalEntries);
                        ApprovalEntries.SetRange("Document No.", Rec.Number);
                        page.Run(page::"Approval Entries", ApprovalEntries);
                    end;

                    trigger OnDrillDown()
                    var
                        ApprovalEntries: Record "Approval Entry";
                    begin
                        Clear(ApprovalEntries);
                        ApprovalEntries.SetRange("Document No.", Rec.Number);
                        page.Run(page::"Approval Entries", ApprovalEntries);
                    end;
                }
            }
            group(Others)
            {
                Enabled = (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Pending Approval");
                field("PO Value"; Rec."PO Value")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the PO Value field.', Comment = '%';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.', Comment = '%';
                }
                field("Balance on Order"; Rec."Balance on Order")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Balance on Order field.', Comment = '%';
                }
                field("Expected Next Payment"; Rec."Expected Next Payment")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Expected Next Payment field.', Comment = '%';
                }
                field("Requested By (Person)"; Rec."Requested By (Person)")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Requested By (Person) field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field("Assigned User ID"; Rec."Assigned User ID") //NB MASQ
                {
                    ApplicationArea = All;
                }
            }
            part("Request for Payment Subform"; "Request for Payment Subform")
            {
                ApplicationArea = All;
                SubPageLink = Number = field(Number);
                UpdatePropagation = Both; //NB MASQ
            }
            group(Execution)
            {
                Enabled = Caneditfieldsafterpost;
                field(Executed; Rec.Executed)
                {
                    ToolTip = 'Specifies the value of the Executed field.', Comment = '%';
                    Enabled = (Rec."Sent to journals" = false);
                }
                field("Date of Execution"; Rec."Date of Execution")
                {
                    ToolTip = 'Specifies the value of the Date of Execution field.', Comment = '%';
                    Enabled = (Rec."Sent to journals" = false);
                }
            }
        }

        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"SUPPLIER PAYMENT REQUEST"),
                              "No." = field("Number");
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Request for Payment")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RequestforPayment: Record "SUPPLIER PAYMENT REQUEST";
                begin
                    RequestforPayment.SetRange(Number, Rec.Number);
                    Report.Run(report::"Request for Payment", false, false, RequestforPayment);
                end;
            }
            // action("Send Approval Request")
            // {
            //     Image = SendApprovalRequest;
            //     Enabled = (Rec.Status = Rec.Status::Open);
            //     trigger OnAction()
            //     var
            //         PurchReqWorkFlowFunctions: Codeunit "Travel Req. WorkFlow Functions";
            //     begin
            //         Rec.TESTFIELD(Status, Rec.Status::Open);
            //         Rec.CheckPayments();
            //     end;
            // }
            // action(CancelApprovalRequest)
            // {
            //     ApplicationArea = Suite;
            //     Caption = 'Cancel Approval Re&quest';
            //     Image = CancelApprovalRequest;
            //     Promoted = true;
            //     PromotedCategory = Category9;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     ToolTip = 'Cancel the approval request.';
            //     Enabled = (Rec.Status = Rec.Status::"Pending Approval");
            //     trigger OnAction()
            //     var
            //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         Sub: Codeunit "Travel Req. WorkFlow Functions";
            //     begin
            //         Rec.TESTFIELD(Status, Rec.Status::"Pending Approval");
            //         Rec.Status := Rec.Status::Open;//to be removed
            //     end;
            // }
            // action("Send to Payment journal")
            // {
            //     ApplicationArea = All;
            //     Image = Journals;
            //     Enabled = ((Rec."RFP Type" = Rec."RFP Type"::"Supplier payment") and (REc.Executed = true));
            //     trigger OnAction()
            //     begin
            //         Rec.TestField("Sent to journals", false);
            //         Rec.TestField(Supplier);
            //         Rec.TestField("Bank Number");
            //         Rec.SendtoPaymentJournal();
            //         Rec."Sent to journals" := true;
            //     end;
            // }
        }
    }
    trigger OnOpenPage()//to be removed
    var
        UserSetup: Record "User Setup";
        ApprovedEntries: Record "Approval Entry";
        CancelledEntries: Record "Approval Entry";
        RejectedEntries: Record "Approval Entry";
        AllApprovalEntries: Record "Approval Entry";
        PurchaseOrder: Record "Purchase Header";
        POEnum: Enum "Purchase Document Type";
        DimensionValue: Record "Dimension Value";
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        Clear(ApprovedEntries);
        ApprovedEntries.SetRange("Document No.", Rec.Number);
        ApprovedEntries.SetRange(Status, ApprovedEntries.Status::Approved);
        ApprovedEntries.SetRange("Pending Approvals", 0);
        IF ApprovedEntries.FindFirst() then begin
            Rec.Status := Rec.Status::Released;
            Rec.Modify();
        end;

        Clear(CancelledEntries);
        CancelledEntries.SetRange("Document No.", Rec.Number);
        CancelledEntries.SetRange(Status, CancelledEntries.Status::Canceled);
        IF CancelledEntries.FindFirst() then begin

            Clear(AllApprovalEntries);
            AllApprovalEntries.SetRange("Document No.", Rec.Number);

            Clear(CancelledEntries);
            CancelledEntries.SetRange("Document No.", Rec.Number);
            CancelledEntries.SetRange(Status, CancelledEntries.Status::Canceled);
            IF AllApprovalEntries.Count = CancelledEntries.Count then begin
                Rec.Status := Rec.Status::Open;
                Rec.Modify();
            end;
        end;

        Clear(RejectedEntries);
        RejectedEntries.SetRange("Document No.", Rec.Number);
        RejectedEntries.SetRange(Status, RejectedEntries.Status::Rejected);
        IF RejectedEntries.FindFirst() then begin
            Rec.Status := Rec.Status::Declined;
            Rec.Modify();
        end;

        Clear(UserSetup);
        UserSetup.Get(UserId);
        Caneditfieldsafterpost := UserSetup."Can edit RFP fields after post" AND (Rec.Status =
        Rec.Status::Released);

        //AN 06/27/2025
        IF Rec."PO#" <> '' then begin
            Clear(PurchaseOrder);
            if PurchaseOrder.Get(POEnum::Order, Rec."PO#") then begin
                PurchaseOrder.CalcFields("Amount Including VAT");
                Rec."PO Value" := PurchaseOrder."Amount Including VAT";
                Rec.Currency := PurchaseOrder."Currency Code";
                Rec."Request Amount/PO Value %" := (Rec."Requested Amount" / Rec."PO Value") * 100;
                Rec.Project := PurchaseOrder."Shortcut Dimension 1 Code";
                if DimensionValue.Get('PROJECT', PurchaseOrder."Shortcut Dimension 1 Code") then //NB MASQ
                    Rec.Validate("Project Name", DimensionValue.Name);
                Rec."Responsibility Center" := PurchaseOrder."Responsibility Center";
                Rec.Modify(true);
            end;
        end;

        //NB MASQ Start
        IF Rec."PPI#" <> '' then begin
            Clear(PurchaseInvoiceHeader);
            PurchaseInvoiceHeader.Get(Rec."PPI#");

            PurchaseInvoiceHeader.CalcFields("Amount Including VAT");
            Rec."PO Value" := PurchaseInvoiceHeader."Amount Including VAT";
            Rec.Currency := PurchaseInvoiceHeader."Currency Code";
            Rec."Request Amount/PO Value %" := (Rec."Requested Amount" / Rec."PO Value") * 100;
            Rec.Project := PurchaseInvoiceHeader."Shortcut Dimension 1 Code";
            if DimensionValue.Get('PROJECT', PurchaseInvoiceHeader."Shortcut Dimension 1 Code") then
                Rec.Validate("Project Name", DimensionValue.Name);
            Rec."Responsibility Center" := PurchaseInvoiceHeader."Responsibility Center";
            Rec."PO#" := PurchaseInvoiceHeader."Order No.";
            Rec.Modify(true);
        end;
        //NB MASQ End
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.Date := Today;
        REc."Requested By (Person)" := UserId;
    end;
    //NB MASQ Start
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Create Direct RFP" then
            Error('You do not have permission to create direct RFP, You can create RFP from PO');
    end;
    //NB MASQ End
    procedure ChangeUrgencyColor()
    var
    begin
        //TRANSFER FIELDS
        case Rec."Level of Urgency" of
            rec."Level of Urgency"::"1. Critical":
                begin
                    StyleExprText := 'Unfavorable';
                end;
            rec."Level of Urgency"::"2. Major":
                begin
                    StyleExprText := 'Ambiguous';
                end;
            rec."Level of Urgency"::"3. Medium":
                begin
                    StyleExprText := 'Favorable';
                end;
            rec."Level of Urgency"::"4. Minor":
                begin
                    StyleExprText := 'StandardAccent';
                end;
        end;
    end;

    var
        myInt: Integer;
        Caneditfieldsafterpost: Boolean;
        StyleExprText: Text;
}
//NB MASQ End