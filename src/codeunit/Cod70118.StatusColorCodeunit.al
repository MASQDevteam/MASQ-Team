codeunit 70118 StatusColorChange
{
    trigger OnRun()
    begin

    end;

    procedure ChangeColorBasedonCustomStatusPaymentLine(paymentLine: Record "Payment Line"): text[50]
    var
        myInt: Integer;
    begin

        case paymentLine."Payment Status" of
            paymentLine."Payment Status"::Open:
                exit('Favorable');
            paymentLine."Payment Status"::"Pending Approval":
                exit('Strong');
            paymentLine."Payment Status"::Released:
                exit('StrongAccent');

        end;

    end;

    var
        myInt: Integer;
}