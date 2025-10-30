//NB MASQ Start
page 70182 "Shipping Dates Log List"
{
    ApplicationArea = All;
    Caption = 'Shipping Dates Log List';
    PageType = List;
    SourceTable = "Supply Chain LOG";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ATA; Rec.ATA)
                {
                    ToolTip = 'Specifies the value of the ATA field.', Comment = '%';
                }
                field("BL/AWB ID"; Rec."BL/AWB ID")
                {
                    ToolTip = 'Specifies the value of the BL/AWB ID field.', Comment = '%';
                }
                field("Batch Number"; Rec."Batch Number")
                {
                    ToolTip = 'Specifies the value of the Batch Number field.', Comment = '%';
                }
                field("Container Number"; Rec."Container Number")
                {
                    ToolTip = 'Specifies the value of the Container Number field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Final ETA"; Rec."Final ETA")
                {
                    ToolTip = 'Specifies the value of the Final ETA field.', Comment = '%';
                }
                field("Final ETAW"; Rec."Final ETAW")
                {
                    ToolTip = 'Specifies the value of the Final ETAW field.', Comment = '%';
                }
                field("Final ETD"; Rec."Final ETD")
                {
                    ToolTip = 'Specifies the value of the Final ETD field.', Comment = '%';
                }
                field("Final ETR"; Rec."Final ETR")
                {
                    ToolTip = 'Specifies the value of the Final ETR field.', Comment = '%';
                }
                field("Initial ETA"; Rec."Initial ETA")
                {
                    ToolTip = 'Specifies the value of the Initial ETA field.', Comment = '%';
                }
                field("Initial ETAW"; Rec."Initial ETAW")
                {
                    ToolTip = 'Specifies the value of the Initial ETAW field.', Comment = '%';
                }
                field("Initial ETD"; Rec."Initial ETD")
                {
                    ToolTip = 'Specifies the value of the Initial ETD field.', Comment = '%';
                }
                field("Initial ETR"; Rec."Initial ETR")
                {
                    ToolTip = 'Specifies the value of the Initial ETR field.', Comment = '%';
                }
                field("Item Number"; Rec."Item Number")
                {
                    ToolTip = 'Specifies the value of the Item Number field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("New Cost"; Rec."New Cost")
                {
                    ToolTip = 'Specifies the value of the New Cost field.', Comment = '%';
                }
                field("New Item"; Rec."New Item")
                {
                    ToolTip = 'Specifies the value of the New Item field.', Comment = '%';
                }
                field("New Price"; Rec."New Price")
                {
                    ToolTip = 'Specifies the value of the New Price field.', Comment = '%';
                }
                field("New Qty"; Rec."New Qty")
                {
                    ToolTip = 'Specifies the value of the New Qty field.', Comment = '%';
                }
                field("New UOM"; Rec."New UOM")
                {
                    ToolTip = 'Specifies the value of the New UOM field.', Comment = '%';
                }
                field("Old Cost"; Rec."Old Cost")
                {
                    ToolTip = 'Specifies the value of the Old Cost field.', Comment = '%';
                }
                field("Old Item"; Rec."Old Item")
                {
                    ToolTip = 'Specifies the value of the Old Item field.', Comment = '%';
                }
                field("Old Price"; Rec."Old Price")
                {
                    ToolTip = 'Specifies the value of the Old Price field.', Comment = '%';
                }
                field("Old Qty"; Rec."Old Qty")
                {
                    ToolTip = 'Specifies the value of the Old Qty field.', Comment = '%';
                }
                field("Old UOM"; Rec."Old UOM")
                {
                    ToolTip = 'Specifies the value of the Old UOM field.', Comment = '%';
                }
                field("PO Line Number"; Rec."PO Line Number")
                {
                    ToolTip = 'Specifies the value of the PO Line Number field.', Comment = '%';
                }
                field("PO Number"; Rec."PO Number")
                {
                    ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
                }
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.', Comment = '%';
                }
                field("Project planning Line No."; Rec."Project planning Line No.")
                {
                    ToolTip = 'Specifies the value of the Project planning Line No. field.', Comment = '%';
                }
                field("SO Line Number"; Rec."SO Line Number")
                {
                    ToolTip = 'Specifies the value of the SO Line Number field.', Comment = '%';
                }
                field("SO Number"; Rec."SO Number")
                {
                    ToolTip = 'Specifies the value of the SO Number field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Truck Details ID"; Rec."Truck Details ID")
                {
                    ToolTip = 'Specifies the value of the Truck Details ID field.', Comment = '%';
                }
                field("Truck WayBill ID"; Rec."Truck WayBill ID")
                {
                    ToolTip = 'Specifies the value of the Truck WayBill ID field.', Comment = '%';
                }
                field("VO Number"; Rec."VO Number")
                {
                    ToolTip = 'Specifies the value of the VO Number field.', Comment = '%';
                }
            }
        }
    }
}
//NB MASQ End