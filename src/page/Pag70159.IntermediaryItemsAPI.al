page 70159 "Intermediary Items API"
{
    APIGroup = 'ERP';
    APIPublisher = 'MASQ';
    APIVersion = 'beta';
    ApplicationArea = All;
    Caption = 'IntermediaryItemsAPI';
    DelayedInsert = true;
    EntityName = 'IntermediaryItem';
    EntitySetName = 'IntermediaryItems';
    PageType = API;
    SourceTable = "Intermediate Items";
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(apiStatus; Rec."API Status")
                {
                    Caption = 'API Status';
                }
                field(apolloProjectNumber; Rec."Apollo Project Number")
                {
                    Caption = 'Apollo Project Number';
                }
                field(apolloUserName; Rec."Apollo User Name")
                {
                    Caption = 'Apollo User Name';
                }
                field(base; Rec.Base)
                {
                    Caption = 'Base';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(beamAngle; Rec."Beam Angle")
                {
                    Caption = 'Beam Angle';
                }
                field(beamType; Rec."Beam Type")
                {
                    Caption = 'Beam Type';
                }
                field(bracket; Rec.Bracket)
                {
                    Caption = 'Bracket';
                }
                field(brand; Rec.Brand)
                {
                    Caption = 'Brand';
                }
                field(colorTemp; Rec."Color Temp")
                {
                    Caption = 'Color Temp';
                }
                field(commentsToApollo; Rec."Comments to Apollo")
                {
                    Caption = 'Comments to Apollo';
                }
                field(costingMethod; Rec."Costing Method")
                {
                    Caption = 'Costing Method';
                }
                field(coverColor; Rec."Cover Color")
                {
                    Caption = 'Cover Color';
                }
                field(cri; Rec.CRI)
                {
                    Caption = 'CRI';
                }
                field(cutoutDiameter; Rec."Cutout Diameter")
                {
                    Caption = 'Cutout Diameter';
                }
                field(cutoutHeight; Rec."Cutout Height")
                {
                    Caption = 'Cutout Height';
                }
                field(cutoutLength; Rec."Cutout Length")
                {
                    Caption = 'Cutout Length';
                }
                field(cutoutWidth; Rec."Cutout Width")
                {
                    Caption = 'Cutout Width';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(diameterInMm; Rec."Diameter in mm")
                {
                    Caption = 'Diameter in mm';
                }
                field(driver; Rec.Driver)
                {
                    Caption = 'Driver';
                }
                field(dynamicsNumber; Rec."Dynamics Number")
                {
                    Caption = 'Dynamics Number';
                }
                field(family; Rec.Family)
                {
                    Caption = 'Family';
                }
                field(fittingColor; Rec."Fitting Color")
                {
                    Caption = 'Fitting Color';
                }
                field(frame; Rec.Frame)
                {
                    Caption = 'Frame';
                }
                field(gearBallast; Rec."Gear / Ballast")
                {
                    Caption = 'Gear / Ballast';
                }
                field(heightInMm; Rec."Height in mm")
                {
                    Caption = 'Height in mm';
                }
                field(housing; Rec.Housing)
                {
                    Caption = 'Housing';
                }
                field(hsCode; Rec."HS Code")
                {
                    Caption = 'HS Code';
                }
                field(installation; Rec.Installation)
                {
                    Caption = 'Installation';
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group';
                }
                field(ipRating; Rec."IP Rating")
                {
                    Caption = 'IP Rating';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(lampSource; Rec."Lamp Source")
                {
                    Caption = 'Lamp Source';
                }
                field(lampsCount; Rec."Lamps Count")
                {
                    Caption = 'Lamps Count';
                }
                field(lengthInMm; Rec."Length in mm")
                {
                    Caption = 'Length in mm';
                }
                field(lifespan; Rec.Lifespan)
                {
                    Caption = 'Lifespan';
                }
                field(lob; Rec.LOB)
                {
                    Caption = 'LOB';
                }
                field(luminousFluxLm; Rec."Luminous Flux (Lm)")
                {
                    Caption = 'Luminous Flux (Lm)';
                }
                field(mainGroup; Rec."Main Group")
                {
                    Caption = 'Main Group';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(no2; Rec."No. 2")
                {
                    Caption = 'No. 2';
                }
                field(opticDiffuser; Rec."Optic/Diffuser")
                {
                    Caption = 'Diffuser';
                }
                field(processed; Rec.Processed)
                {
                    Caption = 'Processed';
                }
                field(projectNumber; Rec."Project Number")
                {
                    Caption = 'Project Number';
                }
                field(reflector; Rec.Reflector)
                {
                    Caption = 'Reflector';
                }
                field(searchDescription; Rec."Search Description")
                {
                    Caption = 'Search Description';
                }
                field(shape; Rec.Shape)
                {
                    Caption = 'Shape';
                }
                field(subGroup; Rec."Sub Group")
                {
                    Caption = 'Sub Group';
                }
                field(supplierCurrency; Rec."Supplier Currency")
                {
                    Caption = 'Supplier Currency';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(totalWattage; Rec."Total Wattage")
                {
                    Caption = 'Total Wattage';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(updatedDate; Rec."Updated Date")
                {
                    Caption = 'Updated Date';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(vendorCustomCode; Rec."Vendor Custom Code")
                {
                    Caption = 'Vendor Custom Code';
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                    Caption = 'Vendor Item No.';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field(viewingDistance; Rec."Viewing Distance")
                {
                    Caption = 'Viewing Distance';
                }
                field(voltage; Rec.Voltage)
                {
                    Caption = 'Voltage';
                }
                field(wattage; Rec.Wattage)
                {
                    Caption = 'Wattage';
                }
                field(widthInMm; Rec."Width in mm")
                {
                    Caption = 'Width in mm';
                }
                
            }
        }
    }
}
