table 70102 "SUPPLIER PAYMENT REQUEST"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Number"; Code[20])
        {
            //  AutoIncrement = true;
            DataClassification = SystemMetadata;

            // trigger OnValidate()
            // var
            //     NoSeries: Codeunit "No. Series";
            //     GLSetup: Record "General Ledger Setup";
            // begin
            //     if "Number" <> xRec."Number" then begin
            //         //   GetSalesSetup();
            //         GLSetup.Get();
            //         GLSetup.TestField("Request for Payment No. Series");
            //         NoSeries.TestManual(GLSetup."Request for Payment No. Series");
            //         "No. Series" := '';
            //     end;
            // end;
        }

        field(2; "Supplier"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }

        field(3; "Project Name"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('PROJECT'));
        }

        field(4; "PO#"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = const(Order), "Buy-from Vendor No." = field(Supplier));

            trigger OnValidate()
            var
                PurchaseOrder: Record "Purchase Header";
                POEnum: Enum "Purchase Document Type";
            begin
                IF Rec."PO#" <> '' then begin
                    Clear(PurchaseOrder);
                    if PurchaseOrder.Get(POEnum::Order, Rec."PO#") then begin
                        PurchaseOrder.CalcFields("Amount Including VAT");
                        Rec."PO Value" := PurchaseOrder."Amount Including VAT";
                        Rec.Currency := PurchaseOrder."Currency Code";
                        Rec."Request Amount/PO Value %" := (Rec."Requested Amount" / Rec."PO Value") * 100;
                        Rec."Project Name" := PurchaseOrder."Shortcut Dimension 1 Code";
                        Rec."Responsibility Center" := PurchaseOrder."Responsibility Center";
                    end;
                end;
            end;
        }

        field(5; "SO#"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = const(Order), "Shortcut Dimension 1 Code" = field("Project Name"));
        }

        field(6; "Payment Terms"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }

        field(7; "Reason For Transfer"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Advance Payment","Progress Payment","Goods are Ready";
        }

        field(8; "Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(9; "Branch"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
        }

        field(10; "Payment Method"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }

        field(11; "Requested By / Department"; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }

        field(12; "Good Readiness Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(13; "Operation Expected"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(14; "Head Of Department"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }

        field(15; "Requested Amount"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
            begin
                Rec."Total Requested Amount" := Rec."Requested Amount" + Rec."Additional Charges";
                Rec."Request Amount/PO Value %" := (Rec."Requested Amount" / Rec."PO Value") * 100;
            end;
        }

        field(16; "Currency"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }

        field(17; "PO Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(18; "1st Payment"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(19; "1st Payment Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(20; "2nd Payment"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(21; "2nd Payment Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(22; "Balance on Order"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(23; "Expected Next Payment"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(24; "Requested By (Person)"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(25; Details; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Operation Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(27; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;


        }
        field(28; "Status"; Enum "Document Status")
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Level of Urgency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "0. ","1. Critical","2. Major","3. Medium","4. Minor";
        }
        field(30; "Executed"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            begin
                Rec."Date of Execution" := Today;
            end;
        }
        field(31; "Date of Execution"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Approval Entries"; code[50])
        {
            Caption = 'Approval Entries';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Document No." where("Document No." = field(Number)));
        }
        field(33; "Request Amount/PO Value %"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;

            trigger OnValidate()
            var
            begin
                IF "Request Amount/PO Value %" <> 0 then begin
                    Rec."Requested Amount" := Rec."PO Value" * (Rec."Request Amount/PO Value %" / 100);
                end;
                Rec."Total Requested Amount" := Rec."Requested Amount" + Rec."Additional Charges";
            end;
        }
        field(34; "Bank Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(35; "RFP Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Supplier payment","Non-Supplier payment";
        }
        field(36; "Sent to journals"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Responsibility Center"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(38; "Supplier Name"; Text[100])
        {
            Caption = 'Supplier Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field(Supplier)));
        }

        field(39; "PPI#"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purch. Inv. Header"."No." WHERE("Buy-from Vendor No." = field(Supplier), "Order No." = filter('<> '''''));

            ValidateTableRelation = false;
            trigger OnValidate()
            var
                PurchaseInvoiceHeader: Record "Purch. Inv. Header";
                POEnum: Enum "Purchase Document Type";
            begin
                IF Rec."PPI#" <> '' then begin
                    Clear(PurchaseInvoiceHeader);
                    PurchaseInvoiceHeader.Get(Rec."PPI#");

                    PurchaseInvoiceHeader.CalcFields("Amount Including VAT");
                    Rec."PO Value" := PurchaseInvoiceHeader."Amount Including VAT";
                    Rec.Currency := PurchaseInvoiceHeader."Currency Code";
                    Rec."Request Amount/PO Value %" := (Rec."Requested Amount" / Rec."PO Value") * 100;
                    Rec."Project Name" := PurchaseInvoiceHeader."Shortcut Dimension 1 Code";
                    Rec."Responsibility Center" := PurchaseInvoiceHeader."Responsibility Center";
                    Rec."PO#" := PurchaseInvoiceHeader."Order No.";
                end;
            end;
        }

        field(40; "3rd Payment"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(41; "3rd Payment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(42; "Additional Charges"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Rec."Total Requested Amount" := Rec."Requested Amount" + Rec."Additional Charges";
            end;
        }

        field(43; "Total Requested Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }


    keys
    {
        key(PK; "Number")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        "SUPPLIERPAYMENTREQUEST": Record "SUPPLIER PAYMENT REQUEST";
    begin
        //    if "Number" = '' then begin
        GLSetup.Get();
        GLSetup.TestField("Request for Payment No. Series");
        NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(GLSetup."Request for Payment No. Series", xRec."No. Series", 0D, Rec."Number", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(GLSetup."Request for Payment No. Series", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := GLSetup."Request for Payment No. Series";

        Rec."Number" := NoSeries.GetNextNo(Rec."No. Series");
        SUPPLIERPAYMENTREQUEST.ReadIsolation(IsolationLevel::ReadUncommitted);
        SUPPLIERPAYMENTREQUEST.SetLoadFields("Number");
        while SUPPLIERPAYMENTREQUEST.Get(Rec."Number") do
            Rec."Number" := NoSeries.GetNextNo(Rec."No. Series");
        NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", GLSetup."Request for Payment No. Series", 0D, Rec."Number");
        //   end;
        //  end;
    end;


    procedure SendtoPaymentJournal()
    var
        GenJnlLines: Record "Gen. Journal Line";
        LineNo: Integer;
        GenJnlLinesCheck: Record "Gen. Journal Line";
    begin
        Clear(GenJnlLinesCheck);
        GenJnlLinesCheck.SetRange("Journal Template Name", 'PAYMENTS');
        GenJnlLinesCheck.SetRange("Journal Batch Name", 'GLENDA RFP');
        IF GenJnlLinesCheck.FindLast() then
            LineNo += GenJnlLinesCheck."Line No." + 10000 else
            LineNo := 0;


        CLEAR(GenJnlLines);
        GenJnlLines.INIT;
        GenJnlLines.VALIDATE("Journal Template Name", 'PAYMENTS');
        GenJnlLines.VALIDATE("Journal Batch Name", 'GLENDA RFP');
        // GenJnlLines.SetParameters(TRUE);
        LineNo += 10000;
        GenJnlLines."Line No." := LineNo;

        GenJnlLines.VALIDATE("Document Date", Rec.date);
        GenJnlLines.VALIDATE("Posting Date", TODAY);
        GenJnlLines.Validate("Document Type", GenJnlLines."Document Type"::Payment);
        //GenJnlLines.VALIDATE("Document Type", GenJnlLines."Document Type"::Invoice);
        //DocNumber := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", GenJnlLines."Posting Date"); // .GetNextNo(GenJnlBatch."No. Series", GenJnlLines."Posting Date", FALSE);
        GenJnlLines.VALIDATE("Document No.", Rec.Number);
        GenJnlLines.VALIDATE("Source Code", 'PAYMENTJNL');
        GenJnlLines.VALIDATE("Account Type", GenJnlLines."Account Type"::Vendor);
        GenJnlLines.VALIDATE("Account No.", Rec.Supplier);
        //     GenJnlLines.VALIDATE("Gen. Posting Type", GenJnlLines."Gen. Posting Type"::Purchase);
        //   Rec.CALCFIELDS("Inv. Amount Currency Code");
        GenJnlLines.VALIDATE("Currency Code", Rec.Currency);
        GenJnlLines.VALIDATE(Amount, Rec."Total Requested Amount"); // Rec."Payment Amount");
                                                                    //  GenJnlLines.VALIDATE("Job No.", Rec."Job No.");
                                                                    //   GenJnlLines.VALIDATE("Job Task No.", Rec."Job Task No.");
                                                                    //  GenJnlLines.VALIDATE("Job Quantity", 1);
                                                                    // GenJnlLines.VALIDATE("Due Date", Rec."Due Date");
        GenJnlLines.VALIDATE("Shortcut Dimension 1 Code", Rec."Project Name");
        GenJnlLines.ValidateShortcutDimCode(4, Rec.Branch);
        GenJnlLines.ValidateShortcutDimCode(5, Rec."Requested By / Department");
        GenJnlLines.Validate("Payment Method Code", rec."Payment Method");
        GenJnlLines.Validate("Payment Terms Code", Rec."Payment Terms");

        //  GenJnlLines.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
        // GenJnlLines.Description := Rec.desc;
        //    GenJnlLines."Reference Number" := Rec."Document No.";//EDM.AI+-
        //    GenJnlLines.VALIDATE("Job No", Rec."Job No.");//EDM.AI+-
        //   GenJnlLines.VALIDATE("Job Task No", Rec."Job Task No.");
        //  GenJnlLines.Validate("FX Rate", Rec."FX Rate");//EDM.AI_FXRATE
        GenJnlLines.INSERT(TRUE);

        // Credit Line for Vendor Invoice
        CLEAR(GenJnlLines);
        GenJnlLines.INIT;
        GenJnlLines.VALIDATE("Journal Template Name", 'PAYMENTS');
        GenJnlLines.VALIDATE("Journal Batch Name", 'GLENDA RFP');
        //   GenJnlLines.SetParameters(TRUE);
        LineNo += 10000;
        GenJnlLines."Line No." := LineNo;

        GenJnlLines.VALIDATE("Document Date", Rec."Date");
        GenJnlLines.VALIDATE("Posting Date", TODAY);
        GenJnlLines.Validate("Document Type", GenJnlLines."Document Type"::Payment);
        //GenJnlLines.VALIDATE("Document Type", GenJnlLines."Document Type"::Invoice);
        GenJnlLines.VALIDATE("Document No.", Rec.Number);
        GenJnlLines.VALIDATE("Source Code", 'GENJNL');
        GenJnlLines.VALIDATE("Account Type", GenJnlLines."Account Type"::"Bank Account");
        GenJnlLines.VALIDATE("Account No.", Rec."Bank Number");
        //    GenJnlLines.VALIDATE("External Document No.", Rec."External Document No.");
        //   Rec.CALCFIELDS("Inv. Amount Currency Code");
        GenJnlLines.VALIDATE("Currency Code", Rec.Currency);
        GenJnlLines.VALIDATE(Amount, -Rec."Total Requested Amount"); // -Rec."Payment Amount");
                                                                     //  GenJnlLines.VALIDATE("Due Date", Rec."Due Date");
                                                                     //  GenJnlLines.VALIDATE("Job No.", Rec."Job No.");
                                                                     // GenJnlLines.VALIDATE("Job Task No.", Rec."Job Task No.");
        GenJnlLines.VALIDATE("Shortcut Dimension 1 Code", Rec."Project Name");
        GenJnlLines.ValidateShortcutDimCode(4, Rec.Branch);
        GenJnlLines.ValidateShortcutDimCode(5, Rec."Requested By / Department");
        GenJnlLines.Validate("Payment Method Code", rec."Payment Method");
        GenJnlLines.Validate("Payment Terms Code", Rec."Payment Terms");
        //  GenJnlLines.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
        //  GenJnlLines.VALIDATE("Job No", Rec."Job No.");//EDM.AI+-
        //  GenJnlLines.VALIDATE("Job Task No", Rec."Job Task No.");
        //   GenJnlLines.Description := Rec.Description;
        //  GenJnlLines."Reference Number" := Rec."Document No.";//EDM.AI+-
        //  GenJnlLines.Validate("FX Rate", Rec."FX Rate");//EDM.AI_FXRATE
        GenJnlLines.INSERT(TRUE);
    end;

}



