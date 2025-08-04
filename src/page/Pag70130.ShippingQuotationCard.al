page 70130 "Shipping Quotation Card"
{
    PageType = Card;
    SourceTable = "Shipping Quotation";  // Referring to your table (70120)
    ApplicationArea = All;
    //  UsageCategory = Administration;
    InsertAllowed = false;
    RefreshOnActivate = true;
    //play on level visibility for the air or sea type
    layout
    {
        area(content)
        {
            group("General Information")
            {
                Enabled = Rec.Status <> Rec.Status::Approved;
                field("Comparison ID";
                Rec."Comparison ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Project Name"; Rec."Project Name")
                // {
                //     ToolTip = 'Specifies the value of the Project Name field.', Comment = '%';
                // }



                field("Incoterm"; Rec."Incoterm")
                {
                    ApplicationArea = All;
                }
                field("Option"; Rec."Option")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Agent; Rec.Agent)
                {
                    ToolTip = 'Specifies the value of the Agent field.', Comment = '%';
                    Editable = CanChangeAgentonHeader;
                }

                field("Document Reference"; Rec."Document Reference")
                {
                    ApplicationArea = All;
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

            group("Sea Shipping Information")
            {
                Visible = (Rec."Quotation Type" = Rec."Quotation Type"::Sea);
                Enabled = Rec.Status <> Rec.Status::Approved;

                field("Qty of CTR"; Rec."Qty of CTR")
                {
                    ApplicationArea = All;
                }

                field("POL (Port of Loading)"; Rec."POL (Port of Loading)")
                {
                    ApplicationArea = All;
                }

                field("POD (Port of Discharge)"; Rec."POD (Port of Discharge)")
                {
                    ApplicationArea = All;
                }

                // field("Fitting"; Rec."Fitting")
                // {
                //     ApplicationArea = All;
                // }
            }
            group("Air Shipping Information")
            {
                Visible = (Rec."Quotation Type" = Rec."Quotation Type"::Air);
                Enabled = Rec.Status <> Rec.Status::Approved;
                field("AOL"; Rec."AOL")
                {
                    ApplicationArea = All;

                }
                field("AOD"; Rec."AOD")
                {
                    ApplicationArea = All;
                }
                field("NW (Net Weight)"; Rec."NW (Net Weight)")
                {
                    ApplicationArea = All;

                }
                field("GW (Gross Weight)"; Rec."GW (Gross Weight)")
                {
                    ApplicationArea = All;

                }
                field("Volumetric Weight"; Rec."Volumetric Weight")
                {
                    ApplicationArea = All;

                }

                field("Chargeable Weight"; Rec."Chargeable Weight")
                {
                    ApplicationArea = All;

                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
            }

            group("Inland Information")
            {
                Visible = (Rec."Quotation Type" = Rec."Quotation Type"::Inland);
                Enabled = Rec.Status <> Rec.Status::Approved;


                field("POL (Port of Loading)1"; Rec."POL (Port of Loading)")
                {
                    ApplicationArea = All;
                    Caption = 'POL (Port of Loading)';
                }

                field("POD (Port of Discharge)1"; Rec."POD (Port of Discharge)")
                {
                    ApplicationArea = All;
                    Caption = 'POD (Port of Discharge)';
                }

            }

            part("Projects"; "Shipping Quotation Projects")
            {
                ApplicationArea = Basic, Suite;
                Enabled = Rec.Status <> Rec.Status::Approved;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Comparison ID" = field("Comparison ID"), "Quotation Type" = field("Quotation Type");
                //   Visible = rec."Quotation Type" = Rec."Quotation Type"::Air;
                UpdatePropagation = Both;
            }

            part("Air Requirements"; "Requirement Air Subform")
            {
                ApplicationArea = Basic, Suite;
                Enabled = Rec.Status <> Rec.Status::Approved;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Comparison ID" = field("Comparison ID"), "Quotation Type" = const(Air);
                Visible = rec."Quotation Type" = Rec."Quotation Type"::Air;
                UpdatePropagation = Both;
            }
            part("InLand Requirements"; "Requirement Inland Subform")
            {
                ApplicationArea = Basic, Suite;
                Enabled = Rec.Status <> Rec.Status::Approved;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Comparison ID" = field("Comparison ID"), "Quotation Type" = const(Inlnand);
                Visible = rec."Quotation Type" = Rec."Quotation Type"::Inland;
                UpdatePropagation = Both;
            }
            part("Sea Requirements"; "Requirement Sea Subform")
            {
                ApplicationArea = Basic, Suite;
                Enabled = Rec.Status <> Rec.Status::Approved;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Comparison ID" = field("Comparison ID"), "Quotation Type" = const(Sea);
                Visible = rec."Quotation Type" = Rec."Quotation Type"::Sea;
                UpdatePropagation = Both;
            }
            part("Air Details"; "Shipping Quotation Air Subform")
            {
                ApplicationArea = Basic, Suite;
                Enabled = Rec.Status <> Rec.Status::Approved;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Comparison ID" = field("Comparison ID"), "Quotation Type" = const(Air);
                Visible = rec."Quotation Type" = Rec."Quotation Type"::Air;
                UpdatePropagation = Both;
            }
            part("Sea Details"; "Shipping Quotation sea Subform")
            {
                ApplicationArea = Basic, Suite;
                Enabled = Rec.Status <> Rec.Status::Approved;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Comparison ID" = field("Comparison ID"), "Quotation Type" = const(Sea);
                Visible = rec."Quotation Type" = Rec."Quotation Type"::Sea;
                UpdatePropagation = Both;
            }
            part("InLand Details"; "Shipping Quo. InLand Subform")
            {
                ApplicationArea = Basic, Suite;
                Enabled = Rec.Status <> Rec.Status::Approved;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Comparison ID" = field("Comparison ID"), "Quotation Type" = const(Inlnand);
                Visible = rec."Quotation Type" = Rec."Quotation Type"::Inland;
                UpdatePropagation = Both;
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
            part("Decision"; "shipping Quote Factbox")
            {
                ApplicationArea = All;
                Caption = 'Decision';

                // SubPageLink = "Comparison ID" = field("Comparison ID");
                // "Document Type" = field("Document Type")

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
            action(Save)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                begin
                    // Custom save logic or validation can be added here if needed.
                    Message('Shipping Quotation Saved');
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
                var
                    MASQEmail: Codeunit "MASQ Email";
                begin
                    Rec.Status := Rec.Status::Approved;
                    CurrPage.Update();

                    //AN 08/04/2025
                    if Rec.Status = Rec.Status::Approved then
                        MASQEmail.SendEmailAppSQ(Rec);
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
        CanChangeAgentonHeader := Usersetup."Can Change Agent From Header";
    end;

    var
        ChangeStatusofSQ: Boolean;
        CanChangeAgentonHeader: Boolean;
        Usersetup: Record "User Setup";


}
