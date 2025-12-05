pageextension 70105 "Item Ledger Entries Extension" extends "Item Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        //FQ MASQ** Start
        addafter("Document No.")
        {
            field("Source Order No"; Rec."Source Order No.")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Source Order No.';
                ToolTip = 'Specifies the originating sales or purchase order for this entry.', Comment = '%';

                trigger OnDrillDown()
                var
                    SalesHeader: Record "Sales Header";
                    PurchHeader: Record "Purchase Header";
                begin
                    case Rec."Document Type" of
                        Rec."Document Type"::"Sales Shipment":
                            if Rec."Source Order No." <> '' then
                                if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Source Order No.") then
                                    Page.Run(Page::"Sales Order", SalesHeader);
                        Rec."Document Type"::"Purchase Receipt":
                            if Rec."Source Order No." <> '' then
                                if PurchHeader.Get(PurchHeader."Document Type"::Order, Rec."Source Order No.") then
                                    Page.Run(Page::"Purchase Order", PurchHeader);
                    end;
                end;
            }
            //FQ MASQ** End
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
            field("Item Type Purch. CM"; Rec."Item Type Purch. CM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Purchase CM field.', Comment = '%';
            }
            field("Item Type Sales Shipment"; Rec."Item Type Sales Shipment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Sales Shipment. field.', Comment = '%';
            }
            field("Item Type Sales Invoice"; Rec."Item Type Sales Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type Sales Inv. field.', Comment = '%';
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

            //NB MASQ Start
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
            field(Family; Rec.Family)
            {
                ApplicationArea = All;
            }
            field("Item Subcategory Code"; Rec."Item Subcategory Code")
            {
                ApplicationArea = All;
            }
            //NB MASQ End

        }
        addafter("Location Code")
        {
            field("Warehouse Category"; Rec."Warehouse Category")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warehouse Category field.', Comment = '%';
            }
        }
    }


    actions
    {
        // Add changes to page actions here

        addafter("&Value Entries")
        {
            action("Update Item Type")
            {
                ApplicationArea = All;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    ItemTypeUpdateReport: Report "Item Type - Update";
                begin
                    ItemTypeUpdateReport.GetItemLEdger(Rec);
                    ItemTypeUpdateReport.Run();

                end;
            }
            action("Inventory")
            {
                ApplicationArea = All;
                Image = Inventory;

                trigger OnAction()
                var
                // Inventory_MASQ: Report Inventory_MASQ;
                begin
                    Report.Run(Report::Inventory_MASQ, true, true, Rec);
                end;
            }
        }
    }
    //FQ MASQ** Start
    trigger OnAfterGetRecord()
    begin
        SetSourceOrderNo();
    end;

    local procedure SetSourceOrderNo()
    var
        SalesShptHeader: Record "Sales Shipment Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        Rec."Source Order No." := '';

        case Rec."Document Type" of
            Rec."Document Type"::"Sales Shipment":
                if SalesShptHeader.Get(Rec."Document No.") then
                    Rec."Source Order No." := SalesShptHeader."Order No.";
            Rec."Document Type"::"Purchase Receipt":
                if PurchRcptHeader.Get(Rec."Document No.") then
                    Rec."Source Order No." := PurchRcptHeader."Order No.";
        end;
    end;
    //FQ MASQ** End
}