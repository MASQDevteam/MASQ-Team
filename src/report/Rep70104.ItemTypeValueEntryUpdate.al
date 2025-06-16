report 70104 "Item Type Value Entry- Update"
{
    //UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //  DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;
    Permissions = tabledata "Value Entry" = rm, tabledata "Purch. Rcpt. Line" = rm, tabledata "Purch. Inv. Line" = rm, tabledata "Sales Shipment Line" = rm, tabledata "Sales Invoice Line" = rm;
    ;
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
                    //
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
        ValueEntry: Record "Value Entry";
        PurchReceiptLine: Record "Purch. Rcpt. Line";
        PurchInvLine: Record "Purch. Inv. Line";
        SalesShipmentline: Record "Sales Shipment Line";
        SalesInvLine: Record "Sales Invoice Line";
    begin
        Clear(ValueEntry);
        ValueEntry.Get(ValueEntryP."Entry No.");
        ValueEntry."MASQ Item Type" := ItemType;
        ValueEntry.Modify();

        IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Receipt" then begin
            Clear(PurchReceiptLine);
            PurchReceiptLine.Get(ValueEntry."Document No.", ValueEntry."Document Line No.");
            PurchReceiptLine."Meg Item Type" := ItemType;
            PurchReceiptLine.Modify();
        end;
        IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Invoice" then begin
            Clear(PurchInvLine);
            PurchInvLine.Get(ValueEntry."Document No.", ValueEntry."Document Line No.");
            PurchInvLine."Meg Item Type" := ItemType;
            PurchInvLine.Modify();
        end;

        IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Invoice" then begin
            Clear(SalesInvLine);
            SalesInvLine.Get(ValueEntry."Document No.", ValueEntry."Document Line No.");
            SalesInvLine."Meg Item Type" := ItemType;
            SalesInvLine.Modify();
        end;

        IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Shipment" then begin
            Clear(SalesShipmentline);
            SalesShipmentline.Get(ValueEntry."Document No.", ValueEntry."Document Line No.");
            SalesShipmentline."Meg Item Type" := ItemType;
            SalesShipmentline.Modify();
        end;


    end;


    procedure GetValueEntry(ValueEntryV: Record "Value Entry")
    var
    begin
        ValueEntryP := ValueEntryV;
    end;

    var
        myInt: Integer;
        ItemType: Code[20];
        ValueEntryP: Record "Value Entry";
}