//FQ MASQ Start
pageextension 70168 "Purch. Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Waybill Reference ID"; Rec."Waybill Reference ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the waybill reference ID (AWB, Truck Waybill, or BL)';
                Importance = Promoted;

                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }
            field("Waybill Type"; Rec."Waybill Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of waybill: Air, Truck, or Bill of Lading';
                Importance = Promoted;

                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }

            field("Waybill Document No."; Rec."Waybill Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Document number from the selected waybill';
                Importance = Additional;
            }

            field("Waybill PO References"; Rec."Waybill PO References")
            {
                ApplicationArea = All;
                ToolTip = 'All PO numbers referenced in the waybill';
                Importance = Additional;
            }

            field("Linked PO No."; Rec."Linked PO No.")
            {
                ApplicationArea = All;
                ToolTip = 'The specific PO number linked to this line';
                Importance = Promoted;

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }

            field("Waybill Vendor Name"; Rec."Waybill Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Vendor name from the linked PO';
                Importance = Additional;
            }

            field("Waybill Project Code"; Rec."Waybill Project Code")
            {
                ApplicationArea = All;
                ToolTip = 'Project code from the linked PO';
                Importance = Additional;
            }

        }
    }
}
//FQ MASQ End