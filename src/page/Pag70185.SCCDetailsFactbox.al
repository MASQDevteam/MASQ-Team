//FQ MASQ **START
page 70185 "SCC Details FactBox"
{
    PageType = CardPart;
    SourceTable = "Shipping Conformity Cert";
    Caption = 'Certificate Details';

    layout
    {
        area(content)
        {
            group(Status)
            {
                Caption = 'Status';

                field("Certificate Status"; Rec."Certificate Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                    ToolTip = 'Shows the current status of the certificate.';
                }

                field("SCC Number"; Rec."SCC Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the certificate number.';
                }
            }

            group(Dates)
            {
                Caption = 'Key Dates';

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the document date.';
                }

                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the request date.';
                }
                field("SCC Issuance Date"; Rec."SCC Issuance Date")
                {
                    ApplicationArea = All;
                }
                field("SCC Expiry Date"; Rec."SCC Expiry Date")
                {
                    ApplicationArea = All;
                }
            }

            group(References)
            {
                Caption = 'References';

                field("Sadad Reference"; Rec."Sadad Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the SADAD reference.';
                }
                field("SABER App. No"; Rec."SABER App. No")
                {
                    ApplicationArea = All;
                }

            }

            group(Agent)
            {
                Caption = 'Agent';

                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the agent code.';
                }

                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the agent name.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStatusStyle();
    end;

    var
        StatusStyle: Text;

    local procedure SetStatusStyle()
    begin
        case Rec."Certificate Status" of
            Rec."Certificate Status"::"In Process":
                StatusStyle := 'Ambiguous';
            Rec."Certificate Status"::Completed:
                StatusStyle := 'Favorable';
            Rec."Certificate Status"::Rejected:
                StatusStyle := 'Unfavorable';
        end;
    end;
}
//FQ MASQ **END