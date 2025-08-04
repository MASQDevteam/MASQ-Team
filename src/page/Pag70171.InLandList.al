page 70171 "InLand List"
{
    PageType = List;
    SourceTable = "Truck WayBill";
    SourceTableView = where("In Land" = const(true));
    ApplicationArea = All;
    CardPageId = "In Land Truck WayBill Card";
    UsageCategory = Lists;
    Caption = 'InLand Truck WayBills';


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Truck WayBill"; Rec."Truck WayBill")
                {
                    Caption = 'InLand Truck WayBill';
                }
                field("Waybill Date"; Rec."Waybill Date")
                {
                    Caption = 'Inland Waybill Date';
                }
                field("WayBill Type"; Rec."WayBill Type")
                {
                    ApplicationArea = All;
                }
                field(Agent; Rec.Agent)
                {
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
                field("Line"; Rec."Line")
                {
                }
                field("Free Demurrage Days"; Rec."Free Demurrage Days")
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
                field("Remarks"; Rec."Remarks")
                {
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                }
                // field("From Location"; Rec."From Location")
                // {
                //     ApplicationArea = All;
                // }
                // field("To Location"; Rec."To Location")
                // {
                //     ApplicationArea = All;
                // }
                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                }
            }


        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Truck WayBill"),
                              "No." = field("Truck WayBill ID");// modified by  //AN 04/03/2025 was field("Truck WayBill");
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
}