pageextension 70160 "Posted purch inv extension" extends "Posted Purchase Invoice"
{
    layout
    {
        modify("Order No.") //NB MASQ
        {
            Visible = true;
            ApplicationArea = All;
            Importance = Standard;
        }
        addafter("Order No.") //NB MASQ
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
        addafter("Meg SO No.")
        {
            field("PO Type"; Rec."PO Type")
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Date field.', Comment = '%';
            }
        }
    }
    //NB MASQ Start
    actions
    {
        addfirst(processing)
        {
            action("Open RFP")
            {
                ApplicationArea = All;
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SUPPLIERPAYMENTREQUEST: Record "SUPPLIER PAYMENT REQUEST";
                begin
                    SUPPLIERPAYMENTREQUEST.Reset();
                    SUPPLIERPAYMENTREQUEST.SetRange("PPI#", Rec."No.");
                    if SUPPLIERPAYMENTREQUEST.FindFirst() then
                        Page.RunModal(Page::"Request for Payment", SUPPLIERPAYMENTREQUEST)
                    else begin
                        SUPPLIERPAYMENTREQUEST.Reset();
                        SUPPLIERPAYMENTREQUEST.SetRange("PO#", Rec."Order No.");
                        if SUPPLIERPAYMENTREQUEST.FindFirst() then
                            Page.RunModal(Page::"Request for Payment", SUPPLIERPAYMENTREQUEST)
                        else
                            Message('RFP is not created for this PPI');
                    end;
                end;
            }
            action("Create RFP")
            {
                ApplicationArea = All;
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SUPPLIERPAYMENTREQUEST: Record "SUPPLIER PAYMENT REQUEST";
                    NoSeries: Codeunit "No. Series";
                    GeneralLedgerSetup: Record "General Ledger Setup";
                    Vendor: Record Vendor;
                begin
                    SUPPLIERPAYMENTREQUEST.Reset();
                    SUPPLIERPAYMENTREQUEST.SetRange("PPI#", Rec."No.");
                    if SUPPLIERPAYMENTREQUEST.FindFirst() then
                        Message('RFP %1 is already created for PPI %2', SUPPLIERPAYMENTREQUEST.Number, Rec."No.")
                    else begin
                        SUPPLIERPAYMENTREQUEST.Reset();
                        SUPPLIERPAYMENTREQUEST.SetRange("PO#", Rec."Order No.");
                        if SUPPLIERPAYMENTREQUEST.FindFirst() then
                            Message('RFP %1 is already created for PO %2', SUPPLIERPAYMENTREQUEST.Number, Rec."Order No.")
                        else begin
                            GeneralLedgerSetup.Get();
                            SUPPLIERPAYMENTREQUEST.Init();
                            SUPPLIERPAYMENTREQUEST.Validate(Number, NoSeries.GetNextNo(GeneralLedgerSetup."Request for Payment No. Series"));
                            SUPPLIERPAYMENTREQUEST.Validate(Supplier, Rec."Buy-from Vendor No.");
                            if Vendor.Get(Rec."Buy-from Vendor No.") then //NB MASQ
                                SUPPLIERPAYMENTREQUEST.Validate("RFP Type", Vendor."RFP Type");
                            SUPPLIERPAYMENTREQUEST.Validate("PPI#", Rec."No.");
                            SUPPLIERPAYMENTREQUEST.Validate("Payment Terms", Rec."Payment Terms Code");
                            //NB MASQ Start 30-Sep-25
                            //SUPPLIERPAYMENTREQUEST.Validate("Good Readiness Date", Rec."Initial ETR");
                            //Rec.CalcFields(Rec."MASQ Sales Order No.");
                            //SUPPLIERPAYMENTREQUEST.Validate("SO#", Rec."MASQ Sales Order No.");
                            SUPPLIERPAYMENTREQUEST.Validate("Requested By (Person)", UserId());
                            SUPPLIERPAYMENTREQUEST.Validate(Date, Today());
                            //NB MASQ End 30-Sep-25
                            SUPPLIERPAYMENTREQUEST.Insert(true);
                            Message('RFP %1 is successfully created for PPI %2', SUPPLIERPAYMENTREQUEST.Number, Rec."No.");
                        end;
                    end;
                end;
            }
        }
    }
    //NB MASQ End
}