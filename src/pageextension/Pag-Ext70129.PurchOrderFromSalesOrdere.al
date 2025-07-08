pageextension 70129 "Purch. Order From Sales Ordere" extends "Purch. Order From Sales Order"
{
    layout
    {
        addafter("No.")
        {
            field("Vendor Item No."; Rec."Vendor Item No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Meg Item Type"; Rec."Meg Item Type")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addbefore(Vendor)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
        addafter(Vendor)
        {

            field("Append to PO No."; Rec."Append to PO No.")
            {
                ApplicationArea = All;
                Editable = EditAppendPO;
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the currency code for the requisition lines.';
                Editable = false;
            }
        }
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the cost of one unit of the selected item or resource.';
                Editable = (CanSubmitPurchaseRequest) and (Rec.Include);//added on 22/04/2025

                trigger OnValidate()
                var
                    CostPRLog: Record "Cost PR Log";
                begin

                    if (xRec."Direct Unit Cost" <> 0) and (xRec."Direct Unit Cost" <> Rec."Direct Unit Cost") then begin
                        CostPRLog.Init();
                        CostPRLog."Item Number" := Rec."No.";
                        CostPRLog."PR Line Number" := Rec."Line No.";
                        CostPRLog."New Cost" := Rec."Direct Unit Cost";
                        CostPRLog."Old Cost" := xRec."Direct Unit Cost";
                        CostPRLog."Project No." := Rec."Job No.";
                        CostPRLog."Project planning Line No." := Rec."Job Planning Line No.";
                        CostPRLog."Created By" := UserId;
                        CostPRLog.Insert(true);
                    end;
                end;
            }
            field(Include; Rec.Include)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Include field.', Comment = '%';
                Caption = 'Submitted';
                Editable = CanSubmitPurchaseRequest;//added on 25/02/2025

                trigger OnValidate()
                var
                    ProjectPlanningLines: Record "Job Planning Line";
                    PurchaseRequestLine: Record "Purchase Request Line";
                begin
                    IF Rec.Include = true then begin
                        IF NOT Rec."Sent to PO" then
                            Rec.Validate(Quantity, Rec."Demand Quantity") else
                            Rec.Validate(Quantity, 0);
                    end else
                        Rec.Validate(Quantity, 0);


                    Clear(ProjectPlanningLines);//01012025
                    IF ProjectPlanningLines.Get(Rec."Job No.", Rec."Job Task No.", Rec."Job Planning Line No.") then begin
                        IF Rec."Currency Code" = '' then
                            Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost (LCY)")      //01/01/2025  
                        else
                            Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost in Vendor Currency");//updated by Abdallah on 18/03/2025
                    end;

                    Rec.Modify();

                end;
            }
            field("PO from PR"; Rec."PO from PR")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO from PR field.', Comment = '%';
                Editable = false;

            }
            field("PO No."; Rec."PO No.")
            {
                ApplicationArea = All;
                // trigger OnValidate()
                // var
                //     myInt: Integer;
                // begin
                //     EditableAppendPO();
                // end;
            }
            field("PO Line No"; Rec."PO Line No")
            {
                ApplicationArea = All;
            }

        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                CostPRLog: Record "Cost PR Log";
            begin
                if (xRec.Quantity <> 0) and (xRec.Quantity <> Rec.Quantity) then begin
                    CostPRLog.Init();
                    CostPRLog."Item Number" := Rec."No.";
                    CostPRLog."PR Line Number" := Rec."Line No.";
                    CostPRLog."Old Qty" := xRec.Quantity;
                    CostPRLog."New Qty" := Rec.Quantity;
                    CostPRLog."Project No." := Rec."Job No.";
                    CostPRLog."Project planning Line No." := Rec."Job Planning Line No.";
                    CostPRLog."Created By" := UserId;
                    CostPRLog.Insert(true);
                end;
            end;
        }
        /* modify(Quantity)//stooped on 07/05/2025
         {
             Editable = CanSubmitPurchaseRequest;
             //Enabled = false;
         }
         {
           //  Editable = false;
             //Enabled = false;
         }
         modify(Vendor)
         {
             //Editable = false;
             //Enabled = false;
         }*/
        addfirst(FactBoxes)
        {
            part("Cost PR LOGs Factbox"; "Cost PR LOGs Factbox")
            {
                ApplicationArea = All;
                Caption = 'Cost Variation LOG';
                SubPageLink = "PR Line Number" = field("Line No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(ShowUnavailable)
        {
            action("Submittals")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    SubmittalComment: Record SubmittalComment;
                    SubmittalCommentPage: Page "SubmittalComment Subform";
                begin
                    Clear(SubmittalComment);
                    SubmittalComment.SetRange("Dynamics Project Number", Rec."Job No.");
                    page.Run(page::"SubmittalComment Subform", SubmittalComment);
                end;
            }
            action("Create Purchase Requests")
            {
                ApplicationArea = All;
                Image = Purchase;
                trigger OnAction()
                begin
                    CreateOrOpenPurchaseRequests()
                end;
            }
        }
    }






    trigger OnAfterGetRecord()
    var
        Submital: Record Submittal;
        SubmitalDetail: Record SubmittalComment;
        ProjectPlanningLines: Record "Job Planning Line";
        PurchaseRequest: Record "Purchase Request Header";
        PurchaseRequestLine: Record "Purchase Request Line";
        Project: Record Job;
        CostPRLog: Record "Cost PR Log";
    begin
        Clear(PurchaseRequestLine);
        Clear(CostPRLog);
        //ChangePOFromPR();
        //AN 04/04/2025
        EditAppendPO := EditableAppendPO();
        Clear(Submital);
        Submital.SetRange("Dynamics Project Number", Rec."Job No.");//EDM.AI_31/12/2024
        IF Submital.FindFirst()
    then begin
            Clear(SubmitalDetail);
            SubmitalDetail.SetRange(SubmittalId, Submital.SubmittalId);
            SubmitalDetail.SetRange(A, true);
            IF SubmitalDetail.FindFirst() then
                repeat
                    IF SubmitalDetail."Dynamics Item Number" = Rec."No." then begin
                        Rec.Validate(Include, true);


                        Clear(ProjectPlanningLines);//01012025
                        IF ProjectPlanningLines.Get(Rec."Job No.", Rec."Job Task No.", Rec."Job Planning Line No.") then begin
                            IF Rec."Currency Code" = '' then
                                Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost (LCY)")      //01/01/2025
                            else
                                Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost in Vendor Currency");//updated by Abdallah on 18/03/2025
                        end;

                        Rec.Modify();
                        IF Rec.Include = true then begin
                            IF NOT Rec."Sent to PO" then
                                Rec.Validate(Quantity, Rec."Demand Quantity") else
                                Rec.Validate(Quantity, 0);
                        end else
                            Rec.Validate(Quantity, 0);
                    end;
                until SubmitalDetail.Next() = 0;

            Clear(SubmitalDetail);
            SubmitalDetail.SetRange(SubmittalId, Submital.SubmittalId);
            SubmitalDetail.SetRange(B, true);
            SubmitalDetail.SetRange(ClearToOrder, true);
            IF SubmitalDetail.FindFirst() then
                repeat
                    IF SubmitalDetail."Dynamics Item Number" = Rec."No." then begin
                        Rec.Validate(Include, true);
                        Clear(ProjectPlanningLines);//01012025
                        IF ProjectPlanningLines.Get(Rec."Job No.", Rec."Job Task No.", Rec."Job Planning Line No.") then begin
                            IF Rec."Currency Code" = '' then
                                Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost (LCY)")      //01/01/2025
                            else
                                Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost in Vendor Currency");//updated by Abdallah on 18/03/2025
                        end;
                        Rec.Modify();
                        IF Rec.Include = true then begin
                            IF NOT Rec."Sent to PO" then
                                Rec.Validate(Quantity, Rec."Demand Quantity") else
                                Rec.Validate(Quantity, 0);
                        end else
                            Rec.Validate(Quantity, 0);
                    end;
                until SubmitalDetail.Next() = 0;

            Clear(SubmitalDetail);
            SubmitalDetail.SetRange(SubmittalId, Submital.SubmittalId);
            SubmitalDetail.SetRange(ClearToOrderPMOApprove, true);
            IF SubmitalDetail.FindFirst() then
                repeat
                    IF SubmitalDetail."Dynamics Item Number" = Rec."No." then begin
                        Rec.Validate(Include, true);

                        Clear(ProjectPlanningLines);//01012025
                        IF ProjectPlanningLines.Get(Rec."Job No.", Rec."Job Task No.", Rec."Job Planning Line No.") then begin
                            IF Rec."Currency Code" = '' then
                                Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost (LCY)")      //01/01/2025
                            else
                                Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost in Vendor Currency");//updated by Abdallah on 18/03/2025
                        end;
                        Rec.Modify();
                        IF Rec.Include = true then begin
                            IF NOT Rec."Sent to PO" then
                                Rec.Validate(Quantity, Rec."Demand Quantity") else
                                Rec.Validate(Quantity, 0);
                        end else
                            Rec.Validate(Quantity, 0);
                    end;
                until SubmitalDetail.Next() = 0;

            //AN 04/07/2025
            Clear(project);
            if Project.Get(Rec."Demand Order No.") then begin
                if Project."Box Mover" = true then
                    Rec.Validate(Include, true);
            end;
        end;


        Clear(PurchaseRequest);//this is oonly used if the  yopu want to create the PO from THe PR case the the user assigned the PR to create a PO only create the lines that are assigned from this PR
        PurchaseRequest.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code MASQ");//get all the PR for this project
        if PurchaseRequest.FindSet() then
            repeat
                IF PurchaseRequest.Assigned then begin
                    PurchaseRequestLine.Reset();
                    PurchaseRequestLine.SetRange("Document No.", PurchaseRequest."No.");
                    IF PurchaseRequestLine.FindSet() then
                        repeat
                            // IF PurchaseRequestLine."Item No." = Rec."No." then begin//commented on 28/04/2025 AI

                            IF (PurchaseRequestLine."MASQ Sales Order No." = Rec."MASQ Sales Order No.") and (PurchaseRequestLine."MASQ Sales Order Line No." = Rec."MASQ Sales Order Line No.") then begin//added on 28/04/2025 by AI
                                Rec.Validate("PO from PR", true);

                                //AN 04/29/25
                                IF (PurchaseRequestLine."Qty of PR" <> PurchaseRequestLine."Qty of Req") then begin
                                    if CostPRLog."Entry No." = 0 then begin
                                        CostPRLog.Init();
                                        CostPRLog."Item Number" := Rec."No.";
                                        CostPRLog."PR Line Number" := Rec."Line No.";
                                        CostPRLog."New Qty" := PurchaseRequestLine."Qty of PR";
                                        CostPRLog."Old Qty" := PurchaseRequestLine."Qty of Req";
                                        CostPRLog."Project No." := Rec."Job No.";
                                        CostPRLog."Project planning Line No." := Rec."Job Planning Line No.";
                                        CostPRLog."Created By" := UserId;
                                        CostPRLog.Insert(true);
                                    end
                                    else begin
                                        CostPRLog."New Qty" := PurchaseRequestLine."Qty of PR";
                                        CostPRLog."Old Qty" := PurchaseRequestLine."Qty of Req";
                                        CostPRLog.Modify(true);
                                    end;
                                    PurchaseRequestLine."Qty of PR" := 0;
                                    PurchaseRequestLine."Qty of Req" := 0;
                                    PurchaseRequestLine.Modify();
                                end;
                                IF PurchaseRequestLine."Official PO QTY" <> 0 then//16/01/2025    this quantity is the confirmed quantity from thr PR and will overright the demand quantity from the sales Order
                                    Rec.Validate(Quantity, PurchaseRequestLine."Official PO QTY");


                                //AN 04/29/25
                                IF (PurchaseRequestLine."Cost of PR" <> PurchaseRequestLine."Cost oof Req") then begin
                                    if CostPRLog."Entry No." = 0 then begin
                                        CostPRLog.Init();
                                        CostPRLog."Item Number" := Rec."No.";
                                        CostPRLog."PR Line Number" := Rec."Line No.";
                                        CostPRLog."New Cost" := PurchaseRequestLine."Cost of PR";
                                        CostPRLog."Old Cost" := PurchaseRequestLine."Cost oof Req";
                                        CostPRLog."Project No." := Rec."Job No.";
                                        CostPRLog."Project planning Line No." := Rec."Job Planning Line No.";
                                        CostPRLog."Created By" := UserId;
                                        CostPRLog.Insert(true);
                                    end
                                    else begin
                                        CostPRLog."New Cost" := PurchaseRequestLine."Cost of PR";
                                        CostPRLog."Old Cost" := PurchaseRequestLine."Cost oof Req";
                                        CostPRLog.Modify(true);
                                    end;
                                    PurchaseRequestLine."Cost of PR" := 0;
                                    PurchaseRequestLine."Cost oof Req" := 0;
                                    PurchaseRequestLine.Modify();
                                end;
                                //added by AI 22/04/2025
                                IF (PurchaseRequestLine."Unit Cost" <> Rec."Direct Unit Cost") then begin
                                    Rec.Validate("Direct Unit Cost", PurchaseRequestLine."Unit Cost");
                                end;
                                Rec.Modify(true);

                            end;
                        until PurchaseRequestLine.Next() = 0;
                end;

            until PurchaseRequest.Next() = 0;

    end;

    local procedure HideQtyServiceItemLocalVendor()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Item: Record Item;
        RequisitionLine: Record "Requisition Line";
    begin
        Filters := '';
        Clear(PurchasesPayablesSetup);
        PurchasesPayablesSetup.Get();
        Clear(Item);
        Clear(RequisitionLine);
        repeat
            Item.SetRange("No.", Rec."No.");
            Item.SetFilter(Type, '%1', Item.Type::Service);
            if Item.FindFirst() then
                repeat
                    if Item."Vendor No." = PurchasesPayablesSetup."Local Vendor" then begin
                        Filters := '<>';
                        Filters += Item."No." + '&<>';
                    end;
                until Item.Next() = 0;
        until Rec.Next() = 0;
        if Filters <> '' then
            Filters := DelStr(Filters, StrLen(Filters) - 2, 4); // Remove trailing '&'    
        Rec.SetFilter("No.", Filters);
    end;

    local procedure CreateOrOpenPurchaseRequests()
    var
        PurchaseRequest: Record "Purchase Request Header";
        PurchaseRequestLine: Record "Purchase Request Line";
        Vendor: Record Vendor;
        LineNo: Integer;
        ProjectPlanningLines: Record "Job Planning Line";
        Item: Record Item;
    begin
        Clear(PurchaseRequest);
        PurchaseRequest.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");

        IF NOT PurchaseRequest.FindFirst() then begin

            LineNo := 0;
            if Rec.FindSet() then
                repeat
                    Clear(PurchaseRequest);
                    PurchaseRequest.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    PurchaseRequest.SetRange("Vendor No.", Rec."Vendor No.");
                    IF NOT PurchaseRequest.FindFirst()
                    then begin
                        Clear(Vendor);
                        Vendor.Get(Rec."Vendor No.");
                        Clear(PurchaseRequest);
                        PurchaseRequest.Init();
                        PurchaseRequest.Date := REc."Order Date";
                        PurchaseRequest."Location Code" := Rec."Location Code";
                        PurchaseRequest.Status := PurchaseRequest.Status::Open;
                        PurchaseRequest."Global Dimension 1 Code" := rec."Shortcut Dimension 1 Code";
                        PurchaseRequest."Currency Code" := Rec."Currency Code";
                        PurchaseRequest."Vendor No." := Rec."Vendor No.";
                        PurchaseRequest."VAT Bus. Posting Group" := Vendor."VAT Bus. Posting Group";
                        PurchaseRequest."Sales Order No." := Rec."Demand Order No.";
                        Clear(ProjectPlanningLines);//17/02/2025
                        IF ProjectPlanningLines.Get(Rec."Job No.", Rec."Job Task No.", Rec."Job Planning Line No.") then begin
                            //AN 06/04/2025
                            PurchaseRequest.Validate("Project No.", ProjectPlanningLines."Job No.");
                        end;
                        PurchaseRequest.Insert(true);

                    end;
                    LineNo := LineNo + 10000;
                    Clear(PurchaseRequestLine);
                    PurchaseRequestLine.Init();
                    PurchaseRequestLine."Document No." := PurchaseRequest."No.";
                    PurchaseRequestLine."Line No." := LineNo;
                    PurchaseRequestLine.Insert();
                    //  PurchaseRequestLine.CalcFields("Main Stock");
                    PurchaseRequestLine.Type := PurchaseRequestLine.Type::Item;
                    PurchaseRequestLine.Validate("Item No.", Rec."No.");
                    Clear(Item);
                    item.Get(Rec."No.");
                    PurchaseRequestLine.Description := item.Description;
                    PurchaseRequestLine."Item Description" := item.Description;

                    PurchaseRequestLine.Validate(Quantity, Rec."Demand Quantity");
                    Clear(ProjectPlanningLines);//17/02/2025
                    IF ProjectPlanningLines.Get(Rec."Job No.", Rec."Job Task No.", Rec."Job Planning Line No.") then begin
                        //AN 6/13/2025
                        PurchaseRequestLine.Validate("Unit of Measure Code", ProjectPlanningLines."Unit of Measure Code");
                        //AN 06/04/2025
                        PurchaseRequestLine.Validate("Project No.", ProjectPlanningLines."Job No.");
                        IF Rec."Currency Code" = '' then
                            PurchaseRequestLine.Validate("Unit Cost", ProjectPlanningLines."Unit Cost (LCY)") //17/02/2025
                        else
                            PurchaseRequestLine.Validate("Unit Cost", ProjectPlanningLines."Unit Cost in Vendor Currency");//updated by Abdallah on 18/03/2025
                    end;

                    PurchaseRequestLine.Validate(Amount, PurchaseRequestLine.Quantity * PurchaseRequestLine."Unit Cost");


                    PurchaseRequestLine."Document Type" := PurchaseRequestLine."Document Type"::"Purchase Order";
                    PurchaseRequestLine.Validate("Document Reference", Rec."Vendor No.");
                    PurchaseRequestLine.Validate("Shortcut Dimension 1 Code", REc."Shortcut Dimension 1 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 4 Code", REc."Shortcut Dimension 4 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 5 Code", Rec."Shortcut Dimension 5 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 6 Code", Rec."Shortcut Dimension 6 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 7 Code", REc."Shortcut Dimension 7 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 8 Code", Rec."Shortcut Dimension 8 Code");
                    PurchaseRequestLine.Validate("MASQ Sales Order No.", Rec."MASQ Sales Order No.");
                    PurchaseRequestLine.Validate("MASQ Sales Order Line No.", Rec."MASQ Sales Order Line No.");
                    PurchaseRequestLine."PO Status" := PurchaseRequestLine."PO Status"::"Not Ordered";
                    PurchaseRequestLine."PO No." := Rec."PO No.";
                    PurchaseRequestLine."PO Line No" := Rec."PO Line No";



                    IF rec.Include then
                        PurchaseRequestLine.Check := true;

                    PurchaseRequestLine.Modify();

                    if PurchaseRequestLine."PO No." <> '' then begin
                        PurchaseRequestLine."PO Status" := PurchaseRequestLine."PO Status"::Created;
                        PurchaseRequestLine.Modify();
                    end;
                until Rec.Next() = 0;
        end;
        Clear(PurchaseRequest);
        PurchaseRequest.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        Page.Run(page::"Purchase Request List", PurchaseRequest);

    end;


    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";

    begin
        Clear(UserSetup);
        IF UserSetup.GET(USERID) THEN
            CanSubmitPurchaseRequest := UserSetup."Can Submit Purchase Request";
        //AN 04/04/2025
        EditAppendPO := EditableAppendPO();
        //AN 04/11/2025
        Rec.FilterGroup(2);
        HideQtyServiceItemLocalVendor();
        // Rec.FilterGroup(0);   
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        PurchaseRequest: Record "Purchase Request Header";
        RequisitionLine: Record "Requisition Line";

    begin
        Rec.SetRange("No.");
        RequisitionLine.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
        RequisitionLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        if RequisitionLine.FindFirst() then
            repeat
                Clear(PurchaseRequest);
                PurchaseRequest.SetRange("Global Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code MASQ");
                PurchaseRequest.SetRange("Vendor No.", RequisitionLine."Vendor No.");
                if PurchaseRequest.FindSet() then
                    repeat
                        PurchaseRequest.Assigned := false;
                        PurchaseRequest.Modify();
                    until PurchaseRequest.Next() = 0;
            until RequisitionLine.Next() = 0;
    end;

    //AN 04/04/2025
    local procedure EditableAppendPO(): Boolean
    var
        myInt: Integer;
    begin
        if Rec."PO No." <> '' then
            EditAppendPO := false
        else if Rec."PO No." = '' then
            EditAppendPO := true;
        exit(EditAppendPO);
    end;

    var
        EditAppendPO: Boolean;
        CanSubmitPurchaseRequest: Boolean;
        Filters: Text;
}