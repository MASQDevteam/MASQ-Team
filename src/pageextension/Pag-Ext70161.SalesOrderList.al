pageextension 70161 "Sales Order List" extends "Sales Order List"
{
    layout
    {
        addafter("No.")
        {
            field("SO Type"; Rec."SO Type")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Print Confirmation")
        {
            action(PrintDeliveryOrder)
            {
                ApplicationArea = All;
                Caption = 'Print Delivery Order';
                Promoted = true;
                Image = Print;
                ToolTip = 'Print or view the new Delivery Order report';

                trigger OnAction()
                var
                    CompanyInfo: Record "Company Information";
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Rec.SetRange("Bill-to Customer No.", Rec."Bill-to Customer No.");

                    // CompanyInfo.Get();

                    // if (CompanyInfo."Country/Region Code" = 'KSA') then
                    Report.Run(Report::"Delivery Order before posting", true, false, Rec);
                end;
            }
        }
    }
}
