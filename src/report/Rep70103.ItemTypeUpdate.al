report 70103 "Item Type - Update"
{
    //UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //  DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;
    Permissions = tabledata "Item Ledger Entry" = rm, tabledata "Purch. Rcpt. Line" = rm, tabledata "Purch. Inv. Line" = rm, tabledata "Sales Shipment Line" = rm, tabledata "Sales Invoice Line" = rm;

    dataset
    {

    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(ItemType; ItemType)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPostReport()
    var
    begin
        ItemTypeUPDATE;
    end;

    local procedure ItemTypeUPDATE()
    var
        ItemLedgerentry: Record "Item Ledger Entry";
        PurchReceiptLine: Record "Purch. Rcpt. Line";
        PurchInvLine: Record "Purch. Inv. Line";
        SalesShipmentline: Record "Sales Shipment Line";
        SalesInvLine: Record "Sales Invoice Line";
    begin
        Clear(ItemLedgerentry);
        ItemLedgerentry.Get(ItemLedgerP."Entry No.");
        ItemLedgerentry."MASQ Item Type" := ItemType;
        ItemLedgerentry.Modify();
        IF ItemLedgerentry."Document Type" = ItemLedgerentry."Document Type"::"Purchase Receipt" then begin
            Clear(PurchReceiptLine);
            PurchReceiptLine.Get(ItemLedgerentry."Document No.", ItemLedgerentry."Document Line No.");
            PurchReceiptLine."Meg Item Type" := ItemType;
            PurchReceiptLine.Modify();
        end;
        IF ItemLedgerentry."Document Type" = ItemLedgerentry."Document Type"::"Purchase Invoice" then begin
            Clear(PurchInvLine);
            PurchInvLine.Get(ItemLedgerentry."Document No.", ItemLedgerentry."Document Line No.");
            PurchInvLine."Meg Item Type" := ItemType;
            PurchInvLine.Modify();
        end;

        IF ItemLedgerentry."Document Type" = ItemLedgerentry."Document Type"::"Sales Invoice" then begin
            Clear(SalesInvLine);
            SalesInvLine.Get(ItemLedgerentry."Document No.", ItemLedgerentry."Document Line No.");
            SalesInvLine."Meg Item Type" := ItemType;
            SalesInvLine.Modify();
        end;

        IF ItemLedgerentry."Document Type" = ItemLedgerentry."Document Type"::"Sales Shipment" then begin
            Clear(SalesShipmentline);
            SalesShipmentline.Get(ItemLedgerentry."Document No.", ItemLedgerentry."Document Line No.");
            SalesShipmentline."Meg Item Type" := ItemType;
            SalesShipmentline.Modify();
        end;

    end;

    procedure GetItemLEdger(ItemLedgerV: Record "Item Ledger Entry")
    var
    begin
        ItemLedgerP := ItemLedgerV;
    end;

    var
        myInt: Integer;
        ItemType: Code[20];
        ItemLedgerP: Record "Item Ledger Entry";
}