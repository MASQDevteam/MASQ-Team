page 70158 "Variation Order API"
{
    APIGroup = 'ERP';
    APIPublisher = 'MASQ';
    APIVersion = 'beta';
    ApplicationArea = All;
    Caption = 'variationOrderAPI';
    DelayedInsert = true;
    EntityName = 'VO';
    EntitySetName = 'VO1';
    PageType = API;
    SourceTable = "Variation Order";
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(number; Rec.Number)
                {
                    Caption = 'Number';
                }
                field(itemNumber; Rec."Item Number")
                {
                    Caption = 'Item Number';
                }
                field(variationActionReplaceItem; Rec."Variation Action(Replace Item)")
                {
                    Caption = 'Variation Action(Replace Item)';
                }
                field(newItemNumber; Rec."New Item Number")
                {
                    Caption = 'New Item Number';
                }
                field(NewCost; Rec."New Cost")
                {
                    Caption = 'New Cost';
                }
                field(NewPrice; Rec."New Price")
                {
                    Caption = 'New Price';
                }
                field(NewQty; Rec."New Qty")
                {
                    Caption = 'New Qty';
                }
                field(NewUOM; Rec."New UOM")
                {
                    Caption = 'New UOM';
                }

                field(VariationActionAddItem; Rec."Variation Action(Add Item)")
                {

                }
                field(VariationActionChangeCost; Rec."Variation Action(Change Cost)")
                {

                }
                field(VariationActionChangePrice; Rec."Variation Action(Change Price)")
                {

                }
                field(VariationActionChangeQty; Rec."Variation Action(Change Qty)")
                {

                }
                field(VariationActionChangeUOM; Rec."Variation Action(Change UOM)")
                {

                }
                field(MASQItemType; Rec."MASQ Item Type")
                {

                }
                field(ProjectCode; Rec."Project Code")
                {

                }
                field(CurrencyCode; Rec."Currency Code")
                {

                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                }
                field(apolloProjectNumber; Rec."Apollo project Number")
                {
                    Caption = 'Apollo project Number';
                }
                field(emailAddress; Rec."Email Address")
                {
                    Caption = 'Email Address';
                }
                field(vendorItemCode; Rec."Vendor Item Code")
                {
                    Caption = 'Vendor Item Code';
                }
                field(newVendorItemCode; Rec."New Vendor Item Code")
                {
                    Caption = 'New Vendor Item Code';
                }
                field(JobCategory; Rec."Job Category")
                {
                    Caption = 'Job Category';
                }
                field(PMApprovalRequired;Rec."PM Approval Required")
                {
                    
                }

            }
        }
    }
}
