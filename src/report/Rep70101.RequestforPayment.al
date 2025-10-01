report 70101 "Request for Payment"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //  DefaultRenderingLayout = LayoutName;
    RDLCLayout = 'RequestforPayment.rdl';
    dataset
    {
        dataitem("SUPPLIER PAYMENT REQUEST"; "SUPPLIER PAYMENT REQUEST")
        {
            RequestFilterFields = Number;
            column(stPayment_SUPPLIERPAYMENTREQUEST; "1st Payment")
            {
            }
            column(stPaymentDate_SUPPLIERPAYMENTREQUEST; FORMAT("1st Payment Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(ndPayment_SUPPLIERPAYMENTREQUEST; "2nd Payment")
            {
            }
            column(ndPaymentDate_SUPPLIERPAYMENTREQUEST; FORMAT("2nd Payment Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(BalanceonOrder_SUPPLIERPAYMENTREQUEST; "Balance on Order")
            {
            }
            column(Branch_SUPPLIERPAYMENTREQUEST; Branchname)
            {
            }
            column(Currency_SUPPLIERPAYMENTREQUEST; Currency)
            {
            }
            column(Date_SUPPLIERPAYMENTREQUEST; FORMAT("Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(Details_SUPPLIERPAYMENTREQUEST; Details)
            {
            }
            column(ExpectedNextPayment_SUPPLIERPAYMENTREQUEST; FORMAT("Expected Next Payment", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(GoodReadinessDate_SUPPLIERPAYMENTREQUEST; FORMAT("Good Readiness Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(HeadOfDepartment_SUPPLIERPAYMENTREQUEST; "Head Of Department")
            {
            }
            column(NoSeries_SUPPLIERPAYMENTREQUEST; "No. Series")
            {
            }
            column(Number_SUPPLIERPAYMENTREQUEST; Number)
            {
            }
            column(OperationConfirmed_SUPPLIERPAYMENTREQUEST; "Operation Confirmed")
            {
            }
            column(OperationExpected_SUPPLIERPAYMENTREQUEST; "Operation Expected")
            {
            }
            column(PaymentMethod_SUPPLIERPAYMENTREQUEST; PaymentMEthodName)
            {
            }
            column(PaymentTerms_SUPPLIERPAYMENTREQUEST; PaymentTermsName)
            {
            }
            column(POValue_SUPPLIERPAYMENTREQUEST; "PO Value")
            {
            }
            column(PO_SUPPLIERPAYMENTREQUEST; "PO#")
            {
            }
            column(ProjectName_SUPPLIERPAYMENTREQUEST; projectname)
            {
            }
            column(ReasonForTransfer_SUPPLIERPAYMENTREQUEST; "Reason For Transfer")
            {
            }
            column(RequestedAmount_SUPPLIERPAYMENTREQUEST; "Requested Amount")
            {
            }
            column(RequestedByPerson_SUPPLIERPAYMENTREQUEST; "Requested By (Person)")
            {
            }
            column(RequestedByDepartment_SUPPLIERPAYMENTREQUEST; requestbyDepartment)
            {
            }
            column(SO_SUPPLIERPAYMENTREQUEST; "SO#")
            {
            }
            column(Supplier_SUPPLIERPAYMENTREQUEST; SupplierName)
            {
            }
            column(picture; companyinformation.Picture)
            { }
            column(BankNumber_SUPPLIERPAYMENTREQUEST; "Bank Number")
            {
            }
            column(Executed_SUPPLIERPAYMENTREQUEST; Executed)
            {
            }
            column(DateofExecution_SUPPLIERPAYMENTREQUEST; FORMAT("Date of Execution", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(RequestAmountPOValue_SUPPLIERPAYMENTREQUEST; "Request Amount/PO Value %")
            {
            }

            trigger OnAfterGetRecord()
            var
            begin
                //RetrieveAnalysisAmounts();
                Clear(Vendor);
                Vendor.Get("SUPPLIER PAYMENT REQUEST".Supplier);
                SupplierName := Vendor.Name;

                Clear(PAymentTerms);
                PAymentTerms.Get("Payment Terms");
                PaymentTermsName := PAymentTerms.Description;

                Clear(PAymentmethod);
                PAymentmethod.Get("Payment Method");
                PaymentMEthodName := PAymentmethod.Description;

                Clear(Dimenvalue);
                Dimenvalue.Get('PROJECT', Project); //NB MASQ
                projectname := Dimenvalue.Code + ' - ' + Dimenvalue.Name;

                Clear(Dimenvalue);
                Dimenvalue.Get('DEPARTMENT', "Requested By / Department");
                requestbyDepartment := Dimenvalue.Name;

                Clear(Dimenvalue);
                Dimenvalue.Get('BRANCH', Branch);
                Branchname := Dimenvalue.Name;
            end;


            trigger OnPreDataItem()
            var
            begin

            end;
        }
    }

    /* requestpage
     {
         AboutTitle = 'Teaching tip title';
         AboutText = 'Teaching tip content';
         layout
         {

             area(Content)

             {
                 field(ProjectFilter; ProjectFilter)
                 {
                     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));//Dimension 1
                 }
                 field(LocationFilter; LocationFilter)

                 { TableRelation = Location.Code where("Use As In-Transit" = const(false)); }
                 field(DateFilter; DateFilter)
                 { }

             }
         }

     }*/






    trigger OnPreReport()
    var

    begin
        //   RetrieveAnalysisAmounts();
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        SupplierName: Text;
        Vendor: Record Vendor;
        PaymentTermsName: Text;
        PAymentTerms: Record "Payment Terms";
        PaymentMEthodName: Text;
        PAymentmethod: Record "Payment Method";
        requestbyDepartment: Text;
        Dimenvalue: Record "Dimension Value";
        projectname: Text;
        Branchname: Text;






}