reportextension 70102 "Meg Sales Order Conf. KSADr Ex" extends "Meg Sales Order Conf. KSADraft"
{
    RDLCLayout = 'MegSalesOrderConfKSADraftNew.rdl';
    dataset
    {
        add("Sales Line")
        {
            column(ItemCategoryCode; "Item Category Code")
            {
            }

        }
        add("Sales Header")
        {
            column(HideAccessory; HideAccessory)
            {

            }
        }

    }
    requestpage
    {
        layout
        {
            addfirst(Content)
            {
                field(HideAccessory; HideAccessory)
                {
                    ApplicationArea = All;
                    Caption = 'Hide Accessory';

                }
            }
        }

    }

    var
        HideAccessory: Boolean;
}
