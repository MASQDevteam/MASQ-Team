pageextension 70135 "posted sales shipment exten" extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name") { }
    }

    actions
    {
        // Add changes to page actions here
        addfirst(processing)
        {
            action("Print Label")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SalesShipmentHeader: Record "Sales Shipment Header";
                begin
                    SalesShipmentHeader.Reset();
                    SalesShipmentHeader.SetRange("No.", Rec."No.");
                    if SalesShipmentHeader.FindFirst() then
                        Report.RunModal(Report::"Print Shipment Label", true, true, SalesShipmentHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}