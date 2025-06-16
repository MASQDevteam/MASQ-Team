pageextension 70156 "Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {

    }
    actions
    {
        // Add changes to page actions here
        addafter("&Invoice")
        {
            action("Aluzo Invoice")
            {
                Image = Print;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(Report::"Aluzo Invoice", true, false, Rec);
                end;
            }
        }
    }
}
