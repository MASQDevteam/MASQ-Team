report 70102 "Travel Request"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //  DefaultRenderingLayout = LayoutName;
    RDLCLayout = 'TravelRequest.rdl';
    dataset
    {
        dataitem("Travel Request"; "Travel Request")
        {
            RequestFilterFields = Number;
            column(Airline_TravelRequest; Airline)
            {
            }
            column(ApprovedByFinance_TravelRequest; "Approved By Finance")
            {
            }
            column(ApprovedByManager_TravelRequest; "Approved By Manager")
            {
            }
            column(ApprovedByProjectManager_TravelRequest; "Approved By Project Manager")
            {
            }
            column(Branch_TravelRequest; Branch)
            {
            }
            column(Departure_TravelRequest; FORMAT(Departure, 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(Destination_TravelRequest; Destination)
            {
            }
            column(NoofWorkedHolidaysWeekends_TravelRequest; "No of Worked Holidays&Weekends")
            {
            }
            column(NoSeries_TravelRequest; "No. Series")
            {
            }
            column(Number_TravelRequest; Number)
            {
            }
            column(ProjectCode_TravelRequest; "Project Code")
            {
            }
            column(ReasonforTravel_TravelRequest; "Reason for Travel")
            {
            }
            column(Return_TravelRequest; FORMAT(Return, 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(SpecificRequests_TravelRequest; "Specific Requests")
            {
            }
            column(TimeofDeparture_TravelRequest; FORMAT("Time of Departure", 0, '<Hours12,2>:<Minutes,2> <AM/PM>'))
            {
            }
            column(TimeofReturn_TravelRequest; FORMAT("Time of Return", 0, '<Hours12,2>:<Minutes,2> <AM/PM>'))
            {
            }
            column(TravelAdvanceRequired_TravelRequest; "Travel Advance Required")
            {
            }
            column(TravelersName_TravelRequest; "Traveler's Name")
            {
            }
            column(TravelingBoth_TravelRequest; "Traveling Both")
            {
            }
            column(TravelingbyAir_TravelRequest; "Traveling by Air")
            {
            }
            column(TravelingbyRoad_TravelRequest; "Traveling by Road")
            {
            }
            column(picture; companyinformation.Picture)
            { }


            trigger OnAfterGetRecord()
            var
            begin
                //RetrieveAnalysisAmounts();

            end;


            trigger OnPreDataItem()
            var
            begin
                //   RetrieveAnalysisAmounts();
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
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

    end;

    var
        CompanyInformation: Record "Company Information";



}