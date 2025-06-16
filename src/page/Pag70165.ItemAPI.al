page 70165 "Item API"
{

    Caption = 'items';
    APIGroup = 'MASQ';
    APIPublisher = 'MASQ';
    APIVersion = 'beta';
    DelayedInsert = true;
    EntityName = 'MasqItemsAPI';
    EntitySetName = 'MasqItemsAPI';
    PageType = API;
    SourceTable = Item;
    ODataKeyFields = SystemId;



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Id"; Rec.SystemId)
                {
                    ApplicationArea = All;
                    Caption = 'Id';
                }
                field("price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Id';
                }

                field("No"; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';//, Locked = true;
                    Editable = false;
                }
                field("ItemCode"; Rec."Meg Vendor Item Code")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }

                field(ItemSearchDescription; Rec."Search Description")
                {
                    ApplicationArea = All;
                    Caption = 'ItemSearchDescription';
                }
                field("DynamicsDescription"; Rec.Description) //100 char only
                {
                    ApplicationArea = All;
                    Caption = 'DynamicsDescription';

                    trigger OnValidate()
                    begin
                        Rec."Meg Other Details" := Rec.Description;
                    end;
                }
                field("ItemCategoryCode"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                }
                // field("ItemCategoryCode"; Rec."Meg Item Subcategory Code")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Item Category Code';
                // }
                field("CountryRegionCode"; Rec."Country/Region of Origin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country/Region of Origin Code';
                }
                field("VendorNo"; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                }

                field("NetWeight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Net Weight';
                }
                field("Comment"; Rec.Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comment';
                }

                field("Type"; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field("BaseUnitOfMeasure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }

                field("SalesUnitOfMeasure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'SalesUnitOfMeasure';
                }
                field("PurchaseUnitOfMeasure"; Rec."Purch. Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'PurchaseUnitOfMeasure';
                }
                field("ApolloItemNo"; Rec.ApolloItemNo)
                {
                    ApplicationArea = All;
                    Caption = 'Apollo Item No.';
                }

                field("Family"; Rec."Meg Family")
                {
                    ApplicationArea = All;
                    Caption = 'Family';
                }

                field("SupplyPower"; Rec."Meg Supply Power")
                {
                    ApplicationArea = All;
                    Caption = 'Supply Power';
                }

                field("SupplyCurrent"; Rec."Meg Supply Current")
                {
                    ApplicationArea = All;
                    Caption = 'Supply Current';
                }

                field("IKCode"; Rec."Meg IK Code")
                {
                    ApplicationArea = All;
                    Caption = 'IKCode';
                }

                field("BeamAngle"; Rec."Meg Beam Angle")
                {
                    ApplicationArea = All;
                    Caption = 'beamAngle';
                }

                field("ItemDimension"; Rec.ItemDimension)
                {
                    ApplicationArea = All;
                    Caption = 'Item Dimension';
                }

                field("LampIncluded"; Rec.LampIncluded)
                {
                    ApplicationArea = All;
                    Caption = 'Lamp Included';
                }

                field("LampsCount"; Rec."Meg Lamps Count")
                {
                    ApplicationArea = All;
                    Caption = 'Lamps Count';
                }

                field("Wattage"; Rec."Meg Wattage")
                {
                    ApplicationArea = All;
                    Caption = 'Wattage';
                }

                field("TotalWatt"; Rec."Meg Total Wattage")
                {
                    ApplicationArea = All;
                    Caption = 'Total Watt';
                }

                field("Voltage"; Rec."Meg Voltage")
                {
                    ApplicationArea = All;
                    Caption = 'Voltage';
                }

                field("LEDLumen"; Rec."Meg LED Lumen")
                {
                    ApplicationArea = All;
                    Caption = 'LED Lumen';
                }

                field("NetLumen"; Rec."Meg Net Lumen")
                {
                    ApplicationArea = All;
                    Caption = 'Net Lumen';
                }

                field("Installation"; Rec."Meg Installation")
                {
                    ApplicationArea = All;
                    Caption = 'Installation';
                }

                field("Driver"; Rec."Meg Driver")
                {
                    ApplicationArea = All;
                    Caption = 'Driver';
                }

                field("Housing"; Rec."Meg Housing")
                {
                    ApplicationArea = All;
                    Caption = 'Housing';
                }

                field("Reflector"; Rec."Meg Reflector")
                {
                    ApplicationArea = All;
                    Caption = 'Reflector';
                }

                field("Diffuser"; Rec."Meg Diffuser")
                {
                    ApplicationArea = All;
                    Caption = 'Diffuser';
                }

                field("Frame"; Rec."Meg Frame")
                {
                    ApplicationArea = All;
                    Caption = 'Frame';
                }

                field("Brackets"; Rec."Meg Bracket")
                {
                    ApplicationArea = All;
                    Caption = 'Brackets';
                }

                field("IPCode"; Rec."Meg IP Code")
                {
                    ApplicationArea = All;
                    Caption = 'IP Code';
                }

                field("BeamType"; Rec."Meg Beam Type")
                {
                    ApplicationArea = All;
                    Caption = 'Beam Type';
                }

                field("FittingColor"; Rec."Meg Fitting Color")
                {
                    ApplicationArea = All;
                    Caption = 'Fitting Color';
                }

                field("Shape"; Rec."Meg Shape")
                {
                    ApplicationArea = All;
                    Caption = 'Shape';
                }

                field("LampSource"; Rec."Meg Lamp Source")
                {
                    ApplicationArea = All;
                    Caption = 'Lamp Source';
                }

                field("ColorTemp"; Rec."Meg Color Temp")
                {
                    ApplicationArea = All;
                    Caption = 'Color Temp';
                }

                field("Comments"; Rec."Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                }
                field(Brand; Rec."Meg Brand")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }
                field(HistoryId; Rec.HistoryId)
                {
                    ApplicationArea = All;
                    Caption = 'HistoryId';
                }
                field(IsAccessory; Rec.IsAccessory)
                {
                    ApplicationArea = All;
                    Caption = 'IsAccessory';
                }

                field("IsPreferred"; Rec."Meg Is Preferred")
                {
                    ApplicationArea = All;
                    Caption = 'Is Preferred';
                }

                field("IsService"; Rec."Meg Is Service")
                {
                    ApplicationArea = All;
                    Caption = 'Is Service';
                }

                field("IsOutdoor"; Rec."Meg Is Outdoor")
                {
                    ApplicationArea = All;
                    Caption = 'Is Outdoor';
                }

                field("IsIndoor"; Rec."Meg Is Indoor")
                {
                    ApplicationArea = All;
                    Caption = 'Is Indoor';
                }

                field("IsLocked"; Rec."Meg Is Locked")
                {
                    ApplicationArea = All;
                    Caption = 'Is Locked';
                }

                field("IsSpecial"; Rec."Meg Is Special")
                {
                    ApplicationArea = All;
                    Caption = 'Is Special';
                }

                //NEW Fieldds
                field("HSCode"; Rec."Meg HS Code")
                {
                    ApplicationArea = All;
                    Caption = 'HS Code';
                }

                field("CRI"; Rec."Meg CRI")
                {
                    ApplicationArea = All;
                    Caption = 'CRI';
                }

                field("UGR"; Rec."Meg UGR")
                {
                    ApplicationArea = All;
                    Caption = 'UGR';
                }

                field("Diameter"; Rec."Meg Diameter")
                {
                    ApplicationArea = All;
                    Caption = 'Diameter';
                }

                field("CutoutLength"; Rec."Meg Cutout Length")
                {
                    ApplicationArea = All;
                    Caption = 'Cutout Length';
                }

                field("CutoutWidth"; Rec."Meg Cutout Width")
                {
                    ApplicationArea = All;
                    Caption = 'Cutout Width';
                }

                // field("CutoutHeight"; Rec."Meg Cutout Height")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Cutout Height';
                // }

                field("CutoutDiameter"; Rec."Meg Cutout Diameter")
                {
                    ApplicationArea = All;
                    Caption = 'Cutout Diameter';
                }

                field("SupplierCurrency"; Rec."Meg Supplier Currency")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier Currency';
                }

                // field("UpdatedDate"; Rec."Meg Updated Date")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Updated Date';
                // }

                field("Notes"; Rec."Meg Notes")
                {
                    ApplicationArea = All;
                    Caption = 'Notes';
                }

                field("GearBallast"; Rec."Meg Gear / Ballast")
                {
                    ApplicationArea = All;
                    Caption = 'Gear / Ballast';
                }

                field("Model"; Rec."Meg Model")
                {
                    ApplicationArea = All;
                    Caption = 'Model';
                }
                field("Height"; Rec."Meg Height")
                {
                    ApplicationArea = All;
                    Caption = 'Height';
                }
                // field("OtherDetails"; Rec."Meg Other Details")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Other Details';
                // }

            }
        }
    }
    /*  trigger OnInsertRecord(BelowxRec: Boolean): Boolean
     var
         ItemAttr: Codeunit ItemAttr;
     begin
         Rec.Insert(true);
         ItemAttr.InsertItemAttr('Brand', Brand, Rec);
         Rec.Modify(true);

         exit(false);

     end; */

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    // begin
    //     Rec.Insert(true);
    //     Rec."Gen. Prod. Posting Group" := 'GOODS';
    //     Rec."VAT Prod. Posting Group" := 'GOODSVAT';
    //     Rec."Inventory Posting Group" := 'GOODS';
    //     Rec."Meg Other Details" := Rec.Description;
    //     Rec.Modify(true);

    //     exit(false);
    // end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Insert(true);
        Rec."Gen. Prod. Posting Group" := 'GOODS';
        Rec."VAT Prod. Posting Group" := 'GOODSVAT';
        Rec."Inventory Posting Group" := 'GOODS';
        Rec.Modify(true);
    end;




    var
        Brand: Text;

}

