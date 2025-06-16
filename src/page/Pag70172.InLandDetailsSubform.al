page 70172 "InLandDetailsSubform"
{
    PageType = ListPart;
    SourceTable = "Truck Details";
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'InLand Truck Details';

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
                    Caption = 'InLand Truck Type';
                }
                field("Truck Load CBM"; Rec."Truck Load CBM")
                {
                    Caption = 'InLand Truck Load CBM';
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
                field("Initial ETA"; Rec."Initial ETA")
                {
                }
                field("Initial ETD"; Rec."Initial ETD")
                { }

                field("Final ETD"; Rec."Final ETD")
                {
                }
                field("Final ETA"; Rec."Final ETA")
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