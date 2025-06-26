pageextension 70162 "Shipping Methods Ext" extends "Shipment Methods"
{
    layout
    {
        addafter(Description)
        {
            field("NotMand for Shipping Quotation"; Rec."NotMand for Shipping Quotation")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether this shipping method is mandatory for shipping quotations.';
            }
        }
    }

    actions
    {
        // Add any custom actions here if needed
    }
}
