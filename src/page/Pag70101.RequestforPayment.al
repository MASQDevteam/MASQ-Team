page 70101 "Request for Payment"
{
    PageType = Card;
    ApplicationArea = All;
    //  UsageCategory = Administration;
    SourceTable = "SUPPLIER PAYMENT REQUEST";
    //  DeleteAllowed = false;

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
                field("Bank Number"; Rec."Bank Number")
                {
                    ToolTip = 'Specifies the value of the Bank Number field.', Comment = '%';
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ToolTip = 'Specifies the value of the Payment Terms field.', Comment = '%';
                }
                field("Reason For Transfer"; Rec."Reason For Transfer")
                {
                    ToolTip = 'Specifies the value of the Reason For Transfer field.', Comment = '%';
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ToolTip = 'Specifies the value of the Payment Method field.', Comment = '%';
                }
                field("Requested By / Department"; Rec."Requested By / Department")
                {
                    ToolTip = 'Specifies the value of the Requested By / Department field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field("Head Of Department"; Rec."Head Of Department")
                {
                    ToolTip = 'Specifies the value of the Head Of Department field.', Comment = '%';
                }
                field("PO#"; Rec."PO#")
                {
                    ToolTip = 'Specifies the value of the PO# field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                    //  Enabled = Rec."PPI#" = '';
                    trigger OnValidate()
                    var
                    begin

                        IF Rec."PO#" <> '' then
                            Rec."PPI#" := '';
                    end;
                }
                field("PPI#"; Rec."PPI#")
                {
                    ToolTip = 'Specifies the value of the PPI# field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                    Enabled = (Rec."PO#" = '');
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Specifies the value of the Project Name field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
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
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                }
                field(Details; Rec.Details)
                {
                    ToolTip = 'Specifies the value of the Details field.', Comment = '%';
                }
                field("Good Readiness Date"; Rec."Good Readiness Date")
                {
                    ToolTip = 'Specifies the value of the Good Readiness Date field.', Comment = '%';
                }
                field("Operation Confirmed"; Rec."Operation Confirmed")
                {
                    ToolTip = 'Specifies the value of the Operation Confirmed field.', Comment = '%';
                }
                field("Operation Expected"; Rec."Operation Expected")
                {
                    ToolTip = 'Specifies the value of the Operation Expected field.', Comment = '%';
                }
                field("Level of Urgency"; Rec."Level of Urgency")
                {
                    ToolTip = 'Specifies the value of the Level of Urgency field.', Comment = '%';
                    StyleExpr = StyleExprText;
                    trigger OnValidate()
                    var
                    begin
                        ChangeUrgencyColor();
                    end;
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
                field("RFP Type"; Rec."RFP Type")
                {
                    ToolTip = 'Specifies the value of the RFP Type field.', Comment = '%';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.', Comment = '%';
                }
            }
            Group("Requested Amounts")
            {
                Enabled = (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Pending Approval");

                field("Requested Amount"; Rec."Requested Amount")
                {
                    ToolTip = 'Specifies the value of the Requested Amount field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field("Additional Charges"; Rec."Additional Charges")
                {
                    ToolTip = 'Specifies the value of the Additional Charges field.', Comment = '%';
                }
                field("Total Requested Amount"; Rec."Total Requested Amount")
                {
                    ToolTip = 'Specifies the value of the Total Requested Amount field.', Comment = '%';
                }
                field("Request Amount/PO Value %"; Rec."Request Amount/PO Value %")
                {
                    ToolTip = 'Specifies the value of the Request Amount/PO Value % field.', Comment = '%';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.', Comment = '%';
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
                field("1st Payment"; Rec."1st Payment")
                {
                    ToolTip = 'Specifies the value of the 1st Payment field.', Comment = '%';
                }
                field("1st Payment Date"; Rec."1st Payment Date")
                {
                    ToolTip = 'Specifies the value of the 1st Payment Date field.', Comment = '%';
                }
                field("2nd Payment"; Rec."2nd Payment")
                {
                    ToolTip = 'Specifies the value of the 2nd Payment field.', Comment = '%';
                }
                field("2nd Payment Date"; Rec."2nd Payment Date")
                {
                    ToolTip = 'Specifies the value of the 2nd Payment Date field.', Comment = '%';
                }
                field("3rd Payment"; Rec."3rd Payment")
                {
                    ToolTip = 'Specifies the value of the 3rd Payment field.', Comment = '%';
                }
                field("3rd Payment Date"; Rec."3rd Payment Date")
                {
                    ToolTip = 'Specifies the value of the 3rd Payment Date field.', Comment = '%';
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
                // "Document Type" = field("Document Type");
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
                //  RunObject = report "Request for Payment";
                //RunPageLink = Number = field(Number);
                trigger OnAction()
                var
                    RequestforPayment: Record "SUPPLIER PAYMENT REQUEST";
                begin
                    RequestforPayment.SetRange(Number, Rec.Number);
                    Report.Run(report::"Request for Payment", false, false, RequestforPayment);
                end;


            }
            action("Send Approval Request")
            {
                Image = SendApprovalRequest;
                Enabled = (Rec.Status = Rec.Status::Open);

                trigger OnAction()
                var
                    PurchReqWorkFlowFunctions: Codeunit "Travel Req. WorkFlow Functions";
                begin
                    //  PurchReqWorkFlowFunctions.ChangePurchReqStatus(Rec);//EDM.YEHYA+-
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    Rec.CheckPayments();
                    //EDM
                    // RequestLine.SETRANGE("Document No.", Rec."No.");
                    //  IF NOT RequestLine.FINDFIRST THEN
                    //     ERROR('You have to enter your request description in the purchase request line to send approval request');
                    //EDM
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Suite;
                Caption = 'Cancel Approval Re&quest';
                // Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                Enabled = (Rec.Status = Rec.Status::"Pending Approval");

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Sub: Codeunit "Travel Req. WorkFlow Functions";
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending Approval");

                    // Sub.OnCancelPurchaseReqApprovalRequest(Rec);
                    Rec.Status := Rec.Status::Open;//to be removed
                end;
            }
            action("Send to Payment journal")
            {
                ApplicationArea = All;
                Image = Journals;
                Enabled = ((Rec."RFP Type" = Rec."RFP Type"::"Supplier payment") AND (REc.Executed = true));
                trigger OnAction()
                begin
                    Rec.TestField("Sent to journals", false);
                    Rec.TestField(Supplier);
                    Rec.TestField("Bank Number");
                    Rec.SendtoPaymentJournal();
                    Rec."Sent to journals" := true;
                end;
            }
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
                Rec."Project Name" := PurchaseOrder."Shortcut Dimension 1 Code";
                Rec."Responsibility Center" := PurchaseOrder."Responsibility Center";
            end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var

    begin
        Rec.Date := Today;
        REc."Requested By (Person)" := UserId;
    end;

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



    trigger OnAfterGetRecord()
    var
    begin
        ChangeUrgencyColor();
    end;


    var
        myInt: Integer;
        Caneditfieldsafterpost:
                Boolean;
        StyleExprText:
                Text;
}