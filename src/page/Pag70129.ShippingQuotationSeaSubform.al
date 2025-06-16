page 70129 "Shipping Quotation Sea Subform"
{
    PageType = ListPart;
    SourceTable = "Shipping Quotation Details";  // Referring to the table we just created
    ApplicationArea = All;

    AutoSplitKey = true;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Agent"; Rec."Agent")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        ShippingQuote: Record "Shipping Quotation";
                        shippingquoteDetials: Record "Shipping Quotation Details";
                    begin
                        Clear(ShippingQuote);
                        ShippingQuote.Get(Rec."Comparison ID");
                        Clear(shippingquoteDetials);
                        shippingquoteDetials.SetRange("Comparison ID", Rec."Comparison ID");
                        shippingquoteDetials.SetFilter(Agent, '<> %1', '');
                        ShippingQuote.Option := shippingquoteDetials.Count;
                    end;
                }

                field("Liner"; Rec."Liner")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("currency Code"; Rec."currency Code")//added on 19/03/2025
                {
                    ToolTip = 'Specifies the value of the currency Code field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
                field("Inland Transport Cost"; Rec."Inland Transport Cost")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    var
                    begin
                        Rec.Total := Rec."Export Declaration Cost" + Rec."Inland Transport Cost" + rec."Ocean Freight" + Rec.Insurance + Rec."D to D";//updated on 19/03/2025
                        IF REc."currency Code" <> '' then//added on 19/03/2025
                            Rec."Total in LCY" := CurrencyExchange.ExchangeAmtFCYToFCY(WorkDate(), Rec."currency Code", '', Rec.Total) else
                            REc."Total in LCY" := Rec.Total;
                        GetStyle();
                    end;
                }

                field("Export Declaration Cost"; Rec."Export Declaration Cost")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    var
                    begin
                        Rec.Total := Rec."Export Declaration Cost" + Rec."Inland Transport Cost" + rec."Ocean Freight" + Rec.Insurance + Rec."D to D";//updated on 19/03/2025
                        IF REc."currency Code" <> '' then//added on 19/03/2025
                            Rec."Total in LCY" := CurrencyExchange.ExchangeAmtFCYToFCY(WorkDate(), Rec."currency Code", '', Rec.Total) else
                            REc."Total in LCY" := Rec.Total;
                        GetStyle();
                    end;
                }

                field("Ocean Freight"; Rec."Ocean Freight")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    var
                    begin
                        Rec.Total := Rec."Export Declaration Cost" + Rec."Inland Transport Cost" + rec."Ocean Freight" + Rec.Insurance + Rec."D to D";//updated on 19/03/2025
                        IF REc."currency Code" <> '' then//added on 19/03/2025
                            Rec."Total in LCY" := CurrencyExchange.ExchangeAmtFCYToFCY(WorkDate(), Rec."currency Code", '', Rec.Total) else
                            REc."Total in LCY" := Rec.Total;
                        GetStyle();
                    end;
                }

                field("Insurance"; Rec."Insurance")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    var
                    begin
                        Rec.Total := Rec."Export Declaration Cost" + Rec."Inland Transport Cost" + rec."Ocean Freight" + Rec.Insurance + Rec."D to D";//updated on 19/03/2025
                        IF REc."currency Code" <> '' then//added on 19/03/2025
                            Rec."Total in LCY" := CurrencyExchange.ExchangeAmtFCYToFCY(WorkDate(), Rec."currency Code", '', Rec.Total) else
                            REc."Total in LCY" := Rec.Total;
                        GetStyle();
                    end;
                }
                field("D to D"; Rec."D to D")//added on 19/03/2025
                {
                    ToolTip = 'Specifies the value of the D to D field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    var
                    begin
                        Rec.Total := Rec."Export Declaration Cost" + Rec."Inland Transport Cost" + rec."Ocean Freight" + Rec.Insurance + Rec."D to D";//updated on 19/03/2025
                        IF REc."currency Code" <> '' then//added on 19/03/2025
                            Rec."Total in LCY" := CurrencyExchange.ExchangeAmtFCYToFCY(WorkDate(), Rec."currency Code", '', Rec.Total) else
                            REc."Total in LCY" := Rec.Total;
                        GetStyle();
                    end;
                }

                field("Total"; Rec."Total")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    var
                    begin
                        GetStyle();
                    end;
                }
                field("Total in LCY"; Rec."Total in LCY")//added on 19/03/2025
                {
                    ToolTip = 'Specifies the value of the Total in LCY field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                    CaptionClass = 'Total in ' + GLSetup."LCY Code";
                    Editable = false;
                }

                field("Transit Time"; Rec."Transit Time")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Free Demurrage"; Rec."Free Demurrage")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("number Free Demurrage"; Rec."number Free Demurrage")
                {
                    ToolTip = 'Specifies the value of the number Free Demurrage field.', Comment = '%';
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ToolTip = 'Specifies the value of the Payment Terms field.', Comment = '%';
                }
                field("Payment Terms Description"; Rec."Payment Terms Description")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Payment Terms";
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(AddRow)
            {
                ApplicationArea = All;
                //  StyleExpr = StyleExprTxt;
                trigger OnAction()
                begin
                    // Code to add a new row
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        Rec."Quotation Type" := rec."Quotation Type"::Sea;

        //   GetStyle;

    end;

    trigger OnAfterGetRecord()
    var
    begin
        GetStyle;
    end;

    // trigger OnAfterGetRecord()
    // var
    //     ShippingQuotationDetails: Record "Shipping Quotation Details";
    // begin
    //     IF rec.Total <> 0 then begin
    //         If Rec.Total > 10 then
    //             StyleExprTxt := 'Unfavorable'
    //         else
    //             If Rec.Total < 10 then
    //                 StyleExprTxt := 'Favorable'
    //             else
    //                 StyleExprTxt := 'None'
    //     end;
    //     CurrPage.Update(false);
    // end;


    local procedure GetStyle()

    var
        ShippingQuotationDetails: Record "Shipping Quotation Details";
        HighestTotal: Decimal;
        LowestTotal: Decimal;
    begin
        HighestTotal := 0;
        LowestTotal := 0;
        IF rec."Total in LCY" <> 0 then begin
            Clear(ShippingQuotationDetails);
            ShippingQuotationDetails.SetRange("Comparison ID", Rec."Comparison ID");
            IF ShippingQuotationDetails.count = 1 then
                exit;


            Clear(ShippingQuotationDetails);
            ShippingQuotationDetails.SetCurrentKey("Total in LCY");
            ShippingQuotationDetails.Ascending(false);
            ShippingQuotationDetails.SetRange("Comparison ID", Rec."Comparison ID");
            // ShippingQuotationDetails.SetFilter("Line No.", '<> %1', Rec."Line No.");
            //    ShippingQuotationDetails.SetFilter(Total, '> %1', Rec.Total);
            IF ShippingQuotationDetails.FindFirst() then begin
                //  ChangeRecordStyle(ShippingQuotationDetails, 'Unfavorable');
                HighestTotal := ShippingQuotationDetails."Total in LCY";
            end;
            // end
            // else begin
            //     StyleExprTxt := 'Unfavorable';
            //     //  Rec.Modify();
            // end;



            Clear(ShippingQuotationDetails);
            ShippingQuotationDetails.SetCurrentKey("Total in LCY");
            ShippingQuotationDetails.Ascending(true);
            ShippingQuotationDetails.SetRange("Comparison ID", Rec."Comparison ID");
            //    ShippingQuotationDetails.SetFilter("Line No.", '<> %1', Rec."Line No.");
            //   ShippingQuotationDetails.SetFilter(Total, '< %1', Rec.Total);
            IF ShippingQuotationDetails.FindFirst() then begin
                //   ChangeRecordStyle(ShippingQuotationDetails, 'Favorable');
                LowestTotal := ShippingQuotationDetails."Total in LCY";
            end;
            // end
            // else begin
            //     StyleExprTxt := 'Favorable';

            //   Rec.Modify();
        end;

        StyleExprTxt := 'None';
        IF Rec."Total in LCY" = HighestTotal then begin
            StyleExprTxt := 'Unfavorable';
        end;

        IF Rec."Total in LCY" = LowestTotal then begin
            StyleExprTxt := 'Favorable';
        end;

    end;

    local procedure ChangeRecordStyle(var ShippingQuotationDetails: Record "Shipping Quotation Details"; StyleExprTxt: Text)
    var
    begin
        ShippingQuotationDetails.StyleExprTxt := StyleExprTxt;
        ShippingQuotationDetails.Modify();
    end;

    trigger OnOpenPage()
    var
    begin
        GLSetup.Get();
    end;

    var
        StyleExprTxt: Text;
        CurrencyExchange: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";




}
