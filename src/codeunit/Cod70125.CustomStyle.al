//FQ MASQ **START**
codeunit 70125 "Custom Status Style"
{
    procedure GetStyleForPurchaseStatus(CustomStatus: Enum "Custom Purchase Status"): Text
    begin
        case CustomStatus of
            CustomStatus::Open:
                exit('Favorable');
            CustomStatus::Released:
                exit('strong');
            CustomStatus::"Pending Approval":
                exit('strong');
            CustomStatus::"Pending Prepayment":
                exit('strong');
            CustomStatus::"Partially Received":
                exit('ambiguous');
            CustomStatus::"Fully Received":
                exit('StrongAccent');
            CustomStatus::"Partially Invoiced":
                exit('ambiguous');
            CustomStatus::"Fully Invoiced":
                exit('StrongAccent');
            CustomStatus::"Partially Received/Partially Invoiced":
                exit('ambiguous');
            CustomStatus::"Fully Received/Partially Invoiced":
                exit('StrongAccent');
            CustomStatus::"Partially Received/Fully Invoiced":
                exit('StrongAccent');
            CustomStatus::"Fully Received/Fully Invoiced":
                exit('unfavorable');
            else
                exit('Standard');
        end;
    end;

    procedure GetStyleForSalesStatus(CustomStatus: Enum "Custom Sales Status"): Text
    begin
        case CustomStatus of
            CustomStatus::Open:
                exit('Favorable');
            CustomStatus::Released:
                exit('strong');
            CustomStatus::"Pending Approval":
                exit('strong');
            CustomStatus::"Pending Prepayment":
                exit('strong');
            CustomStatus::"Partially Delivered":
                exit('ambiguous');
            CustomStatus::"Fully Delivered":
                exit('StrongAccent');
            CustomStatus::"Partially Invoiced":
                exit('ambiguous');
            CustomStatus::"Fully Invoiced":
                exit('StrongAccent');
            CustomStatus::"Partially Delivered/Partially Invoiced":
                exit('ambiguous');
            CustomStatus::"Fully Delivered/Partially Invoiced":
                exit('StrongAccent');
            CustomStatus::"Partially Delivered/Fully Invoiced":
                exit('StrongAccent');
            CustomStatus::"Fully Delivered/Fully Invoiced":
                exit('unfavorable');
            else
                exit('Standard');
        end;
    end;
}
//FQ MASQ **END**