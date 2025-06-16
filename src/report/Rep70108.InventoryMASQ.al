report 70108 "Inventory_MASQ"
{
    ApplicationArea = All;
    Caption = 'Inventory';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Inventory_MASQ.rdl';
    dataset
    {

        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.", "Location Code", "Warehouse Category";
            DataItemTableView = sorting("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date") where("Entry Type" = filter(Sale | Purchase));
            column(ItemNo; "Item No.")
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Description; Description)
            {
            }
            column(OpeningBalance; OpeningBal)
            {
            }

            column(Inbound; InboundQty)
            {
            }
            column(Outbound; OutboundQty)
            {
            }
            column(ClosingBalance; ClosingBalance)
            {
            }
            column(Quantity; Quantity)
            {

            }
            column(Entry_Type; "Entry Type")
            {
            }
            column(CostAmountActual; "Cost Amount (Actual)")
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(StartDate; StartDate)
            {

            }
            column(EndDate; EndDate)
            {

            }
            trigger OnAfterGetRecord()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                Clear(ItemLedgEntry);
                if xitem <> ItemLedgerEntry."Item No." then begin
                    ClosingBalance := 0;
                    OpeningBal := 0;
                end;
                InboundQty := 0;
                OutboundQty := 0;
                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetFilter("Posting Date", '<%1', StartDate);
                ItemLedgEntry.CalcSums(ItemLedgEntry.Quantity);
                OpeningBal := ItemLedgEntry.Quantity;

                if ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase then
                    InboundQty := ItemLedgerEntry.Quantity;
                if ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Sale then
                    OutboundQty := ItemLedgerEntry.Quantity;


                xitem := ItemLedgerEntry."Item No.";
                if ClosingBalance = 0 then
                    ClosingBalance := OpeningBal + InboundQty + OutboundQty
                else
                    ClosingBalance := ClosingBalance + InboundQty + OutboundQty;

            end;


            trigger OnPreDataItem()
            begin
                ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Date Filters")
                {
                    field(StartDate; StartDate) { ApplicationArea = All; }
                    field(EndDate; EndDate) { ApplicationArea = All; }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        InboundQty: Decimal;
        OutboundQty: Decimal;
        OpeningBal: Decimal;
        ClosingBalance: Decimal;
        xitem: code[20];
        CompanyInfo: Record "Company Information";

}
