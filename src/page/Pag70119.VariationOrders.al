page 70119 "Variation Orders"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Variation Order";
    //  Editable = false;
    SourceTableView = sorting(Number, executed, status);

    layout
    {
        area(Content)
        {
            repeater("Variation Order")
            {
                // Editable = false;
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the value of the Number field.', Comment = '%';
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
                }
                field("Item Number"; Rec."Item Number")
                {
                    ToolTip = 'Specifies the value of the Item Number field.', Comment = '%';
                }
                field("Vendor Item Code"; Rec."Vendor Item Code")
                {
                    ToolTip = 'Specifies the value of the Vendor Item Code field.', Comment = '%';
                }
                field("Variation Action(Replace Item)"; Rec."Variation Action(Replace Item)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Replace Item) field.', Comment = '%';
                }
                field("New Item Number"; Rec."New Item Number")
                {
                    ToolTip = 'Specifies the value of the New Itew Number field.', Comment = '%';
                    //  Visible = Rec."Variation Action(Change Price)";
                }
                field("New Vendor Item Code"; Rec."New Vendor Item Code")
                {
                    ToolTip = 'Specifies the value of the New Vendor Item Code field.', Comment = '%';
                }
                field("Variation Action(Change UOM)"; Rec."Variation Action(Change UOM)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Change UOM) field.', Comment = '%';

                }
                field("New UOM"; Rec."New UOM")
                {
                    ToolTip = 'Specifies the value of the New UOM field.', Comment = '%';
                    //  Visible = Rec."Variation Action(Change UOM)";
                }
                field("Variation Action(Change Qty)"; Rec."Variation Action(Change Qty)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Change Qty) field.', Comment = '%';
                }
                field("New Qty"; Rec."New Qty")
                {
                    ToolTip = 'Specifies the value of the New Qty field.', Comment = '%';
                }
                field("Variation Action(Change Price)"; Rec."Variation Action(Change Price)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Change Price) field.', Comment = '%';
                }
                field("New Price"; Rec."New Price")
                {
                    ToolTip = 'Specifies the value of the New Price field.', Comment = '%';
                }
                field("Variation Action(Change Cost)"; Rec."Variation Action(Change Cost)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Change Cost) field.', Comment = '%';
                }
                field("New Cost"; Rec."New Cost")
                {
                    ToolTip = 'Specifies the value of the New Cost field.', Comment = '%';
                }
                field("Variation Action(Add Item)"; Rec."Variation Action(Add Item)")
                {
                    ToolTip = 'Specifies the value of the Variation Action(Add Item) field.', Comment = '%';
                }
                field("Cost Status"; Rec."Cost Status")
                {
                    ToolTip = 'Specifies the value of the Cost Status field.', Comment = '%';
                }
                field("MASQ Item Type"; Rec."MASQ Item Type")//added on 25/03/2025
                {
                    ToolTip = 'Specifies the value of the MASQ Item Type field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field(Executed; Rec.Executed)
                {
                    ToolTip = 'Specifies the value of the Executed field.', Comment = '%';
                    Editable = false;
                    Enabled = false;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.', Comment = '%';
                    Editable = false;
                    Enabled = false;
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order Line No. field.', Comment = '%';
                    Editable = false;
                    Enabled = false;
                }
                field("Job Category"; Rec."Job Category")
                {
                    ApplicationArea = All;
                }
                field("PM Approval Required"; Rec."PM Approval Required")
                {
                    ApplicationArea = All;
                }
                field("Apollo project Number"; Rec."Apollo project Number")
                {
                    ToolTip = 'Specifies the value of the Apollo project Number field.', Comment = '%';
                }
                field("Email Address"; Rec."Email Address")
                {
                    ToolTip = 'Specifies the value of the Email Address field.', Comment = '%';
                }
            }
        }

        //AN 03/06/25
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Variation Order"),
                             "No." = field(Number);
                // "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Varition Order")
            {
                //NB MASQ Start
                action("Execute VO")
                {
                    Image = ExecuteBatch;
                    trigger OnAction()
                    var
                        SalesOrderLine: Record "Sales Line";
                        SalesOrderLinepage: Page "Sales Lines";
                        PurchaseOrderLine: Record "Purchase Line";
                        SupplyChainLog: Record "Supply Chain LOG";
                        NewSalesOrderLine: Record "Sales Line";
                        NewPurchaseOrderLine: Record "Purchase Line";
                        PO: Record "Purchase Header";
                        ProjectPlanningLine: Record "Job Planning Line";
                        "JobPlanningLineInvoice": Record "Job Planning Line Invoice";
                        PurchaseRequestLine: Record "Purchase Request Line";
                        NewProjectPlanningLines: Record "Job Planning Line";
                        CurrencyExchangeRate: Record "Currency Exchange Rate";
                        NewJobPlanningLineInvoice: Record "Job Planning Line Invoice";
                        ProjectLineunitCost: Decimal;
                        PurchLineunitCost: Decimal;
                        ProjectLocationCode: code[20];//added on 28/03/2025
                        ProjectDim1: Code[20];
                        ProjectDim2: Code[20];
                        ProjectDim3: Code[20];
                        ProjectDim4: Code[20];
                        ProjectDim5: Code[20];
                        ProjectDim6: Code[20];
                    begin
                        Rec.TestField(Status, Rec.Status::Released);

                        OldItem := '';
                        OldPrice := 0;
                        OldQuantity := 0;
                        OldUOM := '';
                        OldCost := 0;

                        ProjectLineunitCost := 0;
                        PurchLineunitCost := 0;
                        ProjectLocationCode := '';//added on 28/03/2025

                        ProjectDim1 := '';
                        ProjectDim2 := '';
                        ProjectDim3 := '';
                        ProjectDim4 := '';
                        ProjectDim5 := '';
                        ProjectDim6 := '';

                        Rec.TestField(Executed, false);
                        rec.FilterGroup(4);
                        Clear(SupplyChainLog);

                        IF Rec."Variation Action(Add Item)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New Item Number");
                            rec.TestField("New Qty");
                            REc.TestField("MASQ Item Type");
                            Rec.TestField("Cost Status", Rec."Cost Status"::" ");
                        end;

                        IF Rec."Variation Action(Replace Item)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New Item Number");
                        end;

                        IF Rec."Variation Action(Change UOM)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New UOM");
                        end;

                        IF Rec."Variation Action(Change Qty)" then begin
                            Rec.TestField("Item Number");
                            rec.TestField("New Qty");
                        end;

                        IF Rec."Variation Action(Change Cost)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New Cost");
                            Rec.TestField("Cost Status");
                        end;

                        IF Rec."Variation Action(Change Price)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New Price");
                        end;

                        Clear(SalesOrderLine);
                        SalesOrderLine.SetRange("Document Type", SalesOrderLine."Document Type"::Order);
                        SalesOrderLine.SetRange(Type, SalesOrderLine.Type::Item);
                        SalesOrderLine.SetRange("Job No.", Rec."Project Code");

                        IF NOT rec."Variation Action(Add Item)" then begin
                            SalesOrderLine.SetRange("No.", Rec."Item Number");
                            SalesOrderLine.SetFilter("Quantity Shipped", '%1', 0);
                        end;

                        Clear(SalesOrderLinepage);
                        SalesOrderLinepage.SetTableView(SalesOrderLine);
                        SalesOrderLinepage.LookupMode(true);
                        IF SalesOrderLinepage.RunModal() = Action::LookupOK then begin
                            //sales line splitting
                            SalesOrderLinepage.SetSelectionFilter(SalesOrderLine);
                            if SalesOrderLine.FindFirst() then begin
                                SalesOrderLine."Skip Line Checking " := true;//added before
                                IF (NOT Rec."Variation Action(Add Item)") then
                                    Rec.TestField("Item Number", SalesOrderLine."No.");

                                OldItem := SalesOrderLine."No.";
                                OldPrice := SalesOrderLine."Unit Price";
                                OldQuantity := SalesOrderLine.Quantity;
                                OldUOM := SalesOrderLine."Unit of Measure Code";

                                //section SO
                                Clear(SupplyChainLog);
                                SupplyChainLog.Init();
                                SupplyChainLog."VO Number" := Rec.Number;
                                IF Rec."Variation Action(Replace Item)" then begin
                                    SupplyChainLog."Old Item" := OldItem;
                                    SupplyChainLog."New Item" := Rec."New Item Number";

                                    Clear(ProjectPlanningLine);
                                    ProjectPlanningLine.Get(SalesOrderLine."Job No.", SalesOrderLine."Job Task No.", SalesOrderLine."Job Planning Line No.");
                                    ProjectLineunitCost := ProjectPlanningLine."Unit Cost";//added on 27/03/2025
                                    ProjectLocationCode := ProjectPlanningLine."Location Code";//added on 28/03/2025
                                    ProjectDim1 := ProjectPlanningLine."Shortcut Dimension 1 Code";
                                    ProjectDim2 := ProjectPlanningLine."Shortcut Dimension 2 Code";
                                    ProjectDim3 := ProjectPlanningLine."Shortcut Dimension 3 Code";
                                    ProjectDim4 := ProjectPlanningLine."Shortcut Dimension 4 Code";
                                    ProjectDim5 := ProjectPlanningLine."Shortcut Dimension 5 Code";
                                    ProjectDim6 := ProjectPlanningLine."Shortcut Dimension 6 Code";

                                    ProjectPlanningLine.Validate("No.", Rec."New Item Number");
                                    ProjectPlanningLine.Validate("Unit Price", SalesOrderLine."Unit Price");//added on 22/01/2025

                                    IF (ProjectLocationCode <> '') and (ProjectPlanningLine."Location Code" = '') then//added on 28/03/2025
                                        ProjectPlanningLine.Validate("Location Code", ProjectLocationCode);

                                    IF (ProjectDim1 <> '') and (ProjectPlanningLine."Shortcut Dimension 1 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 1 Code", ProjectDim1);

                                    IF (ProjectDim2 <> '') and (ProjectPlanningLine."Shortcut Dimension 2 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 2 Code", ProjectDim2);

                                    IF (ProjectDim3 <> '') and (ProjectPlanningLine."Shortcut Dimension 3 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 3 Code", ProjectDim3);

                                    IF (ProjectDim4 <> '') and (ProjectPlanningLine."Shortcut Dimension 4 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 4 Code", ProjectDim4);

                                    IF (ProjectDim5 <> '') and (ProjectPlanningLine."Shortcut Dimension 5 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 5 Code", ProjectDim5);

                                    IF (ProjectDim6 <> '') and (ProjectPlanningLine."Shortcut Dimension 6 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 6 Code", ProjectDim6);

                                    IF ProjectLineunitCost <> 0 then//added on 27/03/2025
                                        ProjectPlanningLine.Validate("Unit Cost", ProjectLineunitCost);//added on 27/03/2025

                                    ProjectPlanningLine."VO Number" := Rec.Number;
                                    ProjectPlanningLine.Modify();

                                    SalesOrderLine.Validate("No.", Rec."New Item Number");

                                    //adjust the purchase request //16/01/2025
                                    Clear(PurchaseRequestLine);
                                    PurchaseRequestLine.SetRange("MASQ Sales Order No.", SalesOrderLine."Document No.");
                                    PurchaseRequestLine.SetRange("MASQ Sales Order Line No.", SalesOrderLine."Line No.");
                                    If PurchaseRequestLine.FindFirst() then begin
                                        PurchaseRequestLine.Validate("Item No.", Rec."New Item Number");
                                        PurchaseRequestLine.Modify();
                                    end;

                                    IF Rec."Variation Action(Change UOM)" then
                                        SalesOrderLine.Validate("Unit of Measure Code", Rec."New UOM");
                                    SalesOrderLine."Skip Line Checking " := true;//added on 25/02/2025 to prevent the job sale hcecking 
                                                                                 //   the value is = false after first vo is executed on the same variation order line
                                                                                 //  validating fields is reseting the valie of the skip line checking
                                    ProjectLineunitCost := 0;//added on 02/04/2025

                                    IF Rec."Variation Action(Change Qty)" then begin
                                        SupplyChainLog."Old Qty" := OldQuantity;
                                        SupplyChainLog."New Qty" := Rec."New Qty";

                                        //ADDED on 13/01/2025
                                        Clear(ProjectPlanningLine);
                                        ProjectPlanningLine.Get(SalesOrderLine."Job No.", SalesOrderLine."Job Task No.", SalesOrderLine."Job Planning Line No.");
                                        ProjectLineunitCost := ProjectPlanningLine."Unit Cost";//added on 02/04/2025
                                        ProjectPlanningLine.Validate(Quantity, ProjectPlanningLine.Quantity + (Rec."New Qty" - SalesOrderLine.Quantity));
                                        ProjectPlanningLine.Validate("Unit Price", SalesOrderLine."Unit Price");
                                        IF ProjectLineunitCost <> 0 then//added on 02/04/2025
                                            ProjectPlanningLine.Validate("Unit Cost", ProjectLineunitCost);//added on 02/04/2025
                                        ProjectPlanningLine.Validate("Remaining Qty.");
                                        ProjectPlanningLine."VO Number" := Rec.Number;
                                        ProjectPlanningLine.Modify();

                                        Clear(JobPlanningLineInvoice);
                                        JobPlanningLineInvoice.SetRange("Job No.", ProjectPlanningLine."Job No.");
                                        JobPlanningLineInvoice.SetRange("Job Task No.", ProjectPlanningLine."Job Task No.");
                                        JobPlanningLineInvoice.SetRange("Job Planning line No.", ProjectPlanningLine."Line No.");
                                        IF JobPlanningLineInvoice.FindFirst() then begin
                                            JobPlanningLineInvoice.Validate("Quantity Transferred", JobPlanningLineInvoice."Quantity Transferred" + (Rec."New Qty" - SalesOrderLine.Quantity));
                                            JobPlanningLineInvoice.Modify();
                                        end;

                                        SalesOrderLine.Validate(Quantity, Rec."New Qty");
                                        SalesOrderLine."Skip Line Checking " := true;//added on 25/02/2025

                                        IF Rec."Cost Status" = Rec."Cost Status"::"Absorb Cost" then//16/01/2025
                                            IF Rec."New Qty" > OldQuantity then
                                                SalesOrderLine.Validate("Line Discount Amount", (Rec."New Qty" - OldQuantity) * SalesOrderLine."Unit Price");//to absorrb the cost in case 
                                                                                                                                                             //change the quantity add discount amount and keep the qty changed

                                        //adjust the purchase request //16/01/2025
                                        Clear(PurchaseRequestLine);
                                        PurchaseRequestLine.SetRange("MASQ Sales Order No.", SalesOrderLine."Document No.");
                                        PurchaseRequestLine.SetRange("MASQ Sales Order Line No.", SalesOrderLine."Line No.");
                                        If PurchaseRequestLine.FindFirst() then begin
                                            PurchaseRequestLine.Validate(Quantity, Rec."New Qty");
                                            PurchaseRequestLine.Modify();
                                        end;
                                    end;

                                    SalesOrderLine."Skip Line Checking " := true;//added on 25/02/2025 
                                    IF Rec."Cost Status" = Rec."Cost Status"::"Charge New Cost" then//21/01/2025
                                        IF Rec."Variation Action(Change Price)" then begin
                                            SupplyChainLog."Old Price" := OldPrice;
                                            SupplyChainLog."New Price" := Rec."New Price";
                                            SalesOrderLine.Validate("Unit Price", Rec."New Price");
                                        end;
                                end;

                                //case new item always creat SO and PO lines
                                SalesOrderLine."Skip Line Checking " := true;//added on 25/02/2025
                                IF Rec."Variation Action(Add Item)" then begin
                                    //this section added on 25/03/2025
                                    Clear(NewProjectPlanningLines);
                                    NewProjectPlanningLines.Init();
                                    NewProjectPlanningLines.Validate("Job No.", SalesOrderLine."Job No.");
                                    NewProjectPlanningLines.Validate("Job Task No.", SalesOrderLine."Job Task No.");
                                    NewProjectPlanningLines.Validate("Line No.", GetLastProjectPlanningLineNumber(SalesOrderLine."Job No.", SalesOrderLine."Job Task No.") + 10000);
                                    NewProjectPlanningLines.Insert(true);
                                    NewProjectPlanningLines.Validate("Line Type", NewProjectPlanningLines."Line Type"::"Both Budget and Billable");
                                    NewProjectPlanningLines.Validate(Type, NewProjectPlanningLines.Type::Item);
                                    NewProjectPlanningLines.Validate("No.", Rec."New Item Number");
                                    NewProjectPlanningLines.Validate(Quantity, Rec."New Qty");
                                    NewProjectPlanningLines.Validate("Qty. to Transfer to Invoice", 0);
                                    NewProjectPlanningLines.Validate("Unit Price", Rec."New Price");
                                    NewProjectPlanningLines.Validate("Unit Cost in Vendor Currency", Rec."New Cost");
                                    NewProjectPlanningLines.Validate("Unit Cost", CurrencyExchangeRate.ExchangeAmtFCYToFCY(WorkDate(), Rec."Currency Code", '', Rec."New Cost"));
                                    NewProjectPlanningLines.Validate("Meg Item Type", Rec."MASQ Item Type");
                                    NewProjectPlanningLines.Modify();

                                    NewSalesOrderLine.Init();
                                    NewSalesOrderLine.Copy(SalesOrderLine);
                                    NewSalesOrderLine.Validate("Line No.", GetLAstSalesLineNumber(SalesOrderLine."Document No.") + 1000);
                                    NewSalesOrderLine."Skip Line Checking " := true;//added on 27/03/2025
                                    NewSalesOrderLine.Validate("No.", Rec."New Item Number");
                                    NewSalesOrderLine."Skip Line Checking " := true;//added on 27/03/2025
                                    NewSalesOrderLine.Validate(Quantity, Rec."New Qty");
                                    NewSalesOrderLine.Validate("Unit Price", Rec."New Price");
                                    NewSalesOrderLine.Validate("Job No.", NewProjectPlanningLines."Job No.");//added on 25/03/2025 
                                    NewSalesOrderLine.Validate("Job Task No.", NewProjectPlanningLines."Job Task No.");//added on 25/03/2025 
                                    NewSalesOrderLine.Validate("Job Contract Entry No.", NewProjectPlanningLines."Job Contract Entry No.");//added on 25/03/2025 
                                    NewSalesOrderLine.Validate("Job Planning Line No.", NewProjectPlanningLines."Line No.");//added on 25/03/2025 
                                    NewSalesOrderLine."Meg Item Type" := Rec."MASQ Item Type";
                                    NewSalesOrderLine.Insert();

                                    Clear(NewJobPlanningLineInvoice);
                                    NewJobPlanningLineInvoice.Init();
                                    NewJobPlanningLineInvoice.Validate("Job No.", SalesOrderLine."Job No.");
                                    NewJobPlanningLineInvoice.Validate("Job Task No.", SalesOrderLine."Job Task No.");
                                    NewJobPlanningLineInvoice.Validate("Job Planning Line No.", NewProjectPlanningLines."Line No.");
                                    NewJobPlanningLineInvoice.Validate("Document Type", NewJobPlanningLineInvoice."Document Type"::Order);
                                    NewJobPlanningLineInvoice.Validate("Document No.", NewSalesOrderLine."Document No.");
                                    NewJobPlanningLineInvoice.Validate("Line No.", NewSalesOrderLine."Line No.");
                                    NewJobPlanningLineInvoice.Validate("Quantity Transferred", NewSalesOrderLine.Quantity);
                                    NewJobPlanningLineInvoice.Insert();

                                    IF PurchaseOrderLine.Get(PurchaseOrderLine."Document Type"::Order, SalesOrderLine."MASQ Purchase Order No.", SalesOrderLine."MASQ Purchase Order Line No.") then begin//confition IF added on 25/03/2025
                                        NewPurchaseOrderLine.Init();
                                        NewPurchaseOrderLine.Copy(PurchaseOrderLine);
                                        NewPurchaseOrderLine.Validate("Line No.", GetLastPurchaseLineNumber(PurchaseOrderLine."Document No.") + 1000);
                                        NewPurchaseOrderLine."Job Planning Line No." := 0;
                                        NewPurchaseOrderLine.Validate("No.", Rec."New Item Number");
                                        NewPurchaseOrderLine.Validate(Quantity, Rec."New Qty");
                                        NewPurchaseOrderLine.Validate("Direct Unit Cost", Rec."New Cost");//added on 25/03/2025
                                        NewPurchaseOrderLine.Validate("Job No.", NewProjectPlanningLines."Job No.");//added on 25/03/2025 
                                        NewPurchaseOrderLine.Validate("Job Task No.", NewProjectPlanningLines."Job Task No.");//added on 25/03/2025 
                                        NewPurchaseOrderLine.Validate("Job Line Type", NewPurchaseOrderLine."Job Line Type"::"Both Budget and Billable");//added on 25/03/2025 
                                        NewPurchaseOrderLine.Validate("Job Planning Line No.", NewProjectPlanningLines."Line No.");//added on 25/03/2025 
                                        NewPurchaseOrderLine.Insert(true);

                                        NewSalesOrderLine."MASQ Purchase Order No." := NewPurchaseOrderLine."Document No.";
                                        NewSalesOrderLine."MASQ Purchase Order Line No." := NewPurchaseOrderLine."Line No.";
                                        NewSalesOrderLine."Line is Splitted" := false;
                                        NewSalesOrderLine."Splitted Line No." := '';
                                        NewSalesOrderLine."Original Line No." := 0;
                                        NewSalesOrderLine."Original PO Line No." := 0;
                                        NewSalesOrderLine."Sent to PO" := true;//case create purchase order from sales order already po line created
                                        NewSalesOrderLine.Modify();

                                        Clear(PO);
                                        PO.Get(PO."Document Type"::Order, PurchaseOrderLine."Document No.");
                                        NewPurchaseOrderLine."MASQ Sales Order No." := NewSalesOrderLine."Document No.";
                                        NewPurchaseOrderLine."MASQ Sales Order Line No." := NewSalesOrderLine."Line No.";
                                        NewPurchaseOrderLine."Initial ETA" := PO."Initial ETA";
                                        NewPurchaseOrderLine."Initial ETD" := PO."Initial ETD";
                                        NewPurchaseOrderLine."Initial ETR" := PO."Initial ETR";
                                        NewPurchaseOrderLine."Initial ETAW" := PO."Initial ETAW";
                                        NewPurchaseOrderLine."BL/AWB ID" := '';
                                        NewPurchaseOrderLine."Container ID" := '';
                                        NewPurchaseOrderLine."Quantity Shipped" := 0;
                                        NewPurchaseOrderLine."Remaining Quantity Shipped" := 0;
                                        NewPurchaseOrderLine."Line is Splitted" := false;
                                        NewPurchaseOrderLine."Splitted Line No." := '';
                                        NewPurchaseOrderLine."Original Line No." := 0;
                                        NewPurchaseOrderLine."Original Quantity" := 0;
                                        NewPurchaseOrderLine."Disable fields after Shipping" := false;
                                        NewPurchaseOrderLine."Final ETA" := 0D;
                                        NewPurchaseOrderLine."Final ETR" := 0D;
                                        NewPurchaseOrderLine."Final ETD" := 0D;
                                        NewPurchaseOrderLine."Final ETAW" := 0D;
                                        NewPurchaseOrderLine."ATA" := 0D;
                                        NewPurchaseOrderLine."Container Line No." := 0;
                                        NewPurchaseOrderLine."VO Number" := '';
                                        NewPurchaseOrderLine."Batch Number" := '';
                                        NewPurchaseOrderLine."Job#" := '';//added on 25/02/2025
                                        NewPurchaseOrderLine."Subjob ID" := 0;
                                        NewPurchaseOrderLine."Truck Details ID" := '';
                                        NewPurchaseOrderLine."Truck Details Line No." := 0;
                                        Clear(NewPurchaseOrderLine."Truck WayBill ID"); //:= ''; //NB MASQ
                                        NewPurchaseOrderLine."Meg Item Type" := Rec."MASQ Item Type";
                                        NewPurchaseOrderLine.Modify();

                                        IF Rec."Variation Action(Add Item)" then begin
                                            NewPurchaseOrderLine."VO Number" := Rec.Number;
                                            NewPurchaseOrderLine.Modify(true);
                                        end
                                    end;
                                end;

                                //section PO  case po exsit and linked to the SO  do the VO in the PO lines too
                                Clear(PurchaseOrderLine);
                                PurchaseOrderLine.SetRange("MASQ Sales Order No.", SalesOrderLine."Document No.");
                                PurchaseOrderLine.SetRange("MASQ Sales Order Line No.", SalesOrderLine."Line No.");
                                IF PurchaseOrderLine.FindFirst() then begin
                                    PurchaseOrderLine.TestField("Quantity Received", 0);//ADDED ON 14012025
                                    OldCost := PurchaseOrderLine."Direct Unit Cost";//16/01/2025
                                    IF Rec."Variation Action(Replace Item)" then begin
                                        PurchLineunitCost := PurchaseOrderLine."Direct Unit Cost";//added on 27/03/2025
                                        PurchaseOrderLine.Validate("No.", Rec."New Item Number");

                                        IF (ProjectLocationCode <> '') and (PurchaseOrderLine."Location Code" = '') then//added on 28/03/2025
                                            PurchaseOrderLine.Validate("Location Code", ProjectLocationCode);

                                        IF (ProjectDim1 <> '') and (PurchaseOrderLine."Shortcut Dimension 1 Code" = '') then
                                            PurchaseOrderLine.Validate("Shortcut Dimension 1 Code", ProjectDim1);

                                        IF (ProjectDim2 <> '') and (PurchaseOrderLine."Shortcut Dimension 2 Code" = '') then
                                            PurchaseOrderLine.Validate("Shortcut Dimension 2 Code", ProjectDim2);

                                        PurchaseOrderLine.CalcFields("Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code");

                                        IF (ProjectDim3 <> '') and (PurchaseOrderLine."Shortcut Dimension 3 Code" = '') then
                                            PurchaseOrderLine.ValidateShortcutDimCode(3, ProjectDim3);

                                        IF (ProjectDim4 <> '') and (PurchaseOrderLine."Shortcut Dimension 4 Code" = '') then
                                            PurchaseOrderLine.ValidateShortcutDimCode(4, ProjectDim4);

                                        IF (ProjectDim5 <> '') and (PurchaseOrderLine."Shortcut Dimension 5 Code" = '') then
                                            PurchaseOrderLine.ValidateShortcutDimCode(5, ProjectDim5);

                                        IF (ProjectDim6 <> '') and (PurchaseOrderLine."Shortcut Dimension 6 Code" = '') then
                                            PurchaseOrderLine.ValidateShortcutDimCode(6, ProjectDim6);

                                        IF PurchLineunitCost <> 0 then//added on 27/03/2025
                                            PurchaseOrderLine.Validate("Direct Unit Cost", PurchLineunitCost);

                                        IF Rec."Variation Action(Change UOM)" then
                                            PurchaseOrderLine.Validate("Unit of Measure Code", Rec."New UOM");

                                        IF Rec."Variation Action(Change Qty)" then
                                            IF (PurchaseOrderLine.Quantity = SupplyChainLog."Old Qty") then//only change the quantity if the so line and po line have same quantity
                                                PurchaseOrderLine.Validate(Quantity, Rec."New Qty");

                                        IF Rec."Variation Action(Change Cost)" then begin//16/01/2025 
                                            SupplyChainLog."Old Cost" := OldCost;
                                            SupplyChainLog."New Cost" := Rec."New Cost";
                                            PurchaseOrderLine.Validate("Direct Unit Cost", Rec."New Cost");
                                        end;

                                        PurchaseOrderLine."VO Number" := Rec.Number;
                                        PurchaseOrderLine.Modify(true);
                                    end;
                                end;

                                IF Rec."Variation Action(Add Item)" then begin
                                    NewSalesOrderLine."VO Number" := Rec.Number;
                                    NewSalesOrderLine."Skip Line Checking " := false;
                                    NewSalesOrderLine.Modify(true);
                                    REc."Sales Order No." := NewSalesOrderLine."Document No.";
                                    Rec."Sales Order Line No." := NewSalesOrderLine."Line No.";
                                end else begin
                                    SalesOrderLine."VO Number" := Rec.Number;
                                    SalesOrderLine."Skip Line Checking " := false;
                                    SalesOrderLine.Modify(true);
                                    REc."Sales Order No." := SalesOrderLine."Document No.";
                                    Rec."Sales Order Line No." := SalesOrderLine."Line No.";
                                end;

                                IF Rec."Variation Action(Add Item)" then begin
                                    SupplyChainLog."SO Number" := NewSalesOrderLine."Document No.";
                                    SupplyChainLog."SO Line Number" := NewSalesOrderLine."Line No.";
                                    SupplyChainLog."PO Number" := NewPurchaseOrderLine."Document No.";
                                    SupplyChainLog."PO Line Number" := NewPurchaseOrderLine."Line No.";
                                    SupplyChainLog."Project No." := NewProjectPlanningLines."Job No.";//added on 27/03/2025
                                    SupplyChainLog."Project planning Line No." := NewProjectPlanningLines."Line No.";//added on 27/03/2025
                                    SupplyChainLog.Insert();
                                end else begin
                                    SupplyChainLog."SO Number" := SalesOrderLine."Document No.";
                                    SupplyChainLog."SO Line Number" := SalesOrderLine."Line No.";
                                    SupplyChainLog."PO Number" := PurchaseOrderLine."Document No.";
                                    SupplyChainLog."PO Line Number" := PurchaseOrderLine."Line No.";
                                    SupplyChainLog."Project No." := ProjectPlanningLine."Job No.";//added on 27/03/2025
                                    SupplyChainLog."Project planning Line No." := ProjectPlanningLine."Line No.";//added on 27/03/2025
                                    SupplyChainLog.Insert();
                                end;

                                Rec.Executed := true;
                                Rec.Status := Rec.Status::Executed;
                                Rec.Modify();
                            end;
                        end;
                    end;
                }
                action("Execute VO(SO Only)")
                {
                    Image = ExecuteBatch;
                    trigger OnAction()
                    var
                        SalesOrderLine: Record "Sales Line";
                        SalesOrderLinepage: Page "Sales Lines";
                        SupplyChainLog: Record "Supply Chain LOG";
                        NewSalesOrderLine: Record "Sales Line";
                        PO: Record "Purchase Header";
                        ProjectPlanningLine: Record "Job Planning Line";
                        JobPlanningLineInvoice: Record "Job Planning Line Invoice";
                        PurchaseRequestLine: Record "Purchase Request Line";
                        NewProjectPlanningLines: Record "Job Planning Line";
                        CurrencyExchangeRate: Record "Currency Exchange Rate";
                        NewJobPlanningLineInvoice: Record "Job Planning Line Invoice";
                        ProjectLineunitCost: Decimal;
                        PurchLineunitCost: Decimal;
                        ProjectLocationCode: code[20];//added on 28/03/2025
                        ProjectDim1: Code[20];
                        ProjectDim2: Code[20];
                        ProjectDim3: Code[20];
                        ProjectDim4: Code[20];
                        ProjectDim5: Code[20];
                        ProjectDim6: Code[20];
                    begin
                        Rec.TestField(Status, Rec.Status::Released);

                        OldItem := '';
                        OldPrice := 0;
                        OldQuantity := 0;
                        OldUOM := '';
                        OldCost := 0;

                        ProjectLineunitCost := 0;
                        PurchLineunitCost := 0;
                        ProjectLocationCode := '';//added on 28/03/2025

                        ProjectDim1 := '';
                        ProjectDim2 := '';
                        ProjectDim3 := '';
                        ProjectDim4 := '';
                        ProjectDim5 := '';
                        ProjectDim6 := '';

                        Rec.TestField(Executed, false);

                        rec.FilterGroup(4);

                        Clear(SupplyChainLog);

                        IF Rec."Variation Action(Add Item)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New Item Number");
                            rec.TestField("New Qty");
                            REc.TestField("MASQ Item Type");
                            Rec.TestField("Cost Status", Rec."Cost Status"::" ");
                        end;

                        IF Rec."Variation Action(Replace Item)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New Item Number");
                        end;

                        IF Rec."Variation Action(Change UOM)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New UOM");
                        end;

                        IF Rec."Variation Action(Change Qty)" then begin
                            Rec.TestField("Item Number");
                            rec.TestField("New Qty");
                        end;

                        IF Rec."Variation Action(Change Cost)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New Cost");
                            Rec.TestField("Cost Status");
                        end;

                        IF Rec."Variation Action(Change Price)" then begin
                            Rec.TestField("Item Number");
                            Rec.TestField("New Price");
                        end;

                        Clear(SalesOrderLine);
                        SalesOrderLine.SetRange("Document Type", SalesOrderLine."Document Type"::Order);
                        SalesOrderLine.SetRange(Type, SalesOrderLine.Type::Item);
                        SalesOrderLine.SetRange("Job No.", Rec."Project Code");

                        IF NOT rec."Variation Action(Add Item)" then begin
                            SalesOrderLine.SetRange("No.", Rec."Item Number");
                            SalesOrderLine.SetFilter("Quantity Shipped", '%1', 0);
                        end;

                        Clear(SalesOrderLinepage);
                        SalesOrderLinepage.SetTableView(SalesOrderLine);
                        SalesOrderLinepage.LookupMode(true);
                        IF SalesOrderLinepage.RunModal() = Action::LookupOK then begin
                            //sales line splitting
                            SalesOrderLinepage.SetSelectionFilter(SalesOrderLine);
                            if SalesOrderLine.FindFirst() then begin
                                SalesOrderLine."Skip Line Checking " := true;//added before
                                IF (NOT Rec."Variation Action(Add Item)") then
                                    Rec.TestField("Item Number", SalesOrderLine."No.");

                                OldItem := SalesOrderLine."No.";
                                OldPrice := SalesOrderLine."Unit Price";
                                OldQuantity := SalesOrderLine.Quantity;
                                OldUOM := SalesOrderLine."Unit of Measure Code";

                                //section SO
                                Clear(SupplyChainLog);
                                SupplyChainLog.Init();
                                SupplyChainLog."VO Number" := Rec.Number;
                                IF Rec."Variation Action(Replace Item)" then begin
                                    SupplyChainLog."Old Item" := OldItem;
                                    SupplyChainLog."New Item" := Rec."New Item Number";
                                    Clear(ProjectPlanningLine);
                                    ProjectPlanningLine.Get(SalesOrderLine."Job No.", SalesOrderLine."Job Task No.", SalesOrderLine."Job Planning Line No.");
                                    ProjectLineunitCost := ProjectPlanningLine."Unit Cost";//added on 27/03/2025
                                    ProjectLocationCode := ProjectPlanningLine."Location Code";//added on 28/03/2025
                                    ProjectDim1 := ProjectPlanningLine."Shortcut Dimension 1 Code";
                                    ProjectDim2 := ProjectPlanningLine."Shortcut Dimension 2 Code";
                                    ProjectDim3 := ProjectPlanningLine."Shortcut Dimension 3 Code";
                                    ProjectDim4 := ProjectPlanningLine."Shortcut Dimension 4 Code";
                                    ProjectDim5 := ProjectPlanningLine."Shortcut Dimension 5 Code";
                                    ProjectDim6 := ProjectPlanningLine."Shortcut Dimension 6 Code";

                                    ProjectPlanningLine.Validate("No.", Rec."New Item Number");
                                    ProjectPlanningLine.Validate("Unit Price", SalesOrderLine."Unit Price");//added on 22/01/2025

                                    IF (ProjectLocationCode <> '') and (ProjectPlanningLine."Location Code" = '') then//added on 28/03/2025
                                        ProjectPlanningLine.Validate("Location Code", ProjectLocationCode);

                                    IF (ProjectDim1 <> '') and (ProjectPlanningLine."Shortcut Dimension 1 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 1 Code", ProjectDim1);

                                    IF (ProjectDim2 <> '') and (ProjectPlanningLine."Shortcut Dimension 2 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 2 Code", ProjectDim2);

                                    IF (ProjectDim3 <> '') and (ProjectPlanningLine."Shortcut Dimension 3 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 3 Code", ProjectDim3);

                                    IF (ProjectDim4 <> '') and (ProjectPlanningLine."Shortcut Dimension 4 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 4 Code", ProjectDim4);

                                    IF (ProjectDim5 <> '') and (ProjectPlanningLine."Shortcut Dimension 5 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 5 Code", ProjectDim5);

                                    IF (ProjectDim6 <> '') and (ProjectPlanningLine."Shortcut Dimension 6 Code" = '') then
                                        ProjectPlanningLine.Validate("Shortcut Dimension 6 Code", ProjectDim6);

                                    IF ProjectLineunitCost <> 0 then//added on 27/03/2025
                                        ProjectPlanningLine.Validate("Unit Cost", ProjectLineunitCost);//added on 27/03/2025

                                    ProjectPlanningLine."VO Number" := Rec.Number;
                                    ProjectPlanningLine.Modify();

                                    SalesOrderLine.Validate("No.", Rec."New Item Number");

                                    //adjust the purchase request //16/01/2025
                                    Clear(PurchaseRequestLine);
                                    PurchaseRequestLine.SetRange("MASQ Sales Order No.", SalesOrderLine."Document No.");
                                    PurchaseRequestLine.SetRange("MASQ Sales Order Line No.", SalesOrderLine."Line No.");
                                    If PurchaseRequestLine.FindFirst() then begin
                                        PurchaseRequestLine.Validate("Item No.", Rec."New Item Number");
                                        PurchaseRequestLine.Modify();
                                    end;

                                    IF Rec."Variation Action(Change UOM)" then
                                        SalesOrderLine.Validate("Unit of Measure Code", Rec."New UOM");
                                    SalesOrderLine."Skip Line Checking " := true;//added on 25/02/2025 to prevent the job sale hcecking 
                                                                                 //   the value is = false after first vo is executed on the same variation order line
                                                                                 //  validating fields is reseting the valie of the skip line checking
                                    ProjectLineunitCost := 0;//added on 02/04/2025

                                    IF Rec."Variation Action(Change Qty)" then begin
                                        SupplyChainLog."Old Qty" := OldQuantity;
                                        SupplyChainLog."New Qty" := Rec."New Qty";

                                        //ADDED on 13/01/2025
                                        Clear(ProjectPlanningLine);
                                        ProjectPlanningLine.Get(SalesOrderLine."Job No.", SalesOrderLine."Job Task No.", SalesOrderLine."Job Planning Line No.");
                                        ProjectLineunitCost := ProjectPlanningLine."Unit Cost";//added on 02/04/2025
                                        ProjectPlanningLine.Validate(Quantity, ProjectPlanningLine.Quantity + (Rec."New Qty" - SalesOrderLine.Quantity));
                                        ProjectPlanningLine.Validate("Unit Price", SalesOrderLine."Unit Price");
                                        IF ProjectLineunitCost <> 0 then//added on 02/04/2025
                                            ProjectPlanningLine.Validate("Unit Cost", ProjectLineunitCost);//added on 02/04/2025
                                        ProjectPlanningLine.Validate("Remaining Qty.");
                                        ProjectPlanningLine."VO Number" := Rec.Number;
                                        ProjectPlanningLine.Modify();

                                        Clear(JobPlanningLineInvoice);
                                        JobPlanningLineInvoice.SetRange("Job No.", ProjectPlanningLine."Job No.");
                                        JobPlanningLineInvoice.SetRange("Job Task No.", ProjectPlanningLine."Job Task No.");
                                        JobPlanningLineInvoice.SetRange("Job Planning line No.", ProjectPlanningLine."Line No.");
                                        IF JobPlanningLineInvoice.FindFirst()
                                        then begin
                                            JobPlanningLineInvoice.Validate("Quantity Transferred", JobPlanningLineInvoice."Quantity Transferred" + (Rec."New Qty" - SalesOrderLine.Quantity));
                                            JobPlanningLineInvoice.Modify();
                                        end;

                                        SalesOrderLine.Validate(Quantity, Rec."New Qty");
                                        SalesOrderLine."Skip Line Checking " := true;//added on 25/02/2025 
                                        IF Rec."Cost Status" = Rec."Cost Status"::"Absorb Cost" then//16/01/2025
                                            IF Rec."New Qty" > OldQuantity then
                                                SalesOrderLine.Validate("Line Discount Amount", (Rec."New Qty" - OldQuantity) * SalesOrderLine."Unit Price");//to absorrb the cost in case 
                                                                                                                                                             //change the quantity add discount amount and keep the qty changed

                                        //adjust the purchase request //16/01/2025
                                        Clear(PurchaseRequestLine);
                                        PurchaseRequestLine.SetRange("MASQ Sales Order No.", SalesOrderLine."Document No.");
                                        PurchaseRequestLine.SetRange("MASQ Sales Order Line No.", SalesOrderLine."Line No.");
                                        If PurchaseRequestLine.FindFirst() then begin
                                            PurchaseRequestLine.Validate(Quantity, Rec."New Qty");
                                            PurchaseRequestLine.Modify();
                                        end;
                                    end;

                                    SalesOrderLine."Skip Line Checking " := true;//added on 25/02/2025

                                    IF Rec."Cost Status" = Rec."Cost Status"::"Charge New Cost" then//21/01/2025
                                        IF Rec."Variation Action(Change Price)" then begin
                                            SupplyChainLog."Old Price" := OldPrice;
                                            SupplyChainLog."New Price" := Rec."New Price";
                                            SalesOrderLine.Validate("Unit Price", Rec."New Price");
                                        end;
                                end;

                                //case new item always creat SO and PO lines
                                SalesOrderLine."Skip Line Checking " := true;//added on 25/02/2025

                                IF Rec."Variation Action(Add Item)" then begin
                                    //this section added on 25/03/2025
                                    Clear(NewProjectPlanningLines);
                                    NewProjectPlanningLines.Init();
                                    NewProjectPlanningLines.Validate("Job No.", SalesOrderLine."Job No.");
                                    NewProjectPlanningLines.Validate("Job Task No.", SalesOrderLine."Job Task No.");
                                    NewProjectPlanningLines.Validate("Line No.", GetLastProjectPlanningLineNumber(SalesOrderLine."Job No.", SalesOrderLine."Job Task No.") + 10000);
                                    NewProjectPlanningLines.Insert(true);
                                    NewProjectPlanningLines.Validate("Line Type", NewProjectPlanningLines."Line Type"::"Both Budget and Billable");
                                    NewProjectPlanningLines.Validate(Type, NewProjectPlanningLines.Type::Item);
                                    NewProjectPlanningLines.Validate("No.", Rec."New Item Number");
                                    NewProjectPlanningLines.Validate(Quantity, Rec."New Qty");
                                    NewProjectPlanningLines.Validate("Qty. to Transfer to Invoice", 0);
                                    NewProjectPlanningLines.Validate("Unit Price", Rec."New Price");
                                    NewProjectPlanningLines.Validate("Unit Cost in Vendor Currency", Rec."New Cost");
                                    NewProjectPlanningLines.Validate("Unit Cost", CurrencyExchangeRate.ExchangeAmtFCYToFCY(WorkDate(), Rec."Currency Code", '', Rec."New Cost"));
                                    NewProjectPlanningLines.Validate("Meg Item Type", Rec."MASQ Item Type");
                                    NewProjectPlanningLines.Modify();

                                    NewSalesOrderLine.Init();
                                    NewSalesOrderLine.Copy(SalesOrderLine);
                                    NewSalesOrderLine.Validate("Line No.", GetLAstSalesLineNumber(SalesOrderLine."Document No.") + 1000);
                                    NewSalesOrderLine."Skip Line Checking " := true;//added on 27/03/2025
                                    NewSalesOrderLine.Validate("No.", Rec."New Item Number");
                                    NewSalesOrderLine."Skip Line Checking " := true;//added on 27/03/2025
                                    NewSalesOrderLine.Validate(Quantity, Rec."New Qty");
                                    NewSalesOrderLine.Validate("Unit Price", Rec."New Price");
                                    NewSalesOrderLine.Validate("Job No.", NewProjectPlanningLines."Job No.");//added on 25/03/2025 
                                    NewSalesOrderLine.Validate("Job Task No.", NewProjectPlanningLines."Job Task No.");//added on 25/03/2025 
                                    NewSalesOrderLine.Validate("Job Contract Entry No.", NewProjectPlanningLines."Job Contract Entry No.");//added on 25/03/2025 
                                    NewSalesOrderLine.Validate("Job Planning Line No.", NewProjectPlanningLines."Line No.");//added on 25/03/2025 
                                    NewSalesOrderLine."Meg Item Type" := Rec."MASQ Item Type";
                                    NewSalesOrderLine.Insert();

                                    //added on 28/04/2025
                                    NewSalesOrderLine."MASQ Purchase Order No." := '';
                                    NewSalesOrderLine."MASQ Purchase Order Line No." := 0;
                                    NewSalesOrderLine."Line is Splitted" := false;
                                    NewSalesOrderLine."Splitted Line No." := '';
                                    NewSalesOrderLine."Original Line No." := 0;
                                    NewSalesOrderLine."Original PO Line No." := 0;
                                    NewSalesOrderLine."Sent to PO" := false;//case create purchase order from sales order already po line created
                                    NewSalesOrderLine.Modify();

                                    Clear(NewJobPlanningLineInvoice);
                                    NewJobPlanningLineInvoice.Init();
                                    NewJobPlanningLineInvoice.Validate("Job No.", SalesOrderLine."Job No.");
                                    NewJobPlanningLineInvoice.Validate("Job Task No.", SalesOrderLine."Job Task No.");
                                    NewJobPlanningLineInvoice.Validate("Job Planning Line No.", NewProjectPlanningLines."Line No.");
                                    NewJobPlanningLineInvoice.Validate("Document Type", NewJobPlanningLineInvoice."Document Type"::Order);
                                    NewJobPlanningLineInvoice.Validate("Document No.", NewSalesOrderLine."Document No.");
                                    NewJobPlanningLineInvoice.Validate("Line No.", NewSalesOrderLine."Line No.");
                                    NewJobPlanningLineInvoice.Validate("Quantity Transferred", NewSalesOrderLine.Quantity);
                                    NewJobPlanningLineInvoice.Insert();
                                end;

                                IF Rec."Variation Action(Add Item)" then begin
                                    NewSalesOrderLine."VO Number" := Rec.Number;
                                    NewSalesOrderLine."Skip Line Checking " := false;
                                    NewSalesOrderLine.Modify(true);
                                    REc."Sales Order No." := NewSalesOrderLine."Document No.";
                                    Rec."Sales Order Line No." := NewSalesOrderLine."Line No.";
                                end else begin
                                    SalesOrderLine."VO Number" := Rec.Number;
                                    SalesOrderLine."Skip Line Checking " := false;
                                    SalesOrderLine.Modify(true);
                                    REc."Sales Order No." := SalesOrderLine."Document No.";
                                    Rec."Sales Order Line No." := SalesOrderLine."Line No.";
                                end;

                                IF Rec."Variation Action(Add Item)" then begin
                                    SupplyChainLog."SO Number" := NewSalesOrderLine."Document No.";
                                    SupplyChainLog."SO Line Number" := NewSalesOrderLine."Line No.";
                                    SupplyChainLog."Project No." := NewProjectPlanningLines."Job No.";//added on 27/03/2025
                                    SupplyChainLog."Project planning Line No." := NewProjectPlanningLines."Line No.";//added on 27/03/2025
                                    SupplyChainLog.Insert();
                                end else begin
                                    SupplyChainLog."SO Number" := SalesOrderLine."Document No.";
                                    SupplyChainLog."SO Line Number" := SalesOrderLine."Line No.";
                                    SupplyChainLog."Project No." := ProjectPlanningLine."Job No.";//added on 27/03/2025
                                    SupplyChainLog."Project planning Line No." := ProjectPlanningLine."Line No.";//added on 27/03/2025
                                    SupplyChainLog.Insert();
                                end;

                                Rec.Executed := true;
                                Rec.Status := Rec.Status::Executed;
                                Rec.Modify();
                            end;
                        end;
                    end;
                }
                //NB MASQ End
                group(Approvals)
                {
                    action(Release)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Re&lease';
                        Image = ReleaseDoc;
                        Enabled = (Rec.Status <> Rec.Status::Released) AND (ChangeStatusofVO);
                        ShortCutKey = 'Ctrl+F9';
                        ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                        trigger OnAction()
                        begin
                            Rec.Status := Rec.Status::Released;
                            CurrPage.Update();
                            ;
                            // Rec.PerformManualRelease();
                            // CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                        end;
                    }
                    action(Reopen)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Re&open';
                        Enabled = (Rec.Status <> Rec.Status::Open) AND (ChangeStatusofVO);
                        Image = ReOpen;
                        ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                        trigger OnAction()
                        var
                            ReleaseSalesDoc: Codeunit "Release Sales Document";
                        begin
                            Rec.Status := Rec.Status::Open;
                            CurrPage.Update();
                            ;
                            //    ReleaseSalesDoc.PerformManualReopen(Rec);
                            //   CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                        end;
                    }
                    action(Reject)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Reject';
                        Enabled = (Rec.Status = Rec.Status::Open) AND (ChangeStatusofVO);
                        Image = ReOpen;
                        ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                        trigger OnAction()
                        var
                            ReleaseSalesDoc: Codeunit "Release Sales Document";
                        begin
                            Rec.Status := Rec.Status::Rejected;
                            CurrPage.Update();
                            ;
                            //    ReleaseSalesDoc.PerformManualReopen(Rec);
                            //   CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                        end;
                    }
                }
            }
            Group("Sales Order")
            {
                action("Open Sales Order")
                {
                    Image = SalesInvoice;
                    trigger OnAction()
                    var

                        SalesOrderPage: page "Sales Order";
                    begin
                        Clear(SalesOrder);
                        SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."Sales Order No.");
                        page.Run(page::"Sales Order", SalesOrder);
                    end;
                }

                action("Release Sales Order")
                {
                    ApplicationArea = Suite;
                    // Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';
                    Enabled = (Rec."Sales Order No." <> '') AND (ChangeStatusofVO) AND (SalesOrderIsOpen);
                    trigger OnAction()
                    var

                    begin
                        Clear(SalesOrder);
                        SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."Sales Order No.");

                        SalesOrder.PerformManualRelease();
                        //   CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                    end;
                }
                action("Reopen Sales Order")
                {
                    ApplicationArea = Basic, Suite;
                    // Caption = 'Re&open';
                    Enabled = (Rec."Sales Order No." <> '') AND (ChangeStatusofVO) AND (NOT SalesOrderIsOpen);
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";

                    begin
                        Clear(SalesOrder);
                        SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."Sales Order No.");

                        ReleaseSalesDoc.PerformManualReopen(SalesOrder);
                        ///    CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                    end;
                }
            }
        }
    }

    local procedure GetLAstSalesLineNumber(OrderNumber: code[20]): Integer
    var
        SaleLine: Record "Sales Line";

    begin
        Clear(SaleLine);
        SaleLine.SetRange("Document Type", SaleLine."Document Type"::Order);
        SaleLine.SetRange("Document No.", OrderNumber);
        IF SaleLine.FindLast() then
            exit(SaleLine."Line No.");
    end;

    local procedure GetLastPurchaseLineNumber(OrderNumber: code[20]): Integer
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(PurchaseLine);
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange("Document No.", OrderNumber);
        IF PurchaseLine.FindLast() then
            exit(PurchaseLine."Line No.");
    end;

    local procedure GetLastProjectPlanningLineNumber(JobNumber: code[20]; JobTaskNumber: Code[20]): Integer
    var
        ProjectPlanningLine: Record "Job Planning Line";

    begin
        Clear(ProjectPlanningLine);
        ProjectPlanningLine.SetRange("Job No.", JobNumber);
        ProjectPlanningLine.SetRange("Job Task No.", JobTaskNumber);
        IF ProjectPlanningLine.FindLast() then
            exit(ProjectPlanningLine."Line No.");

        exit(0);
    end;

    trigger OnOpenPage()
    var
    begin
        // Rec.SetRange(Executed, false)
        ;
        IF Usersetup.Get(UserId) then;
        ChangeStatusofVO := Usersetup."Change Status of VO";
        Clear(SalesOrder);
        IF SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."Sales Order No.") then begin
            IF SalesOrder.Status = SalesOrder.Status::Open
            then
                SalesOrderIsOpen := true else
                SalesOrderIsOpen := false;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin

        Clear(SalesOrder);
        IF SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."Sales Order No.") then begin
            IF SalesOrder.Status = SalesOrder.Status::Open
            then
                SalesOrderIsOpen := true else
                SalesOrderIsOpen := false;
        end;
    end;

    var
        OldItem: code[20];
        OldQuantity: Decimal;
        OldPrice: Decimal;
        OldCost: Decimal;
        OldUOM: code[20];
        Usersetup: Record "User Setup";
        ChangeStatusofVO: Boolean;
        SalesOrderIsOpen: Boolean;
        SalesOrder: Record "Sales Header";
}

