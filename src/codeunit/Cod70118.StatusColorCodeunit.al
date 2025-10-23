codeunit 70118 StatusColorChange
//FQ MASQ Start
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

    procedure ChangeColorbasedonCustomStatusProject(job: Record Job): text[50]
    var
    begin
        case job."Project Status" of
            job."Project Status"::Open:
                exit('Favorable');
            job."Project Status"::Closed:
                exit('unfavorable');
        end;
    end;

    

    //FQ MASQ End
    var
        myInt: Integer;

}