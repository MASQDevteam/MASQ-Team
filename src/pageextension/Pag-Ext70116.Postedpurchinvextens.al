pageextension 70116 "Posted purch inv extens" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter(Corrective)
        {
            field("posted Receipts"; Rec."posted Receipts")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the posted Receipts field.', Comment = '%';
            }
            field("Shipping Quotation No."; Rec."Shipping Quotation No.")
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                    ShippingQuotation: Record "Shipping Quotation";
                    ShippingQuotationsList: Page "Shipping Quotations List";
                    FilterValue: Text;
                    QuotationId: Text;
                    IdArray: List of [Text];
                begin
                    Clear(FilterValue);
                    IdArray := Rec."Shipping Quotation No.".Split(',');

                    foreach QuotationId in IdArray do begin
                        QuotationId := DelChr(QuotationId, '=', ' '); // Trim spaces

                        if FilterValue = '' then
                            FilterValue := QuotationId
                        else
                            FilterValue := FilterValue + '|' + QuotationId;
                    end;

                    if FilterValue <> '' then begin
                        ShippingQuotation.SetFilter("Comparison ID", FilterValue);
                        ShippingQuotationsList.SetTableView(ShippingQuotation);
                        ShippingQuotationsList.Run();
                    end;
                end;

            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Date field.', Comment = '%';
            }
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}