pageextension 70138 "Job Planning Lines extension" extends "Job Planning Lines"
{
    //if Remaining of the Quantity = 0 the quantity will be doubld on after post the PO so make sure remaining quantity is not zero coming from apollo
    layout
    {
        addafter("No.")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.', Comment = '%';
                Editable = false;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.', Comment = '%';
                DrillDownPageId = "Vendor List";
            }
            field("Vendor Item Code"; Rec."Vendor Item Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Item Code field.', Comment = '%';
                Editable = false;
            }
            field(Item_Code_Suffix; Rec.Item_Code_Suffix)
            {
                ApplicationArea = All;
            }
            field(OrderNumber; Rec.OrderNumber)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Number field.', Comment = '%';
                // Editable = false;
            }
        }
        addafter("Invoiced Amount (LCY)")
        {
            field("Meg Item Type"; Rec."Meg Item Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type field.', Comment = '%';
            }
            field("Freight Cost"; Rec."Freight Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Freight Cost field.', Comment = '%';
            }
            field("Custom & Clearance Cost"; Rec."Custom & Clearance Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Custom & Clearance Cost field.', Comment = '%';
            }
            field(CC_Percentage; Rec.CC_Percentage)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CC Percentage field.', Comment = '%';
            }
            field("Custom Cost"; Rec."Custom Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Custom Cost field.', Comment = '%';
            }
            field("Clearance Cost"; Rec."Clearance Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Clearance Cost field.', Comment = '%';
            }
            field(COF; Rec.COF)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the COF field.', Comment = '%';
            }
            field("Schedule (Total Landed Cost)"; Rec."Schedule (Total Landed Cost)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Landed Cost) field.', Comment = '%';
            }
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
            }
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
            }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 70100 Code field.', Comment = '%';
            }
            field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
            }
            field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.', Comment = '%';
            }
            field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.', Comment = '%';
            }
            field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 8 Code field.', Comment = '%';
            }
            field("Usage (Total Cost)"; Rec."Usage (Total Cost)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) field.', Comment = '%';
            }
            field("Usage (Total Cost) Freight"; Rec."Usage (Total Cost) Freight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Freight field.', Comment = '%';
            }
            field("Usage (Total Cost) Clearance"; Rec."Usage (Total Cost) Clearance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Clearance field.', Comment = '%';
            }
            field("Usage (Total Cost) Customs"; Rec."Usage (Total Cost) Customs")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Customs field.', Comment = '%';
            }
            field("Usage (Total Cost) Insurance"; Rec."Usage (Total Cost) Insurance")//added on 10022025
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Insurance field.', Comment = '%';
            }
            field("Usage (Total Cost) Others"; Rec."Usage (Total Cost) Others")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Others field.', Comment = '%';
            }

            field("Usage (Total Landed Cost)"; Rec."Usage (Total Landed Cost)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Landed Cost) field.', Comment = '%';
            }
            field(Insurance; Rec.Insurance)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Insurance field.', Comment = '%';
            }
            field("Unit Cost in Vendor Currency"; Rec."Unit Cost in Vendor Currency")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Cost in Vendor Currency field.', Comment = '%';
            }
            // field("Usage (Total Cost) Opex"; Rec."Usage (Total Cost) Opex")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Usage (Total Cost) Opex field.', Comment = '%';
            // }




        }
        modify("Unit Price")
        {
            Editable = true;//commented on 29/11/2024 need to check
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
            begin
                Rec.Validate(Quantity);//this is added on 18/02/2025 to validate the quantity from apollo since the remaining quanitty is showing zero quantity and we are facing quantitties duplicates issues since rem = 0 on post of the purchase order 
            end;
        }
        // Add changes to page layout here
        addfirst(factboxes)
        {
            part("Variation Order"; "Variation Order Factbox")
            {
                ApplicationArea = All;
                Caption = 'Variation Order';
                // Provider = SalesLines;
                SubPageLink = "Project Code" = field("Job No."), "Item Number" = field("No.");
                // "Document Type" = field("Document Type")
            }
        }



        modify("No.")
        {
            Editable = true;
        }
        modify("Unit Cost")
        { Editable = true; }
        addafter(Control1)
        {
            group(Totals)
            {
                field("Total Exported Quantity"; Rec."Total Exported Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Exported Quantity field.', Comment = '%';
                    Editable = false;
                }
                field("Apollo Total Offer Value"; Rec."Apollo Total Offer Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Apollo Total Offer Value field.', Comment = '%';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        addafter("Create &Sales Invoice")
        {
            action("Create Purchase Requests")
            {
                ApplicationArea = All;
                Image = Purchase;
                trigger OnAction()
                begin
                    CreateOrOpenPurchaseRequestsJob();
                end;
            }
            action("Create &Sales Order")
            {
                ApplicationArea = Jobs;
                Caption = 'Create &Sales Order';
                Ellipsis = true;
                Image = JobSalesInvoice;
                ToolTip = 'Use a batch job to help you create sales Order for the involved project tasks.';

                trigger OnAction()
                var
                    IsHandled: Boolean;
                begin
                    //   IsHandled := false;
                    //  OnCreateSalesInvoiceOnBeforeAction(Rec, IsHandled);
                    // if not IsHandled then
                    CreateSalesInvoice(false);
                end;
            }
        }
        addafter("Create Sales &Credit Memo")//Added on 17/02/2025
        {
            action("Sales &Order/Credit Memos")
            {
                ApplicationArea = Jobs;
                Caption = 'Sales &Order/Credit Memos';
                Ellipsis = true;
                Image = GetSourceDoc;
                ToolTip = 'View sales Order or sales credit memos that are related to the selected project.';

                trigger OnAction()
                begin
                    JobCreateInvoice.GetJobPlanningLineInvoices(Rec);
                end;
            }
        }


        modify("Create &Sales Invoice")//Added on 17/02/2025
        {
            Caption = 'Create &Sales Order';
            ToolTip = 'Use a batch job to help you create sales Order for the involved project tasks.';
            // Visible = false;
            Visible = false;
        }
        modify("Sales &Invoices/Credit Memos")//Added on 17/02/2025
        {
            Caption = 'Sales &Order/Credit Memos';
            ToolTip = 'View sales Order or sales credit memos that are related to the selected project.';
            //  CaptionML = 'Sales Order/Credit Memos';
            // Visible = false;
            Visible = false;

        }
        modify("Create &Sales Invoice_Promoted")//Added on 17/02/2025
        {
            Visible = false;

        }
        modify("Sales &Invoices/Credit Memos_Promoted")//Added on 17/02/2025
        {
            Visible = false;
        }
        // addafter("Create &Sales Invoice_Promoted")
        // {
        //     actionref("Create &Sales Order_Promoted"; "Create &Sales Invoice")
        //     {
        //     }
        // }
        // addafter("Sales &Invoices/Credit Memos_Promoted")
        // {
        //     actionref("Sales &Order/Credit Memos_Promoted"; "Sales &Invoices/Credit Memos")
        //     {
        //     }
        // }

        addafter(CreateJobJournalLines_Promoted)
        {
            actionref("Create &Sales Order_Promoted"; "Create &Sales Invoice")
            {
            }
        }

    }

    trigger OnAfterGetRecord()//added on 05022025
    var
    begin
        Rec."Schedule (Total Landed Cost)" := Rec."Total Cost (LCY)" + Rec."Freight Cost" + Rec."Custom & Clearance Cost" + Rec.COF + Rec.Insurance;//added on 10022024


        Rec.CalcFields("Usage (Total Cost)", "Usage (Total Cost) Clearance", "Usage (Total Cost) Customs", "Usage (Total Cost) Freight", "Usage (Total Cost) Others", "Usage (Total Cost) Insurance");//updated on 10022025
        Rec."Usage (Total Landed Cost)" := Rec."Usage (Total Cost)" + rec."Usage (Total Cost) Freight" + Rec."Usage (Total Cost) Clearance"
        + Rec."Usage (Total Cost) Customs" + Rec."Usage (Total Cost) Others" + Rec."Usage (Total Cost) Insurance";//updated on 10022025
    end;



    local procedure CreateSalesInvoice(CrMemo: Boolean)//Added on 17/02/2025
    var
        JobPlanningLine: Record "Job Planning Line";
        JobCreateInvoice: Codeunit "MASQ Job Create-Order";
    begin
        Rec.TestField("Line No.");
        JobPlanningLine.Copy(Rec);
        CurrPage.SetSelectionFilter(JobPlanningLine);
        JobCreateInvoice.CreateSalesInvoice(JobPlanningLine, CrMemo)
    end;

    local procedure CreateOrOpenPurchaseRequestsJob()
    var
        PurchaseRequest: Record "Purchase Request Header";
        PurchaseRequestLine: Record "Purchase Request Line";
        Vendor: Record Vendor;
        LineNo: Integer;
        Item: Record Item;
    begin
        Clear(PurchaseRequest);
        PurchaseRequest.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        PurchaseRequest.SetRange("Project No.", Rec."Job No.");
        IF NOT PurchaseRequest.FindFirst() then begin

            LineNo := 0;
            if Rec.FindSet() then
                repeat
                    Clear(PurchaseRequest);
                    PurchaseRequest.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    PurchaseRequest.SetRange("Vendor No.", Rec."Vendor No.");
                    PurchaseRequest.SetRange("Project No.", Rec."Job No.");
                    IF NOT PurchaseRequest.FindFirst()
                    then begin
                        Clear(Vendor);
                        Vendor.Get(Rec."Vendor No.");
                        Clear(PurchaseRequest);
                        PurchaseRequest.Init();
                        PurchaseRequest.Date := REc."Document Date";
                        PurchaseRequest."Location Code" := Rec."Location Code";
                        PurchaseRequest.Status := PurchaseRequest.Status::Open;
                        PurchaseRequest."Global Dimension 1 Code" := rec."Shortcut Dimension 1 Code";
                        PurchaseRequest."Project No." := Rec."Job No.";
                        PurchaseRequest."Currency Code" := Vendor."Currency Code";
                        Rec.CalcFields("Vendor No.");
                        PurchaseRequest."Vendor No." := Rec."Vendor No.";
                        PurchaseRequest."VAT Bus. Posting Group" := Vendor."VAT Bus. Posting Group";
                        // PurchaseRequest."Sales Order No." := Rec."Demand Order No.";
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
                    PurchaseRequestLine.Validate("Project No.", Rec."Job No.");
                    PurchaseRequestLine.Validate(Quantity, Rec.Quantity);
                    // IF Rec."Currency Code" = '' then
                    //     PurchaseRequestLine.Validate("Unit Cost", Rec."Unit Cost (LCY)")
                    // else
                    PurchaseRequestLine.Validate("Unit Cost", Rec."Unit Cost in Vendor Currency");


                    PurchaseRequestLine.Validate(Amount, PurchaseRequestLine.Quantity * PurchaseRequestLine."Unit Cost");


                    PurchaseRequestLine."Document Type" := PurchaseRequestLine."Document Type"::"Purchase Order";
                    PurchaseRequestLine.Validate("Document Reference", Rec."Vendor No.");
                    PurchaseRequestLine.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 4 Code", REc."Shortcut Dimension 4 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 5 Code", Rec."Shortcut Dimension 5 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 6 Code", Rec."Shortcut Dimension 6 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 7 Code", REc."Shortcut Dimension 7 Code");
                    PurchaseRequestLine.Validate("Shortcut Dimension 8 Code", Rec."Shortcut Dimension 8 Code");
                    //AN 6/13/2025
                    PurchaseRequestLine.Validate("Unit of Measure Code", Rec."Unit of Measure Code");
                    // PurchaseRequestLine."MASQ Sales Order No." := Rec."MASQ Sales Order No.";
                    // PurchaseRequestLine."MASQ Sales Order Line No." := Rec."MASQ Sales Order Line No.";
                    PurchaseRequestLine."PO Status" := PurchaseRequestLine."PO Status"::"Not Ordered";
                    // PurchaseRequestLine."PO No." := Rec."PO No.";
                    // PurchaseRequestLine."PO Line No" := Rec."PO Line No";

                    // IF rec.Include then
                    //     PurchaseRequestLine.Check := true;
                    //modified by AN 07/11/2025
                    PurchaseRequestLine.Validate("Project No.", PurchaseRequest."Project No.");
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


    var
        JobCreateInvoice: Codeunit "Job Create-Invoice";
}