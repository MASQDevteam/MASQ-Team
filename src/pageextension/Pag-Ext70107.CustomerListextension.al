pageextension 70107 "Customer List extension" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
            }
        }

    }

    actions
    {
        // Add changes to page actions here

        /* addafter("Customer/Item Sales")
          {
              action("Remove Analysis Lines")
              {
                  ApplicationArea = All;
                  Image = Delete;

                  trigger OnAction()
                  var


                      AnalysisList: Record "Analysis List by Brand";
                  begin
                      AnalysisList.DeleteAll();
                  end;
              }
          }*/

        /*  addafter(Statistics)
          {
              action("Send mail test job que")
              {
                  ApplicationArea = All;
                  Image = SendMail;

                  trigger OnAction()
                  var
                      testcodeunit: Codeunit "MASQ Email";
                  //queentry: Record "Job Queue Entry";
                  begin
                      testcodeunit.SendMOFVendEmail();
                  end;
              }
          }*/

        addafter(Statement)


        {
            action("RUN API")
            {

                Image = AmountByPeriod;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Message(CreateRequest('https://apollolightingapp.com/api/v1/Project/UpdateItemDyanmiscNumber/123/546'));
                    GerRecordds(Rec."No.", Rec."No.");
                end;
            }
        }
    }


    procedure CreateRequest(RequestUrl: Text): Text //100% working
    var
        TempBlob: Codeunit "Temp Blob";
        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        MailContentHeaders: HttpHeaders;
        MailContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        JObject: JsonObject;
        ResponseStream: InStream;
        APICallResponseMessage: Text;
        StatusCode: Text;
        IsSuccessful: Boolean;

    begin
        // RequestMessage.GetHeaders(RequestHeaders);
        //    RequestHeaders.Add('Authorization', 'Bearer ' + AccessToken);  //BEARER + ACCESSTOKEN
        RequestMessage.SetRequestUri(RequestUrl);
        RequestMessage.Method('GET');

        Clear(TempBlob);
        TempBlob.CreateInStream(ResponseStream);
        IsSuccessful := Client.Send(RequestMessage, ResponseMessage);

        if not IsSuccessful then exit('An API call with the provided header has failed.');

        if not ResponseMessage.IsSuccessStatusCode() then begin
            StatusCode := Format(ResponseMessage.HttpStatusCode()) + ' - ' + ResponseMessage.ReasonPhrase;
            exit('The request has failed with status code ' + StatusCode);
        end;

        if not ResponseMessage.Content().ReadAs(ResponseStream) then exit('The response message cannot be processed.');
        if not JObject.ReadFrom(ResponseStream) then exit('Cannot read JSON response.');

        JObject.WriteTo(APICallResponseMessage);

        APICallResponseMessage := APICallResponseMessage.Replace(',', '\');

        exit(APICallResponseMessage);
    end;

    procedure GerRecordds(ApolloNumber: text; DynamicsNumber: text)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Request: HttpRequestMessage;
        OutputString: Text;
    begin
        Request.SetRequestUri('https://apollolightingapp.com/api/v1/Project/UpdateItemDyanmiscNumber/' + ApolloNumber + '/' + DynamicsNumber);
        Message('https://apollolightingapp.com/api/v1/Project/UpdateItemDyanmiscNumber/' + ApolloNumber + '/' + DynamicsNumber);
        Request.Method := 'GET';
        IF Client.Send(Request, Response) then begin
            IF Response.IsSuccessStatusCode then begin
                Response.Content.ReadAs(OutputString);
                Message('%1', OutputString);
            end else
                Error('Error: %1', Response.ReasonPhrase);
        end else
            Error('Error: %1', Response.ReasonPhrase);
    end;

    var
        myInt: Integer;
}