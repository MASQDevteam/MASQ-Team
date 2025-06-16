page 70123 "Intermediate Customers List"
{
    PageType = List;
    SourceTable = "Intermediate Customers";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Apollo Number"; Rec."Apollo Number")
                { }
                field("No."; Rec."No.")
                {
                }

                field("Name"; Rec."Name")
                {
                }

                field("Search Name"; Rec."Search Name")
                {
                }

                field("Name 2"; Rec."Name 2")
                {
                }

                field("Address"; Rec."Address")
                {
                }

                field("Address 2"; Rec."Address 2")
                {
                }

                field("City"; Rec."City")
                {
                }

                field("Contact"; Rec."Contact")
                {
                }

                field("Phone No."; Rec."Phone No.")
                {
                }

                field("Telex No."; Rec."Telex No.")
                {
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }

                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                }

                field("Currency Code"; Rec."Currency Code")
                {
                }

                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }

                field("Salesperson Code"; Rec."Salesperson Code")
                {
                }

                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                }

                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }

                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }

                field("Location Code"; Rec."Location Code")
                {
                }

                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }

                field("Post Code"; Rec."Post Code")
                {
                }

                field("County"; Rec."County")
                {
                }
                field("Apollo Customer No."; Rec."Apollo Customer No.")
                {
                    ToolTip = 'Specifies the value of the Apollo Customer No. field.', Comment = '%';
                }
                field("Apollo User Name"; Rec."Apollo User Name")
                {
                    ApplicationArea = All;
                }
                field("Arabic Customer Name"; Rec."Arabic Customer Name")
                {
                    ToolTip = 'Specifies the value of the Arabic Customer Name field.', Comment = '%';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the value of the Area field.', Comment = '%';
                }
                field("Building NO."; Rec."Building NO.")
                {
                    ToolTip = 'Specifies the value of the Building NO. field.', Comment = '%';
                }
                field("Building Name"; Rec."Building Name")
                {
                    ToolTip = 'Specifies the value of the Building Name field.', Comment = '%';
                }
                field("Building Name Arabic"; Rec."Building Name Arabic")
                {
                    ToolTip = 'Specifies the value of the Building Name Arabic field.', Comment = '%';
                }
                field(CR; Rec.CR)
                {
                    ToolTip = 'Specifies the value of the CR field.', Comment = '%';
                }
                field(Classification; Rec.Classification)
                {
                    ToolTip = 'Specifies the value of the Classification field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field(CompanySubType; Rec.CompanySubType)
                {
                    ToolTip = 'Specifies the value of the CompanySubType field.', Comment = '%';
                }
                field("Contact Name Arabic"; Rec."Contact Name Arabic")
                {
                    ToolTip = 'Specifies the value of the Contact Name Arabic field.', Comment = '%';
                }
                field(District; Rec.District)
                {
                    ToolTip = 'Specifies the value of the District field.', Comment = '%';
                }
                field("District Arabic"; Rec."District Arabic")
                {
                    ToolTip = 'Specifies the value of the District Arabic field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.', Comment = '%';
                }
                field("PO BOX"; Rec."PO BOX")
                {
                    ToolTip = 'Specifies the value of the PO BOX field.', Comment = '%';
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.', Comment = '%';
                }
                field(Road; Rec.Road)
                {
                    ToolTip = 'Specifies the value of the Road field.', Comment = '%';
                }
                field("Road Name Arabic"; Rec."Road Name Arabic")
                {
                    ToolTip = 'Specifies the value of the Road Name Arabic field.', Comment = '%';
                }
                field(Street; Rec.Street)
                {
                    ToolTip = 'Specifies the value of the Street field.', Comment = '%';
                }
                field("Street Arabic"; Rec."Street Arabic")
                {
                    ToolTip = 'Specifies the value of the Street Arabic field.', Comment = '%';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.', Comment = '%';
                }
                field("Comments to Apollo"; Rec."Comments to Apollo")
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field("API Status"; Rec."API Status")
                {
                    ToolTip = 'Specifies the value of the API Status field.', Comment = '%';
                    Editable = false;
                }
                field("Dynamics Number"; Rec."Dynamics Number")
                {
                    ToolTip = 'Specifies the value of the Dynamics Number field.', Comment = '%';
                    Editable = InputDynamicsNumber;
                }
                field(Processed; Rec.Processed)
                {
                    //Editable = false;
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                }

                /* field("Email"; Rec."Email")
                 {
                 }

                 field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                 {
                 }

                 field("Mobile Phone No."; Rec."Mobile Phone No.")
                 {
                 }

                 field("Responsibility Center"; Rec."Responsibility Center")
                 {
                 }

                 field("Road"; Rec."Road")
                 {
                 }

                 field("Street"; Rec."Street")
                 {
                 }

                 field("District"; Rec."District")
                 {
                 }

                 field("PO BOX"; Rec."PO BOX")
                 {
                 }

                 field("Building Name"; Rec."Building Name")
                 {
                 }

                 field("Building NO."; Rec."Building NO.")
                 {
                 }

                 field("CR"; Rec."CR")
                 {
                 }

                 field("Road Name Arabic"; Rec."Road Name Arabic")
                 {
                 }

                 field("Street Arabic"; Rec."Street Arabic")
                 {
                 }

                 field("District Arabic"; Rec."District Arabic")
                 {
                 }

                 field("Building Name Arabic"; Rec."Building Name Arabic")
                 {
                 }

                 field("Contact Name Arabic"; Rec."Contact Name Arabic")
                 {
                 }

                 field("Arabic Customer Name"; Rec."Arabic Customer Name")
                 {
                 }

                 field("Apollo Customer No."; Rec."Apollo Customer No.")
                 {
                 }

                 field("CompanySubType"; Rec."CompanySubType")
                 {
                 }

                 field("Classification"; Rec."Classification")
                 {
                 }

                 field("Area"; Rec."Area")
                 {
                 }

                 field("Comments"; Rec."Comments")
                 {
                 }*/

            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(New)
            {
                ApplicationArea = All;
                Caption = 'Create New Customer';
                Image = NewCustomer;
                trigger OnAction()
                begin
                    // Custom action for creating a new customer
                    //   PAGE.Run(PAGE::"Customer Card");
                    SendIntermediateCustomertoCustomer(Rec);
                    IF CustomerRec."Apollo Number" <> '' then//add conditiion if CustomerRec."Apollo Number" not empty send to apollo
                        GetRecords(CustomerRec."Apollo Number", CustomerRec."No.");

                    Rec.Processed := true;
                    Rec.Modify();
                end;
            }
            action("Reject the Customer")
            {
                ApplicationArea = All;
                Caption = 'Reject the Customer';
                Image = Reject;
                trigger OnAction()
                begin
                    PostRejectCustomer(Rec."No.", Rec."Dynamics Number", Rec."Comments to Apollo");
                end;
            }
        }
    }


    local procedure SendIntermediateCustomertoCustomer(IntCustomer: Record "Intermediate Customers")
    var

    begin
        REc.TestField("Dynamics Number", '');
        Rec.TestField("API Status", '');
        Rec.TestField(Name);

        Clear(CustomerRec);
        CustomerRec.Init();
        //CustomerRec.Validate("Apollo Number", IntCustomer."No.");//IntCustomer."No." must be removed replaced with new field
        CustomerRec.Validate("Apollo Number", IntCustomer."Apollo Number");
        Evaluate(CustomerRec.ApolloCustomerNo, Rec."No.");//added on 14/03/2025
        CustomerRec.Validate("Name", IntCustomer.Name);
        CustomerRec.Validate("Search Name", IntCustomer."Search Name");
        CustomerRec.Validate("Name 2", IntCustomer."Name 2");
        CustomerRec.Validate("Address", IntCustomer.Address);
        CustomerRec.Validate("Address 2", IntCustomer."Address 2");
        CustomerRec.Validate("City", IntCustomer.City);

        CustomerRec.Validate("Phone No.", IntCustomer."Phone No.");
        CustomerRec.Validate("Telex No.", IntCustomer."Telex No.");
        CustomerRec.Insert(true);
        CustomerRec.Validate("Contact", IntCustomer.Contact);
        CustomerRec.Validate("Global Dimension 1 Code", IntCustomer."Global Dimension 1 Code");
        CustomerRec.Validate("Global Dimension 2 Code", IntCustomer."Global Dimension 2 Code");
        CustomerRec.Validate("Gen. Bus. Posting Group", 'LOCAL');
        CustomerRec.Validate("VAT Bus. Posting Group", 'LOCAL');
        CustomerRec.Validate("Customer Posting Group", 'ORDINARY');
        CustomerRec.Validate("Currency Code", IntCustomer."Currency Code");
        CustomerRec.Validate("Payment Terms Code", IntCustomer."Payment Terms Code");
        CustomerRec.Validate("Salesperson Code", IntCustomer."Salesperson Code");
        CustomerRec.Validate("Shipment Method Code", IntCustomer."Shipment Method Code");
        CustomerRec.Validate("Country/Region Code", IntCustomer."Country/Region Code");
        CustomerRec.Validate("Payment Method Code", IntCustomer."Payment Method Code");
        CustomerRec.Validate("Location Code", IntCustomer."Location Code");

        CustomerRec.Validate("Post Code", IntCustomer."Post Code");
        CustomerRec.Validate("County", IntCustomer.County);
        CustomerRec.Validate("Apollo Customer No.", IntCustomer."Apollo Customer No.");
        // CustomerRec.Validate("Meg Arabic Customer Name", IntCustomer."Arabic Customer Name");
        CustomerRec.Validate("Area", IntCustomer.Area);
        // CustomerRec.Validate("Building NO.", IntCustomer."Building NO.");
        // CustomerRec.Validate("Building Name", IntCustomer."Building Name");
        // CustomerRec.Validate("Building Name Arabic", IntCustomer."Building Name Arabic");
        // CustomerRec.Validate("CR", IntCustomer.CR);
        CustomerRec.Validate("Classification", IntCustomer.Classification);
        CustomerRec.Validate("Comments", IntCustomer.Comments);
        CustomerRec.Validate("CompanySubType", IntCustomer.CompanySubType);
        // CustomerRec.Validate("Contact Name Arabic", IntCustomer."Contact Name Arabic");
        // CustomerRec.Validate("District", IntCustomer.District);
        // CustomerRec.Validate("District Arabic", IntCustomer."District Arabic");
        CustomerRec.Validate("E-mail", IntCustomer.Email);
        CustomerRec.Validate("Mobile Phone No.", IntCustomer."Mobile Phone No.");
        // CustomerRec.Validate(, IntCustomer."PO BOX");
        // CustomerRec.Validate("Processed", IntCustomer.Processed);
        CustomerRec.Validate("Responsibility Center", IntCustomer."Responsibility Center");
        // CustomerRec.Validate("Road", IntCustomer.Road);
        // CustomerRec.Validate("Road Name Arabic", IntCustomer."Road Name Arabic");
        // CustomerRec.Validate("Street", IntCustomer.Street);
        // CustomerRec.Validate("Street Arabic", IntCustomer."Street Arabic");
        CustomerRec.Modify();
        Rec."Dynamics Number" := CustomerRec."No.";
        rec.Modify();

    end;



    procedure GetRecords(ApolloNumber: text; DynamicsNumber: text)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Request: HttpRequestMessage;
        OutputString: Text;
    begin
        Request.SetRequestUri(StrSubstNo('https://apollolightingapp.com/api/v1/Project/UpdateCustomerDyanmiscNumber/%1/%2', ApolloNumber, DynamicsNumber));
        Request.Method := 'GET';
        IF Client.Send(Request, Response) then begin
            IF Response.IsSuccessStatusCode then begin
                Response.Content.ReadAs(OutputString);
                Message('%1', OutputString);
            end else
                Error('Error: %1', Response.ReasonPhrase);
        end else
            Error('Error: %1', Response.ReasonPhrase);

        Rec."API Status" := OutputString + StrSubstNo('Error: %1', Response.ReasonPhrase);
        Rec.Modify();
    end;

    procedure PostRejectCustomer(ApolloNumber: text; DynamicsNumber: text; CommentstoApollo: Text)//added on 10/03/2025
    var
        Client: HttpClient;
        //  Response: HttpResponseMessage;
        //   Request: HttpRequestMessage;
        OutputString: Text;
        Content: HttpContent;
        postData: Text;
        RequestHeaders: HttpHeaders;
        ResponseHeader: HttpResponseMessage;
        HttpHeadersContent: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;

    begin
        //     postData := '{"useEnvironmentUpdateWindow": false,"targetVersion": "' + '4.0' + '","allowPreviewVersion": true,"installOrUpdateNeededDependencies":  true}';
        // postData := '{"ApolloNo": 1234,"Comments": "Reason for rejection","DynamicsNo": "5678"}';
        If DynamicsNumber = '' then
            DynamicsNumber := '0';

        postData := '{"ApolloNo": ' + ApolloNumber + ',"Comments":  "' + CommentstoApollo + '","DynamicsNo":  "' + DynamicsNumber + '"}';
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Clear();
        RequestHeaders.Add('Authorization', 'No Auth');
        RequestHeaders.Add('Accept', 'application/json');
        Content.WriteFrom(postData);

        //GET HEADERS
        Content.GetHeaders(HttpHeadersContent);
        HttpHeadersContent.Clear();
        HttpHeadersContent.Remove('Content-Type');
        HttpHeadersContent.Add('Content-Type', 'application/json; charset=UTF-8');


        //POST METHOD
        RequestMessage.Content := Content;
        RequestMessage.SetRequestUri('https://apollolightingapp.com/api/v1/project/RejectDyanmiscIntermediateCustomer');
        RequestMessage.Method := 'POST';

        IF Client.Send(RequestMessage, ResponseMessage) then begin
            IF ResponseMessage.IsSuccessStatusCode then begin
                ResponseMessage.Content.ReadAs(OutputString);
                Message('%1', OutputString + ' :  Customer is Rejected and information is sent back to apollo');
            end else
                Error('Error: %1', ResponseMessage.ReasonPhrase);
        end else
            Error('Error: %1', ResponseMessage.ReasonPhrase);

        Rec."API Status" := OutputString + StrSubstNo('Response: %1', OutputString + ' :  Item is Rejected and information is sent back to apollo');
        IF Rec."Dynamics Number" <> '' then
            Rec.Processed := true;

        Rec.Modify();
    end;

    trigger OnOpenPage()
    var
    begin
        Clear(UserSetup);
        IF UserSetup.Get(UserId) then;
        InputDynamicsNumber := UserSetup."Input DynamicNum to Intermed.";
    end;

    var
        CustomerRec: Record Customer;
        UserSetup: Record "User Setup";
        InputDynamicsNumber: Boolean;
}
