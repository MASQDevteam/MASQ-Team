reportextension 70104 PurchOrderExtKSA50011 extends "Meg Purchase Order KSA"
{
    RDLCLayout = 'MegPurchaseOrderKSANew.rdl';
    dataset
    {
        add("Purchase Header")
        {
            column(Order_Date; "Order Date")
            {

            }

            //NB MASQ Start
            column(SystemCreatedByVar; SystemCreatedByVar)
            {

            }
            column(Assigned_User_ID; "Assigned User ID")
            {

            }
            //NB MASQ End
            
        }
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

        //NB MASQ Start
        modify("Purchase Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                User: Record User;
            begin
                if User.Get(SystemCreatedBy) then
                    SystemCreatedByVar := User."User Name";
            end;
        }
        //NB MASQ End
    }
    var
        SystemCreatedByVar: Text; //NB MASQ
}

