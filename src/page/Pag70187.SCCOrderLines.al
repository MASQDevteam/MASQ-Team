//FQ MASQ **START**
page 70187 "SCC Order Lines"
{
    ApplicationArea = All;
    Caption = 'Purchase Orders';
    PageType = ListPart;
    SourceTable = "SCC Order Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase order number.';
                    Importance = Promoted;
                }

                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
                    Editable = false;
                }

                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name.';
                    Editable = false;
                }

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document date.';
                    Editable = false;
                }

                field("Apollo Project No."; Rec."Apollo Project No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Apollo project number.';
                    Editable = false;
                }
            }
        }
    }



    /*  trigger OnNewRecord(BelowxRec: Boolean)
     begin
         Rec."SCC No." := Rec.GetFilter("SCC No.");
     end; */
}
//FQ MASQ **END**
