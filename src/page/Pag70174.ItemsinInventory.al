namespace MASQ.MASQ;

page 70174 "Items in Inventory"
{
    ApplicationArea = All;
    Caption = 'Items in Inventory';
    PageType = List;
    SourceTable = "Item in Inventory";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field(PostAPI; Rec.PostAPI)
                {
                    ToolTip = 'Specifies the value of the Modified field.', Comment = '%';
                }
            }
        }
    }
}
