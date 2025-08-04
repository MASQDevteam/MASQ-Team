reportextension 70105 MegPurchaseOrderNewQatar extends "Meg Purchase Order"
{
    RDLCLayout = 'MegPurchaseOrderNew.rdl';
    dataset
    {
        add("Purchase Header")
        {
            column(Order_Date; "Order Date")
            {

            }
        }
        add("Purchase Line")
        {
            column(PurchLineType; Type)
            {

            }
            column(PNo_; "No.")
            {

            }
            column(PDescription; Description)
            {

            }
        }

    }

}
