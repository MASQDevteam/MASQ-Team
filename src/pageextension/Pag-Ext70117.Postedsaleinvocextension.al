pageextension 70117 "Posted sale invoc extension" extends "Posted Sales Invoice"
{

    layout
    {
        // Add changes to page layout here
        addafter(Closed)
        {
            field("MASQ Delivery Order No."; Rec."MASQ Delivery Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Order No. field.', Comment = '%';
                Editable = false;
                Enabled = false;
            }
            field("SO Type"; Rec."SO Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of the Sales Order.';
                Caption = 'SO Type';
            }
        }
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

                    CompanyInfo.Get();

                    if (CompanyInfo."Country/Region Code" = 'KSA') then
                        Report.Run(Report::"MASQ Delivery Order KSA", true, false, Rec)
                    //     else
                    ///     Report.Run(Report::"Meg Delivery Order", true, false, Rec);
                end;
            }


        }
    }

    var
        myInt: Integer;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}