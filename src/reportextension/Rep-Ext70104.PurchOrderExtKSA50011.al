reportextension 70104 PurchOrderExtKSA50011 extends "Meg Purchase Order KSA"
{
    RDLCLayout = 'MegPurchaseOrderKSANew.rdl';
    dataset
    {
        add("Purchase Line")
        {
            column(PurchLineType; Type)
            {

            }
            // column(ProjNo; ProjNo)c:\Users\Aya Natour\Downloads\MegPurchaseOrder.rdl
            // {
            // }
            column(PNo_; "No.")
            {

            }
            column(PDescription; Description)
            {

            }
        }
        modify("Purchase Line")
        {

        }
    }

}

