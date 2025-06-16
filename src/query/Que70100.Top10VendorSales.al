
query 70100 "Top 10 Vendor Sales"
{
    Caption = 'Top 10 Vendor Sales';
    DataAccessIntent = ReadOnly;
    OrderBy = ascending(Sum_Purchase__LCY_);
    TopNumberOfRows = 10;

    elements
    {
        dataitem(Vendor_Ledger_Entry; "Vendor Ledger Entry")
        {
            filter(Posting_Date; "Posting Date")
            {
            }
            column(Vendor_No_; "Vendor No.")
            {
            }
            column(Sum_Purchase__LCY_; "Purchase (LCY)")
            {
                Method = Sum;
            }
        }
    }
}

