pageextension 70112 "item jorunal extension" extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("MASQ Item Type"; Rec."MASQ Item Type")
            {
                Caption = 'Item Type';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Item Type field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}