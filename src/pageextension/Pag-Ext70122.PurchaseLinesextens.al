pageextension 70122 "Purchase Lines extens  " extends "Purchase Lines"
{
    Editable = true;
    layout
    {
        modify("Line No.")
        {
            Visible = true;
            Editable = false;
        }
        // modify("Document No.")
        // { Editable = false; }
        modify("Document Type")
        { Editable = false; }
        modify(Type)
        { Editable = false; }
        modify("No.")
        { Editable = false; }
        modify(Description)

        { Editable = false; }
        modify("Location Code")
        { Editable = false; }
        modify(Quantity)
        { Editable = false; }
        modify("Unit of Measure Code")
        { Editable = false; }
        modify("Direct Unit Cost")
        { Editable = false; }
        modify("Expected Receipt Date")
        { Editable = false; }
        modify("Line Amount")
        { Editable = false; }
        modify("Description 2") { Editable = false; }
        modify("Indirect Cost %") { Editable = false; }
        modify("Job No.") { Editable = false; }
        modify("Job Task No.") { Editable = false; }
        modify("Unit Cost (LCY)") { Editable = false; }
        modify("Unit Price (LCY)")
        { Editable = false; }


        // Add changes to page layout here
        addafter("Outstanding Quantity")
        {

            field("Quantity Received"; Rec."Quantity Received")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item on the line have been posted as received.';
                Editable = false;
            }
            field("Qty. to Invoice"; Rec."Qty. to Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                Editable = false;
            }
            field("Qty. to Receive"; Rec."Qty. to Receive")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of items that remains to be received.';
                Editable = false;
            }
            field("Planned Receipt Date"; Rec."Planned Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the item is planned to arrive in inventory. Forward calculation: planned receipt date = order date + vendor lead time (per the vendor calendar and rounded to the next working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: planned receipt date = order date + vendor lead time (per the location calendar). Backward calculation: order date = planned receipt date - vendor lead time (per the vendor calendar and rounded to the previous working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: order date = planned receipt date - vendor lead time (per the location calendar).';
                Editable = false;
            }
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                Editable = false;
            }
            field("Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.';
                Editable = false;
            }
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                Editable = false;
            }
            field("Line Discount Amount"; Rec."Line Discount Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                Editable = false;
            }
            field("Shortcut  Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = Dimensions;
                ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                Editable = false;
            }
            field("Shortcut  Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = Dimensions;
                ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                Editable = false;
            }
            field(ShortcutDimCode3; ShortcutDimCode[3])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,3';
                Editable = false;
            }
            field(ShortcutDimCode4; ShortcutDimCode[4])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,4';
                Editable = false;
            }
            field(ShortcutDimCode5; ShortcutDimCode[5])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,5';
                Editable = false;
            }
            field(ShortcutDimCode6; ShortcutDimCode[6])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,6';
                Editable = false;
            }
            field(ShortcutDimCode7; ShortcutDimCode[7])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,7';
                Editable = false;
            }
            field(ShortcutDimCode8; ShortcutDimCode[8])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,8';

                Editable = false;
            }
            field(Modify; Modify)

            { ApplicationArea = All; Editable = false; }
        }
        addafter("Expected Receipt Date")
        {
            field("Initial ETR"; Rec."Initial ETR")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETR field.', Comment = '%';
            }

            field("Initial ETD"; Rec."Initial ETD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETD field.', Comment = '%';
            }
            field("Initial ETA"; Rec."Initial ETA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETA field.', Comment = '%';
            }
            field("Initial ETAW"; Rec."Initial ETAW")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETAW field.', Comment = '%';
            }


            field("Final ETR"; Rec."Final ETR")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETR field.', Comment = '%';
            }
            field("Final ETD"; Rec."Final ETD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETD field.', Comment = '%';
            }
            field("Final ETA"; Rec."Final ETA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETA field.', Comment = '%';
            }
            field("Final ETAW"; Rec."Final ETAW")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETAW field.', Comment = '%';
            }
            field(ATA; Rec.ATA)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ATA field.', Comment = '%';
            }
            field("BL/AWB ID"; Rec."BL/AWB ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BL/AWB ID field.', Comment = '%';
                Editable = false;
            }

        }
        addafter(Quantity)
        {
            field("Quantity Shipped"; Rec."Quantity Shipped")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Shipped field.', Comment = '%';
                Editable = NOT Rec."Disable fields after Shipping";
                trigger OnValidate()
                var
                    PurchaseLine: Record "Purchase Line";
                    PurchaseLine2: Record "Purchase Line";
                    PurchaseLine3: Record "Purchase Line";
                    SalesLine4: Record "Sales Line";//added by AI on 17/04/2025
                    LineSpacing: Integer;
                    PurchaseLine4: Record "Purchase Line";

                    LinesSplitted: Boolean;

                    SalesLine: Record "Sales Line";
                    SalesLine2: Record "Sales Line";
                begin
                    Rec.TestField("Quantity Received", 0);
                    Rec.TestField("BL/AWB ID", '');//added on 25/02/2025
                    Rec.TestField("Truck WayBill ID", '');//added on 25/02/2025
                    LinesSplitted := false;
                    Rec.TestField("Quantity Shipped");
                    IF Rec."Quantity Shipped" > Rec.Quantity then
                        Error('Quantity shipped must be less than Quantity');

                    IF Rec."Line is Splitted" = false then begin
                        Rec."Original Quantity" := Rec.Quantity;
                        Rec."Original Line No." := Rec."Line No.";
                        REc."Splitted Line No." := FORMAT(Rec."Line No.") + '0.1';
                    end;
                    //splitted line
                    IF (Rec."Quantity Shipped" <> Rec.Quantity) then begin
                        PurchaseLine.Init();
                        PurchaseLine.Copy(Rec);
                        EVALUATE(PurchaseLine."Line No.", IncStr(FORMAT(Rec."Line No.")));// + 1;//commented by AI on 17/04/2025 reason adding only 1 to the split line is showing error 'There is not enough space to insert correction lines.' on undo shipment

                        //added by AI on 17/04/2025
                        LineSpacing := 0;
                        Clear(PurchaseLine4);
                        PurchaseLine4.SetRange("Document Type", PurchaseLine4."Document Type"::Order);
                        PurchaseLine4.SetRange("Document No.", Rec."Document No.");
                        PurchaseLine4."Document Type" := Rec."Document Type";
                        PurchaseLine4."Document No." := Rec."Document No.";
                        PurchaseLine4."Line No." := Rec."Line No.";
                        PurchaseLine4.Find('=');
                        if PurchaseLine4.Find('>') then begin
                            LineSpacing := (PurchaseLine4."Line No." - Rec."Line No.") div 2;
                        end else
                            LineSpacing := 10000;

                        PurchaseLine."Line No." := Rec."Line No." + LineSpacing;


                        PurchaseLine.Validate(Quantity, PurchaseLine.Quantity - Rec."Quantity Shipped");
                        PurchaseLine.Validate("Direct Unit Cost");
                        PurchaseLine."Quantity Shipped" := 0;
                        //AN 03/14/25 +
                        PurchaseLine."Initial ETA" := 0D;
                        PurchaseLine."Initial ETAW" := 0D;
                        PurchaseLine."Initial ETD" := 0D;
                        PurchaseLine."Initial ETR" := 0D;
                        //AN 03/14/25 -
                        //  PurchaseLine."Remaining Quantity Shipped" := PurchaseLine."Original Quantity" - PurchaseLine2."Quantity Shipped";
                        PurchaseLine."Line is Splitted" := true;
                        PurchaseLine."Splitted Line No." := IncStr(PurchaseLine."Splitted Line No.");
                        PurchaseLine.Insert();

                        LinesSplitted := true;
                    end;


                    Clear(PurchaseLine2);
                    PurchaseLine2.SetRange("Document Type", PurchaseLine2."Document Type"::Order);
                    PurchaseLine2.SetRange("Document No.", Rec."Document No.");
                    PurchaseLine2.SetRange("Original Line No.", Rec."Original Line No.");
                    PurchaseLine2.CalcSums("Quantity Shipped");

                    Clear(PurchaseLine3);
                    PurchaseLine3.SetRange("Document Type", PurchaseLine3."Document Type"::Order);
                    PurchaseLine3.SetRange("Document No.", Rec."Document No.");
                    PurchaseLine3.SetRange("Original Line No.", Rec."Original Line No.");
                    //    PurchaseLine3.CalcSums("Quantity Shipped");
                    //   Message(Format(PurchaseLine2."Quantity Shipped"));



                    //line being modified
                    //   Rec."Remaining Quantity Shipped" := Rec."Original Quantity" - PurchaseLine2."Quantity Shipped";
                    IF LinesSplitted then begin
                        Rec.Validate(Quantity, Rec."Quantity Shipped");
                        Rec.Validate("Direct Unit Cost");
                        rec."Line is Splitted" := true;
                        REc.Modify();
                    end;
                    Rec."Disable fields after Shipping" := true;
                    Rec."Remaining Quantity Shipped" := Rec."Original Quantity" - PurchaseLine2."Quantity Shipped" - Rec."Quantity Shipped";
                    REc.Modify();


                    PurchaseLine3.ModifyAll("Remaining Quantity Shipped", Rec."Original Quantity" - PurchaseLine2."Quantity Shipped" - Rec."Quantity Shipped");

                    CurrPage.Update();

                    //Rec is current line that will be splitted
                    //Purchase line is the splitted line
                    //SalesLine is the mirror of Rec the current line, that will be splitted
                    //SalesLine2 is the splitted line

                    //sales line splitting
                    Clear(SalesLine);
                    IF SalesLine.Get(SalesLine."Document Type"::Order, Rec."MASQ Sales Order No.", Rec."MASQ Sales Order Line No.") then begin
                        IF SalesLine."Line is Splitted" = false then begin
                            SalesLine."Original Line No." := SalesLine."Line No.";
                            SalesLine."Splitted Line No." := FORMAT(SalesLine."Line No.") + '0.1';
                            SalesLine."Original PO Line No." := Rec."Line No.";
                            SalesLine."MASQ Purchase Order Line No." := Rec."Line No.";
                            SalesLine.Modify();
                        end;
                        //splitted Sales line
                        IF LinesSplitted then begin

                            SalesLine2.Init();

                            SalesLine2.Copy(SalesLine);
                            SalesLine2."Skip Line Checking " := true;
                            //  EVALUATE(SalesLine2."Line No.", IncStr(FORMAT(SalesLine."Line No.")));// + 1;//commented by AI on 17/04/2025 reason adding only 1 to the split line is showing error 'There is not enough space to insert correction lines.' on undo shipment

                            //added by AI on 17/04/2025
                            LineSpacing := 0;
                            Clear(SalesLine4);
                            SalesLine4.SetRange("Document Type", SalesLine4."Document Type"::Order);
                            SalesLine4.SetRange("Document No.", SalesLine."Document No.");
                            SalesLine4."Document Type" := Rec."Document Type";
                            SalesLine4."Document No." := SalesLine."Document No.";
                            SalesLine4."Line No." := SalesLine."Line No.";
                            SalesLine4.Find('=');
                            if SalesLine4.Find('>') then begin
                                LineSpacing := (SalesLine4."Line No." - SalesLine."Line No.") div 2;
                            end else
                                LineSpacing := 10000;

                            SalesLine2."Line No." := SalesLine."Line No." + LineSpacing;



                            SalesLine2.Validate(Quantity, PurchaseLine.Quantity);//mirror of the PO line
                            //SalesLine2."Quantity Shipped" := 0;
                            //  SalesLine2."Remaining Quantity Shipped" := SalesLine2."Original Quantity" - SalesLine22."Quantity Shipped";
                            SalesLine2."Line is Splitted" := true;
                            SalesLine2."Splitted Line No." := IncStr(SalesLine2."Splitted Line No.");
                            SalesLine2."MASQ Purchase Order Line No." := PurchaseLine."Line No.";
                            SalesLine2."Skip Line Checking " := false;
                            SalesLine2.Insert();

                            LinesSplitted := true;
                        end;

                        IF LinesSplitted then begin
                            SalesLine."Skip Line Checking " := true;
                            SalesLine.Validate(Quantity, Rec.Quantity);//mirror of the PO line
                            SalesLine."Line is Splitted" := true;
                            SalesLine."MASQ Purchase Order Line No." := Rec."Line No.";
                            SalesLine."Skip Line Checking " := false;
                            SalesLine.Modify();
                        end;

                        Rec."MASQ Sales Order Line No." := SalesLine."Line No.";
                        Rec.Modify();

                        IF LinesSplitted then begin
                            PurchaseLine."MASQ Sales Order Line No." := SalesLine2."Line No.";
                            PurchaseLine.Modify();
                        end;

                    end;
                end;



            }
            field("Remaining Quantity Shipped"; Rec."Remaining Quantity Shipped")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remaining Quantity Shipped field.', Comment = '%';
                Editable = false;
                Enabled = false;
            }
            field("Splitted Line No."; Rec."Splitted Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Splitted Line No. field.', Comment = '%';
                Editable = false;
                Enabled = false;
            }
            field("Line is Splitted"; Rec."Line is Splitted")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line is Splitted field.', Comment = '%';
                Editable = false;
                Enabled = false;
            }
            field("Original Quantity"; Rec."Original Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Original Quantity field.', Comment = '%';
                Editable = false;
                Enabled = false;
                BlankZero = true;
            }
            field("Original Line No."; Rec."Original Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Original Line No. field.', Comment = '%';
                Editable = false;
                Enabled = false;
            }
        }

        modify("Document No.")
        {
            Visible = true;
            Editable = false;
        }
        addbefore(Type)
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Cost field.', Comment = '%';
                Editable = false;
            }

            // field("Document Type"; Rec."Document Type")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the type of document that you are about to create.';
            //     Editable = false;
            // }
            field("MASQ Sales Order No."; Rec."MASQ Sales Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Sales Order No. field.', Comment = '%';
                Editable = false;

                trigger OnLookup(var Text: Text): Boolean
                var
                    SalesLine: Record "Sales Line";

                begin
                    Clear(SalesLine);
                    SalesLine.SetRange("Document No.", Rec."MASQ Sales Order No.");
                    SalesLine.SetRange("Line No.", Rec."MASQ Sales Order Line No.");
                    page.Run(page::"Sales Lines", SalesLine);

                end;
            }
            field("MASQ Sales Order Line No."; Rec."MASQ Sales Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Sales Order Line No. field.', Comment = '%';
                Editable = false;

                trigger OnLookup(var Text: Text): Boolean
                var
                    SalesLine: Record "Sales Line";

                begin
                    Clear(SalesLine);
                    SalesLine.SetRange("Document No.", Rec."MASQ Sales Order No.");
                    SalesLine.SetRange("Line No.", Rec."MASQ Sales Order Line No.");
                    page.Run(page::"Sales Lines", SalesLine);

                end;
            }
            field("Direct Unit Cost LCY"; Rec."Direct Unit Cost LCY")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Direct Unit Cost LCY field.', Comment = '%';
                Editable = false;
            }
            field("Line Amount LCY"; Rec."Line Amount LCY")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line Amount field.', Comment = '%';
                Editable = false;
            }

        }



    }

    actions
    {
        addafter("Show Document")
        {
            action(ExportToExcel)
            {
                Caption = 'Export to Excel';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Export;
                trigger OnAction()
                var
                begin
                    //  Message(FORMAT(rec.Count));
                    ExportPOLines(Rec);
                end;
            }
            action("&Import")
            {
                Caption = '&Import';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Import data from excel.';

                trigger OnAction()
                var
                begin
                    // if BatchName = '' then
                    //     Error(BatchISBlankMsg);
                    ReadExcelSheet();
                    ImportExcelData();
                    UpdatePurchaseLines();
                end;
            }
            Group("Sales Order")
            {
                action("Open Sales Order")
                {
                    Image = SalesInvoice;
                    ApplicationArea = All;
                    trigger OnAction()
                    var

                        SalesOrderPage: page "Sales Order";
                    begin
                        Clear(SalesOrder);
                        SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."MASQ Sales Order No.");
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
                    Enabled = (Rec."MASQ Sales Order No." <> '') AND (ChangeStatusofVO) AND (SalesOrderIsOpen);
                    trigger OnAction()
                    var

                    begin
                        Clear(SalesOrder);
                        SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."MASQ Sales Order No.");

                        SalesOrder.PerformManualRelease();
                        //   CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                    end;
                }
                action("Reopen Sales Order")
                {
                    ApplicationArea = Basic, Suite;
                    // Caption = 'Re&open';
                    Enabled = (Rec."MASQ Sales Order No." <> '') AND (ChangeStatusofVO) AND (NOT SalesOrderIsOpen);
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";

                    begin
                        Clear(SalesOrder);
                        SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."MASQ Sales Order No.");

                        ReleaseSalesDoc.PerformManualReopen(SalesOrder);
                        ///    CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                    end;
                }
            }

        }
    }

    var
        BatchName: Code[10];
        FileName: Text[100];
        SheetName: Text[100];

        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        BatchISBlankMsg: Label 'Batch name is blank';
        ExcelImportSucess: Label 'Excel is successfully imported.';

    local procedure ExportPOLines(var PurchaseLineRec: Record "Purchase Line")
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        CustLedgerEntriesLbl: Label 'Purchase Lines';
        ExcelFileName: Label 'Purchase_Lines_%1_%2';
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(PurchaseLineRec.FieldCaption("Buy-from Vendor No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('PO Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Item Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseLineRec.FieldCaption(Description), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseLineRec.FieldCaption(Quantity), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseLineRec.FieldCaption("Initial ETR"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseLineRec.FieldCaption("Initial ETD"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseLineRec.FieldCaption("Initial ETA"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseLineRec.FieldCaption("Initial ETAW"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseLineRec.FieldCaption("Line No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        if PurchaseLineRec.FindSet() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(PurchaseLineRec."Buy-from Vendor No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec.Quantity, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec."Initial ETR", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec."Initial ETD", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec."Initial ETA", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec."Initial ETAW", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(PurchaseLineRec."Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            until PurchaseLineRec.Next() = 0;
        TempExcelBuffer.CreateNewBook(CustLedgerEntriesLbl);
        TempExcelBuffer.WriteSheet(CustLedgerEntriesLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;

    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure ImportExcelData()
    var
        POImportBuffer: Record "PO Import Buffer";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
    begin
        Clear(POImportBuffer);
        POImportBuffer.DeleteAll();
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        POImportBuffer.Reset();
        if POImportBuffer.FindLast() then
            LineNo := POImportBuffer."Line No.";
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;

        for RowNo := 2 to MaxRowNo do begin
            // LineNo := LineNo + 10000;
            // IF GetValueAtCell(RowNo, 34) = 'TRUE' then begin
            POImportBuffer.Init();
            POImportBuffer."Document Type" := POImportBuffer."Document Type"::Order;
            POImportBuffer."Document No." := GetValueAtCell(RowNo, 2);
            Evaluate(POImportBuffer."Initial ETA", GetValueAtCell(RowNo, 8));
            Evaluate(POImportBuffer."Initial ETD", GetValueAtCell(RowNo, 7));
            Evaluate(POImportBuffer."Initial ETR", GetValueAtCell(RowNo, 6));
            Evaluate(POImportBuffer."Initial ETAW", GetValueAtCell(RowNo, 9));
            Evaluate(POImportBuffer."Line No.", GetValueAtCell(RowNo, 10));
            POImportBuffer.Insert();
            /*  Evaluate(POImportBuffer."Document Type", GetValueAtCell(RowNo, 1));
              POImportBuffer."Document No." := GetValueAtCell(RowNo, 2);
              Evaluate(POImportBuffer."Line No.", GetValueAtCell(RowNo, 4));
              Evaluate(POImportBuffer.Type, GetValueAtCell(RowNo, 5));
              POImportBuffer."No." := GetValueAtCell(RowNo, 6);

              POImportBuffer.Description := GetValueAtCell(RowNo, 7);
              POImportBuffer."Location Code" := GetValueAtCell(RowNo, 8);
              Evaluate(POImportBuffer.Quantity, GetValueAtCell(RowNo, 9));
              Evaluate(POImportBuffer."Direct Unit Cost", GetValueAtCell(RowNo, 14));
              Evaluate(POImportBuffer."Line Amount", GetValueAtCell(RowNo, 15));
              Evaluate(POImportBuffer."Expected Receipt Date", GetValueAtCell(RowNo, 16));

              Evaluate(POImportBuffer."Planned Receipt Date", GetValueAtCell(RowNo, 21));
              Evaluate(POImportBuffer."Promised Receipt Date", GetValueAtCell(RowNo, 22));
              Evaluate(POImportBuffer."Requested Receipt Date", GetValueAtCell(RowNo, 23));
              Evaluate(POImportBuffer."Line Discount %", GetValueAtCell(RowNo, 24));
              Evaluate(POImportBuffer."Line Discount Amount", GetValueAtCell(RowNo, 25));

              POImportBuffer."Shortcut Dimension 1 Code" := GetValueAtCell(RowNo, 26);
              POImportBuffer."Shortcut Dimension 2 Code" := GetValueAtCell(RowNo, 27);
              POImportBuffer."Shortcut Dimension 3 Code" := GetValueAtCell(RowNo, 28);
              POImportBuffer."Shortcut Dimension 4 Code" := GetValueAtCell(RowNo, 29);
              POImportBuffer."Shortcut Dimension 5 Code" := GetValueAtCell(RowNo, 30);

              POImportBuffer."Shortcut Dimension 6 Code" := GetValueAtCell(RowNo, 31);
              POImportBuffer."Shortcut Dimension 7 Code" := GetValueAtCell(RowNo, 32);
              POImportBuffer."Shortcut Dimension 8 Code" := GetValueAtCell(RowNo, 33);
              POImportBuffer."ITEM TYPE" := GetValueAtCell(RowNo, 34);
              EVALUATE(POImportBuffer.MODIFIED, GetValueAtCell(RowNo, 35));*/
            //   POImportBuffer.Insert();
            //  end;
        end;
        Message(ExcelImportSucess);
    end;

    local procedure UpdatePurchaseLines()
    var
        POImportBuffer: Record "PO Import Buffer";
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(POImportBuffer);
        // POImportBuffer.SetRange(MODIFIED, true);
        if POImportBuffer.FindSet() then
            repeat
                IF PurchaseLine.Get(POImportBuffer."Document Type", POImportBuffer."Document No.", POImportBuffer."Line No.") then begin
                    PurchaseLine.Validate("Initial ETA", POImportBuffer."Initial ETA");
                    PurchaseLine.Validate("Initial ETD", POImportBuffer."Initial ETD");
                    PurchaseLine.Validate("Initial ETR", POImportBuffer."Initial ETR");
                    PurchaseLine.Validate("Initial ETAW", POImportBuffer."Initial ETAW");
                    PurchaseLine.Modify();
                    /*    PurchaseLine.Validate("Document Type", POImportBuffer."Document Type");
                        PurchaseLine.Validate("Document No.", POImportBuffer."Document No.");
                        PurchaseLine.Validate("Line No.", POImportBuffer."Line No.");
                        PurchaseLine.Validate(type, POImportBuffer.type);
                        PurchaseLine.Validate("No.", POImportBuffer."No.");

                        PurchaseLine.Validate(Description, POImportBuffer.Description);
                        PurchaseLine.Validate("Location Code", POImportBuffer."Location Code");
                        PurchaseLine.Validate(Quantity, POImportBuffer.Quantity);
                        PurchaseLine.Validate("Direct Unit Cost", POImportBuffer."Direct Unit Cost");
                        PurchaseLine.Validate("Line Amount", POImportBuffer."Line Amount");
                        PurchaseLine.Validate("Expected Receipt Date", POImportBuffer."Expected Receipt Date");

                        PurchaseLine.Validate("Planned Receipt Date", POImportBuffer."Planned Receipt Date");
                        PurchaseLine.Validate("Promised Receipt Date", POImportBuffer."Promised Receipt Date");
                        PurchaseLine.Validate("Requested Receipt Date", POImportBuffer."Requested Receipt Date");
                        PurchaseLine.Validate("Line Discount %", POImportBuffer."Line Discount %");
                        PurchaseLine.Validate("Line Discount Amount", POImportBuffer."Line Discount Amount");

                        PurchaseLine.Validate("Shortcut Dimension 1 Code", POImportBuffer."Shortcut Dimension 1 Code");
                        PurchaseLine.Validate("Shortcut Dimension 2 Code", POImportBuffer."Shortcut Dimension 2 Code");
                        PurchaseLine.ValidateShortcutDimCode(3, POImportBuffer."Shortcut Dimension 3 Code");
                        PurchaseLine.ValidateShortcutDimCode(4, POImportBuffer."Shortcut Dimension 4 Code");
                        PurchaseLine.ValidateShortcutDimCode(5, POImportBuffer."Shortcut Dimension 5 Code");

                        PurchaseLine.ValidateShortcutDimCode(6, POImportBuffer."Shortcut Dimension 6 Code");
                        PurchaseLine.ValidateShortcutDimCode(7, POImportBuffer."Shortcut Dimension 7 Code");
                        PurchaseLine.ValidateShortcutDimCode(8, POImportBuffer."Shortcut Dimension 8 Code");
                        PurchaseLine."Meg Item Type" := POImportBuffer."ITEM TYPE";*/

                end;
            until POImportBuffer.Next() = 0;
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    // trigger OnOpenPage()
    // var
    // begin
    //     Clear(UserSetup);
    //     UserSetup.Get(UserId);
    //     CanRemovePOLinesfromContainer := UserSetup."Remove PO lines from Container";
    // end;
    trigger OnOpenPage()
    var
    begin
        // Rec.SetRange(Executed, false)
        ;
        Usersetup.Get(UserId);
        ChangeStatusofVO := Usersetup."Change Status of VO";
        Clear(SalesOrder);
        IF SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."MASQ Sales Order No.") then begin
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
        IF SalesOrder.GET(SalesOrder."Document Type"::Order, Rec."MASQ Sales Order No.") then begin
            IF SalesOrder.Status = SalesOrder.Status::Open
            then
                SalesOrderIsOpen := true else
                SalesOrderIsOpen := false;
        end;

    end;

    trigger OnAfterGetRecord()
    var
    begin
        //added on 19/02/82025
        IF Rec."Direct Unit Cost LCY" = 0 then begin
            REc.CalcFields("Currency Factor");
            IF (Rec."Currency Code" = '') then
                Rec."Direct Unit Cost LCY" := Rec."Direct Unit Cost" else
                IF Rec."Currency Factor" <> 0 then
                    Rec."Direct Unit Cost LCY" := Rec."Direct Unit Cost" / Rec."Currency Factor";


            rec.Modify();
        end;

        IF Rec."Line Amount LCY" = 0 then begin
            REc.CalcFields("Currency Factor");
            IF (Rec."Currency Code" = '') then
                Rec."Line Amount LCY" := Rec."Line Amount" else
                IF Rec."Currency Factor" <> 0 then
                    Rec."Line Amount LCY" := Rec."Line Amount" / Rec."Currency Factor";

            rec.Modify();
        end;

    end;

    var
        myInt: Integer;
        Modify: Boolean;
        Usersetup: Record "User Setup";
        ChangeStatusofVO: Boolean;
        SalesOrderIsOpen: Boolean;
        SalesOrder: Record "Sales Header";
        CanRemovePOLinesfromContainer: Boolean;
}