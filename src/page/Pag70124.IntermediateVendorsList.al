page 70124 "Intermediate Vendors List"
{
    PageType = List;
    SourceTable = "Intermediate Vendors";
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
                    ApplicationArea = All;
                }

                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }

                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }

                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }

                field("Address"; Rec."Address")
                {
                    ApplicationArea = All;
                }

                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }

                field("City"; Rec."City")
                {
                    ApplicationArea = All;
                }

                field("Contact"; Rec."Contact")
                {
                    ApplicationArea = All;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }

                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }

                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }

                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }

                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }

                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }

                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }

                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }

                field("County"; Rec."County")
                {
                    ApplicationArea = All;
                }
                field("Apollo Vendor No."; Rec."Apollo Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Apollo Vendor No. field.', Comment = '%';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the value of the Area field.', Comment = '%';
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
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.', Comment = '%';
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.', Comment = '%';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.', Comment = '%';
                }
                field("Apollo User Name"; Rec."Apollo User Name")
                {
                    ToolTip = 'Specifies the value of the Apollo User Name field.', Comment = '%';
                }
                field("Comments to Apollo"; Rec."Comments to Apollo")
                {
                    ToolTip = 'Specifies the value of the Comments to Apollo field.', Comment = '%';
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
                /*  field("Email"; Rec."Email")
                  {
                      ApplicationArea = All;
                  }

                  field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                  {
                      ApplicationArea = All;
                  }

                  field("Mobile Phone No."; Rec."Mobile Phone No.")
                  {
                      ApplicationArea = All;
                  }

                  field("Responsibility Center"; Rec."Responsibility Center")
                  {
                      ApplicationArea = All;
                  }

                  field("Location Code"; Rec."Location Code")
                  {
                      ApplicationArea = All;
                  }

                  field("Apollo Vendor No."; Rec."Apollo Vendor No.")
                  {
                      ApplicationArea = All;
                  }

                  field("CompanySubType"; Rec."CompanySubType")
                  {
                      ApplicationArea = All;
                  }

                  field("Classification"; Rec."Classification")
                  {
                      ApplicationArea = All;
                  }

                  field("Area"; Rec."Area")
                  {
                      ApplicationArea = All;
                  }

                  field("Comments"; Rec."Comments")
                  {
                      ApplicationArea = All;
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
                Caption = 'Create New Vendor';
                Image = New;
                trigger OnAction()
                begin
                    // Custom action for creating a new customer
                    //   PAGE.Run(PAGE::"Customer Card");
                    SendIntermediateVendortoVendor(Rec);
                    IF VendorRec."Apollo Number" <> '' then
                        GetRecords(VendorRec."Apollo Number", VendorRec."No.");
                    SyncVendortoOtherCompanies(VendorRec);//added on 05/03/2025


                    Rec.Processed := true;
                    REc.Modify();
                end;
            }
            action("Reject the Vendor")
            {
                ApplicationArea = All;
                Caption = 'Reject the Vendor';
                Image = Reject;
                trigger OnAction()
                begin
                    PostRejectVendor(Rec."No.", Rec."Dynamics Number", Rec."Comments to Apollo");
                end;
            }
        }
    }

    local procedure SendIntermediateVendortoVendor(IntVendor: Record "Intermediate Vendors")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        REc.TestField("Dynamics Number", '');
        Rec.TestField("API Status", '');
        Rec.TestField(Name);


        Clear(VendorRec);
        VendorRec.Init();
        // VendorRec.Validate("No.", NoSeries.GetNextNo(PurchSetup."Vendor Nos."));
        // VendorRec.Validate("Apollo Number", Rec."No.");
        VendorRec.Validate("Apollo Number", Rec."Apollo Number");
        Evaluate(VendorRec.ApolloVendorNo, Rec."No.");//added on 14/03/2025
        VendorRec.Validate("Name", Rec."Name");
        VendorRec.Validate("Search Name", Rec."Search Name");
        VendorRec.Validate("Name 2", Rec."Name 2");
        VendorRec.Validate("Address", Rec."Address");
        VendorRec.Validate("Address 2", Rec."Address 2");
        VendorRec.Validate("City", Rec."City");

        VendorRec.Validate("Phone No.", Rec."Phone No.");
        VendorRec.Validate("Telex No.", Rec."Telex No.");
        VendorRec.Insert(true);
        //  VendorRec.Validate("Contact", Rec."Contact");
        VendorRec.Validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        VendorRec.Validate("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
        //AN 04/09/25 
        if IntVendor."Gen. Bus. Posting Group" = '' then
            VendorRec.Validate("Gen. Bus. Posting Group", 'LOCAL')
        else
            VendorRec.Validate("Gen. Bus. Posting Group", IntVendor."Gen. Bus. Posting Group");

        if IntVendor."VAT Bus. Posting Group" = '' then
            VendorRec.Validate("VAT Bus. Posting Group", 'LOCAL')
        else
            VendorRec.Validate("VAT Bus. Posting Group", IntVendor."VAT Bus. Posting Group");

        if IntVendor."Vendor Posting Group" = '' then
            VendorRec.Validate("Vendor Posting Group", 'ASSETS')
        else
            VendorRec.Validate("Vendor Posting Group", IntVendor."Vendor Posting Group");

        VendorRec.Validate("Responsibility Center", Rec."Responsibility Center");
        VendorRec.Validate("Currency Code", Rec."Currency Code");
        VendorRec.Validate("Payment Terms Code", Rec."Payment Terms Code");
        VendorRec.Validate("Country/Region Code", Rec."Country/Region Code");
        VendorRec.Validate("Payment Method Code", Rec."Payment Method Code");
        VendorRec.Validate("Fax No.", Rec."Fax No.");

        VendorRec.Validate("Post Code", Rec."Post Code");
        VendorRec.Validate("County", Rec."County");
        VendorRec.Validate("Apollo Vendor No.", Rec."Apollo Vendor No.");
        VendorRec.Validate("Area", Rec."Area");
        VendorRec.Validate("Classification", Rec.Classification);
        VendorRec.Validate("Comments", Rec.Comments);
        VendorRec.Validate("CompanySubType", Rec.CompanySubType);
        VendorRec.Validate("E-mail", Rec.Email);
        VendorRec.Validate("Location Code", Rec."Location Code");
        VendorRec.Validate("Mobile Phone No.", Rec."Mobile Phone No.");
        VendorRec.Modify();
        // VendorRec.Validate("Processed", Rec.Processed);
        Rec."Dynamics Number" := VendorRec."No.";
        Rec.Modify();
    end;

    procedure GetRecords(ApolloNumber: text; DynamicsNumber: text)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Request: HttpRequestMessage;
        OutputString: Text;
    begin
        Request.SetRequestUri(StrSubstNo('https://apollolightingapp.com/api/v1/Project/UpdateVendorDyanmiscNumber/%1/%2', ApolloNumber, DynamicsNumber));
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

    Local procedure SyncVendortoOtherCompanies(VendorRec: Record Vendor)
    var
        OtherCompanyVendorRec: Record Vendor;
    begin
        Clear(OtherCompanyVendorRec);
        IF CompanyName = 'NEW MASQ-KSA' then
            OtherCompanyVendorRec.ChangeCompany('NEW MASQ -QATAR')
        else IF CompanyName = 'NEW MASQ -QATAR' then
            OtherCompanyVendorRec.ChangeCompany('NEW MASQ-KSA');

        OtherCompanyVendorRec.Init();
        OtherCompanyVendorRec.Copy(VendorRec);
        OtherCompanyVendorRec.Insert();
        //  OtherCompanyVendorRec.Validate("Contact", Rec."Contact");
        OtherCompanyVendorRec.Validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        OtherCompanyVendorRec.Validate("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
        //AN 04/09/25 
        if VendorRec."Gen. Bus. Posting Group" = '' then
            OtherCompanyVendorRec.Validate("Gen. Bus. Posting Group", 'LOCAL')
        else
            OtherCompanyVendorRec.Validate("Gen. Bus. Posting Group", VendorRec."Gen. Bus. Posting Group");

        if VendorRec."VAT Bus. Posting Group" = '' then
            OtherCompanyVendorRec.Validate("VAT Bus. Posting Group", 'LOCAL')
        else
            OtherCompanyVendorRec.Validate("VAT Bus. Posting Group", VendorRec."VAT Bus. Posting Group");

        if VendorRec."Vendor Posting Group" = '' then
            OtherCompanyVendorRec.Validate("Vendor Posting Group", 'ASSETS')
        else
            OtherCompanyVendorRec.Validate("Vendor Posting Group", VendorRec."Vendor Posting Group");
        OtherCompanyVendorRec.Validate("Responsibility Center", Rec."Responsibility Center");
        OtherCompanyVendorRec.Validate("Currency Code", Rec."Currency Code");
        OtherCompanyVendorRec.Validate("Payment Terms Code", Rec."Payment Terms Code");
        OtherCompanyVendorRec.Validate("Country/Region Code", Rec."Country/Region Code");
        OtherCompanyVendorRec.Validate("Payment Method Code", Rec."Payment Method Code");
        OtherCompanyVendorRec.Modify();


    end;

    procedure PostRejectVendor(ApolloNumber: text; DynamicsNumber: text; CommentstoApollo: Text)//added on 10/03/2025
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
        RequestMessage.SetRequestUri('https://apollolightingapp.com/api/v1/project/RejectDyanmiscIntermediateVendor');
        RequestMessage.Method := 'POST';

        IF Client.Send(RequestMessage, ResponseMessage) then begin
            IF ResponseMessage.IsSuccessStatusCode then begin
                ResponseMessage.Content.ReadAs(OutputString);
                Message('%1', OutputString + ' :  Vendor is Rejected and information is sent back to apollo');
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
        VendorRec: Record Vendor;
        UserSetup: Record "User Setup";
        InputDynamicsNumber: Boolean;
}
