//FQ MASQ **START**
enum 70111 "Custom Sales Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Released)
    {
        Caption = 'Released';
    }
    value(2; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(3; "Pending Prepayment")
    {
        Caption = 'Pending Prepayment';
    }
    value(4; "Partially Delivered")
    {
        Caption = 'Partially Delivered';
    }
    value(5; "Fully Delivered")
    {
        Caption = 'Fully Delivered';
    }
    value(6; "Partially Invoiced")
    {
        Caption = 'Partially Invoiced';
    }
    value(7; "Fully Invoiced")
    {
        Caption = 'Fully Invoiced';
    }
    value(8; "Partially Delivered/Partially Invoiced")
    {
        Caption = 'Partially Delivered/Partially Invoiced';
    }
    value(9; "Fully Delivered/Partially Invoiced")
    {
        Caption = 'Fully Delivered/Partially Invoiced';
    }
    value(10; "Partially Delivered/Fully Invoiced")
    {
        Caption = 'Partially Delivered/Fully Invoiced';
    }
    value(11; "Fully Delivered/Fully Invoiced")
    {
        Caption = 'Fully Delivered/Fully Invoiced';
    }
}
//FQ MASQ **END**