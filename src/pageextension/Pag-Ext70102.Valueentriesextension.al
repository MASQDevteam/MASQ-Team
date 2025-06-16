pageextension 70102 "Value entries extension" extends "Value Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document No.")
        {
            field("Item Type Purch. Inv."; Rec."Item Type Purch. Inv.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Purchase Inv. field.', Comment = '%';
            }
            field("Item Type Purch. Rcpt."; Rec."Item Type Purch. Rcpt.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Purchase Rcpt. field.', Comment = '%';
            }
            field("Item Type Sales Shipment"; Rec."Item Type Sales Shipment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Sales Shipment. field.', Comment = '%';
            }
            field("Item Type Sales Invoice"; Rec."Item Type Sales Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Purchase Inv. field.', Comment = '%';
            }
            field("Item Type Purch. CM"; Rec."Item Type Purch. CM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Purchase CM field.', Comment = '%';
            }
            field("Item Type Sales CM"; Rec."Item Type Sales CM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Sales CM field.', Comment = '%';
            }
            field("MASQ Item Type"; Rec."MASQ Item Type")
            {
                Caption = 'Item Type';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Item Type field.', Comment = '%';
            }
            field("Batch Number"; Rec."Batch Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch Number field.', Comment = '%';
                Editable = false;
            }
            field("Freight Air"; Rec."Freight Air")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Freight Air field.', Comment = '%';
            }
            field("Freight Sea"; Rec."Freight Sea")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Freight Sea field.', Comment = '%';
            }

        }
    }

    actions
    {
        // Add changes to page actions here

        addafter(Dimensions)
        {
            action("Update Item Type")
            {
                ApplicationArea = All;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    ItemTypeUpdateReport: Report "Item Type Value Entry- Update";
                begin
                    ItemTypeUpdateReport.GetValueEntry(Rec);
                    ItemTypeUpdateReport.Run();

                end;
            }
        }
    }

    var
        myInt: Integer;
}