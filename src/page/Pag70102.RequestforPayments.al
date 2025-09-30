page 70102 "Request for Payments"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUPPLIER PAYMENT REQUEST";
    CardPageId = "Request for Payment";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Number; Rec."Number")
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';
                }
                field(Supplier; Rec.Supplier)
                {
                    ToolTip = 'Specifies the value of the Supplier field.', Comment = '%';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ToolTip = 'Specifies the value of the Supplier Name field.', Comment = '%';
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
                }
                field("Head Of Department"; Rec."Head Of Department")
                {
                    ToolTip = 'Specifies the value of the Head Of Department field.', Comment = '%';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ToolTip = 'Specifies the value of the Requested Amount field.', Comment = '%';
                }
                field("Additional Charges"; Rec."Additional Charges")
                {
                    ToolTip = 'Specifies the value of the Additional Charges field.', Comment = '%';
                }
                field("Total Requested Amount"; Rec."Total Requested Amount")
                {
                    ToolTip = 'Specifies the value of the Total Requested Amount field.', Comment = '%';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.', Comment = '%';
                }
                field("Operation Expected"; Rec."Operation Expected")
                {
                    ToolTip = 'Specifies the value of the Operation Expected field.', Comment = '%';
                }
                field("PO Value"; Rec."PO Value")
                {
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
                field("PO#"; Rec."PO#")
                {
                    ToolTip = 'Specifies the value of the PO# field.', Comment = '%';
                }
                field("PPI#"; Rec."PPI#")
                {
                    ToolTip = 'Specifies the value of the PPI# field.', Comment = '%';

                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Specifies the value of the Project Name field.', Comment = '%';
                }
                field("SO#"; Rec."SO#")
                {
                    ToolTip = 'Specifies the value of the SO# field.', Comment = '%';
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
                field("Requested By (Person)"; Rec."Requested By (Person)")
                {
                    ToolTip = 'Specifies the value of the Requested By (Person) field.', Comment = '%';
                }
                field(Executed; Rec.Executed)
                {
                    ToolTip = 'Specifies the value of the Executed field.', Comment = '%';
                }
                field("Date of Execution"; Rec."Date of Execution")
                {
                    ToolTip = 'Specifies the value of the Date of Execution field.', Comment = '%';
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
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
            action("Send to Payment journal")
            {
                ApplicationArea = All;
                Image = Journals;
                Enabled = ((Rec."RFP Type" = Rec."RFP Type"::"Facility Supplier Via Insurance") AND (REc.Executed = true)); //NB MASQ 30-Sep-25
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
        StyleExprText: Text;

}