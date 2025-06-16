pageextension 70155 "Job Task Lines extension" extends "Job Task Lines"
{
    layout
    {
      
    }

    actions
    {
        // Add changes to page actions here
    }

    procedure SetPurchLineFilters(VAR PurchLine: Record "Purchase Line")
    var
    begin
        PurchLine.SETCURRENTKEY("Document Type", "Job No.", "Job Task No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Job No.", Rec."Job No.");
        IF Rec."Job Task Type" IN ["Job Task Type"::Total, "Job Task Type"::"End-Total"] THEN
            PurchLine.SETFILTER("Job Task No.", Rec.Totaling)
        ELSE
            PurchLine.SETRANGE("Job Task No.", Rec."Job Task No.");
    end;


    var
        myInt: Integer;
}