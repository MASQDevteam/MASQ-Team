page 70131 "Shipping Quotations List"
{
    PageType = List;
    SourceTable = "Shipping Quotation";  // Referring to your table (70120)
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    CardPageId = "Shipping Quotation Card";
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Comparison ID"; Rec."Comparison ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the comparison';
                }
                // field("Project Name"; Rec."Project Name")
                // {
                //     ToolTip = 'Specifies the value of the Project Name field.', Comment = '%';
                // }



                field("AOD"; Rec."AOD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Airport of Discharge';
                }

                field("Incoterm"; Rec."Incoterm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Incoterm used for this shipment';
                }

                field("GW (Gross Weight)"; Rec."GW (Gross Weight)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gross weight of the shipment';
                }

                field("Volumetric Weight"; Rec."Volumetric Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Volumetric weight of the shipment';
                }

                field("Chargeable Weight"; Rec."Chargeable Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Chargeable weight based on the gross or volumetric weight';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                //AN 05/12/2025
                field("Document Reference"; Rec."Document Reference")
                {
                    Caption = 'PO #';
                }
                field("Apollo Project No."; Rec."Apollo Project No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Shipping Quotation"),
                              "No." = field("Comparison ID");
                // "Document Type" = field("Document Type");
            }
            part("Attached Documents2"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments Details';
                SubPageLink = "Table ID" = const(Database::"Shipping Quotation Details"),
                                 "No." = field("Comparison ID");
                // "Document Type" = field("Document Type");
            }

            //AN 04/17/2025
            systempart(ShQNotes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(NewRecord_Sea)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    ShippingQuotationRec: Record "Shipping Quotation";
                    ShippingQuotationDetail: Record "Shipping Quotation Details";
                begin
                    // Create new record for the Shipping Quotation
                    ShippingQuotationRec.Init();


                    if ShippingQuotationRec."Comparison ID" = '' then begin
                        GLSetup.Get();
                        GLSetup.TestField("Shipping Quo Sea No. series");

                        ShippingQuotationRec."Comparison ID" := NoSeries.GetNextNo(GLSetup."Shipping Quo Sea No. series");

                        //   end;
                    end;
                    ShippingQuotationRec."Quotation Type" := ShippingQuotationRec."Quotation Type"::Sea;
                    ShippingQuotationRec.Insert();


                    // ShippingQuotationDetail.Init();
                    // ShippingQuotationDetail."Comparison ID" := ShippingQuotationRec."Comparison ID";
                    // ShippingQuotationDetail."Line No." := 1000;
                    // ShippingQuotationDetail."Quotation Type" := ShippingQuotationDetail."Quotation Type"::Sea;
                    // ShippingQuotationDetail.Insert(true);
                    // Optionally, you can navigate the user to the created record's card page
                    PAGE.Run(PAGE::"Shipping Quotation Card", ShippingQuotationRec);
                end;
            }
            action(NewRecord_Air)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    ShippingQuotationRec: Record "Shipping Quotation";
                    ShippingQuotationDetail: Record "Shipping Quotation Details";
                begin
                    // Create new record for the Shipping Quotation
                    ShippingQuotationRec.Init();

                    if ShippingQuotationRec."Comparison ID" = '' then begin
                        GLSetup.Get();
                        GLSetup.TestField("Shipping Quo Air No. series");

                        ShippingQuotationRec."Comparison ID" := NoSeries.GetNextNo(GLSetup."Shipping Quo Air No. series");

                        //   end;
                    end;
                    ShippingQuotationRec."Quotation Type" := ShippingQuotationRec."Quotation Type"::Air;
                    ShippingQuotationRec.Insert();

                    // ShippingQuotationDetail.Init();
                    // ShippingQuotationDetail."Comparison ID" := ShippingQuotationRec."Comparison ID";
                    // ShippingQuotationDetail."Line No." := 1000;
                    // ShippingQuotationDetail."Quotation Type" := ShippingQuotationDetail."Quotation Type"::Air;
                    // ShippingQuotationDetail.Insert(true);
                    // Optionally, you can navigate the user to the created record's card page
                    PAGE.Run(PAGE::"Shipping Quotation Card", ShippingQuotationRec);
                end;
            }

            action(NewRecord_InLand)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    ShippingQuotationRec: Record "Shipping Quotation";
                    ShippingQuotationDetail: Record "Shipping Quotation Details";
                begin
                    // Create new record for the Shipping Quotation
                    ShippingQuotationRec.Init();

                    if ShippingQuotationRec."Comparison ID" = '' then begin
                        GLSetup.Get();
                        GLSetup.TestField("Shipping Quo InLand No. series");

                        ShippingQuotationRec."Comparison ID" := NoSeries.GetNextNo(GLSetup."Shipping Quo InLand No. series");

                        //   end;
                    end;
                    ShippingQuotationRec."Quotation Type" := ShippingQuotationRec."Quotation Type"::Inland;
                    ShippingQuotationRec.Insert();

                    // ShippingQuotationDetail.Init();
                    // ShippingQuotationDetail."Comparison ID" := ShippingQuotationRec."Comparison ID";
                    // ShippingQuotationDetail."Line No." := 1000;
                    // ShippingQuotationDetail."Quotation Type" := ShippingQuotationDetail."Quotation Type"::Air;
                    // ShippingQuotationDetail.Insert(true);
                    // Optionally, you can navigate the user to the created record's card page
                    PAGE.Run(PAGE::"Shipping Quotation Card", ShippingQuotationRec);
                end;
            }
            action(Approve)
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = ReleaseDoc;
                Enabled = (Rec.Status <> Rec.Status::Approved) AND (ChangeStatusofSQ);
                ShortCutKey = 'Ctrl+F9';
                ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    CurrPage.Update();

                end;
            }
            action(Reopen)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Re&open';
                Enabled = (Rec.Status <> Rec.Status::Open) AND (ChangeStatusofSQ);
                Image = ReOpen;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                trigger OnAction()
                var
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin
                    Rec.Status := Rec.Status::Open;
                    CurrPage.Update();
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reject';
                Enabled = (Rec.Status = Rec.Status::Open) AND (ChangeStatusofSQ);
                Image = ReOpen;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                trigger OnAction()
                var
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin
                    Rec.Status := Rec.Status::Rejected;
                    CurrPage.Update();
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
    begin
        // Rec.SetRange(Executed, false)
        ;
        Usersetup.Get(UserId);
        ChangeStatusofSQ := Usersetup."Change Status of SQ";

    end;

    var
        GLSetup: Record "General Ledger Setup";
        NoSeries: Codeunit "No. Series";
        Usersetup: Record "User Setup";
        ChangeStatusofSQ: Boolean;

    // Optional: Filtering / Sorting can be applied here
}
