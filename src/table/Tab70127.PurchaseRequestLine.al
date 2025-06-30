table 70127 "Purchase Request Line"
{
    Caption = 'Purchase Request Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = IF (Type = CONST(Item)) Item ELSE
            IF (Type = CONST(Service)) "G/L Account" ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            var
                TempLine: Record "Purchase Request Line" temporary;
            begin
                IF (CurrFieldNo <> 0) THEN
                    IF TestStatus THEN BEGIN
                        TempLine := Rec;
                        "Item No." := TempLine."Item No.";
                        IF "Item No." = '' THEN BEGIN
                            "Item Description" := '';
                            "Item Category Code" := '';
                            "Product Group Code" := '';
                            "Tax Group Code" := '';
                            "VAT Prod. Posting Group" := '';
                            EXIT;
                        END;

                        CASE Type OF
                            Type::Item:
                                BEGIN
                                    GetItem;
                                    Item.TESTFIELD(Blocked, FALSE);
                                    VALIDATE("Item Description", Item.Description);
                                    VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                    //VALIDATE("Unit Cost", Item."Last Direct Cost");
                                    "Item Category Code" := Item."Item Category Code";
                                    // "Product Group Code" := Item."Product Group Code";//EDM.AI-Check
                                    "Tax Group Code" := Item."Tax Group Code";
                                    "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                                    //"VAT Bus. Posting Group" := Item."VAT Bus. Posting Gr. (Price)";
                                    IF Item."Price Includes VAT" THEN BEGIN
                                        IF NOT VATPostingSetup.GET(
                                             Item."VAT Bus. Posting Gr. (Price)", Item."VAT Prod. Posting Group")
                                        THEN
                                            VATPostingSetup.INIT;
                                        CASE VATPostingSetup."VAT Calculation Type" OF
                                            VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                                VATPostingSetup."VAT %" := 0;
                                            VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                                ERROR(
                                                  Text005,
                                                  VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
                                                  VATPostingSetup."VAT Calculation Type");
                                        END;
                                        //"Unit Price (LCY)" :=
                                        //  ROUND("Unit Price (LCY)" / (1 + VATPostingSetup."VAT %" / 100),
                                        //    GLSetup."Unit-Amount Rounding Precision");
                                    END;

                                END;
                            Type::"Fixed Asset":
                                ERROR('Fixed Asset is not a valid option here.');
                            /*BEGIN
                              GetAsset;
                              VALIDATE("Item Description",FixedAsset.Description);
                            END;*/
                            Type::Service:
                                BEGIN
                                    GetGLAccount;
                                    VALIDATE("Item Description", GLAccount.Name);
                                    "Tax Group Code" := GLAccount."Tax Group Code";
                                    "VAT Prod. Posting Group" := GLAccount."VAT Prod. Posting Group";
                                    //"VAT Bus. Posting Group" := GLAccount."VAT Bus. Posting Group";
                                END;
                        END;

                        IF NOT (Type IN [Type::"Fixed Asset"]) THEN
                            VALIDATE("VAT Prod. Posting Group");

                    END;

            end;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) THEN BEGIN

                END;

                IF ("Item No." = '') AND (Description = '') THEN
                    ERROR(Text002, FIELDCAPTION("Item No."), FIELDCAPTION(Description));

                IF Quantity <> 0 THEN
                    "Quantity (Base)" := CalcBaseQty(Quantity);

                VALIDATE("Total Cost", Quantity * "Unit Cost");
                VALIDATE("Expected Total Cost", Quantity * "Expected Unit Cost");

                Rec.CalcFields("Main Stock");//16/01/2025
                Rec."Suggested Qty" := Rec."Main Stock" - Rec.Quantity;
            end;
        }
        field(5; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) THEN BEGIN

                END;
            end;
        }
        field(13; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
        }
        field(16; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) THEN BEGIN

                END;
            end;
        }
        field(22; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(23; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF ("item No." = FILTER('')) "Unit of Measure".Code ELSE
            "Item Unit of Measure".Code WHERE("item No." = FIELD("Item No."));

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
                UOMMgt: Codeunit "Unit of Measure Management";
            begin
                IF (CurrFieldNo <> 0) THEN BEGIN

                END;

                IF "Unit of Measure Code" = '' THEN
                    "Unit of Measure" := ''
                ELSE BEGIN
                    IF UnitOfMeasure.GET("Unit of Measure Code") THEN
                        "Unit of Measure" := UnitOfMeasure.Description;
                END;
                IF "Item No." <> '' THEN BEGIN
                    GetItem;
                    VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code"));
                END;
            end;
        }
        field(24; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("item No." = FIELD("Item No."));

            trigger OnValidate()
            var
                ItemVariant: Record "Item Variant";
            begin
                IF (CurrFieldNo <> 0) THEN BEGIN

                END;
                IF "Document Reference" = '' THEN
                    EXIT;

                ItemVariant.GET("Item No.", "Document Reference");
                "Item Description" := ItemVariant.Description;
                Description := ItemVariant."Description 2";
            end;
        }
        field(25; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                GetHeader();
                //IF NOT PurchReqHeader.Editable THEN
                //ERROR('Cannot edit this field Since the request was sent');
            end;
        }
        field(26; Check; Boolean)
        {
            Editable = false;
        }
        field(27; Remark; Text[250])
        {
        }
        field(28; Assigned; Boolean)
        {
            Editable = false;
        }
        field(29; "Document Type"; Option)
        {
            Caption = 'Document Type';
            FieldClass = Normal;
            OptionCaption = 'Negative Adjustment,Purchase Order,Purchase Quote';
            OptionMembers = "Negative Adjustment","Purchase Order","Purchase Quote";

            trigger OnValidate()
            begin


                IF Rec."Document Type" <> xRec."Document Type" THEN
                    VALIDATE("Document Reference", '');
            end;
        }
        field(30; "Document Reference"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = IF ("Document Type" = FILTER('Purchase Order|Purchase Quote')) Vendor;

            trigger OnValidate()
            begin


                IF "Document Reference" = '' THEN BEGIN
                    "Reference Name" := '';
                    EXIT;
                END;

                IF "Document Type" = "Document Type"::"Negative Adjustment" THEN BEGIN
                    ERROR('Negative Adjustment is not a valid option here.');
                    /*Location.SETRANGE(Code,"Document Reference");
                    IF Location.FINDFIRST THEN
                      "Reference Name" := Location.Name*/
                END
                ELSE
                    IF ("Document Type" = "Document Type"::"Purchase Order") THEN BEGIN
                        GetPurchReqHeader;
                        IF PurchReqHeader."Vendor No." = '' THEN
                            PurchReqHeader.VALIDATE("Vendor No.", "Document Reference")
                        ELSE
                            IF PurchReqHeader."Vendor No." <> "Document Reference" THEN
                                PurchReqHeader.VALIDATE("Vendor No.", '');

                        IF VendorRec.GET("Document Reference") THEN
                            "Reference Name" := VendorRec.Name
                        ELSE
                            "Reference Name" := '';
                    END
                    ELSE
                        IF ("Document Type" = "Document Type"::"Purchase Quote") THEN BEGIN
                            "Reference Name" := '';
                            ERROR('Please fill Vendors list under Line -> Vendors.');
                        END;

            end;
        }
        field(31; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            CaptionClass = GetCaptionClass(FIELDNO("Unit Cost"));
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                VALIDATE("Total Cost", Quantity * "Unit Cost");
            end;
        }
        field(32; "Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            CaptionClass = GetCaptionClass(FIELDNO("Total Cost"));
            DecimalPlaces = 3 : 3;
            Editable = false;

            trigger OnValidate()
            var
                PurcReqHdr: Record "Purchase Request Header";
            begin
                CALCFIELDS("Currency Code");
                IF "Currency Code" <> '' THEN BEGIN
                    CurrencyExchangeRate.GetLastestExchangeRate("Currency Code", ExchangeRateDate, ExchangeRateAmt);
                    "Line Amount (LCY)" := "Total Cost" * ExchangeRateAmt;
                END ELSE
                    "Line Amount (LCY)" := "Total Cost";

                SetLineAmount;
            end;
        }
        field(33; "Reference Name"; Text[50])
        {
            Editable = false;
        }
        field(35; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            Editable = false;
            TableRelation = "Item Category".Code;
        }
        field(36; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            //   TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //   ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                //VALIDATE("Job Task No.", "Shortcut Dimension 1 Code");
            end;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //  ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                //VALIDATE("Job No.", "Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(50000; "Expected Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                GetHeader();
                //IF NOT PurchReqHeader.Editable THEN
                //  ERROR('Cannot edit this field Since the request was sent');

                VALIDATE("Expected Total Cost", Quantity * "Expected Unit Cost");
            end;
        }
        field(50001; "Expected Total Cost"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                GetHeader();
                //IF NOT PurchReqHeader.Editable THEN
                //  ERROR('Cannot edit this field Since the request was sent');

                SetLineAmount;

                //CheckBudget;
            end;
        }
        field(50002; "PR Status"; Option)
        {
            CalcFormula = Lookup("Purchase Request Header".Status WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = Open,Closed,"Pending Approval",Released,Declined;
        }
        /* field(50003; "Budget Item Category"; Code[20])
         {
            // TableRelation = "Budget Item Category"."No.";

             trigger OnValidate()
             begin
                 CALCFIELDS(Type);
                 IF BudgetItemCateg.GET("Budget Item Category") THEN BEGIN
                     VALIDATE("Item No.", BudgetItemCateg."Account No.");
                     VALIDATE("Document Type", BudgetItemCateg.Assignment);
                     /*JobTask.RESET;
                     CLEAR(JobTask);
                     JobTask.SETRANGE("Budget Item Category", "Budget Item Category");
                     //IF "Job No." <> '' THEN
                     //  JobTask.SETRANGE("Job No.", "Job No.");
                     IF JobTask.FINDFIRST THEN
                     BEGIN
                       //VALIDATE("Job No.", JobTask."Job No.");
                       //VALIDATE("Job Task No.", JobTask."Job Task No.");
                     END; ELSE BEGIN
                       VALIDATE("Job No.", '');
                       VALIDATE("Job Task No.", '');
                     END;
                 END;

             end;
         }*/
        field(50005; Reason; Text[50])
        {
            TableRelation = "Reason Code".Code;
        }
        field(50008; Type; Option)
        {
            // CalcFormula = Lookup("Budget Item Category".Type WHERE("No." = FIELD("Budget Item Category")));
            Editable = false;
            //    FieldClass = FlowField;
            OptionCaption = 'Item,Service, Fixed Asset';
            OptionMembers = Item,Service,"Fixed Asset";
        }
        field(50009; "Line Amount (LCY)"; Decimal)
        {
        }
        field(50010; Date; Date)
        {
            CalcFormula = Lookup("Purchase Request Header".Date WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50011; "Currency Code"; Code[10])
        {
            CalcFormula = Lookup("Purchase Request Header"."Currency Code" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                VALIDATE("Expected Unit Cost");
                VALIDATE("Unit Cost");
            end;
        }
        field(50013; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                //     ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50014; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                //    ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(50015; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                //    ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(50016; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                //     ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(50017; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                //    ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(50018; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                //    ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        // field(50020; "Budget Allocation"; Boolean)
        // {
        //     CalcFormula = Exist("Purchase Budget Allocation" WHERE("Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No."), "Document Type" = CONST(Request)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(50021; "Line Amount"; Decimal)
        {
            Description = '= Expected Total Cost If Total Cost = 0 / Otherwise = Total Cost';

            trigger OnValidate()
            begin
                UpdateAmounts;
            end;
        }
        // field(50022; "Has Vendors"; Boolean)
        // {
        //     CalcFormula = Exist("Purch. Request Line Vendor" WHERE("Purch. Request No." = FIELD("Document No."), "Line No." = FIELD("Line No.")));
        //     FieldClass = FlowField;
        // }
        field(50023; "Expected Delivery Date"; Date)
        {
        }
        field(50024; "Delivery Location"; Code[10])
        {
            TableRelation = Location;
        }
        field(50025; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50026; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(50027; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(50028; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";

            trigger OnValidate()
            begin
                ////////// TestStatusOpen;
                UpdateAmounts;
            end;
        }
        field(50029; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(50030; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;

            trigger OnValidate()
            begin
                GetPurchReqHeader;
                "Amount Including VAT" := ROUND("Amount Including VAT", Currency."Amount Rounding Precision");
                CASE "VAT Calculation Type" OF
                    "VAT Calculation Type"::"Normal VAT",
                    "VAT Calculation Type"::"Reverse Charge VAT":
                        BEGIN
                            Amount :=
                              ROUND(
                                "Amount Including VAT" / (1 + "VAT %" / 100), Currency."Amount Rounding Precision");
                            "VAT Base Amount" :=
                              ROUND(Amount, Currency."Amount Rounding Precision");
                        END;
                    "VAT Calculation Type"::"Full VAT":
                        BEGIN
                            Amount := 0;
                            "VAT Base Amount" := 0;
                        END;
                /*"VAT Calculation Type"::"Sales Tax":
                  BEGIN
                    PurchHeader.TESTFIELD("VAT Base Discount %",0);
                    IF "Use Tax" THEN BEGIN
                      Amount := "Amount Including VAT";
                      "VAT Base Amount" := Amount;
                    END ELSE BEGIN
                      Amount :=
                        ROUND(
                          SalesTaxCalculate.ReverseCalculateTax(
                            "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
                            "Amount Including VAT","Quantity (Base)",PurchHeader."Currency Factor"),
                          Currency."Amount Rounding Precision");
                      "VAT Base Amount" := Amount;
                      IF "VAT Base Amount" <> 0 THEN
                        "VAT %" :=
                          ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                      ELSE
                        "VAT %" := 0;
                    END;
                  END;*/
                END;

                //InitOutstandingAmount;
                //UpdateUnitCost;

            end;
        }
        field(50032; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;

            trigger OnValidate()
            begin
                GetPurchReqHeader;
                Amount := ROUND(Amount, Currency."Amount Rounding Precision");
                CASE "VAT Calculation Type" OF
                    "VAT Calculation Type"::"Normal VAT",
                    "VAT Calculation Type"::"Reverse Charge VAT":
                        BEGIN
                            "VAT Base Amount" :=
                              ROUND(Amount, Currency."Amount Rounding Precision");
                            "Amount Including VAT" :=
                              ROUND(Amount + "VAT Base Amount" * "VAT %" / 100, Currency."Amount Rounding Precision");
                        END;
                    "VAT Calculation Type"::"Full VAT":
                        IF Amount <> 0 THEN
                            FIELDERROR(Amount,
                              STRSUBSTNO(
                                Text011, FIELDCAPTION("VAT Calculation Type"),
                                "VAT Calculation Type"));
                /*"VAT Calculation Type"::"Sales Tax":
                  BEGIN
                    PurchHeader.TESTFIELD("VAT Base Discount %",0);
                    "VAT Base Amount" := Amount;
                    IF "Use Tax" THEN
                      "Amount Including VAT" := "VAT Base Amount"
                    ELSE BEGIN
                      "Amount Including VAT" :=
                        Amount +
                        ROUND(
                          SalesTaxCalculate.CalculateTax(
                            "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
                            "VAT Base Amount","Quantity (Base)",PurchHeader."Currency Factor"),
                          Currency."Amount Rounding Precision");
                      IF "VAT Base Amount" <> 0 THEN
                        "VAT %" :=
                          ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                      ELSE
                        "VAT %" := 0;
                    END;
                  END;*/
                END;

                //InitOutstandingAmount;
                //UpdateUnitCost;

            end;
        }
        field(50033; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                VALIDATE("VAT Prod. Posting Group");
            end;
        }
        field(50034; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                //////////// TestStatusOpen;
                VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                //"VAT Difference" := 0;
                "VAT %" := VATPostingSetup."VAT %";
                "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                "VAT Identifier" := VATPostingSetup."VAT Identifier";
                CASE "VAT Calculation Type" OF
                    "VAT Calculation Type"::"Reverse Charge VAT",
                  "VAT Calculation Type"::"Sales Tax":
                        "VAT %" := 0;
                    "VAT Calculation Type"::"Full VAT":
                        BEGIN
                            TESTFIELD(Type, Type::Service); // :"G/L Account");
                            VATPostingSetup.TESTFIELD("Purchase VAT Account");
                            TESTFIELD("Item No.", VATPostingSetup."Purchase VAT Account");
                        END;
                END;
                IF PurchReqHeader."Prices Including VAT" AND (Type = Type::Item) THEN
                    "Unit Cost" :=
                      ROUND(
                        "Unit Cost" * (100 + "VAT %") / (100 + xRec."VAT %"),
                        Currency."Unit-Amount Rounding Precision");
                UpdateAmounts;
            end;
        }
        field(50035; Status; Option)
        {
            CalcFormula = Lookup("Purchase Request Header".Status WHERE("No." = FIELD("Document No.")));
            Caption = 'Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Closed,Pending Approval,Released,Declined';
            OptionMembers = Open,Closed,"Pending Approval",Released,Declined;
        }
        field(50036; "MASQ Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FIllItemType();
            end;
        }
        field(50037; "MASQ Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FIllItemType();
            end;
        }
        field(50038; "Total Available Stock"; Decimal)
        {
            //  DataClassification = ToBeClassified;

            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50039; "Suggested Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Final PR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Official PO QTY";
        Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "PO Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Created,Ordered,"Not Ordered";
        }
        field(50043; "Main Stock"; Decimal)
        {
            //  DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."), "Warehouse Category" = const(Main)));//only the stock from the main warehosues


        }
        field(50044; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Purchase Header";
        }
        field(50045; "PO Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50047; "Cost of PR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Cost oof Req"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Qty of PR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Qty of Req"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Project No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FIllItemType();
            end;
        }
        field(50052; "Vendor Item Code"; Code[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Meg Vendor Item Code" where("No." = field("Item No.")));
        }
        field(50053; "Item Type"; Code[20])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Job Planning Line"."Meg Item Type" WHERE("Job No." = FIELD("Project No."), "No." = field("Item No.")));
        }
        //AN 06/27/2025+
        field(50054; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                if "Line Amount" <> 0 then
                    "Discount Amount" := Round(("Line Amount" * "Discount %") / 100, 0.01);

                RecalculateLineDiscount();
                UpdateHeaderDiscounts();
            end;
        }

        field(50055; "Discount Amount"; Decimal)
        {
            Caption = 'Discount Amount';

            trigger OnValidate()
            begin
                if "Line Amount" <> 0 then
                    "Discount %" := Round(("Discount Amount" / "Line Amount") * 100, 0.01);

                RecalculateLineDiscount();
                UpdateHeaderDiscounts();
            end;
        }

        field(50056; "Line Amount After Discount"; Decimal)
        {
            Caption = 'Line After Discount';
            Editable = false;
        }

        field(50057; "Line Amt After Disc Incl. VAT"; Decimal)
        {
            Caption = 'Line After Discount Incl. VAT';
            Editable = false;
        }
        //AN 06/27/2025-
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure FIllItemType()
    var
        SalesLine: Record "Sales Line";
        JobPlanningLine: Record "Job Planning Line";
    begin
        if ("Project No." = '') then begin
            SalesLine.SetRange("Document No.", "MASQ Sales Order No.");
            SalesLine.SetRange("Line No.", "MASQ Sales Order Line No.");
            if SalesLine.FindFirst() then
                "Item Type" := SalesLine."Meg Item Type";
        end else begin
            JobPlanningLine.SetRange("Job No.", "Project No.");
            JobPlanningLine.SetRange("No.", "Item No.");
            if JobPlanningLine.FindFirst() then
                "Item Type" := JobPlanningLine."Meg Item Type";
        end;
    end;

    trigger OnDelete()
    begin
        TestStatusOpen;
    end;

    trigger OnInsert()
    begin
        TestStatusOpen;

        GetHeader;
        VALIDATE("VAT Bus. Posting Group", PurchReqHeader."VAT Bus. Posting Group");

        /*IF "Dimension Set ID" = 0 THEN
        BEGIN
          "Dimension Set ID" := PurchReqHeader."Dimension Set ID";
          DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        END;*/

        //"Job No." := PurchReqHeader."Global Dimension 2 Code";

    end;

    trigger OnModify()
    begin


        IF ("Item No." = '') AND (Description = '') THEN
            ERROR(Text002, FIELDCAPTION("Item No."), FIELDCAPTION(Description));
    end;

    trigger OnRename()
    begin
        ERROR(Text001, TABLECAPTION);
    end;

    //AN 06/27/2025+
    procedure RecalculateLineDiscount()
    var
        VATAmount: Decimal;
    begin
        "Line Amount After Discount" := Amount - "Discount Amount";
        VATAmount := "Amount Including VAT" - Amount;
        "Line Amt After Disc Incl. VAT" := "Line Amount After Discount" + VATAmount;
        Modify();
    end;

    procedure UpdateHeaderDiscounts()
    var
        HeaderRec: Record "Purchase Request Header";
        LineRec: Record "Purchase Request Line";
        LineCount: Integer;
        TotalDiscountPercent: Decimal;
        TotalDiscountAmount: Decimal;
    begin
        TotalDiscountPercent := 0;
        TotalDiscountAmount := 0;
        LineCount := 0;
        if GetHeader(HeaderRec) then begin
            LineRec.SetRange("Document No.", "Document No.");
            if LineRec.FindSet() then begin
                repeat
                    TotalDiscountPercent += LineRec."Discount %";
                    TotalDiscountAmount += LineRec."Discount Amount";
                    LineCount += 1;
                until LineRec.Next() = 0;
            end;

            if LineCount > 0 then begin
                HeaderRec."Discount %" := TotalDiscountPercent / LineCount;
                HeaderRec."Discount Amount" := TotalDiscountAmount / LineCount;
                HeaderRec.Modify();
                HeaderRec.RecalculateDiscountTotals();
            end;
            if (TotalDiscountAmount = 0) and (TotalDiscountPercent = 0) then begin
                HeaderRec."Discount %" := 0;
                HeaderRec."Discount Amount" := 0;
                HeaderRec."Total After Discount" := 0;
                HeaderRec."Total After Discount Incl. VAT" := 0;
            end;
            HeaderRec.Modify();
        end;
    end;

    local procedure GetHeader(var Header: Record "Purchase Request Header"): Boolean
    begin
        exit(Header.Get("Document No."));
    end;
    //AN 06/27/2025-

    var
        PurchReqHeader: Record "Purchase Request Header";
        Item: Record Item;
        Text001: Label 'You cannot rename a %1.';
        Location: Record Location;
        VendorRec: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ExchangeRateDate: Date;
        ExchangeRateAmt: Decimal;
        PurcReqHdr: Record "Purchase Request Header";
        Text002: Label 'Either %1 or %2 must be filled';
        DimMgt: Codeunit DimensionManagement;
        JobTask: Record "Job Task";
        Text003: Label 'Remaining Budget does not cover the Expected Cost';
        GLAccount: Record "G/L Account";
        UserSetup: Record "User Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        Text004: Label 'Remaining Budget does not cover the Cost';
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        Text011: Label ' must be 0 when %1 is %2';
        VATPostingSetup: Record "VAT Posting Setup";
        Text005: Label 'Prices including VAT cannot be calculated when %1 is %2.';

    local procedure GetHeader()
    begin
        TESTFIELD("Document No.");
        IF ("Document No." <> PurchReqHeader."No.") THEN
            IF PurchReqHeader.GET("Document No.") then;
    end;

    local procedure GetItem()
    begin
        //TESTFIELD("Item No.");
        IF "Item No." <> Item."No." THEN
            Item.GET("Item No.");
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TESTFIELD("Qty. per Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;

    local procedure TestStatusOpen()
    begin
        GetHeader();
        // UserSetup.GET(USERID);
        // //EDM_12092017
        // IF NOT ((UserSetup."User Type" = UserSetup."User Type"::Purchaser) AND (UserSetup.Logistic)) THEN
        //     //EDM_12092017
        //     PurchReqHeader.TESTFIELD(Status, PurchReqHeader.Status::Open);
    end;

    local procedure TestStatus(): Boolean
    begin
        // GetHeader();
        // UserSetup.GET(USERID);

        // IF PurchReqHeader.Status = PurchReqHeader.Status::Open THEN
        //     EXIT(TRUE)
        // ELSE
        //     IF PurchReqHeader.Status = PurchReqHeader.Status::Released THEN
        //         EXIT(TRUE)
        //     ELSE
        //         IF ((PurchReqHeader.Status = PurchReqHeader.Status::"Pending Approval") AND (UserSetup."User Type" = UserSetup."User Type"::Purchaser)) THEN
        //             EXIT(TRUE)
        //         ELSE
        //             EXIT(FALSE);
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //VerifyItemLineDim;
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    /*  [Scope('Internal')]//stopped by EDM.AI
      procedure ShowDimensions()
      begin
          "Dimension Set ID" :=
            DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Document Type", "Document No.", "Line No."));
          //VerifyItemLineDim;
          DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
          DimMgt.UpdateDimensionFromDimSetID("Dimension Set ID", 3, "Shortcut Dimension 3 Code");
          DimMgt.UpdateDimensionFromDimSetID("Dimension Set ID", 4, "Shortcut Dimension 4 Code");
          DimMgt.UpdateDimensionFromDimSetID("Dimension Set ID", 5, "Shortcut Dimension 5 Code");
          DimMgt.UpdateDimensionFromDimSetID("Dimension Set ID", 6, "Shortcut Dimension 6 Code");
          DimMgt.UpdateDimensionFromDimSetID("Dimension Set ID", 7, "Shortcut Dimension 7 Code");
          DimMgt.UpdateDimensionFromDimSetID("Dimension Set ID", 8, "Shortcut Dimension 8 Code");
      end;
  */
    procedure ShowDimensions()//EDM.AI-UP
                              //from latest version
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "Document Type", "Document No.", "Line No."));
    end;

    local procedure CheckBudget()
    var

    begin
        /*CalcBCYAmounts;
        GetHeader;
        JobTask.RESET;
        CLEAR(JobTask);
        JobTask.SETRANGE("Job No.", "Job No.");
        JobTask.SETRANGE("Job Task No.", "Job Task No.");
        IF JobTask.FINDFIRST THEN
        BEGIN
          //JobTask.CALCFIELDS("Currency Code");
          //"Expected Total Cost (BCY)" := CurrExchRate.ExchangeAmount("Expected Total Cost", PurchReqHeader."Currency Code", JobTask."Currency Code", PurchReqHeader.Date);
          //"Total Cost (BCY)" := CurrExchRate.ExchangeAmount("Total Cost", PurchReqHeader."Currency Code", JobTask."Currency Code", PurchReqHeader.Date);
        
          BudgetEvents.UpdateBudgetValues(JobTask);
          GraceAmount := BudgetEvents.GetBudgetGraceAmount(JobTask);
        
          IF JobTask."Remaining from Budget" + GraceAmount + xRec."Expected Total Cost (BCY)" < Rec."Expected Total Cost (BCY)" THEN
            ERROR(Text003);
          IF JobTask."Remaining from Budget" + GraceAmount + Rec."Expected Total Cost (BCY)" - xRec."Total Cost (BCY)" < Rec."Total Cost (BCY)" - xRec."Total Cost (BCY)" THEN
            ERROR(Text004);
        
          IF "Line No." > 0 THEN
            MODIFY;
        END;
        */

    end;

    local procedure GetAsset()
    begin
        IF "Item No." <> FixedAsset."No." THEN
            FixedAsset.GET("Item No.");
    end;

    local procedure GetGLAccount()
    begin
        IF "Item No." <> GLAccount."No." THEN
            GLAccount.GET("Item No.");
    end;

    local procedure CalcBCYAmounts()
    var
        Job: Record Job;
    begin
        /*Job.RESET;
        CLEAR(Job);
        IF Job.GET("Job No.") THEN
        BEGIN
          CALCFIELDS(Date, "Currency Code");
          "Expected Total Cost (BCY)" := CurrExchRate.ExchangeAmount("Expected Total Cost", "Currency Code", Job."Currency Code", Date);
          "Total Cost (BCY)" := CurrExchRate.ExchangeAmount("Total Cost", "Currency Code", Job."Currency Code", Date);
        
          IF "Total Cost (BCY)" = 0 THEN
            VALIDATE("Total Amount (BCY)", "Expected Total Cost (BCY)")
          ELSE
            VALIDATE("Total Amount (BCY)", "Total Cost (BCY)");
          IF "Line No." > 0 THEN
            MODIFY;
        END;
        */

    end;

    local procedure SetLineAmount()
    begin
        IF "Total Cost" = 0 THEN
            Rec.VALIDATE("Line Amount", "Expected Total Cost")
        ELSE
            Rec.VALIDATE("Line Amount", "Total Cost");
        Rec.MODIFY(false);
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    var
        CaptionClass: Text[80];
    begin
        IF NOT PurchReqHeader.GET("Document No.") THEN BEGIN
            PurchReqHeader."No." := '';
            PurchReqHeader.INIT;
        END;

        IF PurchReqHeader."Prices Including VAT" THEN
            EXIT('2,1,' + GetFieldCaption(FieldNumber));
        EXIT('2,0,' + GetFieldCaption(FieldNumber));
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record "Field";
    begin
        Field.GET(DATABASE::"Purchase Request Line", FieldNumber);
        EXIT(Field."Field Caption");
    end;

    [Scope('Internal')]
    procedure SetPurchReqHeader(NewPurchReqHeader: Record "Purchase Request Header")
    begin
        PurchReqHeader := NewPurchReqHeader;

        IF PurchReqHeader."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            //PurchReqHeader.TESTFIELD("Currency Factor");
            Currency.GET(PurchReqHeader."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        END;
    end;

    local procedure GetPurchReqHeader()
    begin
        TESTFIELD("Document No.");
        IF ("Document No." <> PurchReqHeader."No.") THEN BEGIN
            IF PurchReqHeader.GET("Document No.") then;
            IF PurchReqHeader."Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                //PurchHeader.TESTFIELD("Currency Factor");
                Currency.GET(PurchReqHeader."Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
    end;


    procedure UpdateAmounts()
    var
        RemLineAmountToInvoice: Decimal;
        VATBaseAmount: Decimal;
        LineAmountChanged: Boolean;
    begin
        //IF CurrFieldNo <> FIELDNO("Allow Invoice Disc.") THEN
        //  TESTFIELD(Type);
        GetPurchReqHeader;

        VATBaseAmount := "VAT Base Amount";
        //"Recalculate Invoice Disc." := TRUE;

        IF "Total Cost" <> xRec."Total Cost" THEN BEGIN
            LineAmountChanged := TRUE;
        END;
        IF "Total Cost" <> ROUND(Quantity * "Unit Cost", Currency."Amount Rounding Precision") THEN BEGIN
            "Total Cost" :=
              ROUND(Quantity * "Unit Cost", Currency."Amount Rounding Precision");
            LineAmountChanged := TRUE;
        END;

        /*IF NOT "Prepayment Line" THEN
        BEGIN
          IF "Prepayment %" <> 0 THEN
          BEGIN
            IF Quantity < 0 THEN
              FIELDERROR(Quantity,STRSUBSTNO(Text043,FIELDCAPTION("Prepayment %")));
            IF "Direct Unit Cost" < 0 THEN
              FIELDERROR("Direct Unit Cost",STRSUBSTNO(Text043,FIELDCAPTION("Prepayment %")));
          END;
          IF PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice THEN
          BEGIN
            "Prepayment VAT Difference" := 0;
            IF NOT PrePaymentLineAmountEntered THEN
              "Prepmt. Line Amount" := ROUND("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
            IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN
              FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text037,"Prepmt. Amt. Inv."));
            PrePaymentLineAmountEntered := FALSE;
            IF "Prepmt. Line Amount" <> 0 THEN BEGIN
              RemLineAmountToInvoice :=
                ROUND("Line Amount" * (Quantity - "Quantity Invoiced") / Quantity,Currency."Amount Rounding Precision");
              IF RemLineAmountToInvoice < ("Prepmt. Line Amount" - "Prepmt Amt Deducted") THEN
                FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text039,RemLineAmountToInvoice + "Prepmt Amt Deducted"));
            END;
          END ELSE
            IF (CurrFieldNo <> 0) AND ("Line Amount" <> xRec."Line Amount") AND
               ("Prepmt. Amt. Inv." <> 0) AND ("Prepayment %" = 100)
            THEN BEGIN
              IF "Line Amount" < xRec."Line Amount" THEN
                FIELDERROR("Line Amount",STRSUBSTNO(Text038,xRec."Line Amount"));
              FIELDERROR("Line Amount",STRSUBSTNO(Text039,xRec."Line Amount"));
            END;
        END;*/

        UpdateVATAmounts;
        IF VATBaseAmount <> "VAT Base Amount" THEN
            LineAmountChanged := TRUE;

        IF LineAmountChanged THEN BEGIN
            //UpdateDeferralAmounts;
            LineAmountChanged := FALSE;
        END;

        //InitOutstandingAmount;

        //IF Type = Type::"Charge (Item)" THEN
        //  UpdateItemChargeAssgnt;

        //CalcPrepaymentToDeduct;

        CheckBudget;

    end;

    local procedure UpdateVATAmounts()
    var
        PurchReqLine2: Record "Purchase Request Line";
        TotalLineAmount: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalQuantityBase: Decimal;
    begin
        GetPurchReqHeader;
        //PurchLine2.SETRANGE("Document Type","Document Type");
        /*PurchReqLine2.SETRANGE("Document No.","Document No.");
        PurchReqLine2.SETFILTER("Line No.",'<>%1',"Line No.");
        IF "Total Cost" = 0 THEN
          IF xRec."Total Cost" >= 0 THEN
            PurchReqLine2.SETFILTER(Amount,'>%1',0)
          ELSE
            PurchReqLine2.SETFILTER(Amount,'<%1',0)
        ELSE
          IF "Total Cost" > 0 THEN
            PurchReqLine2.SETFILTER(Amount,'>%1',0)
          ELSE
            PurchReqLine2.SETFILTER(Amount,'<%1',0);
        PurchReqLine2.SETRANGE("VAT Identifier","VAT Identifier");
        PurchReqLine2.SETRANGE("Tax Group Code","Tax Group Code");
        */
        TotalLineAmount := 0;
        TotalInvDiscAmount := 0;
        TotalAmount := 0;
        TotalAmountInclVAT := 0;
        TotalQuantityBase := 0;
        /*IF ("VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax") OR
            (("VAT Calculation Type" IN
              ["VAT Calculation Type"::"Normal VAT","VAT Calculation Type"::"Reverse Charge VAT"]) AND ("VAT %" <> 0))
        THEN
          IF NOT PurchReqLine2.ISEMPTY THEN BEGIN
            PurchReqLine2.CALCSUMS("Total Cost", Amount, "Amount Including VAT", "Quantity (Base)");
            TotalLineAmount := PurchReqLine2."Total Cost";
            TotalAmount := PurchReqLine2.Amount;
            TotalAmountInclVAT := PurchReqLine2."Amount Including VAT";
            TotalQuantityBase := PurchReqLine2."Quantity (Base)";
          END;
        */
        IF PurchReqHeader."Prices Including VAT" THEN
            CASE "VAT Calculation Type" OF
                "VAT Calculation Type"::"Normal VAT",
                "VAT Calculation Type"::"Reverse Charge VAT":
                    BEGIN
                        Amount :=
                          ROUND(
                            (TotalLineAmount + "Total Cost") / (1 + "VAT %" / 100),
                            Currency."Amount Rounding Precision") -
                          TotalAmount;
                        "VAT Base Amount" :=
                          ROUND(
                            Amount, Currency."Amount Rounding Precision");
                        //Test//"Amount Including VAT" := TotalLineAmount + "Total Cost";
                        VALIDATE("Amount Including VAT", (TotalLineAmount + "Total Cost"));
                        /*- ROUND(
                          (TotalAmount + Amount) * "VAT %" / 100,
                          Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                        TotalAmountInclVAT;*/
                    END;
                "VAT Calculation Type"::"Full VAT":
                    BEGIN
                        Amount := 0;
                        "VAT Base Amount" := 0;
                    END;
            /*"VAT Calculation Type"::"Sales Tax":
              BEGIN
                "Amount Including VAT" :=
                  ROUND("Total Cost", Currency."Amount Rounding Precision");
                IF "Use Tax" THEN
                  Amount := "Amount Including VAT"
                ELSE
                  Amount :=
                    ROUND(
                      SalesTaxCalculate.ReverseCalculateTax(
                        "Tax Area Code","Tax Group Code","Tax Liable",PurchReqHeader."Posting Date",
                        TotalAmountInclVAT + "Amount Including VAT",TotalQuantityBase + "Quantity (Base)",
                        PurchReqHeader."Currency Factor"),
                      Currency."Amount Rounding Precision") -
                    TotalAmount;
                "VAT Base Amount" := Amount;
                IF "VAT Base Amount" <> 0 THEN
                  "VAT %" :=
                    ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                ELSE
                  "VAT %" := 0;
              END;*/
            END
        ELSE
            CASE "VAT Calculation Type" OF
                "VAT Calculation Type"::"Normal VAT",
                "VAT Calculation Type"::"Reverse Charge VAT":
                    BEGIN
                        Amount := ROUND("Total Cost", Currency."Amount Rounding Precision");
                        "VAT Base Amount" :=
                          ROUND(Amount, Currency."Amount Rounding Precision");
                        //Test//
                        /*"Amount Including VAT" := TotalAmount + Amount + ROUND((TotalAmount + Amount) * "VAT %" / 100,
                            Currency."Amount Rounding Precision", Currency.VATRoundingDirection) - TotalAmountInclVAT;*/
                        VALIDATE("Amount Including VAT", (TotalAmount + Amount + ROUND((TotalAmount + Amount) * "VAT %" / 100,
                            Currency."Amount Rounding Precision", Currency.VATRoundingDirection) - TotalAmountInclVAT));
                    END;
                "VAT Calculation Type"::"Full VAT":
                    BEGIN
                        Amount := 0;
                        "VAT Base Amount" := 0;
                        "Amount Including VAT" := "Total Cost";
                    END;
            /*"VAT Calculation Type"::"Sales Tax":
              BEGIN
                Amount := ROUND("Total Cost", Currency."Amount Rounding Precision");
                "VAT Base Amount" := Amount;
                IF "Use Tax" THEN
                  "Amount Including VAT" := Amount
                ELSE
                  "Amount Including VAT" :=
                    TotalAmount + Amount +
                    ROUND(
                      SalesTaxCalculate.CalculateTax(
                        "Tax Area Code","Tax Group Code","Tax Liable",PurchReqHeader."Posting Date",
                        TotalAmount + Amount, TotalQuantityBase + "Quantity (Base)",
                        PurchReqHeader."Currency Factor"),
                      Currency."Amount Rounding Precision") -
                    TotalAmountInclVAT;
                IF "VAT Base Amount" <> 0 THEN
                  "VAT %" :=
                    ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                ELSE
                  "VAT %" := 0;
              END;*/
            END;

    end;
}

