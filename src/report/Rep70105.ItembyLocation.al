report 70105 "Item by Location"
{
    ApplicationArea = All;
    Caption = 'Item by Location';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'ItembyLocation.rdl';
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.";
            column(ItemNo; "Item No.")
            {
            }
            column(Description; Description)
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
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
}
