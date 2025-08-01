pageextension 70130 "SO Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Qty to Split"; Rec."Qty to Split")
            {
                ApplicationArea = All;
                Visible = visibleQTYSplit;
                Editable = (Rec."MASQ Purchase Order No." = '') and (Rec."Qty to Split" = 0);
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    SplitSOLines();
                end;
            }
            field("Original Quantity"; Rec."Original Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Original Quantity field.', Comment = '%';
                Editable = false;
                Enabled = false;
                BlankZero = true;
            }
            field("Remaining Quantity Shipped"; Rec."Remaining Quantity Shipped")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remaining Quantity Shipped field.', Comment = '%';
                Editable = false;
                Enabled = false;
            }
        }
        // Add changes to page layout here
        addafter("Unit Price")
        {
            field("Job No."; Rec."Job No.")//commented on 29/11/2024 need to check
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related project. If you fill in this field and the Project Task No. field, then a project ledger entry will be posted together with the sales line.';
                Editable = false;
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related project task.';
                Editable = false;

            }
            field("Job Contract Entry No."; Rec."Job Contract Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the entry number of the project planning line that the sales line is linked to.';
                Editable = false;
            }

        }
        addafter("Planned Delivery Date")
        {
            field("MIR Due Date"; Rec."MIR Due Date")
            {
                ApplicationArea = All;
            }
            field("MIR Comments"; Rec."MIR Comments")
            {
                ApplicationArea = All;
            }
            field("Requested By"; Rec."Requested By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the person who requested the MIR.';
            }
            field("MIR Status"; Rec."MIR Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the status of the MIR.';
            }
            field("MIR Approval By"; Rec."MIR Approval By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the person who approved the MIR.';
            }
            field("MIR Approval Date"; Rec."MIR Approval Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the MIR was approved.';
            }

        }
        modify(Type)
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
        }
        modify("No.")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);


            trigger OnAfterValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ProjectLine: Record "Job Planning Line";
                ProjectLineunitCost: Decimal;
                PurchLineunitCost: Decimal;
                ProjectLocationCode: code[20];//added on 07/05/2025
                ProjectDim1: Code[20];
                ProjectDim2: Code[20];
                ProjectDim3: Code[20];
                ProjectDim4: Code[20];
                ProjectDim5: Code[20];
                ProjectDim6: Code[20];
                CostVariationLOG: Record "Cost Variation LOG";
            begin
                ProjectLineunitCost := 0;
                PurchLineunitCost := 0;
                ProjectLocationCode := '';//added on 07/05/2025
                ProjectDim1 := '';
                ;
                ProjectDim2 := '';
                ;
                ProjectDim3 := '';
                ;
                ProjectDim4 := '';
                ;
                ProjectDim5 := '';
                ;
                ProjectDim6 := '';
                ;
                Clear(PurchaseLine);
                IF PurchaseLine.get(PurchaseLine."Document Type"::Order, Rec."MASQ Purchase Order No.", Rec."MASQ Purchase Order Line No.") then begin
                    IF Rec."No." <> '' then begin
                        IF Rec."No." <> PurchaseLine."No." then begin
                            IF Confirm(StrSubstNo('Warninig! the Item Number in the sales Line is different from the purchase %1 line %2. Do you want to update the item Number on the Purchase Line too?', Rec."MASQ Purchase Order No.", Rec."MASQ Purchase Order Line No.")) then begin
                                IF ProjectLine.Get(PurchaseLine."Job No.", PurchaseLine."Job Task No.", PurchaseLine."Job Planning Line No.") then begin
                                    ProjectLineunitCost := ProjectLine."Unit Cost";//added on 07/05/2025
                                    ProjectLocationCode := ProjectLine."Location Code";//added on 07/05/2025
                                    ProjectDim1 := ProjectLine."Shortcut Dimension 1 Code";
                                    ProjectDim2 := ProjectLine."Shortcut Dimension 2 Code";
                                    ProjectDim3 := ProjectLine."Shortcut Dimension 3 Code";
                                    ProjectDim4 := ProjectLine."Shortcut Dimension 4 Code";
                                    ProjectDim5 := ProjectLine."Shortcut Dimension 5 Code";
                                    ProjectDim6 := ProjectLine."Shortcut Dimension 6 Code";

                                    ProjectLine.Validate("No.", Rec."No.");
                                    ProjectLine.Validate("Unit Price", Rec."Unit Price");//added on 07/05/2025

                                    IF (ProjectLocationCode <> '') and (ProjectLine."Location Code" = '') then//added on 07/05/2025
                                        ProjectLine.Validate("Location Code", ProjectLocationCode);

                                    IF (ProjectDim1 <> '') and (ProjectLine."Shortcut Dimension 1 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 1 Code", ProjectDim1);

                                    IF (ProjectDim2 <> '') and (ProjectLine."Shortcut Dimension 2 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 2 Code", ProjectDim2);

                                    IF (ProjectDim3 <> '') and (ProjectLine."Shortcut Dimension 3 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 3 Code", ProjectDim3);

                                    IF (ProjectDim4 <> '') and (ProjectLine."Shortcut Dimension 4 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 4 Code", ProjectDim4);

                                    IF (ProjectDim5 <> '') and (ProjectLine."Shortcut Dimension 5 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 5 Code", ProjectDim5);

                                    IF (ProjectDim6 <> '') and (ProjectLine."Shortcut Dimension 6 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 6 Code", ProjectDim6);


                                    IF ProjectLineunitCost <> 0 then//added on 07/05/2025
                                        ProjectLine.Validate("Unit Cost", ProjectLineunitCost);//added on 07/05/2025

                                    ProjectLine.Modify();
                                end;


                                PurchaseLine.Validate("No.", Rec."No.");
                                PurchaseLine.Modify();

                                CostVariationLOG.Init();
                                CostVariationLOG."Item Number" := Rec."No.";
                                CostVariationLOG."old Item number" := xRec."No.";
                                CostVariationLOG."new Item number" := Rec."No.";
                                CostVariationLOG."SO Number" := Rec."Document No.";
                                CostVariationLOG."SO Line Number" := Rec."Line No.";
                                CostVariationLOG."Project No." := Rec."Job No.";
                                CostVariationLOG."Project planning Line No." := Rec."Job Planning Line No.";
                                CostVariationLOG."Created By" := UserId;
                                CostVariationLOG.Insert(true);

                            end;
                        end;
                    end;
                end;
            end;
        }


        modify("Meg No. 2")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
        }
        modify("Meg Vendor Item Code")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
        }
        modify("Meg Item Type")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
        }
        modify("Item Reference No.")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
            ;
        }
        modify(Description)
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
            ;
        }
        modify("Unit of Measure Code")

        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);

        }
        modify("Unit Price")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
            trigger OnAfterValidate()
            var
                CostVariationLOG: Record "Cost Variation LOG";
            begin
                if xRec."Unit Price" <> 0 then begin
                    CostVariationLOG.Init();
                    CostVariationLOG."Item Number" := Rec."No.";
                    CostVariationLOG."New Price" := Rec."Unit Price";
                    CostVariationLOG."Old Price" := xRec."Unit Price";
                    CostVariationLOG."SO Number" := Rec."Document No.";
                    CostVariationLOG."SO Line Number" := Rec."Line No.";
                    CostVariationLOG."Project No." := Rec."Job No.";
                    CostVariationLOG."Project planning Line No." := Rec."Job Planning Line No.";
                    CostVariationLOG."Created By" := UserId;
                    CostVariationLOG.Insert(true);
                end;
            end;
        }
        modify("Line Amount")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
            ;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
            ;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines);
            ;
        }
        modify(ShortcutDimCode3)
        { Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines); }
        modify(ShortcutDimCode4)
        { Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines); }
        modify(ShortcutDimCode6)
        { Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines); }
        modify(ShortcutDimCode5)
        { Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines); }
        modify(ShortcutDimCode7)
        { Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines); }
        modify(ShortcutDimCode8)
        { Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines); }
        modify("Location Code")//added on 26/03/2025
        { Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines); }
        //AN 03/14/25 +
        modify("Qty. to Ship")
        {
            Caption = 'Qty. to Deliver';
        }
        modify("Quantity Shipped")
        {
            Caption = 'Qty Delivered';
        }
        //AN 03/14/25 -
        addafter("Meg Item Type")
        {
            field("MASQ Purchase Order No."; Rec."MASQ Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Purchase Order No. field.', Comment = '%';
                Editable = false;


                trigger OnLookup(var Text: Text): Boolean
                var
                    Purchaseline: Record "Purchase Line";

                begin
                    Clear(Purchaseline);
                    Purchaseline.SetRange("Document No.", Rec."MASQ Purchase Order No.");
                    Purchaseline.SetRange("Line No.", Rec."MASQ Purchase Order Line No.");
                    page.Run(page::"Purchase Lines", Purchaseline);

                end;
            }
            field("MASQ Purchase Order Line No."; Rec."MASQ Purchase Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Purchase Order Line No. field.', Comment = '%';
                Editable = false;
                trigger OnLookup(var Text: Text): Boolean
                var
                    Purchaseline: Record "Purchase Line";

                begin
                    Clear(Purchaseline);
                    Purchaseline.SetRange("Document No.", Rec."MASQ Purchase Order No.");
                    Purchaseline.SetRange("Line No.", Rec."MASQ Purchase Order Line No.");
                    page.Run(page::"Purchase Lines", Purchaseline);

                end;
            }
            field("Line is Splitted"; Rec."Line is Splitted")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Line is Splitted field.', Comment = '%';
            }
            field("Splitted Line No."; Rec."Splitted Line No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Splitted Line No. field.', Comment = '%';
            }
            field("PO Line No."; Rec."Original PO Line No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the PO Line No. field.', Comment = '%';
            }
            field("Original Line No."; Rec."Original Line No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Original Line No. field.', Comment = '%';
            }
            field("Batch Number"; Rec."Batch Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch Number field.', Comment = '%';
                Editable = false;
            }
        }
        modify(Quantity)//moved from Table extension
        {
            Editable = (Rec."MASQ Purchase Order No." = '') OR (CanEditPO_SO_Lines) AND ((Rec."Line is Splitted" = false));
            trigger OnAfterValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ProjectLine: Record "Job Planning Line";
                ProjectLineunitCost: Decimal;
                JobPlanningLineInvoice: Record "Job Planning Line Invoice";
                CostVariationLOG: Record "Cost Variation LOG";
            begin
                ProjectLineunitCost := 0;
                IF (NOT CanEditPO_SO_Lines) then
                    if REc."MASQ Purchase Order Line No." <> 0 then
                        Error(Text002, REc.FieldCaption(Quantity), Rec."MASQ Purchase Order No.", Rec."MASQ Purchase Order Line No.");

                Clear(PurchaseLine);
                IF PurchaseLine.get(PurchaseLine."Document Type"::Order, Rec."MASQ Purchase Order No.", Rec."MASQ Purchase Order Line No.") then begin
                    IF Rec.Quantity <> 0 then begin
                        IF Rec.Quantity <> PurchaseLine.Quantity then begin
                            IF Confirm(StrSubstNo('Warninig! the quantity in the sales %1 line %2 is different from the purchase line. Do you want to update the Quantity on the Purchase Line too?',
                                  Rec."MASQ Purchase Order No.", Rec."MASQ Purchase Order Line No.")) then begin
                                //ADDED on 13/01/2025

                                Clear(ProjectLine);
                                ProjectLine.Get(PurchaseLine."Job No.", PurchaseLine."Job Task No.", PurchaseLine."Job Planning Line No.");
                                ProjectLineunitCost := ProjectLine."Unit Cost";//added on 02/04/2025
                                Clear(JobPlanningLineInvoice);
                                JobPlanningLineInvoice.SetRange("Job No.", ProjectLine."Job No.");
                                JobPlanningLineInvoice.SetRange("Job Task No.", ProjectLine."Job Task No.");
                                JobPlanningLineInvoice.SetRange("Job Planning line No.", ProjectLine."Line No.");
                                // JobPlanningLineInvoice.SetRange("Document Type", PurchaseLine."Document Type");
                                // JobPlanningLineInvoice.SetRange("Document No.", PurchaseLine."Document No.");
                                //JobPlanningLineInvoice.Get(ProjectLine."Job No.", ProjectLine."Job Task No.", ProjectLine."Line No.", PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Line No.");
                                IF JobPlanningLineInvoice.FindFirst()
                                then begin
                                    JobPlanningLineInvoice.Validate("Quantity Transferred", Rec.Quantity);
                                    JobPlanningLineInvoice.Modify();
                                end;
                                ProjectLine.Validate(Quantity, Rec.Quantity);
                                ProjectLine.Validate("Unit Price", Rec."Unit Price");
                                IF ProjectLineunitCost <> 0 then//added on 02/04/2025
                                    ProjectLine.Validate("Unit Cost", ProjectLineunitCost);//added on 02/04/2025
                                ProjectLine.Validate("Remaining Qty.");
                                ProjectLine.Modify();



                                //

                                PurchaseLine.Validate(Quantity, Rec.Quantity);
                                PurchaseLine.Modify();

                                CostVariationLOG.Init();
                                CostVariationLOG."Item Number" := Rec."No.";
                                CostVariationLOG."old Quantity" := XRec.Quantity;
                                CostVariationLOG."new Quantity" := Rec.Quantity;
                                CostVariationLOG."SO Number" := Rec."Document No.";
                                CostVariationLOG."SO Line Number" := Rec."Line No.";
                                CostVariationLOG."Project No." := Rec."Job No.";
                                CostVariationLOG."Project planning Line No." := Rec."Job Planning Line No.";
                                CostVariationLOG."Created By" := UserId;
                                CostVariationLOG.Insert(true);

                            end;
                        end;
                    end;
                end;
            end;


        }
    }


    actions
    {
        // Add changes to page actions here
        addafter
        (BlanketOrder)
        {
            action("Open PO")
            {

                Image = Purchase;
                ApplicationArea = All;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, Rec."MASQ Purchase Order No.");
                    page.Run(page::"Purchase Order", PurchaseHeader);
                end;

            }
        }
        addbefore("F&unctions")
        {
            action("Move Up")
            {
                Caption = 'Move Up';
                ApplicationArea = All;
                Image = MoveUp;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Move current line up.';

                trigger OnAction()
                begin
                    MoveLine(-1);
                end;
            }
            action("Move Down")
            {
                Caption = 'Move Down';
                ApplicationArea = All;
                Image = MoveDown;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Move current line down.';

                trigger OnAction()
                begin
                    MoveLine(1);
                end;
            }
        }
    }
    local procedure SplitSOLines()
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        SalesLine4: Record "Sales Line";//added by AI on 17/04/2025
        LineSpacing: Integer;

        LinesSplitted: Boolean;

        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
    begin
        Rec.TestField("Quantity Shipped", 0);
        LinesSplitted := false;
        Rec.TestField("Qty to Split");
        IF Rec."Qty to Split" > Rec.Quantity then
            Error('Quantity shipped must be less than Quantity');
        Rec.TestField("Job No.");
        IF Rec."Line is Splitted" = false then begin
            Rec."Original Quantity" := Rec.Quantity;
            Rec."Original Line No." := Rec."Line No.";
            REc."Splitted Line No." := FORMAT(Rec."Line No.") + '0.1';
        end;
        //splitted line
        IF (Rec."Qty to Split" < Rec.Quantity) and (Rec."MASQ Purchase Order No." = '') and (Rec."Job No." <> '') then begin
            SalesLine.Init();
            SalesLine.Copy(Rec);
            SalesLine."Skip Line Checking " := true;
            // EVALUATE(SalesLine."Line No.", IncStr(FORMAT(Rec."Line No.")));// + 1;//commented by AI on 17/04/2025 reason adding only 1 to the split line Number is showing error 'There is not enough space to insert correction lines.' on undo shipment

            //added by AI on 17/04/2025
            LineSpacing := 0;
            Clear(SalesLine4);
            SalesLine4.SetRange("Document Type", SalesLine4."Document Type"::Order);
            SalesLine4.SetRange("Document No.", Rec."Document No.");
            SalesLine4."Document Type" := Rec."Document Type";
            SalesLine4."Document No." := Rec."Document No.";
            SalesLine4."Line No." := Rec."Line No.";
            SalesLine4.Find('=');
            if SalesLine4.Find('>') then begin
                LineSpacing := (SalesLine4."Line No." - Rec."Line No.") div 2;
            end else
                LineSpacing := 10000;

            SalesLine."Line No." := Rec."Line No." + LineSpacing;

            SalesLine.Validate(Quantity, SalesLine.Quantity - Rec."Qty to Split");
            SalesLine."Qty to Split" := 0;

            //SalesLine."Remaining Quantity Shipped" := SalesLine."Original Quantity" - SalesLine2."Quantity Shipped";
            SalesLine."Line is Splitted" := true;
            SalesLine."Splitted Line No." := IncStr(SalesLine."Splitted Line No.");
            SalesLine."Skip Line Checking " := false;
            SalesLine.Insert();

            LinesSplitted := true;
        end;


        Clear(SalesLine2);
        SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Order);
        SalesLine2.SetRange("Document No.", Rec."Document No.");
        SalesLine2.SetRange("Original Line No.", Rec."Original Line No.");
        SalesLine2.CalcSums("Qty to Split");

        Clear(SalesLine3);
        SalesLine3.SetRange("Document Type", SalesLine3."Document Type"::Order);
        SalesLine3.SetRange("Document No.", Rec."Document No.");
        SalesLine3.SetRange("Original Line No.", Rec."Original Line No.");
        //    PurchaseLine3.CalcSums("Quantity Shipped");
        //   Message(Format(PurchaseLine2."Quantity Shipped"));



        //line being modified
        Rec."Remaining Quantity Shipped" := Rec."Original Quantity" - SalesLine2."Qty to Split";
        IF LinesSplitted then begin
            Rec."Skip Line Checking " := true;
            Rec.Validate(Quantity, Rec."Qty to Split");
            rec."Line is Splitted" := true;
            Rec."Skip Line Checking " := false;
            REc.Modify();
        end;
        //  Rec."Disable fields after Shipping" := true;
        Rec."Remaining Quantity Shipped" := Rec."Original Quantity" - SalesLine2."Qty to Split" - Rec."Qty to Split";
        REc.Modify();


        SalesLine3.ModifyAll("Remaining Quantity Shipped", Rec."Original Quantity" - SalesLine2."Qty to Split" - Rec."Qty to Split");

        CurrPage.Update();
    end;

    trigger OnOpenPage()
    var
    begin
        Clear(UserSetup);
        UserSetup.Get(UserId);
        CanEditPO_SO_Lines := UserSetup."Can Edit SO/PO Details";
        visibleQTYSplit := UserSetup."Can Split SO";
    end;

    procedure MoveLine(Direction: Integer)
    var
        SalesLine: Record "Sales Line";
        SwapLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line";
        TempSwapLine: Record "Sales Line";
        TempLineNo: Integer;
        FilterOperator: Text;
    begin
        if Direction = 0 then
            exit;

        SalesLine := Rec;
        SalesLine.LockTable();

        SwapLine.Reset();
        SwapLine.SetRange("Document Type", SalesLine."Document Type");
        SwapLine.SetRange("Document No.", SalesLine."Document No.");

        if Direction = -1 then
            FilterOperator := '<%1'
        else
            FilterOperator := '>%1';

        SwapLine.SetFilter("Line No.", StrSubstNo(FilterOperator, SalesLine."Line No."));
        // SwapLine.SetFilter(Type, '<>%1', SwapLine.Type::" "); // Optional

        if Direction = -1 then begin
            if SwapLine.FindLast() then begin
                // Copy data
                TempSalesLine := SalesLine;
                TempSwapLine := SwapLine;

                // Swap line numbers
                TempLineNo := TempSalesLine."Line No.";
                TempSalesLine."Line No." := TempSwapLine."Line No.";
                TempSwapLine."Line No." := TempLineNo;

                // Delete originals
                SalesLine.Delete();
                SwapLine.Delete();

                // Insert new
                TempSwapLine.Insert();
                TempSalesLine.Insert();

                CurrPage.Update(false);
            end;
        end else begin
            if SwapLine.FindFirst() then begin
                // Copy data
                TempSalesLine := SalesLine;
                TempSwapLine := SwapLine;

                // Swap line numbers
                TempLineNo := TempSalesLine."Line No.";
                TempSalesLine."Line No." := TempSwapLine."Line No.";
                TempSwapLine."Line No." := TempLineNo;

                // Delete originals
                SalesLine.Delete();
                SwapLine.Delete();

                // Insert new
                TempSwapLine.Insert();
                TempSalesLine.Insert();

                CurrPage.Update(false);
            end;
        end;
    end;

    var
        Text002: Label 'You can''t change %1 because the order line is associated with purchase order %2 line %3.', Comment = '%1=field name, %2=Document No., %3=Line No.';
        UserSetup: Record "User Setup";
        CanEditPO_SO_Lines: Boolean;
        visibleQTYSplit: Boolean;
}