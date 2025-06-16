page 70104 "Travel Request Form"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Travel Request";


    layout
    {
        area(Content)
        {

            group("Travel Request")
            {
                Enabled = (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Pending Approval");
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                }
                field("Traveler Code"; Rec."Traveler Code")
                {
                    ApplicationArea = All;
                }
                field("Traveler Name"; Rec."Traveler's Name")
                {
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field(Departure; Rec.Departure)
                {
                    ToolTip = 'Specifies the value of the Departure field.', Comment = '%';
                }
                field("Departure Country"; Rec."Departure Country")
                {
                    ApplicationArea = All;
                }
                field(Return; Rec.Return)
                {
                    ToolTip = 'Specifies the value of the Return field.', Comment = '%';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Reason for Travel"; Rec."Reason for Travel")
                {
                    ToolTip = 'Specifies the value of the Reason for Travel field.', Comment = '%';
                    MultiLine = true;
                }
                field("No of Worked Holidays&Weekends"; Rec."No of Worked Holidays&Weekends")
                {
                    ToolTip = 'Specifies the value of the No of Worked Holidays&Weekends field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }


            }
            group("Travel Request Amount")
            {
                field(Ticket; Rec.Ticket)
                {
                    ApplicationArea = All;
                }
                field(Hotel; Rec.Hotel)
                {
                    ApplicationArea = All;
                }
                field(Perdiem; Rec.Perdiem)
                {
                    ApplicationArea = All;
                }

                field("Travel Advance Required"; Rec."Travel Advance Required")
                {
                    ToolTip = 'Specifies the value of the Travel Advance Required field.', Comment = '%';
                    Caption = 'Budget Travel Amount';
                    Style = Strong;
                }
            }
            group("Additional Information")
            {
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                    Editable = EditableProj;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CanEditProj();
                        CanEditJob();
                    end;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
                    Editable = EditableProj;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CanEditProj();
                        CanEditJob();
                    end;
                }
                field(Job; Rec.Job)
                {
                    ApplicationArea = All;
                    Editable = EditableJob;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CanEditProj();
                        CanEditJob();
                    end;
                }
                field("Job Name"; Rec."Job Name")
                {
                    ApplicationArea = All;
                    Editable = EditableJob;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CanEditProj();
                        CanEditJob();
                    end;
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                    ShowMandatory = (Rec."Number" <> '');
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                }
                field("Travel Type"; Rec."Travel Type")
                {
                    ApplicationArea = All;
                }
                field("Travel Type Name"; Rec."Travel Type Name")
                {
                    ApplicationArea = All;
                }
                field("Travel Category"; Rec."Travel Category")
                {
                    ApplicationArea = All;
                }
                field("Travel Category Name"; Rec."Travel Category Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }

            }
            group("Approvals")
            {
                Enabled = (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Pending Approval");

                field("Approved By Manager"; Rec."Approved By Manager")
                {
                    ToolTip = 'Specifies the value of the Approved By Manager field.', Comment = '%';
                    Editable = false;
                }
                field("Approved By Project Manager"; Rec."Approved By Project Manager")
                {
                    ToolTip = 'Specifies the value of the Approved By Project Manager field.', Comment = '%';
                    Editable = false;
                    Visible = false;
                }
                field("Approved By Finance"; Rec."Approved By Finance")
                {
                    ToolTip = 'Specifies the value of the Approved By Finance field.', Comment = '%';
                    Editable = false;
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

            group("Travel's Logistics and Essential Information")
            {
                Enabled = (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Pending Approval");

                field("Traveling by Air"; Rec."Traveling by Air")
                {
                    ToolTip = 'Specifies the value of the Traveling by Air field.', Comment = '%';
                }
                field("Traveling by Road"; Rec."Traveling by Road")
                {
                    ToolTip = 'Specifies the value of the Traveling by Road field.', Comment = '%';
                }
                field("Traveling Both"; Rec."Traveling Both")
                {
                    ToolTip = 'Specifies the value of the Traveling Both field.', Comment = '%';
                }
                field(Airline; Rec.Airline)
                {
                    ToolTip = 'Specifies the value of the Airline field.', Comment = '%';
                }
                field("Time of Departure"; Rec."Time of Departure")
                {
                    ToolTip = 'Specifies the value of the Time of Departure field.', Comment = '%';
                }
                field("Time of Return"; Rec."Time of Return")
                {
                    ToolTip = 'Specifies the value of the Time of Return field.', Comment = '%';
                }
                field("Specific Requests"; Rec."Specific Requests")
                {
                    ToolTip = 'Specifies the value of the Specific Requests field.', Comment = '%';
                    MultiLine = true;
                }

            }


        }
        area(Factboxes)
        {
            //AN 03/11/25+
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Travel Request"),
                             "No." = field(Number);
                // "Document Type" = field("Document Type");
            }
            systempart(TRNotes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Travel Request Report")
            {
                ApplicationArea = All;
                Image = Report;
                //   RunObject = report "Travel Request";
                //  Enabled = (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Pending Approval");


                trigger OnAction()
                var
                    TravelRequest: Record "Travel Request";
                begin
                    TravelRequest.SetRange(Number, Rec.Number);
                    Report.Run(report::"Travel Request", false, false, TravelRequest);
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
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CanEditProj();
        CanEditJob();
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CanEditProj();
        CanEditJob();
    end;

    local procedure CanEditProj()
    var
        myInt: Integer;
    begin
        if (Rec.Job = '') then
            EditableProj := true
        else
            EditableProj := false;

    end;

    local procedure CanEditJob()
    var
        myInt: Integer;
    begin
        if Rec."Project Code" = '' then
            EditableJob := true
        else
            EditableJob := false;

    end;


    var
        EditableProj: Boolean;
        EditableJob: Boolean;
}