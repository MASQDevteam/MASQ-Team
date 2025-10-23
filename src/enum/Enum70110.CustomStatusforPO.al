//FQ MASQ **START**
enum 70110 "Custom Purchase Status"
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
    value(4; "Partially Received")
    {
        Caption = 'Partially Received';
    }
    value(5; "Fully Received")
    {
        Caption = 'Fully Received';
    }
    value(6; "Partially Invoiced")
    {
        Caption = 'Partially Invoiced';
    }
    value(7; "Fully Invoiced")
    {
        Caption = 'Fully Invoiced';
    }
    value(8; "Partially Received/Partially Invoiced")
    {
        Caption = 'Partially Received/Partially Invoiced';
    }
    value(9; "Fully Received/Partially Invoiced")
    {
        Caption = 'Fully Received/Partially Invoiced';
    }
    value(10; "Partially Received/Fully Invoiced")
    {
        Caption = 'Partially Received/Fully Invoiced';
    }
    value(11; "Fully Received/Fully Invoiced")
    {
        Caption = 'Fully Received/Fully Invoiced';
    }
}
//FQ MASQ **END**