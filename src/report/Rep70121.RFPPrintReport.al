namespace MASQTeam.MASQTeam;
using Microsoft.Foundation.Company;

report 70121 "RFP Print Report"
{
    ApplicationArea = All;
    Caption = 'RFP Print Report';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    DefaultRenderingLayout = PrintRFP;
    dataset
    {
        dataitem("SUPPLIER PAYMENT REQUEST"; "SUPPLIER PAYMENT REQUEST")
        {
            DataItemTableView = sorting(Number);
            RequestFilterFields = Number;
            column(Number; Number)
            {
            }
            column(Status; Status)
            {
            }
            column(Supplier; Supplier)
            {
            }
            column(SupplierName; "Supplier Name")
            {
            }
            column(RFPType; "RFP Type")
            {
            }
            column(PaymentTerms; "Payment Terms")
            {
            }
            column(RequestedByDepartment; "Requested By / Department")
            {
            }
            column(PPI; "PPI#")
            {
            }
            column(PO; "PO#")
            {
            }
            column(Project; Project)
            {
            }
            column(ProjectName; "Project Name")
            {
            }
            column(SO; "SO#")
            {
            }
            column(Date; "Date")
            {
            }
            column(Details; Details)
            {
            }
            column(GoodReadinessDate; "Good Readiness Date")
            {
            }
            column(ApprovalEntries; "Approval Entries")
            {
            }
            column(POValue; "PO Value")
            {
            }
            column(Currency; Currency)
            {
            }
            column(RequestedByPerson; "Requested By (Person)")
            {
            }
            column(AssignedUserID; "Assigned User ID")
            {
            }
            column(CompName; CompanyInformation.Name) { }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemTableView = sorting(Number, "Line No");
                DataItemLinkReference = "SUPPLIER PAYMENT REQUEST";
                DataItemLink = Number = field(Number);
                RequestFilterFields = Number;
                column(NumberLine; Number) { }
                column(Line_No; "Line No") { }
                column(Payment_Date; "Payment Date") { }
                column(Payment_Value; "Payment Value") { }
                column(Payment__; "Payment %") { }
                column(Payment_Status; "Payment Status") { }
                column(Level_of_Urgency; "Level of Urgency") { }
                column(Reason_For_Transfer; "Reason For Transfer") { }
                column(Production; Production) { }
                column(Procurment_Status; "Procurment Status") { }
                column(Finance_Status; "Finance Status") { }
                column(Expected_Execution_Date; "Expected Execution Date") { }
                column(Accounting_Status; "Accounting Status") { }
                column(Bank_Number; "Bank Number") { }
                column(Comment; Comment) { }
                column(Payment_Method; "Payment Method") { }
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInformation.Get();
            end;
        }
    }
    rendering
    {
        layout(PrintRFP)
        {
            Type = RDLC;
            LayoutFile = 'src/report/Layouts/PrintRFP.rdl';
        }
    }
    var
        CompanyInformation: Record "Company Information";
}
