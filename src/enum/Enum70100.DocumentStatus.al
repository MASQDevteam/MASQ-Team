enum 70100 "Document Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Open) { Caption = 'Open'; }
    value(1; Released) { Caption = 'Released'; }
    value(2; "Pending Approval") { Caption = 'Pending Approval'; }
    value(3; "Declined") { Caption = 'Declined'; }
}