page 70151 "Truck Details Subform"
{
    PageType = ListPart;
    SourceTable = "Truck Details";
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Seal Number"; Rec."Seal Number")
                {
                }
                field("Truck Type"; Rec."Truck Type")
                {
                }
                field("Truck Load CBM"; Rec."Truck Load CBM")
                {
                }
                field("Tonnage"; Rec."Tonnage")
                {
                }
                field("Loaded On Board"; Rec."Loaded On Board")
                {
                }
                field("Terminal Delivery Order Date"; Rec."Terminal Delivery Order Date")
                {
                }
                field("Remarks"; Rec."Remarks")
                {
                }
                field("Final ETR"; Rec."Final ETR")
                {
                }
                field("Final ETD"; Rec."Final ETD")
                {
                }
                field("Final ETA"; Rec."Final ETA")
                {
                }
                field("Final ETAW"; Rec."Final ETAW")
                {
                }
                field("ATA"; Rec."ATA")
                {
                }

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