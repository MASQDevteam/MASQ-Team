
report 70112 "Aluzo Invoice"
{
    ApplicationArea = All;
    Caption = 'Aluzo Invoice';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Aluzo Invoice.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoAddress; "Sell-to Address")
            {
            }
            column(SelltoPhoneNo; "Sell-to Phone No.")
            {
            }
            column(InvNo_; "No.")
            {

            }
            column(CurrencyCodeNew; CurrencyCodeNew)
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(PaymentTermsName; PaymentTermsName)
            {

            }
            column(CompanyInformationName; CompanyInformation.Name)
            {

            }
            column(CompanyInformationMOF; CompanyInformation."MOF #")
            {

            }
            column(CountryName; CountryName)
            {

            }
            column(TotalAmount_Including_VAT; "Amount Including VAT")
            {

            }
            column(TotalAmount; Amount)
            {

            }
            column(TotalAmountInWords; TotalAmountInWords)
            {

            }
            column(printwithVAT; printwithVAT)
            {

            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ItemNo_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Item_Category_Code; "Item Category Code")
                {

                }
                column(LineAmount; Amount)
                {

                }
                column(LineAmount_Including_VAT; "Amount Including VAT")
                {

                }
            }
            trigger OnAfterGetRecord()
            var
                FormatNoTextCod: Codeunit "MASQ Format No Text";

            begin
                TotalAmountInWords := '';
                GLSetup.Get();
                CurrencyCodeNew := SalesInvoiceHeader."Currency Code";

                if (CurrencyCodeNew = '') then begin
                    GLSetup.Get();
                    GLSetup.TestField("LCY Code");
                    CurrencyCodeNew := GLSetup."LCY Code"
                end;
                if printwithVAT = true then
                    FormatNoTextCod.FormatNoTextWithCurrency(TotalAmountInWords, SalesInvoiceHeader."Amount Including VAT", CurrencyCodeNew)
                else
                    FormatNoTextCod.FormatNoTextWithCurrency(TotalAmountInWords, SalesInvoiceHeader.Amount, CurrencyCodeNew);
                Clear(PAymentTerms);
                if PAymentTerms.Get("Payment Terms Code") then
                    PaymentTermsName := PAymentTerms.Description;

                Clear(CountryRegion);
                if CountryRegion.Get(CompanyInformation."Country/Region Code") then
                    CountryName := CountryRegion.Name;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Option)
                {
                    field(printwithVAT; printwithVAT)
                    {
                        ApplicationArea = All;
                        Caption = 'Print with VAT';
                    }
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
    trigger OnPreReport()
    var

    begin
        CompanyInformation.Get();
    end;

    var
        CompanyInformation: Record "Company Information";
        PaymentTermsName: Text;
        PAymentTerms: Record "Payment Terms";
        CountryName: Text;
        CountryRegion: Record "Country/Region";
        TotalAmountInWords: Text[200];
        CurrencyCodeNew: Code[10];
        GLSetup: Record "General Ledger Setup";
        printwithVAT: Boolean;
}
