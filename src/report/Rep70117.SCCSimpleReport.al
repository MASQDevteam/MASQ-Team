
//FQ MASQ **START**
report 70117 "SCC Simple Report"
{
    ApplicationArea = All;
    Caption = 'SCC Simple Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/Layouts/SCCSimple Layout.rdl';
    dataset
    {
        dataitem(ShippingConformityCert; "Shipping Conformity Cert")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(Picture; CompanyInfo.Picture) { }
            column(AgentCode; "Agent Code")
            {
            }
            column(AgentInvoiceNo; "Agent Invoice No.")
            {
            }
            column(AgentName; "Agent Name")
            {
            }
            column(CertificateStatus; "Certificate Status")
            {
            }
            column(Comments; Comments)
            {
            }
            column(CountryofLoading; "Country of Loading")
            {
            }
            column(CountryName; CountryName) { }
            column(DocumentDate; "Document Date")
            {
            }
            column(HSCodeSadad; "HS Code Sadad")
            {
            }
            column(HSCodeSupplier; "HS Code Supplier")
            {
            }
            column(InvoiceDate; "Invoice Date")
            {
            }
            column(No; "No.")
            {
            }
            column(RequestDate; "Request Date")
            {
            }
            column(SABERAppNo; "SABER App. No")
            {
            }
            column(SABERExpiryDate; "SABER Expiry Date")
            {
            }
            column(SABERIssuanceDate; "SABER Issuance Date")
            {
            }
            column(SCCExpiryDate; "SCC Expiry Date")
            {
            }
            column(SCCIssuanceDate; "SCC Issuance Date")
            {
            }
            column(SCCNumber; "SCC Number")
            {
            }
            column(SadadExpiryDate; "Sadad Expiry Date")
            {
            }
            column(SadadIssuanceDate; "Sadad Issuance Date")
            {
            }
            column(SadadReference; "Sadad Reference")
            {
            }
            column(Shipment_Mode; "Shipment Mode") { }


            dataitem(POs; "SCC Order Line")
            {
                DataItemLink = "SCC No." = field("No.");
                DataItemLinkReference = ShippingConformityCert;
                DataItemTableView = sorting("SCC No.", "Line No.", "Purchase Order No.");
                RequestFilterFields = "SCC No.";


                column(SCC_No_; "SCC No.") { }

                column(Purchase_Order_No_; "Purchase Order No.")
                {

                }
                column(Document_Date; "Document Date")
                {

                }
                column(Apollo_Project_No_; "Apollo Project No.")
                {

                }
                column(Vendor_No_; "Vendor No.") { }
                column(Vendor_Name; "Vendor Name")
                { }
                trigger OnPreDataItem()
                var
                    Sccline: Record "SCC Order Line";
                begin
                    SetRange("SCC No.", ShippingConformityCert."No.");
                end;

            }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        if not CompanyInfo."SCC Module Enabled" then
            Error('Shipping Conformity Certificate module is not enabled for this company.');
    end;

    var
        CompanyInfo: Record "Company Information";
}
//FQ MASQ **END**