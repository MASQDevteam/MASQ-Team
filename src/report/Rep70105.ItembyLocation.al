report 70105 "Item by Location"
{
    ApplicationArea = All;
    Caption = 'Item by Location';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'ItembyLocation.rdl';
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.";
            column(ItemNo; "Item No.")
            {
            }
            column(Description; Description)
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(LocName; LocName)
            {

            }
            column(Quantity; Quantity)
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if Location.Get("Location Code") then begin
                    LocName := Location.Name;
                end else begin
                    LocName := '';
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        Location: Record Location;
        LocName: Text[100];
}
