pageextension 70143 "Job Task Subform extension" extends "Job Task Lines Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Usage (Total Price)")
        {
            field("Usage (Total Cost) Freight"; Rec."Usage (Total Cost) Freight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Freight field.', Comment = '%';
            }
            //FQ MASQ  **Start**
            /*  field("Usage (Total Cost) Freight1"; UsageTotalCostFreight1)
             {
                 ApplicationArea = All;
                 Caption = 'Actual (Total Cost) Freight new';
                 ToolTip = 'Calculated from G/L Entries using Job No. or Global Dimension 1 Code when Job No. is blank.', Comment = '%';
                 Editable = false;
             }
             field("Usage (Total Cost) Customs1"; UsageTotalCostCustoms1)
             {
                 ApplicationArea = All;
                 Caption = 'Actual (Total Cost) Customs new';
                 ToolTip = 'Calculated from G/L Entries using Job No. or Global Dimension 1 Code when Job No. is blank.', Comment = '%';
                 Editable = false;
             }
             field("Usage (Total Cost) Clearance1"; UsageTotalCostClearance1)
             {
                 ApplicationArea = All;
                 Caption = 'Actual (Total Cost) Clearance new';
                 ToolTip = 'Calculated from G/L Entries using Job No. or Global Dimension 1 Code when Job No. is blank.', Comment = '%';
                 Editable = false;
             }
             field("Usage (Total Cost) Insurance1"; UsageTotalCostInsurance1)
             {
                 ApplicationArea = All;
                 Caption = 'Actual (Total Cost) Insurance new';
                 ToolTip = 'Calculated from G/L Entries using Job No. or Global Dimension 1 Code when Job No. is blank.', Comment = '%';
                 Editable = false;
             }
             field("Usage (Total Cost) Others1"; UsageTotalCostOthers1)
             {
                 ApplicationArea = All;
                 Caption = 'Actual (Total Cost) Others new';
                 ToolTip = 'Calculated from G/L Entries using Job No. or Global Dimension 1 Code when Job No. is blank.', Comment = '%';
                 Editable = false;
             }
             field("Usage (Total Cost) Cost"; Rec."Usage (Total Cost)1.")
             {
                 ApplicationArea = All;
                 ToolTip = 'Specifies the value of the Actual (Total Cost) Cost field.', Comment = '%';
             }
             field("Usage (Total Landed Cost)1"; Rec."Usage (Total Landed Cost)1")
             {
                 ApplicationArea = All;
             } */
            //FQ MASQ  **END**
            field("Usage (Total Cost) Customs"; Rec."Usage (Total Cost) Customs")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Customs field.', Comment = '%';
            }
            field("Usage (Total Cost) Clearance"; Rec."Usage (Total Cost) Clearance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Clearance field.', Comment = '%';
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
            field("Usage (Total Quantity)"; Rec."Usage (Total Quantity)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Quantity) field.', Comment = '%';
            }
            field("Allocated Job Expenses"; Rec."Allocated Job Expenses")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allocated Job Expenses field.', Comment = '%';
                Editable = false;
                // Enabled = false;
            }
        }
        addafter("Schedule (Total Price)")
        {
            field("Schedule (Total Cost) Freight"; Rec."Schedule (Total Cost) Freight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Cost) Freight field.', Comment = '%';
            }
            field("Schedule (Total Cost) C & C"; Rec."Schedule (Total Cost) C & C")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Cost) C & C field.', Comment = '%';
            }
            field("Schedule (Total Cost) COF"; Rec."Schedule (Total Cost) COF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Cost) COF field.', Comment = '%';
            }
            field("Schedule (Total Landed Cost)"; Rec."Schedule (Total Landed Cost)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Landed Cost) field.', Comment = '%';
            }
            field("Recognized Costs Amount"; Rec."Recognized Costs Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Recognized Costs Amount field.', Comment = '%';
            }
            field("Recognized Sales Amount"; Rec."Recognized Sales Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Recognized Sales Amount field.', Comment = '%';
            }
            field("Schedule (Total Cost) Insurance"; Rec."Schedule (Total Cost) Insurance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Budget (Total Cost) Insurance field.', Comment = '%';
            }
            field("Ordered PO"; Rec."Ordered PO")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ordered PO field.', Comment = '%';
            }
            field("Ordered PO Qty"; Rec."Ordered PO Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ordered PO Qty field.', Comment = '%';
            }

        }
        addafter("Contract (Invoiced Price)")
        {
            field("Contract (Invoiced Quantity)"; Rec."Contract (Invoiced Quantity)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoiced (Total Quantity) field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        modify(Documents)
        {
            Visible = false;
        }
    }
    //FQ MASQ  **Start**
    trigger OnAfterGetRecord()
    var
    begin
        // RecalculateUsageTotalCostFreight1();
        //RecalculateUsageTotalCostCustoms1();
        // RecalculateUsageTotalCostClearance1();
        // RecalculateUsageTotalCostInsurance1();
        // RecalculateUsageTotalCostOthers1();
        // RecalculateUsageActualTotalCost1();
        // Rec.CalcFields("Usage (Total Cost)", "Usage (Total Cost) Freight", "Usage (Total Cost) Clearance", "Usage (Total Cost) Customs", "Usage (Total Cost) Others", "Usage (Total Cost) Insurance");
        // Rec."Usage (Total Landed Cost)1" := Rec."Usage (Total Cost)1." + Rec."Usage (Total Cost) Freight1" + Rec."Usage (Total Cost) Clearance1"
        // + Rec."Usage (Total Cost) Customs1" + Rec."Usage (Total Cost) Others1" + Rec."Usage (Total Cost) Insurance1";
        //Added by FQ on 13082025 **End**
        REc.CalcFields("Schedule (Total Cost)", "Schedule (Total Cost) C & C", "Schedule (Total Cost) Freight", "Schedule (Total Cost) COF", "Schedule (Total Cost) Insurance");
        Rec."Schedule (Total Landed Cost)" := rec."Schedule (Total Cost)" +
        Rec."Schedule (Total Cost) C & C" + Rec."Schedule (Total Cost) Freight" + Rec."Schedule (Total Cost) COF" + Rec."Schedule (Total Cost) Insurance";
        Rec.CalcFields("Usage (Total Cost)", "Usage (Total Cost) Clearance", "Usage (Total Cost) Customs", "Usage (Total Cost) Freight", "Usage (Total Cost) Others", "Usage (Total Cost) Insurance");//added on 10022025
        Rec."Usage (Total Landed Cost)" := Rec."Usage (Total Cost)" + rec."Usage (Total Cost) Freight" + Rec."Usage (Total Cost) Clearance"
        + Rec."Usage (Total Cost) Customs" + Rec."Usage (Total Cost) Others" + Rec."Usage (Total Cost) Insurance";//updated on 10022025


    end;

    /* 
        local procedure RecalculateUsageTotalCostFreight1()
        var
            glByJob: Record "G/L Entry";
            glByDim: Record "G/L Entry";
            job: Record Job;
            dim1Code: Text[250];
            sumJob: Decimal;
            sumDim: Decimal;
        begin
            UsageTotalCostFreight1 := 0;
            sumJob := 0;
            sumDim := 0;

            // Sum entries linked to the Job directly
            glByJob.Reset();
            glByJob.SetRange("Gen. Prod. Posting Group", 'FREIGHT');
            glByJob.SetRange("Job No.", rec."Job No.");
            if glByJob."Job No." <> '' then begin
                glByJob.CalcSums(Amount);
                sumJob := glByJob.Amount;
            end;
            // Sum entries posted without Job No. but tagged with the Job's Apollo Project Number via Global Dimension 1 Code (Project Code)
            if (glByJob."Job No." = '') and job.Get(Rec."Job No.") then begin
                dim1Code := NormalizeApolloToDim1Filter(job."Apollo Project Number");
                if dim1Code <> '' then begin
                    glByDim.Reset();
                    glByDim.SetRange("Gen. Prod. Posting Group", 'FREIGHT');
                    glByDim.SetFilter("Global Dimension 1 Code", dim1Code);
                    glByDim.CalcSums(Amount);
                    sumDim := glByDim.Amount;
                end;
            end;
            UsageTotalCostFreight1 := sumJob + sumDim;
            Rec."Usage (Total Cost) Freight1" := UsageTotalCostFreight1;
        end;

        local procedure RecalculateUsageTotalCostCustoms1()
        var
            glByJob: Record "G/L Entry";
            glByDim: Record "G/L Entry";
            job: Record Job;
            dim1Code: Text[250];
            sumJob: Decimal;
            sumDim: Decimal;
        begin
            UsageTotalCostCustoms1 := 0;
            sumJob := 0;
            sumDim := 0;

            // Sum entries linked to the Job directly
            glByJob.Reset();
            glByJob.SetRange("Gen. Prod. Posting Group", 'CUSTOMS');
            glByJob.SetRange("Job No.", rec."Job No.");
            if glByJob."Job No." <> '' then begin
                glByJob.CalcSums(Amount);
                sumJob := glByJob.Amount;
            end;
            // Sum entries posted without Job No. but tagged with the Job's Apollo Project Number via Global Dimension 1 Code (Project Code)
            if (glByJob."Job No." = '') and job.Get(Rec."Job No.") then begin
                dim1Code := NormalizeApolloToDim1Filter(job."Apollo Project Number");
                if dim1Code <> '' then begin
                    glByDim.Reset();
                    glByDim.SetRange("Gen. Prod. Posting Group", 'CUSTOMS');
                    glByDim.SetFilter("Global Dimension 1 Code", dim1Code);
                    glByDim.CalcSums(Amount);
                    sumDim := glByDim.Amount;
                end;
            end;
            UsageTotalCostCustoms1 := sumJob + sumDim;
            Rec."Usage (Total Cost) Customs1" := UsageTotalCostCustoms1;
        end;

        local procedure RecalculateUsageTotalCostClearance1()
        var
            glByJob: Record "G/L Entry";
            glByDim: Record "G/L Entry";
            job: Record Job;
            dim1Code: Text[250];
            sumJob: Decimal;
            sumDim: Decimal;
        begin
            UsageTotalCostClearance1 := 0;
            sumJob := 0;
            sumDim := 0;

            // Sum entries linked to the Job directly
            glByJob.Reset();
            glByJob.SetRange("Gen. Prod. Posting Group", 'CLEARING');
            glByJob.SetRange("Job No.", rec."Job No.");
            if glByJob."Job No." <> '' then begin
                glByJob.CalcSums(Amount);
                sumJob := glByJob.Amount;
            end;
            // Sum entries posted without Job No. but tagged with the Job's Apollo Project Number via Global Dimension 1 Code (Project Code)
            if (glByJob."Job No." = '') and job.Get(Rec."Job No.") then begin
                dim1Code := NormalizeApolloToDim1Filter(job."Apollo Project Number");
                if dim1Code <> '' then begin
                    glByDim.Reset();
                    glByDim.SetRange("Gen. Prod. Posting Group", 'CLEARING');
                    glByDim.SetFilter("Global Dimension 1 Code", dim1Code);
                    glByDim.CalcSums(Amount);
                    sumDim := glByDim.Amount;
                end;
            end;
            UsageTotalCostClearance1 := sumJob + sumDim;
            Rec."Usage (Total Cost) Clearance1" := UsageTotalCostClearance1;
        end;

        local procedure RecalculateUsageTotalCostInsurance1()
        var
            glByJob: Record "G/L Entry";
            glByDim: Record "G/L Entry";
            job: Record Job;
            dim1Code: Text[250];
            sumJob: Decimal;
            sumDim: Decimal;
        begin
            UsageTotalCostInsurance1 := 0;
            sumJob := 0;
            sumDim := 0;

            // Sum entries linked to the Job directly
            glByJob.Reset();
            glByJob.SetRange("Gen. Prod. Posting Group", 'INSURANCE');
            glByJob.SetRange("Job No.", rec."Job No.");
            if glByJob."Job No." <> '' then begin
                glByJob.CalcSums(Amount);
                sumJob := glByJob.Amount;
            end;
            // Sum entries posted without Job No. but tagged with the Job's Apollo Project Number via Global Dimension 1 Code (Project Code)
            if (glByJob."Job No." = '') and job.Get(Rec."Job No.") then begin
                dim1Code := NormalizeApolloToDim1Filter(job."Apollo Project Number");
                if dim1Code <> '' then begin
                    glByDim.Reset();
                    glByDim.SetRange("Gen. Prod. Posting Group", 'INSURANCE');
                    glByDim.SetFilter("Global Dimension 1 Code", dim1Code);
                    glByDim.CalcSums(Amount);
                    sumDim := glByDim.Amount;
                end;
            end;
            UsageTotalCostInsurance1 := sumJob + sumDim;
            Rec."Usage (Total Cost) Insurance1" := UsageTotalCostInsurance1;
        end;

        local procedure RecalculateUsageTotalCostOthers1()
        var
            glByJob: Record "G/L Entry";
            glByDim: Record "G/L Entry";
            job: Record Job;
            dim1Code: Text[250];
            sumJob: Decimal;
            sumDim: Decimal;
        begin
            UsageTotalCostOthers1 := 0;
            sumJob := 0;
            sumDim := 0;

            // Sum entries linked to the Job directly
            glByJob.Reset();
            glByJob.SetRange("Gen. Prod. Posting Group", 'OTHEREXP TAXABLE');
            glByJob.SetRange("Job No.", rec."Job No.");
            if glByJob."Job No." <> '' then begin
                glByJob.CalcSums(Amount);
                sumJob := glByJob.Amount;
            end;
            // Sum entries posted without Job No. but tagged with the Job's Apollo Project Number via Global Dimension 1 Code (Project Code)
            if (glByJob."Job No." = '') and job.Get(Rec."Job No.") then begin
                dim1Code := NormalizeApolloToDim1Filter(job."Apollo Project Number");
                if dim1Code <> '' then begin
                    glByDim.Reset();
                    glByDim.SetRange("Gen. Prod. Posting Group", 'OTHEREXP TAXABLE');
                    glByDim.SetFilter("Global Dimension 1 Code", dim1Code);
                    glByDim.CalcSums(Amount);
                    sumDim := glByDim.Amount;
                end;
            end;
            UsageTotalCostOthers1 := sumJob + sumDim;
            Rec."Usage (Total Cost) Others1" := UsageTotalCostOthers1;
        end;

        local procedure RecalculateUsageActualTotalCost1()
        var
            glByJob: Record "G/L Entry";
            glByDim: Record "G/L Entry";
            job: Record Job;
            dim1Code: Text[250];
            sumJob: Decimal;
            sumDim: Decimal;
        begin
            UsageTotalCostOthers1 := 0;
            sumJob := 0;
            sumDim := 0;

            // Sum entries linked to the Job directly
            glByJob.Reset();
            glByJob.SetRange("Job No.", rec."Job No.");
            if glByJob."Job No." <> '' then begin
                glByJob.CalcSums(Amount);
                sumJob := glByJob.Amount;
            end;
            // Sum entries posted without Job No. but tagged with the Job's Apollo Project Number via Global Dimension 1 Code (Project Code)
            if (glByJob."Job No." = '') and job.Get(Rec."Job No.") then begin
                dim1Code := NormalizeApolloToDim1Filter(job."Apollo Project Number");
                if dim1Code <> '' then begin
                    glByDim.Reset();
                    glByDim.SetFilter("Global Dimension 1 Code", dim1Code);
                    glByDim.CalcSums(Amount);
                    sumDim := glByDim.Amount;
                end;
            end;
            UsageActualTotalCost1 := sumJob + sumDim;
            Rec."Usage (Total Cost)1." := UsageActualTotalCost1;
        end;

        local procedure NormalizeApolloToDim1Filter(ApolloValue: Text[250]): Text[250]
        var
            filterText: Text[250];
            work: Text[250];
        begin
            work := ApolloValue;
            if work = '' then
                exit('');

            // Convert common multi-value separators to '|'
            work := ReplaceAll(work, ',', '|');
            work := ReplaceAll(work, ';', '|');
            work := ReplaceAll(work, '/', '|');
            work := ReplaceAll(work, '\\', '|');
            // Replace textual AND variants with '|'
            work := ReplaceAll(work, ' AND ', '|');
            work := ReplaceAll(work, ' and ', '|');
            work := ReplaceAll(work, 'And', '|');
            work := ReplaceAll(work, 'AND', '|');
            // Remove spaces
            work := ReplaceAll(work, ' ', '');

            // Remove duplicate pipes
            while StrPos(work, '||') > 0 do
                work := ReplaceAll(work, '||', '|');

            // Trim pipes from ends
            if CopyStr(work, 1, 1) = '|' then
                work := CopyStr(work, 2);
            if (StrLen(work) > 0) and (CopyStr(work, StrLen(work), 1) = '|') then
                work := CopyStr(work, 1, StrLen(work) - 1);

            filterText := work;
            exit(filterText);
        end;

        local procedure ReplaceAll(Input: Text[250]; FindWhat: Text[50]; ReplaceWith: Text[50]): Text[250]
        var
            result: Text[250];
            pos: Integer;
        begin
            result := Input;
            if (FindWhat = '') then
                exit(result);
            pos := StrPos(result, FindWhat);
            while pos > 0 do begin
                result := CopyStr(result, 1, pos - 1) + ReplaceWith + CopyStr(result, pos + StrLen(FindWhat));
                pos := StrPos(result, FindWhat);
            end;
            exit(result);
        end;
      */   //FQ MASQ **End**
    var
        myInt: Integer;
        UsageTotalCostFreight1: Decimal;
        UsageTotalCostCustoms1: Decimal;
        UsageTotalCostClearance1: Decimal;
        UsageTotalCostInsurance1: Decimal;
        UsageTotalCostOthers1: Decimal;
        UsageActualTotalCost1: Decimal;
}