reportextension 70106 MegPurchaseOrderDraftNewQatar extends "Meg Purchase Order Draft"
{
    RDLCLayout = 'MegPurchaseOrderDraftNew.rdl';
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
