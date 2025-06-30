page 70138 "Purchase Request Card"
{
    Caption = 'Purchase Request';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Request Header";
    SourceTableView = SORTING("No.") ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Documents;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Location Code"; Rec."Location Code")
                {

                }
                field(Status; Rec.Status)
                {
                }
                field("Marked for Approval"; Rec."Marked for Approval")
                {
                }
                field("Progress Status"; Rec."Progress Status")
                {
                }
                field(Requester; Rec.Requester)
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {



                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Approver ID"; Rec."Approver ID")
                {
                    TableRelation = User."User Name";
                }
                field("Status Details"; Rec."Status Details")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AppEntry: Record "Approval Entry";
                    begin
                        AppEntry.SETRANGE("Document No.", Rec."No.");
                        PAGE.RUN(50008, AppEntry);
                    end;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.', Comment = '%';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.', Comment = '%';
                }
                field(Assigned; Rec.Assigned)
                {
                    ToolTip = 'Specifies the value of the Assigned field.', Comment = '%';
                }
                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(PurchReqLines; "Purchase Request SubForm")
            {

                SubPageLink = "Document No." = FIELD("No.");
            }
            group("Total Amounts")
            {
                Caption = 'Total Amounts';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    DrillDown = false;
                    Editable = false;
                }
                //AN 06/27/2025+
                // field("Discount %"; Rec."Discount %")
                // {
                //     ToolTip = 'Specifies the value of the Discount % field.', Comment = '%';
                // }
                // field("Discount Amount"; Rec."Discount Amount")
                // {
                //     ToolTip = 'Specifies the value of the Discount Amount field.', Comment = '%';
                // }
                // field("Total After Discount"; Rec."Total After Discount")
                // {
                //     ToolTip = 'Specifies the value of the Total After Discount field.', Comment = '%';
                //     Editable = false;
                // }
                //AN 06/27/2025-
                field("Total Line Amount Inc. VAT"; Rec."Total Line Amount Inc. VAT")
                {
                    DrillDown = false;
                    Editable = false;
                }
                //AN 06/27/2025+
                // field("Total After Discount Incl. VAT"; Rec."Total After Discount Incl. VAT")
                // {
                //     ToolTip = 'Specifies the value of the Total After Discount Incl. VAT field.', Comment = '%';
                //     Editable = false;
                // }
                //AN 06/27/2025-
                field("Total Amount Assigned"; Rec."Total Amount Assigned")
                {
                    DrillDown = false;
                    Editable = false;
                }
                field("Total Line Amount (LCY)"; Rec."Total Line Amount (LCY)")
                {
                    DrillDown = false;
                    Editable = false;
                }
                field("Total Amount Assigned (LCY)"; Rec."Total Amount Assigned (LCY)")
                {
                    DrillDown = false;
                    Editable = false;
                }

            }
            group(Approval)
            {
                Caption = 'Approval';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                Visible = false;
                fixed(Control4)
                {
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;
                    ShowCaption = false;
                    group(Control2)
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        ShowCaption = false;
                        field("Approved By"; Rec."Approved By")
                        {
                            Enabled = false;
                        }
                        field("Rejected By"; Rec."Rejected By")
                        {
                            Enabled = false;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000005; Links)
            {
                Visible = true;
            }
            systempart(Control1000000004; Notes)
            {
                Visible = true;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = true;
            }


        }
    }

    actions
    {
        area(navigation)
        {
            group("Re&quest")
            {
                Caption = 'Re&quest';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        //ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Purchase Request")
                {
                    Image = Report;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        PurchaseRequest: Record "Purchase Request Header";
                    begin
                        Clear(PurchaseRequest);
                        PurchaseRequest.SetRange("No.", Rec."No.");
                        Report.Run(report::"Purchase Request Order", true, false, PurchaseRequest);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group("&Stock Req.")
            {
                Caption = '&Stock Req.';
                Visible = FALSE;
                separator(Action1100409043)
                {
                }
                action("&Reference Document")
                {
                    Caption = '&Reference Document';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchInvHeader: Record "Purch. Inv. Header";
                        TransferHeader: Record "Transfer Header";
                        TransRcptHeader: Record "Transfer Receipt Header";
                    begin
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                separator(Action1100409026)
                {
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&Open';
                    Enabled = (Rec.Status <> REc.Status::Open) AND CanReOpenPR;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    // trigger OnAction()
                    // var
                    //     ReleasePurchReq: Codeunit "Release Purchase Request";
                    // begin
                    //     ReleasePurchReq.PerformManualReopen(Rec);
                    // end;
                }
                action("Decline Request")
                {
                    Caption = '&Decline Request';
                    Enabled = NOT VisibleForRequester;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

                    // trigger OnAction()
                    // begin
                    //     IF CONFIRM(Text001, TRUE) THEN BEGIN
                    //         DeclineStockReq;
                    //         MESSAGE('Request Declined');
                    //     END;
                    // end;
                }
                //modified by AN 03/14/2025
                action("Assign Request")
                {
                    Caption = '&Assign Request';
                    //  Enabled = NOT VisibleForRequester;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PurchDocFromSalesDoc: Codeunit "Purch. Doc. From Sales Doc.";
                        SalesHEader: Record "Sales Header";
                        TempManufacturingUserTemplate: Record "Manufacturing User Template" temporary;
                        RequisitionLine: Record "Requisition Line";
                        PurchaseHeader: Record "Purchase Header";
                        TempDocumentEntry: Record "Document Entry" temporary;
                        OrderPlanningMgt: Codeunit "Order Planning Mgt.";
                        PurchOrderFromSalesOrder: Page "Purch. Order From Sales Order";
                        //RequisitionLine: Record "Requisition Line";
                        PurchaseRequestLine: Record "Purchase Request Line";
                        NoFilter: Text;
                    begin
                        Clear(SalesHEader);//15/01/2025
                        SalesHEader.get(SalesHEader."Document Type"::Order, Rec."Sales Order No.");
                        PurchDocFromSalesDoc.CreatePurchaseOrder(SalesHEader);
                    end;
                }

                action("Reorder Slip")
                {
                    Caption = 'Reorder Slip';
                    Promoted = true;
                    Visible = false;
                }

                action("Change Status")
                {
                    Image = Change;
                    Visible = IsVisible;

                    trigger OnAction()
                    begin
                        ///Func.ChangeRequestStatus("No.");
                    end;
                }
                action("Change Status To ReAssign")
                {
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = IsVisible;

                    trigger OnAction()
                    begin
                        /*PurchaseOrder.SETRANGE("Purchase Request No.","No.");
                        IF NOT PurchaseOrder.FINDFIRST THEN*/
                        ///  Func.ReAssignReq("No.")
                        ///ELSE
                        ///  ERROR('THE Request already Assigned please check purchase order list');

                    end;
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;

                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                action(ViewOrder)
                {
                    Caption = 'View Order';
                    Image = ViewOrder;
                }
                action(ViewQuote)
                {
                    Caption = 'View Quote';
                    Image = ViewJob;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec); //EDM.AttachDoc+-
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //  InitRecord();
    end;

    trigger OnOpenPage()
    var
        lFilterGroup: Integer;
        userSetup: Record "User Setup";
        PurchasseeRequest: Record "Purchase Request Header";
    begin
        // userSetup.Get(UserId);
        // If userSetup."Prevent Change On PR and JRQ" then
        //     CurrPage.Editable := false
        // else
        //     CurrPage.Editable := true;


    end;

    var
        Edit: Boolean;
        Text001: Label 'Decline stock req.';
        RequestLine: Record "Purchase Request Line";
        RequestLine8: Record "Purchase Request Line";
        RequestHeader: Record "Purchase Request Header";
        Locations: Record Location;
        UserSetup: Record "User Setup";
        Text003: Label 'You Don''t have Permission to Send Request';
        Text004: Label 'You Don''t have Permission to Verify Request';
        Text005: Label 'You Don''t have Permission to Declined Request';
        Text006: Label 'You Don''t have Permission to Approve Request';
        LineNo: Integer;
        Text007: Label 'Request sent previously ';
        Text008: Label 'Request Verified previously ';
        ExcelBuf: Record "Excel Buffer";
        ExcelBufRange: Record "Excel Buffer";
        ExcelBufDetRa: Record "Excel Buffer";
        FileName: Text[250];
        SheetName: Text[250];
        TotalRecNo: Integer;
        RecNo: Integer;
        Window: Dialog;
        Text009: Label 'Import from Excel';
        [InDataSet]
        IsVisible: Boolean;

        PurchaseOrder: Record "Purchase Header";
        PurcReqHdr: Record "Purchase Request Header";
        CanCancelApprovalForRecord: Boolean;
        VisibleForRequester: Boolean;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        FACount: Integer;
        CanEditRequest: Boolean;
        DimensionValueList: Page "Dimension Value List";
        DimesninValue: Record "Dimension Value";
        HasIncomingDocument: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        CanDeletePR: Boolean;
        CanReOpenPR: Boolean;
        VendorNo: Code[20];



    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
    end;

    var
        LastLineNo: Integer;
        PurchaseOrderNo: code[20];
}

