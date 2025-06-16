pageextension 70158 "Posted Purch. Invoice Linese" extends "Posted Purchase Invoice Lines"
{
    // Add your customizations here, e.g., new fields, actions, or layout changes

    layout
    {
        // Example: Add a field to the repeater
        // addlast(ControlGroup)
        // {
        //     field("Your Field Name"; "Your Field Source")
        //     {
        //     }
        // }
        addlast(Control1)
        {
            field(ATA; Rec.ATA)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ATA field.', Comment = '%';
            }
            field("BL/AWB ID"; Rec."BL/AWB ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BL/AWB ID field.', Comment = '%';
            }
            field("Batch Number"; Rec."Batch Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch Number field.', Comment = '%';
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
            }
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the blanket order that the record originates from.';
            }
            field("Container ID"; Rec."Container ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container ID field.', Comment = '%';
            }
            field("Container Line No."; Rec."Container Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container Line No. field.', Comment = '%';
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
            }
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Factor field.', Comment = '%';
            }
            field("Direct Unit Cost LCY"; Rec."Direct Unit Cost LCY")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Direct Unit Cost LCY field.', Comment = '%';
            }
            field("Final ETA"; Rec."Final ETA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETA field.', Comment = '%';
            }
            field("Final ETAW"; Rec."Final ETAW")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETAW field.', Comment = '%';
            }
            field("Final ETD"; Rec."Final ETD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETD field.', Comment = '%';
            }
            field("Final ETR"; Rec."Final ETR")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETR field.', Comment = '%';
            }
            field("Initial ETA"; Rec."Initial ETA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETA field.', Comment = '%';
            }
            field("Initial ETAW"; Rec."Initial ETAW")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETAW field.', Comment = '%';
            }
            field("Initial ETD"; Rec."Initial ETD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETD field.', Comment = '%';
            }
            field("Initial ETR"; Rec."Initial ETR")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETR field.', Comment = '%';
            }
            field("Job#"; Rec."Job#")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job ID field.', Comment = '%';
            }
            field("Line Amount LCY"; Rec."Line Amount LCY")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line Amount field.', Comment = '%';
            }
            field("Line Amount"; Rec."Line Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
            }
            field("MASQ Sales Order Line No."; Rec."MASQ Sales Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Sales Order Line No. field.', Comment = '%';
            }
            field("MASQ Sales Order No."; Rec."MASQ Sales Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Sales Order No. field.', Comment = '%';
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the location where the invoice line is registered.';
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
            }
            field("Shipping By"; Rec."Shipping By")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping By field.', Comment = '%';
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
            }
            field("Splitted Line No."; Rec."Splitted Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Splitted Line No. field.', Comment = '%';
            }
            field("Subjob ID"; Rec."Subjob ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subjob ID field.', Comment = '%';
            }
            field("Truck Details ID"; Rec."Truck Details ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Truck Details ID field.', Comment = '%';
            }
            field("Truck Details Line No."; Rec."Truck Details Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Truck Details Line No. field.', Comment = '%';
            }
            field("Truck WayBill ID"; Rec."Truck WayBill ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Truck WayBill ID field.', Comment = '%';
            }
            field("VO Number"; Rec."VO Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VO Number field.', Comment = '%';
            }
            field("Vendor Item No."; Rec."Vendor Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Item No. field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Example: Add a new action
        // addlast(Processing)
        // {
        //     action(MyAction)
        //     {
        //         ApplicationArea = All;
        //         Caption = 'My Action';
        //         Image = Action;
        //         trigger OnAction()
        //         begin
        //             // Your code here
        //         end;
        //     }
        // }
    }
}