page 70166 VendorsAPI
{

    Caption = 'Vendor';
    APIGroup = 'MASQ';
    APIPublisher = 'MASQ';
    APIVersion = 'beta';
    DelayedInsert = true;
    EntityName = 'MasqVendorAPI';
    EntitySetName = 'MasqVendorAPI';
    PageType = API;
    SourceTable = "Vendor";





    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No"; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field("Name2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    Caption = 'Name 2';
                }

                field("Address"; Rec.Address)
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                }

                field("Comment"; Rec.Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comment';
                }

                field("PhoneNo"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                }
                field("FaxNo"; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    Caption = 'Fax No.';
                }

                field("MobilePhoneNo"; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Mobile Phone No.';
                }

                field("Email"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail';
                }
                field("PostCode"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Post Code';
                }
                field("HomePage"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    Caption = 'Home Page';
                }
                field("CountryRegionCode"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country/Region Code';
                }
                field("City"; Rec."City")
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }
                field("CurrencyCode"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Caption = 'Currency Code';
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                    Caption = 'Area';
                }
                field("Classification"; Rec.Classification)
                {
                    ApplicationArea = All;
                    Caption = 'Classification';
                }
                field("Comments"; Rec."Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                }

                field(VendSearchName; Rec."Search Name")
                {
                    ApplicationArea = All;
                    Caption = 'VendSearchName';
                }


                field("CompanySubType"; Rec.CompanySubType)
                {
                    ApplicationArea = All;
                    Caption = 'CompanySubType';
                }

                field("NoSeries"; NoSeries)
                {
                    ApplicationArea = All;
                    Caption = 'NoSeries';
                }





            }
        }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchasePayableSetup: Record "Purchases & Payables Setup";
        NoSeries: Code[20];


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if NoSeries = '' then begin
            PurchasePayableSetup.Get();
            Rec."No." := NoSeriesMgt.GetNextNo(PurchasePayableSetup."Vendor Nos.", 0D, true);
        end else begin
            Rec."No." := NoSeriesMgt.GetNextNo(NoSeries, 0D, true);
        end;
        Rec."Gen. Bus. Posting Group" := 'LOCAL';
        Rec."VAT Bus. Posting Group" := 'LOCAL';
        Rec."Vendor Posting Group" := 'ASSETS';
    end;
}