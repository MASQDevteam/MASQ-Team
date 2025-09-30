//FQ MASQ **Start
page 70178 "Item Api page"
{
    PageType = List;
    Caption = 'Item API Page';
    SourceTable = Item;
    DelayedInsert = true;
    ApplicationArea = all;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Meg Item Subcategory Code"; Rec."Meg Item Subcategory Code")
                {
                    ApplicationArea = All;
                }
                field("Meg Brand"; Rec."Meg Brand")
                {
                    ApplicationArea = All;
                }
                field("Meg Family"; Rec."Meg Family")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Meg Vendor Item Code"; Rec."Meg Vendor Item Code")
                {
                    ApplicationArea = All;
                }
                field("Meg Other Details"; Rec."Meg Other Details")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
//FQ MASQ **END