page 70139 "Purchase Request SubForm"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Purchase Request Line";

    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1100409000)
            {
                //   ShowCaption = false;
                field(Assigned; Rec.Assigned)
                {

                }
                field(Check; Rec.Check)
                {


                    //     trigger OnValidate()
                    //     begin
                    //         /*i := 0;
                    //         IF ISCLEAR(WSHSHELL) THEN
                    //         CREATE(WSHSHELL,FALSE,TRUE);
                    //         REPEAT
                    //         WSHSHELL.SendKeys('{F5}');
                    //         i += 1;
                    //         UNTIL i = 3;*/

                    //     end;
                }
                field(Type; Rec.Type)
                {

                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'No.';


                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Item Description"; Rec."Item Description")
                {

                }
                field(Description; Rec.Description)
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {

                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                    // DrillDownPageId = "Job Planning Lines";
                    Editable = false;
                }
                field("Vendor Item Code"; Rec."Vendor Item Code")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Job Planning Lines";
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = EditableQtyCost;
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                }
                field("PO Line No"; Rec."PO Line No")
                {
                    ApplicationArea = All;
                }

                field("Total Available Stock"; Rec."Total Available Stock")
                {
                    ToolTip = 'Specifies the value of the Total Available Stock field.', Comment = '%';
                }
                field("Main Stock"; Rec."Main Stock")
                {
                    ToolTip = 'Specifies the value of the Main Stock field.', Comment = '%';
                }
                field("Suggested Qty"; Rec."Suggested Qty")
                {
                    ToolTip = 'Specifies the value of the Suggested Qty field.', Comment = '%';
                    Editable = false;
                }
                field("Final PR"; Rec."Final PR")
                {
                    ToolTip = 'Specifies the value of the Final PR field.', Comment = '%';
                }
                field("Official PO QTY"; Rec."Official PO QTY")
                {
                    ToolTip = 'Specifies the value of the Official PO QTY field.', Comment = '%';
                    trigger OnValidate()

                    var
                        reqlines: Record "Requisition Line";
                    begin
                        //AN 04/29/25
                        Clear(reqlines);
                        reqlines.SetRange("MASQ Sales Order No.", Rec."MASQ Sales Order No.");
                        reqlines.SetRange("MASQ Sales Order Line No.", Rec."MASQ Sales Order Line No.");
                        IF reqlines.FindFirst() then begin//AI 04/30/25
                            if Rec."Official PO QTY" <> reqlines.Quantity then begin
                                Rec."Qty of PR" := Rec."Official PO QTY";
                                Rec."Qty of Req" := reqlines.Quantity;
                            end;
                            Rec.Modify(true);
                        end;
                    end;

                }
                field("PO Status"; Rec."PO Status")
                {
                    ToolTip = 'Specifies the value of the PO Status field.', Comment = '%';
                    Editable = false;
                }
                field("Expected Unit Cost"; Rec."Expected Unit Cost")
                {
                    Editable = EditableQtyCost;
                }
                field("Expected Total Cost"; Rec."Expected Total Cost")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = EditableQtyCost;
                    trigger OnValidate()

                    var
                        reqlines: Record "Requisition Line";
                    begin
                        //AN 04/29/25
                        Clear(reqlines);
                        reqlines.SetRange("MASQ Sales Order No.", Rec."MASQ Sales Order No.");
                        reqlines.SetRange("MASQ Sales Order Line No.", Rec."MASQ Sales Order Line No.");
                        IF reqlines.FindFirst() then //AI 04/30/25
                            if Rec."Unit Cost" <> reqlines."Direct Unit Cost" then begin
                                Rec."Cost of PR" := Rec."Unit Cost";
                                Rec."Cost oof Req" := reqlines."Direct Unit Cost";
                            end;
                        Rec.Modify(true);

                    end;
                }
                field("Total Cost"; Rec."Total Cost")
                {


                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                    Editable = false;
                }
                //AN 06/27/2025+
                field("Discount %"; Rec."Discount %")
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Line Amount After Discount"; Rec."Line Amount After Discount")
                {
                    ApplicationArea = All;
                }
                // //AN 06/27/2025-
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                //AN 06/27/2025+
                field("Line Amt After Disc Incl. VAT"; Rec."Line Amt After Disc Incl. VAT")
                {
                    ApplicationArea = All;
                }
                //AN 06/27/2025-
                field(Remark; Rec.Remark)
                {
                }
                field("Document Type"; Rec."Document Type")
                {


                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Document Reference"; Rec."Document Reference")
                {
                    Caption = 'Document Reference';

                }
                field("Reference Name"; Rec."Reference Name")
                {

                }
                field(Reason; Rec.Reason)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimesninValue.SETRANGE(DimesninValue."Global Dimension No.", 1);
                        DimesninValue.SETFILTER(Code, '%1', Rec."Shortcut Dimension 2 Code" + '*');
                        DimesninValue.SETRANGE(DimesninValue."Dimension Value Type", DimesninValue."Dimension Value Type"::Standard);
                        DimensionValueList.SETTABLEVIEW(DimesninValue);
                        DimensionValueList.LOOKUPMODE := TRUE;
                        IF DimensionValueList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            DimensionValueList.GETRECORD(DimesninValue);
                            CLEAR(DimensionValueList);
                            Rec.VALIDATE("Shortcut Dimension 1 Code", DimesninValue.Code);
                        END;
                        CLEAR(DimensionValueList);
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {

                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                }
                field("Delivery Location"; Rec."Delivery Location")
                {
                }
                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Item ledger")
            {
                Image = ItemLedger;

                trigger OnAction()
                begin
                    itemledgerentry.SETRANGE("Item No.", REc."Item No.");
                    itemledgerentry.FINDFIRST;
                    PAGE.RUNMODAL(38, itemledgerentry);
                end;
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("<Action1000000025>")
                {
                    Caption = '&Item Availability by';
                    Enabled = ItemLine;
                    action("<Action1000000026>")
                    {
                        Caption = 'by &Period';
                        Promoted = true;
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("Item No.");
                    }
                    action("<Action1000000027>")
                    {
                        Caption = 'by &Variant';
                        Promoted = true;
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No." = FIELD("Item No.");
                    }
                    action("<Action1000000028>")
                    {
                        Caption = 'by &Location';
                        Promoted = true;
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("Item No.");
                    }
                }


                action("Budget Allocation")
                {
                    Caption = 'Budget Allocation';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ItemLine := (Rec.Type = Rec.Type::Item);


        //EDM.ALI+
        EditableQtyCost := TRUE;
        Rec.CALCFIELDS(Status);
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            EditableQtyCost := FALSE;
            IF UserSetup.GET(USERID) THEN
                EditableQtyCost := UserSetup."Can Edit Qty\Cost Released PR";
        END;
        //EDM.ALI-

    end;

    // trigger OnAfterGetRecord()
    // begin
    //     Rec.FIllItemType();
    // end;


    trigger OnOpenPage()
    begin
        SetControlAppearance;
        Rec.FIllItemType();
    end;

    var
        itemledgerentry: Record "Item Ledger Entry";
        //   WSHSHELL: Automation;
        i: Integer;
        PurcReqHdr: Record "Purchase Request Header";
        UserSetup: Record "User Setup";
        VisibleForRequester: Boolean;
        ItemLine: Boolean;
        RequestHeader: Record "Purchase Request Header";
        DimMgt: Codeunit DimensionManagement;
        JobTask: Record "Job Task";
        UserSetupRead: Boolean;
        Text001: Label 'Cannot assign Request Lines for different vendors';
        Text002: Label 'Request has been fully assigned.';
        Text003: Label 'Request Line(s) assigned Successfully';
        Text004: Label 'Document Type of selected Request Line must be "Purchase Order"';
        GLSetup: Record "General Ledger Setup";
        DimensionValueList: Page "Dimension Value List";
        DimesninValue: Record "Dimension Value";
        EditableQtyCost: Boolean;



    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        VisibleForRequester := FALSE;
        GetUserSetup
    end;

    local procedure GetUserSetup()
    begin
        IF UserSetupRead THEN
            EXIT;

        UserSetup.SETRANGE("User ID", USERID);
        UserSetupRead := TRUE;
        IF UserSetup.FINDFIRST THEN
            EXIT
        ELSE
            ERROR('User Setup does not exist');
    end;


    local procedure GetPurchaseOrderNo(VendorNo: Code[20]): Code[20]
    var
        PurchHeader: Record "Purchase Header";
        PurchOrderList: Page "Purchase Order List";
        PurchHeader2: Record "Purchase Header";
    begin
        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SETRANGE(Status, PurchHeader.Status::Open);
        PurchHeader.SETRANGE("Buy-from Vendor No.", VendorNo);

        CLEAR(PurchOrderList);
        PurchOrderList.SETTABLEVIEW(PurchHeader);
        PurchOrderList.LOOKUPMODE(TRUE);
        IF PurchOrderList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            PurchOrderList.SETSELECTIONFILTER(PurchHeader2);

            IF PurchHeader2.FINDFIRST THEN
                EXIT(PurchHeader2."No.");
        END;
    end;



}

