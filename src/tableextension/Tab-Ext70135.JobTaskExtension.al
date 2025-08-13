tableextension 70135 "Job Task Extension" extends "Job Task"
{
    fields
    {

        // Add changes to table fields here
        field(70100; "Usage (Total Cost) Freight"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Actual (Total Cost) Freight" where("Job No." = field("Job No."),
                                                                           "Job Task No." = field("Job Task No."),
                                                                           "Job Task No." = field(filter(Totaling)),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Actual (Total Cost) Freight';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70101; "Usage (Total Cost) Customs"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Actual (Total Cost) Custom" where("Job No." = field("Job No."),
                                                                           "Job Task No." = field("Job Task No."),
                                                                           "Job Task No." = field(filter(Totaling)),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Actual (Total Cost) Customs';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70102; "Usage (Total Cost) Clearance"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Actual (Total Cost) Clearance" where("Job No." = field("Job No."),
                                                                           "Job Task No." = field("Job Task No."),
                                                                           "Job Task No." = field(filter(Totaling)),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Actual (Total Cost) Clearance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70103; "Usage (Total Cost) Others"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Actual (Total Cost) Others" where("Job No." = field("Job No."),
                                                                           "Job Task No." = field("Job Task No."),
                                                                           "Job Task No." = field(filter(Totaling)),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Actual (Total Cost) Others';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70104; "Usage (Total Landed Cost)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Actual (Landed Cost)';
            Editable = false;

        }

        field(70105; "Schedule (Total Cost) Freight"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Freight Cost" where("Job No." = field("Job No."),
                                                                            "Job Task No." = field("Job Task No."),
                                                                            "Job Task No." = field(filter(Totaling)),
                                                                            "Schedule Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Budget (Total Cost) Freight';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70106; "Schedule (Total Cost) C & C"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Planning Line"."Custom & Clearance Cost" where("Job No." = field("Job No."),
                                                                            "Job Task No." = field("Job Task No."),
                                                                            "Job Task No." = field(filter(Totaling)),
                                                                            "Schedule Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Budget (Total Cost) C & C';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70107; "Schedule (Total Landed Cost)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Budget (Landed Cost)';
            Editable = false;

        }

        field(50102; "Budget Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Planning Line"."Total Cost" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling)), "Schedule Line" = CONST(true), "Planning Date" = FIELD("Planning Date Filter"), "Line Type" = CONST(Budget)));
            Caption = 'Budget Amount';
            Description = 'PurchReq';
            Editable = false;
            Enabled = true;
            FieldClass = FlowField;

            // trigger OnLookup()
            // var
            //     BudgetSubscriberEvents: Codeunit "Budget Subscriber Events";
            // begin
            //     BudgetSubscriberEvents.LookupJobPlanningLinesBudgetDetails(Rec);//AI+-
            //                                                                     //  LookupJobPlanningLinesBudgetDetails(Rec); //PurchReq+-
            // end;
        }
        field(50103; "Paid Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = false;
            CalcFormula = Sum("Job Ledger Entry"."Total Cost" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling)), "Entry Type" = CONST(Usage), "Posting Date" = FIELD("Posting Date Filter"), Type = FILTER('Resource | G/L Account'), "Source Code" = FILTER('PAYMENTJNL|FINVOIDCHK|REVERSAL|GENJNL'), "No." = FILTER('<>6*')));
            Caption = 'Paid Amount';
            Description = 'PurchReq';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50106; "Remaining from PO"; Decimal)
        {
            Description = 'PurchReq';
            Editable = false;

        }
        field(50107; "Remaining from PPI"; Decimal)
        {
            Description = 'PurchReq';
            Editable = false;
        }
        field(50108; "Remaining from Budget"; Decimal)
        {
            Description = 'PurchReq';
            Editable = false;
        }
        field(50111; "Currency Code"; Code[10])
        {
            CalcFormula = Lookup(Job."Currency Code" WHERE("No." = FIELD("Job No.")));
            Description = 'PurchReq';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50114; "Remaining From Financial"; Decimal)
        {
            Description = 'PayReq';
            Editable = false;
        }
        field(50117; "Paid Financial Amount"; Decimal)
        {
            CalcFormula = Sum("Job Ledger Entry"."Total Cost" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling)), "Source Code" = FILTER('PAYMENTJNL')/*, "Journal Batch Name" = FIELD(FILTER("Payment Batch Filter")), "Posting Date" = FIELD("Posting Date Filter")*/));
            Description = 'PayReq';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50118; "Grace Percentage"; Decimal)
        {
            Description = 'PurchReq,PayReq';
            MinValue = 0;
        }
        field(50124; "G/L Financial Amount LCY"; Decimal)
        {
            Caption = 'G/L Financial Amount LCY';
            Description = 'PurchReq';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("Job No." = FIELD("Job No."),/* "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling)), */"Source Code" = FILTER('<>SALES&<>PURCHASES&<>FINVOIDCHK')/*, "Posting Date" = FIELD("Date Filter"), "G/L Account No." = FIELD(FILTER("G/L Account Filter")*/));

        }
        field(50125; "G/L Financial Amount ACY"; Decimal)
        {
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("Job No." = FIELD("Job No.")/*, "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling))*/, "Source Code" = FILTER('<>SALES&<>PURCHASES&<>FINVOIDCHK')/*, "Posting Date" = FIELD("Date Filter"), "G/L Account No." = FIELD(FILTER("G/L Account Filter"))*/));
            Caption = 'G/L Financial Amount ACY';
            Description = 'PurchReq';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50127; "G/L Account Filter"; Code[50])
        {
            Description = 'PurchReq';
        }
        field(50128; "PPI Amount LCY"; Decimal)
        {
            Description = 'PurchReq';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("Job No." = FIELD("Job No.")/*, "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling))*/, "Source Code" = CONST('PURCHASES')/* ,"Posting Date" = FIELD("Date Filter"), "G/L Account No." = FIELD(FILTER("G/L Account Filter")*/));

        }
        field(50129; "PPI Amount ACY"; Decimal)
        {
            Description = 'PurchReq';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("Job No." = FIELD("Job No.")/*,"Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling))*/, "Source Code" = CONST('PURCHASES')/*, "Posting Date" = FIELD("Date Filter"), "G/L Account No." = FIELD(FILTER("G/L Account Filter")*/));

        }
        field(70108; "Schedule (Total Cost) COF"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Planning Line".COF where("Job No." = field("Job No."),
                                                                            "Job Task No." = field("Job Task No."),
                                                                            "Job Task No." = field(filter(Totaling)),
                                                                            "Schedule Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Budget (Total Cost) COF';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70109; "Usage (Total Quantity)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry".Quantity where("Job No." = field("Job No."),
                                                                           "Job Task No." = field("Job Task No."),
                                                                           "Job Task No." = field(filter(Totaling)),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Actual (Total Quantity)';
            Editable = false;
            FieldClass = FlowField;
        }

        field(70110; "Contract (Invoiced Quantity)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = - sum("Job Ledger Entry".Quantity where("Job No." = field("Job No."),
                                                                             "Job Task No." = field("Job Task No."),
                                                                             "Job Task No." = field(filter(Totaling)),
                                                                             "Entry Type" = const(Sale),
                                                                             "Posting Date" = field("Posting Date Filter")));
            Caption = 'Invoiced (Total Quantity)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70111; "Usage (Total Cost) Insurance"; Decimal)//added on 10022025
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Ledger Entry"."Actual (Total Cost) Insurance" where("Job No." = field("Job No."),
                                                                           "Job Task No." = field("Job Task No."),
                                                                           "Job Task No." = field(filter(Totaling)),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Actual (Total Cost) Insurance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70112; "Schedule (Total Cost) Insurance"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job Planning Line".Insurance where("Job No." = field("Job No."),
                                                                            "Job Task No." = field("Job Task No."),
                                                                            "Job Task No." = field(filter(Totaling)),
                                                                            "Schedule Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Budget (Total Cost) Insurance';
            Editable = false;
            FieldClass = FlowField;
        }

        field(70113; "Ordered PO"; Decimal)
        {
            //  DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Line Amount LCY" where("Document Type" = const(Order), "Job No." = field("Job No."), "Job Task No." = field("Job Task No.")));
        }
        field(70114; "Ordered PO Qty"; Decimal)
        {
            //  DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document Type" = const(Order), "Job No." = field("Job No."), "Job Task No." = field("Job Task No.")));
        }
        field(70115; "Allocated Job Expenses"; Decimal)//added on 04/03/2025
        {
            //    DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Job Expense Allocation".Amount where("Project Code" = field("Job No.")));
        }
        field(70116; "Expected Financial Amount"; Decimal)
        {
            CalcFormula = Sum("Gen. Journal Line"."Amount (LCY)" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling)), "Source Code" = CONST('GENJNL')));
            Description = 'EDM.PayReq';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70117; "Amount on Purch. Orders"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Line Amount LCY" WHERE("Document Type" = CONST(Order), "Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling))));
            Description = 'EDM.PurchReq';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70118; "Purchase Credit Memo Amount"; Decimal)
        {
            CalcFormula = Sum("Purch. Cr. Memo Line"."Line Amount LCY" WHERE("Job No." = FIELD("Job No."), "Job Task No." = FIELD("Job Task No."), "Job Task No." = FIELD(FILTER(Totaling))));
            Description = 'EDM.PurchReq';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70119; "Not All Email Sent"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Job Planning Line" WHERE("Email Sent" = const(false), "Job No." = field("Job No."), "Job Task No." = field("Job Task No.")));
        }
        field(70120; "Usage (Total Cost) Freight1"; Decimal)//added on 13082025
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Actual (Total Cost) Freight new';
            Editable = false;

        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    procedure UpdateBudgetValues(var Rec: Record "Job Task"; UpdateData: Boolean): Decimal
    var
        PPIAmount: Decimal;
        GLSetup: Record "General Ledger Setup";
    begin
        //EDM.PurchReq+
        GLSetup.get();


        Rec.CALCFIELDS("Amount on Purch. Orders", "Paid Amount",
          "Budget Amount"/*, "Remaining from PR"*/, "G/L Financial Amount LCY", "Paid Financial Amount",
          "Expected Financial Amount", "Purchase Credit Memo Amount", "Currency Code",
          "G/L Financial Amount LCY", "PPI Amount LCY");
        CASE Rec."Currency Code" OF
            '':
                BEGIN
                    Rec."Remaining From Financial" := Rec."G/L Financial Amount LCY";
                    PPIAmount := Rec."PPI Amount LCY";
                END;
        // 'EURO':
        //     BEGIN
        //         if CompanyName = 'AVSI IRAK' then begin
        //             Rec."Remaining From Financial" := Rec."G/L Financial Amount USD";
        //             PPIAmount := Rec."PPI Amount USD";

        //         end
        //         else begin
        //             Rec."Remaining From Financial" := Rec."G/L Financial Amount EURO";
        //             PPIAmount := Rec."PPI Amount EURO";
        //         end;
        //     END;
        // 'USD':
        //     BEGIN
        //         if CompanyName = 'AVSI IRAK' then begin
        //             Rec."Remaining From Financial" := Rec."G/L Financial Amount EURO";
        //             PPIAmount := Rec."PPI Amount EURO";
        //         end
        //         else begin
        //             Rec."Remaining From Financial" := Rec."G/L Financial Amount USD";
        //             PPIAmount := Rec."PPI Amount USD";
        //         end;
        //     END;
        END;
        Rec."Remaining from PO" := Rec."Amount on Purch. Orders"; // - Rec."Amount on Prepayment PO";
        Rec."Remaining from PPI" := PPIAmount - Rec."Purchase Credit Memo Amount"; // + Rec."Usage (Total Cost) Orig." ;
        //Rec."Remaining from PPI" := Rec."Amount on Purch. Invoices" - Rec."Purchase Credit Memo Amount"; // + Rec."Usage (Total Cost) Orig." ;
        //Rec."Remaining From Financial" := Rec."Financial Amount"; // - Rec."Paid Financial Amount";
        Rec."Remaining from Budget" := Rec."Budget Amount" - Rec."Remaining from PO" - Rec."Remaining from PPI" -
     /*    - Rec."Remaining from PR" */-Rec."Remaining From Financial" -
       -Rec."Expected Financial Amount"; // - Rec."Bank Charges Amount";

        IF UpdateData THEN
            Rec.MODIFY;
        //ELSE
        EXIT(Rec."Remaining from Budget");

        //EDM.PurchReq-
    end;

    var
        myInt: Integer;
}