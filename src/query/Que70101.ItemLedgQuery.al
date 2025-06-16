query 70101 "Item Ledg Query"
{
    APIGroup = 'MASQ';
    APIPublisher = 'MASQ';
    APIVersion = 'beta';
    EntityName = 'ItemLedgQuery';
    EntitySetName = 'ItemLedgQuery';
    QueryType = API;
    elements
    {
        dataitem(itemLedgerEntry; "Item Ledger Entry")
        {
            column(itemNo; "Item No.")
            {
            }
            column(quantity; Quantity)
            {
                Method = Sum;
            }
            column(Location_Code; "Location Code")
            {

            }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
