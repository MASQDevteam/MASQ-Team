page 70141 "Purchase Request List"
{
    AutoSplitKey = false;
    Caption = 'Purchase Requests';
    CardPageID = "Purchase Request Card";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Purchase Request Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1100409000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Progress Status"; Rec."Progress Status")
                {
                }
                field(Requester; Rec.Requester)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Total Line Expected Amount"; Rec."Total Line Expected Amount")
                {
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                }
                field("Total Line Amount Inc. VAT"; Rec."Total Line Amount Inc. VAT")
                {
                }

                field("Total Amount Assigned"; Rec."Total Amount Assigned")
                {
                }
                field("Discount %"; Rec."Discount %")
                {
                    ToolTip = 'Specifies the value of the Discount % field.', Comment = '%';
                    Editable = false;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Discount Amount field.', Comment = '%';
                    Editable = false;
                }
                field("Total After Discount"; Rec."Total After Discount")
                {
                    ToolTip = 'Specifies the value of the Total After Discount field.', Comment = '%';
                    Editable = false;
                }
                field("Total After Discount Incl. VAT"; Rec."Total After Discount Incl. VAT")
                {
                    ToolTip = 'Specifies the value of the Total After Discount Incl. VAT field.', Comment = '%';
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("First Item Description"; Rec."First Item Description")
                {
                    Caption = 'Item Description';
                }

            }
        }

        // area(factboxes)
        // {
        //     systempart(Control1000000005; Links)
        //     {
        //         Visible = true;
        //     }
        //     systempart(Control1000000004; Notes)
        //     {
        //         Visible = true;
        //     }
        //     part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
        //     {
        //         ShowFilter = true;
        //     }



        // }

        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(70126),
                              "No." = FIELD("No.");
            }
        }

    }

    actions
    {
        area(processing)
        {
            group(Delete)
            {

                // action("Purchase Request Report")
                // {
                //     Image = "Report";
                //     Promoted = true;
                //     PromotedCategory = Process;

                //     trigger OnAction()
                //     begin
                //         Requestheader.SETRANGE("No.", "No.");
                //         REPORT.RUNMODAL(50040, TRUE, FALSE, Requestheader);
                //     end;
                // }
                action("Request Lines")
                {
                    Caption = 'Request Lines';
                    Image = List;

                    trigger OnAction()
                    var
                        PurchReqLines: Record "Purchase Request Line";
                        PurchaseRequestLines: Page "Purchase Request SubForm";
                    begin
                        CLEAR(PurchReqLines);
                        PurchReqLines.RESET;
                        PurchReqLines.SETRANGE("Document No.", Rec."No.");
                        PAGE.RUNMODAL(70139, PurchReqLines);
                    end;
                }
            }
            group("Purchase Request History")
            {
                Caption = 'Purchase Request History';
                action("Show Accepted Requests")
                {
                    Caption = 'Show Accepted Requests';
                    Image = Documents;

                    trigger OnAction()
                    begin
                        CLEAR(ReqHeader);
                        //ReqHeader.SETRANGE("Req. Status",ReqHeader."Req. Status"::Accepted);
                        ReqHeader.SETRANGE(Status, ReqHeader.Status::Closed);
                        PAGE.RUNMODAL(94003, ReqHeader);
                    end;
                }
                action("Show Declined Requests")
                {
                    Image = Documents;

                    trigger OnAction()
                    begin
                        CLEAR(ReqHeader);
                        //ReqHeader.SETRANGE("Req. Status",ReqHeader."Req. Status"::Declined);
                        ReqHeader.SETRANGE(Status, ReqHeader.Status::Declined);
                        PAGE.RUNMODAL(94003, ReqHeader);
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
            }
            group("Item Type")
            {
                action("Fill Item Type")
                {
                    Caption = 'Fill Item Type';
                    Image = Add;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchaseRequest: Record "Purchase Request Header";
                        PurchaseRequestLine: Record "Purchase Request Line";
                    begin
                        Clear(PurchaseRequest);
                        Clear(PurchaseRequestLine);
                        // PurchaseRequest.SetRange("No.", Rec."No.");
                        // if PurchaseRequest.FindFirst() then
                        PurchaseRequestLine.SetRange("Document No.", Rec."No.");
                        if PurchaseRequestLine.FindFirst() then begin
                            repeat
                                PurchaseRequestLine.FIllItemTypefromPPLine();
                                PurchaseRequestLine.Modify();
                            until PurchaseRequestLine.Next() = 0;
                        end;

                    end;
                }
            }
        }
    }



    // trigger OnOpenPage()
    // begin
    //     UserSetup.SETRANGE("User ID", USERID);
    //     IF UserSetup.FINDFIRST THEN BEGIN
    //         IF UserSetup."Allow Delete Request" THEN
    //             Allowed := TRUE;
    //     END;
    //     FILTERGROUP(2);
    //     //SETFILTER(Status,'<>Closed');
    //     //SETFILTER("Req. Status",'New|Accepted');
    //     IF UserSetup."User Type" = UserSetup."User Type"::Requester THEN
    //         SETFILTER(Requester, USERID);
    //     IF (UserSetup."Global Dimension 2 Code" <> '') and (UserSetup."Filter Purchase Req Project") then
    //         SetFilter("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
    //     FILTERGROUP(2);
    // end;

    var
        UserSetup: Record "User Setup";
        [InDataSet]
        Allowed: Boolean;
        Ans: Boolean;
        txtcon: Label 'Are you sure to delete Request No %1';
        // EDMFunc: Codeunit "EDM Functions AVSI";
        Requestheader: Record "Purchase Request Header";
        ReqHeader: Record "Purchase Request Header";
}

