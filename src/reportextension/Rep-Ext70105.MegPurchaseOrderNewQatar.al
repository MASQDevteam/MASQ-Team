reportextension 70105 MegPurchaseOrderNewQatar extends "Meg Purchase Order"
{
    RDLCLayout = 'MegPurchaseOrderNew.rdl';
    dataset
    {
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
