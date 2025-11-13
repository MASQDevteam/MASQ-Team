page 70173 "In Land Truck WayBill Card"
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
                    Caption = 'InLand WayBill ID';
                }
                field("Truck WayBill"; Rec."Truck WayBill")
                {
                    Caption = 'InLand WayBill';
                }
                field("Waybill Date"; Rec."Waybill Date")
                {
                    ApplicationArea = All;
                }
                field("WayBill Type"; Rec."WayBill Type")
                {
                    ApplicationArea = All;
                }
                field("GROSS Weight in KG"; Rec."GROSS Weight in KG")
                {
                    ToolTip = 'Specifies the value of the GROSS Weight in KG field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("VOLUMETRIC Weight in KG"; Rec."VOLUMETRIC Weight in KG")
                {
                    ToolTip = 'Specifies the value of the VOLUMETRIC Weight in KG field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("NET Weight in KG"; Rec."NET Weight in KG")
                {
                    ToolTip = 'Specifies the value of the Weight in KG field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Packing Quantity"; Rec."Packing Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Received Date"; Rec."Invoiced Received Date")
                {
                    ApplicationArea = All;
                }


                field("Remarks"; Rec."Remarks")
                {
                }
                field("PO No. (Inland)"; Rec."PO No. (Inland)")
                {
                    ApplicationArea = All;
                    Caption = 'PO No.';
                }
                // field("From Location"; Rec."From Location")
                // {
                //     ApplicationArea = All;
                // }
                // field("To Location"; Rec."To Location")
                // {
                //     ApplicationArea = All;
                // }
                field("Project No. (Inland)"; Rec."Project No. (Inland)")
                {
                    ApplicationArea = All;
                    Caption = 'Apollo Project No.';
                }
            }
            part(InLandDetailsSubform; InLandDetailsSubform)
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
                Provider = InLandDetailsSubform;

                SubPageLink = "InLand ID" = field("Truck WayBill ID"), "Inland Details Line No" = field("Line No.");
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
                Provider = InLandDetailsSubform;

                SubPageLink = "InLand ID" = field("Truck WayBill ID"), "Inland Details Line No" = field("Line No.");
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
       // NoSeriesManagement: Codeunit NoSeriesManagement;
        "BL": Record "BL Details";
    begin
        if Rec."Truck WayBill ID" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("InLandTruckWayBill No. Series");


            if NoSeries.AreRelated(GLSetup."InLandTruckWayBill No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."InLandTruckWayBill No. Series";

            Rec."Truck WayBill ID" := NoSeries.GetNextNo(Rec."No. Series");
        end;
        Rec."In Land" := true;
    end;

}