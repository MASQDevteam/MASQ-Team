page 70149 "Truck WayBill Card"
{
    PageType = Card;
    SourceTable = "Truck WayBill";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Truck WayBill ID"; Rec."Truck WayBill ID")
                {
                    ToolTip = 'Specifies the value of the Truck WayBill ID field.', Comment = '%';
                }
                field("Truck WayBill"; Rec."Truck WayBill")
                {
                }
                field("Line"; Rec."Line")
                {
                }
                field("Shipping Quotation Reference"; Rec."Shipping Quotation Reference")
                {
                    ToolTip = 'Specifies the value of the Shipping Quotation Reference field.', Comment = '%';
                    ShowMandatory = true;
                }
                field("Free Demurrage Days"; Rec."Free Demurrage Days")
                {
                }
                field("Voyage Number"; Rec."Voyage Number")
                {
                }
                field("Cargo Description"; Rec."Cargo Description")
                {
                }
                field("Origin"; Rec."Origin")
                {
                }
                field("Port of Loading"; Rec."Port of Loading")
                {
                    Caption = 'Place of Loading';
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {

                    Caption = 'Place of Discharge';
                }
                field("Waybill Date"; Rec."Waybill Date")
                {
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                }
                field("Docs Sent to Entity Date"; Rec."Docs Sent to Entity Date")
                {
                }
                field("Docs Received in Entity Date"; Rec."Docs Received in Entity Date")
                {
                }
                field("Docs AWB No"; Rec."Docs AWB No")
                {
                }
                field("Copy Docs Sent to Agent Date"; Rec."Copy Docs Sent to Agent Date")
                {
                }
                field("Docs Delivered to Clearing Agent"; Rec."Docs Delivered to Clearing Agent")
                {
                }
                field("Assessment Date"; Rec."Assessment Date")
                {
                }
                field("Duty Paid Date"; Rec."Duty Paid Date")
                {
                }
                field("Duty Receipt sent to agent"; Rec."Duty Receipt sent to agent")
                {
                }
                field("Invoiced Received Date"; Rec."Invoiced Received Date")
                {
                    ApplicationArea = All;
                }
                field("Remarks"; Rec."Remarks")
                {
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
            part("Truck Details"; "Truck Details Subform")
            {
                ApplicationArea = Basic, Suite;
                //  Editable = IsSalesLinesEditable;
                //   Enabled = IsSalesLinesEditable;
                SubPageLink = "Truck WayBill ID" = field("Truck WayBill ID");
                UpdatePropagation = Both;
            }
            part(PurchLines; "Purchase Order Subform")
            {
                ApplicationArea = Suite;
                // Editable = IsPurchaseLinesEditable;
                // Enabled = IsPurchaseLinesEditable;
                ShowFilter = true;
                Provider = "Truck Details";

                SubPageLink = "Truck WayBill ID" = field("Truck WayBill ID"), "Truck Details ID" = field("Truck Details ID"), "Truck Details Line No." = field("Line No.");
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
                Provider = "Truck Details";

                SubPageLink = "Truck WayBill ID" = field("Truck WayBill ID"), "Truck Details ID" = field("Truck Details ID"), "Truck Details Line No." = field("Line No.");
                UpdatePropagation = Both;
            }

        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Truck WayBill"),
                              "No." = field("Truck WayBill ID");
                // "Document Type" = field("Document Type");
            }
            part("Shipping Dates"; "Shipping Dates LOG Factbox")
            {
                ApplicationArea = All;
                Caption = 'Shipping Dates Log';
                Provider = PurchLines;
                SubPageLink = "PO Number" = field("Document No."), "PO Line Number" = field("Line No."), "Truck WayBill ID" = field("Truck WayBill ID"), "Truck Details ID" = field("Truck Details ID");
                // "Document Type" = field("Document Type");
            }
        }
    }


    actions
    {
        area(processing)
        {
            action("Process")
            {
                ApplicationArea = All;
                Caption = 'Process';
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        "BL": Record "BL Details";
    begin
        if Rec."Truck WayBill ID" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("Truck WayBill No. Series");


            if NoSeries.AreRelated(GLSetup."Truck WayBill No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."Truck WayBill No. Series";

            Rec."Truck WayBill ID" := NoSeries.GetNextNo(Rec."No. Series");

            //   end;
        end;
    end;
}