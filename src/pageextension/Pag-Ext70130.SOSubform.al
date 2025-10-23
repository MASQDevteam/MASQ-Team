pageextension 70130 "SO Subform" extends "Sales Order Subform"
{
    layout
    {
        //FQ MASQ **START**
        addafter("No.")
        {
            field("Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                ApplicationArea = All;
                Visible = true;
                Editable = CanEditCustomerFields;
            }
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
                Visible = true;
                Editable = CanEditCustomerFields;
            }

        }
        //FQ MASQ **END**
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

        //NB MASQ Start
        addafter("No.")
        {
            field("Available Inventory"; Rec."Available Inventory")
            {
                ApplicationArea = All;
            }
        }
        //NB MASQ End

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
                ToolTip = 'Move up line fixeble.';

                trigger OnAction()
                begin
                    HandleMoveAction(-1);//FQ MASQ
                end;
            }
            action("Move Down")
            {
                Caption = 'Move Down';
                ApplicationArea = All;
                Image = MoveDown;
                ToolTip = 'Move Down line fixeble.';

                trigger OnAction()
                begin
                    HandleMoveAction(1);//FQ MASQ
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
        CanEditCustomerFields := UserSetup."Can View SO Customer Fields";//FQ MASQ
    end;

    //NB MASQ Start
    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        if Item.Get(Rec."No.") then begin
            Item.CalcFields(Inventory);
            Rec.Validate("Available Inventory", Item.Inventory);
        end;
    end;
    //NB MASQ End

    //FQ MASQ ** START
    local procedure HandleMoveAction(Direction: Integer)
    var
        MenuChoice: Integer;
        Steps: Integer;
        TargetPos: Integer;
        CountLines: Integer;
        Lines: Record "Sales Line";
        OptionsTxt: Text;
        i: Integer;
    begin
        if Direction = 0 then
            exit;

        // Determine total lines for the current document
        Lines.Reset();
        Lines.SetRange("Document Type", Rec."Document Type");
        Lines.SetRange("Document No.", Rec."Document No.");
        if Lines.FindSet() then begin
            repeat
                CountLines += 1;
            until Lines.Next() = 0;
        end;

        MenuChoice := StrMenu('Move by 1,Move by 3,Move by 5,Move by 10,Move to position,Cancel', 1);
        case MenuChoice of
            1:
                MoveLineFlexible(Direction, 1, 0);
            2:
                MoveLineFlexible(Direction, 3, 0);
            3:
                MoveLineFlexible(Direction, 5, 0);
            4:
                MoveLineFlexible(Direction, 10, 0);
            5:
                begin
                    if CountLines <= 1 then
                        exit;

                    OptionsTxt := '';
                    i := 0;
                    Lines.Reset();
                    Lines.SetCurrentKey("Document Type", "Document No.", "Line No.");
                    Lines.SetRange("Document Type", Rec."Document Type");
                    Lines.SetRange("Document No.", Rec."Document No.");
                    if Lines.FindSet() then
                        repeat
                            i += 1;
                            if i = 1 then
                                OptionsTxt := StrSubstNo('%1 - %2 - %3', Format(i), Lines."No.", Format(Lines."Meg Item Type"))
                            else
                                OptionsTxt := StrSubstNo('%1,%2', OptionsTxt, StrSubstNo('%1 - %2 - %3', Format(i), Lines."No.", Format(Lines."Meg Item Type")));
                        until Lines.Next() = 0;
                    TargetPos := StrMenu(OptionsTxt, 1);
                    if TargetPos > 0 then
                        MoveLineFlexible(Direction, 0, TargetPos);
                end;
            else
                exit;
        end;
    end;
procedure MoveLineFlexible(Direction: Integer; Steps: Integer; TargetPos: Integer)
var
    SalesLines: Record "Sales Line";
    TempSalesLines: Record "Sales Line" temporary;
    LineToMoveNo: Integer;
    LineNos: List of [Integer];
    i, CurrentIndex, TargetIndex, Count: Integer;
    TempBase: Integer;
    LineNoStep: Integer;
begin
    // Basic validation
    if Rec."Document No." = '' then
        exit;

    // Collect all lines for current document
    SalesLines.Reset();
    SalesLines.SetRange("Document Type", Rec."Document Type");
    SalesLines.SetRange("Document No.", Rec."Document No.");
    SalesLines.SetCurrentKey("Line No.");
    if not SalesLines.FindSet() then
        exit;

    // Build ordered line number list
    repeat
        LineNos.Add(SalesLines."Line No.");
    until SalesLines.Next() = 0;

    Count := LineNos.Count();
    if Count <= 1 then
        exit;

    // Identify current line position
    LineToMoveNo := Rec."Line No.";
    for i := 1 to Count do
        if LineNos.Get(i) = LineToMoveNo then begin
            CurrentIndex := i;
            break;
        end;

    if CurrentIndex = 0 then
        exit;

    // Determine target index
    if TargetPos > 0 then
        TargetIndex := TargetPos
    else begin
        if Steps = 0 then
            Steps := 1;
        TargetIndex := CurrentIndex + (Direction * Steps);
    end;

    // Bound the target position
    if TargetIndex < 1 then
        TargetIndex := 1;
    if TargetIndex > Count then
        TargetIndex := Count;

    // Nothing to move if same position
    if TargetIndex = CurrentIndex then
        exit;

    // Rebuild order in memory
    // 1. Remove current line no
    LineNos.RemoveAt(CurrentIndex);
    // 2. Insert at new target position
    LineNos.Insert(TargetIndex, LineToMoveNo);

    // Prepare constants
    TempBase := 500000000;
    LineNoStep := 10000;

    // Lock for concurrency safety
    SalesLines.LockTable();

    // Copy all lines into temporary table in new order
    for i := 1 to Count do begin
        SalesLines.Reset();
        SalesLines.SetRange("Document Type", Rec."Document Type");
        SalesLines.SetRange("Document No.", Rec."Document No.");
        SalesLines.SetRange("Line No.", LineNos.Get(i));
        if SalesLines.FindFirst() then begin
            TempSalesLines.Init();
            TempSalesLines.TransferFields(SalesLines, true);
            TempSalesLines."Line No." := TempBase + (i * LineNoStep);
            TempSalesLines.Insert();
        end;
    end;

    // Delete all existing lines for this document
    SalesLines.Reset();
    SalesLines.SetRange("Document Type", Rec."Document Type");
    SalesLines.SetRange("Document No.", Rec."Document No.");
    if SalesLines.FindSet(true) then
        repeat
            SalesLines.Delete();
        until SalesLines.Next() = 0;

    // Reinsert lines from temporary in final 10000 spacing
    if TempSalesLines.FindSet() then begin
        i := 0;
        repeat
            i += 1;
            SalesLines.Init();
            SalesLines.TransferFields(TempSalesLines, true);
            SalesLines."Line No." := i * LineNoStep;
            SalesLines.Insert();
        until TempSalesLines.Next() = 0;
    end;

    CurrPage.Update(false);
end;


    //FQ MASQ ** END

    var
        Text002: Label 'You can''t change %1 because the order line is associated with purchase order %2 line %3.', Comment = '%1=field name, %2=Document No., %3=Line No.';
        UserSetup: Record "User Setup";
        CanEditPO_SO_Lines: Boolean;
        visibleQTYSplit: Boolean;
        CanEditCustomerFields: Boolean;
}