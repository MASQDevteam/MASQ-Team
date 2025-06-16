page 70113 "BL Card"
{
    PageType = Card;
    ApplicationArea = All;
    //  UsageCategory = Administration;
    SourceTable = "BL Details";

    layout
    {
        area(Content)
        {
            group("Bill of Lading")
            {
                field("BL ID"; Rec."BL ID")
                {
                    ToolTip = 'Specifies the value of the BL Number field.', Comment = '%';
                    Enabled = false;
                }
                field("BL Number"; Rec."BL Number")
                {
                    ToolTip = 'Specifies the value of the BL Number field.', Comment = '%';
                    ShowMandatory
                     = true;

                    trigger OnValidate()
                    var
                        BLDetails: Record "BL Details";
                    begin
                        Clear(BLDetails);
                        BLDetails.SetRange("BL Number", REc."BL Number");
                        BLDetails.SetFilter("BL ID", '<> %1', Rec."BL ID");
                        IF BLDetails.FindFirst() then
                            Error('BL Number must be unique for each BL');
                    end;
                }
                field(Liner; Rec.Liner)
                {
                    ToolTip = 'Specifies the value of the Line field.', Comment = '%';
                }
                field("Shipping Quotation Reference"; Rec."Shipping Quotation Reference")
                {
                    ToolTip = 'Specifies the value of the Shipping Quotation Reference field.', Comment = '%';
                    ShowMandatory = true;
                }
                field("Free Demurrage Days"; Rec."Free Demurrage Days")
                {
                    ToolTip = 'Specifies the value of the Free Demurrage Days field.', Comment = '%';
                }
                field("Loading Type"; Rec."Loading Type")
                {
                    ToolTip = 'Specifies the value of the Loading Type field.', Comment = '%';
                }
                field(Vessel; Rec.Vessel)
                {
                    ToolTip = 'Specifies the value of the Vessel field.', Comment = '%';
                }
                field("Voyage Number"; Rec."Voyage Number")
                {
                    ToolTip = 'Specifies the value of the Voyage Number field.', Comment = '%';
                }
                field("Cargo Description"; Rec."Cargo Description")
                {
                    ToolTip = 'Specifies the value of the Cargo Description field.', Comment = '%';
                }
                field(Origin; Rec.Origin)
                {
                    ToolTip = 'Specifies the value of the Origin field.', Comment = '%';
                }
                field("Port of Loading"; Rec."Port of Loading")
                {
                    ToolTip = 'Specifies the value of the Port of Loading field.', Comment = '%';
                }
                field(Transshipment; Rec.Transshipment)
                {
                    ToolTip = 'Specifies the value of the Transshipment field.', Comment = '%';
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.', Comment = '%';
                }
                field(BL; Rec.BL)
                {
                    Caption = 'BL Date';
                    ToolTip = 'Specifies the value of the BL field.', Comment = '%';
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.', Comment = '%';
                }
                field(Agent; Rec.Agent)
                {
                    ToolTip = 'Specifies the value of the Agent field.', Comment = '%';
                }
                field("Docs Sent to Entity Date"; Rec."Docs Sent to Entity Date")
                {
                    ToolTip = 'Specifies the value of the Docs Sent to Entity Date field.', Comment = '%';
                }
                field("Docs Received in Entity Date"; Rec."Docs Received in Entity Date")
                {
                    ToolTip = 'Specifies the value of the Docs Received in Entity Date field.', Comment = '%';
                }
                field("Docs AWB No"; Rec."Docs AWB No")
                {
                    ToolTip = 'Specifies the value of the Docs AWB No field.', Comment = '%';
                }
                field("Copy Docs Sent to Agent Date"; Rec."Copy Docs Sent to Agent Date")
                {
                    ToolTip = 'Specifies the value of the Copy Docs Sent to Agent Date field.', Comment = '%';
                }
                field("Docs Delivered to Clearing Agent"; Rec."Docs Delivered to Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Docs Delivered to Clearing Agent field.', Comment = '%';
                }
                field("Assessment Date"; Rec."Assessment Date")
                {
                    ToolTip = 'Specifies the value of the Assessment Date field.', Comment = '%';
                }
                field("Duty Paid Date"; Rec."Duty Paid Date")
                {
                    ToolTip = 'Specifies the value of the Duty Paid Date field.', Comment = '%';
                }
                field("Duty Receipt sent to agent"; Rec."Duty Receipt sent to agent")
                {
                    ToolTip = 'Specifies the value of the Duty Receipt sent to agent field.', Comment = '%';
                }
                // field("Container ID"; Rec."Container ID")
                // {
                //     ToolTip = 'Specifies the value of the Container ID field.', Comment = '%';
                //     Editable = false;
                //     //  Enabled = false;
                //     // trigger OnValidate()
                //     // var
                //     // begin
                //     //     CurrPage.Update(false);
                //     // end;
                // }
                field("Invoiced Received Date"; Rec."Invoiced Received Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                    MultiLine = true;
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                }


            }
            part(Container; "Container Subform")
            {
                ApplicationArea = Basic, Suite;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "BL ID" = field("BL ID");
                UpdatePropagation = Both;
            }
            part(PurchLines; "Purchase Order Subform")
            {
                ApplicationArea = Suite;
                // Editable = IsPurchaseLinesEditable;
                // Enabled = IsPurchaseLinesEditable;
                ShowFilter = true;
                Provider = Container;

                SubPageLink = "BL/AWB ID" = field("BL ID"), "Container ID" = field("Container ID"), "Container Line No." = field("Line No.");
                UpdatePropagation = Both;
                Editable = false;
                Enabled = false;

            }
            part(PurchInvLines; "Posted Purch. Invoice Subform")
            {
                Caption = 'Posted Lines';
                ApplicationArea = Basic, Suite;
                Editable = false;
                Enabled = false;
                // Editable = IsPurchaseLinesEditable;
                // Enabled = IsPurchaseLinesEditable;
                ShowFilter = true;
                Provider = Container;

                SubPageLink = "BL/AWB ID" = field("BL ID"), "Container ID" = field("Container ID"), "Container Line No." = field("Line No.");
                UpdatePropagation = Both;
            }

        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"BL Details"),
                              "No." = field("BL ID");
                // "Document Type" = field("Document Type");
            }
            part("Shipping Dates"; "Shipping Dates LOG Factbox")
            {
                ApplicationArea = All;
                Caption = 'Shipping Dates Log';
                Provider = PurchLines;
                SubPageLink = "PO Number" = field("Document No."), "PO Line Number" = field("Line No."), "BL/AWB ID" = field("BL/AWB ID"), "Container Number" = field("Container ID");
                // "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        // CurrPage.Update(true);
    end;

    // trigger OnModifyRecord(): Boolean
    // var
    // begin
    //     CurrPage.Update(true);
    //     CurrPage.Container.Page.Update(true);
    // end;

    var
        myInt: Integer;
}