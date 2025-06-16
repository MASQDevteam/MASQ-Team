report 70110 "Modify Existing Item"
{
    ApplicationArea = All;
    Caption = 'Modify Existing Item';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    // field(No; BNo)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field(No_2; BNo_2)
                    // {
                    //     ApplicationArea = All;
                    // }

                    field(Description; BDescription)
                    {
                        ApplicationArea = All;
                    }

                    field(Search_Description; BSearch_Description)
                    {
                        ApplicationArea = All;
                    }

                    field(Updated_Date; BUpdated_Date)
                    {
                        ApplicationArea = All;
                    }

                    field(Vendor_No; BVendor_No)
                    {
                        ApplicationArea = All;
                    }

                    field(Supplier_Currency; BSupplier_Currency)
                    {
                        ApplicationArea = All;
                    }

                    // field(Base_Unit_of_Measure; BBase_Unit_of_Measure)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field(Type; BType)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field(Inventory_Posting_Group; BInventory_Posting_Group)
                    // {
                    //     ApplicationArea = All;
                    // }

                    field(HS_Code; BHS_Code)
                    {
                        ApplicationArea = All;
                    }

                    field(Length_in_mm; BLength_in_mm)
                    {
                        ApplicationArea = All;
                    }

                    field(Width_in_mm; BWidth_in_mm)
                    {
                        ApplicationArea = All;
                    }

                    field(Height_in_mm; BHeight_in_mm)
                    {
                        ApplicationArea = All;
                    }

                    field(Unit_Cost; BUnit_Cost)
                    {
                        ApplicationArea = All;
                    }

                    // field(Costing_Method; BCosting_Method)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field(VAT_Prod_Posting_Group; BVAT_Prod_Posting_Group)
                    // {
                    //     ApplicationArea = All;
                    // }

                    field(Brand; BBrand)
                    {
                        ApplicationArea = All;
                    }

                    field(LOB; LOB)
                    {
                        ApplicationArea = All;
                        Caption = 'Lob';
                    }

                    // field(Vendor_Item_No; BVendor_Item_No)
                    // {
                    //     ApplicationArea = All;
                    // }

                    field(Family; BFamily)
                    {
                        ApplicationArea = All;
                    }

                    field(Sub_Group; BSub_Group)
                    {
                        ApplicationArea = All;
                    }

                    field(Main_Group; BMain_Group)
                    {
                        ApplicationArea = All;
                    }

                    field(Item_Category_Code; BItem_Category_Code)
                    {
                        ApplicationArea = All;
                    }

                    field(Gear_Ballast; BGear_Ballast)
                    {
                        ApplicationArea = All;
                    }

                    field(Installation; BInstallation)
                    {
                        ApplicationArea = All;
                    }

                    field(Driver; BDriver)
                    {
                        ApplicationArea = All;
                    }

                    field(Housing; BHousing)
                    {
                        ApplicationArea = All;
                    }

                    field(Reflector; BReflector)
                    {
                        ApplicationArea = All;
                    }

                    field(Optic_Diffuser; BOptic_Diffuser)
                    {
                        ApplicationArea = All;
                    }

                    field(Frame; BFrame)
                    {
                        ApplicationArea = All;
                    }

                    field(Bracket; BBracket)
                    {
                        ApplicationArea = All;
                    }

                    field(IP_Rating; BIP_Rating)
                    {
                        ApplicationArea = All;
                    }

                    field(Beam_Type; BBeam_Type)
                    {
                        ApplicationArea = All;
                    }

                    field(Fitting_Color; BFitting_Color)
                    {
                        ApplicationArea = All;
                    }

                    field(CRI; BCRI)
                    {
                        ApplicationArea = All;
                    }

                    field(Beam_Angle; BBeam_Angle)
                    {
                        ApplicationArea = All;
                    }

                    field(Lamp_Source; BLamp_Source)
                    {
                        ApplicationArea = All;
                    }

                    field(Base; BBase)
                    {
                        ApplicationArea = All;
                    }

                    field(Color_Temp; BColor_Temp)
                    {
                        ApplicationArea = All;
                    }

                    field(Lamps_Count; BLamps_Count)
                    {
                        ApplicationArea = All;
                    }

                    field(Wattage; BWattage)
                    {
                        ApplicationArea = All;
                    }

                    field(Total_Wattage; BTotal_Wattage)
                    {
                        ApplicationArea = All;
                    }

                    field(Voltage; BVoltage)
                    {
                        ApplicationArea = All;
                    }

                    field(Shape; BShape)
                    {
                        ApplicationArea = All;
                    }

                    field(Diameter_in_mm; BDiameter_in_mm)
                    {
                        ApplicationArea = All;
                    }

                    field(Cutout_Length; BCutout_Length)
                    {
                        ApplicationArea = All;
                    }

                    field(Cutout_Width; BCutout_Width)
                    {
                        ApplicationArea = All;
                    }

                    field(Cutout_Height; BCutout_Height)
                    {
                        ApplicationArea = All;
                    }

                    field(Cutout_Diameter; BCutout_Diameter)
                    {
                        ApplicationArea = All;
                    }

                    field(Cover_Color; BCover_Color)
                    {
                        ApplicationArea = All;
                    }

                    field(Luminous_Flux_Lm; BLuminous_Flux_Lm)
                    {
                        ApplicationArea = All;
                    }

                    field(Viewing_Distance; BViewing_Distance)
                    {
                        ApplicationArea = All;
                    }

                    field(Lifespan; BLifespan)
                    {
                        ApplicationArea = All;
                    }

                    // field(Processed; BProcessed)
                    // {
                    //     ApplicationArea = All;
                    // }

                    field(Vendor_Custom_Code; BVendor_Custom_Code)
                    {
                        ApplicationArea = All;
                    }

                    // field(Dynamics_Number; BDynamics_Number)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field(API_Status; BAPI_Status)
                    // {
                    //     ApplicationArea = All;
                    // }


                    // field(Apollo_User_Name; BApollo_User_Name)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field(Project_Number; BProject_Number)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field(Apollo_Project_Number; BApollo_Project_Number)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field(Comments_to_Apollo; BComments_to_Apollo)
                    // {
                    //     ApplicationArea = All;
                    // }

                }
            }
        }

    }
    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        ModifyExistItem();
    end;

    procedure ModifyExistItem()
    var
        Item: Record Item;
        NewItem: Record Item;
        DefaultDimension: Record "Default Dimension";
        OldDefaultDimension: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
    begin
        Clear(DefaultDimension);
        Clear(Item);
        Clear(NewItem);
        Clear(GLSetup);
        IF CompanyName = 'NEW MASQ-KSA' then begin
            NewItem.ChangeCompany('NEW MASQ -QATAR');
            DefaultDimension.ChangeCompany('NEW MASQ -QATAR');
            GLSetup.ChangeCompany('NEW MASQ -QATAR');
        end
        else IF CompanyName = 'NEW MASQ -QATAR' then begin
            NewItem.ChangeCompany('NEW MASQ-KSA');
            DefaultDimension.ChangeCompany('NEW MASQ-KSA');
            GLSetup.ChangeCompany('NEW MASQ-KSA');
        end;
        if Item.Get(IntermediateItems."Dynamics Number") and NewItem.Get(IntermediateItems."Dynamics Number") then begin
            // if BNo then
            //     Item.Validate("No.", IntermediateItems."No.");

            // if BNo_2 then
            //     Item.Validate("No. 2", IntermediateItems."No. 2");

            if BDescription then begin
                Item.Validate(Description, IntermediateItems.Description);
                NewItem.Validate(Description, IntermediateItems.Description);
            end;

            if BSearch_Description then begin
                Item.Validate("Search Description", IntermediateItems."Search Description");
                NewItem.Validate("Search Description", IntermediateItems."Search Description");
            end;

            if BUpdated_Date then begin
                Item.Validate("Meg Updated Date", IntermediateItems."Updated Date");
                NewItem.Validate("Meg Updated Date", IntermediateItems."Updated Date");
            end;

            if BVendor_No then begin
                Item.Validate("Vendor No.", IntermediateItems."Vendor No.");
                NewItem.Validate("Vendor No.", IntermediateItems."Vendor No.");
            end;

            if BSupplier_Currency then begin
                Item.Validate("Meg Supplier Currency", IntermediateItems."Supplier Currency");
                NewItem.Validate("Meg Supplier Currency", IntermediateItems."Supplier Currency");
            end;

            // if BBase_Unit_of_Measure then begin
            //     Item.Validate("Base Unit of Measure", IntermediateItems."Base Unit of Measure");
            //     NewItem.Validate("Base Unit of Measure", IntermediateItems."Base Unit of Measure");
            // end;

            // if BType then begin
            //     Item.Validate(Type, IntermediateItems.Type);
            // end;

            // if BInventory_Posting_Group then begin
            //     Item.Validate("Inventory Posting Group", IntermediateItems."Inventory Posting Group");
            //     NewItem.Validate("Inventory Posting Group", IntermediateItems."Inventory Posting Group");
            // end;

            if BHS_Code then begin
                Item.Validate("Meg HS Code", IntermediateItems."HS Code");
                NewItem.Validate("Meg HS Code", IntermediateItems."HS Code");
            end;

            if BLength_in_mm then begin
                Item.Validate("Meg Length", IntermediateItems."Length in mm");
                NewItem.Validate("Meg Length", IntermediateItems."Length in mm");
            end;

            if BWidth_in_mm then begin
                Item.Validate("Meg Width", IntermediateItems."Width in mm");
                NewItem.Validate("Meg Width", IntermediateItems."Width in mm");
            end;

            if BHeight_in_mm then begin
                Item.Validate("Meg Height", IntermediateItems."Height in mm");
                NewItem.Validate("Meg Height", IntermediateItems."Height in mm");
            end;

            if BUnit_Cost then begin
                Item.Validate("Unit Cost", IntermediateItems."Unit Cost");
                NewItem.Validate("Unit Cost", IntermediateItems."Unit Cost");
            end;

            // if BCosting_Method then begin
            //     Item.Validate("Costing Method", IntermediateItems."Costing Method");
            //     NewItem.Validate("Costing Method", IntermediateItems."Costing Method");
            // end;

            // if BVAT_Prod_Posting_Group then begin
            //     Item.Validate("VAT Prod. Posting Group", IntermediateItems."VAT Prod. Posting Group");
            //     NewItem.Validate("VAT Prod. Posting Group", IntermediateItems."VAT Prod. Posting Group");
            // end;

            if BBrand then begin
                Item.Validate("Meg Brand", IntermediateItems.Brand);
                NewItem.Validate("Meg Brand", IntermediateItems.Brand);
            end;

            // if BVendor_Item_No then begin
            //     Item.Validate("Vendor Item No.", IntermediateItems."Vendor Item No.");
            //     NewItem.Validate("Vendor Item No.", IntermediateItems."Vendor Item No.");
            // end;

            if BFamily then begin
                Item.Validate(Family, IntermediateItems.Family);
                NewItem.Validate(Family, IntermediateItems.Family);
            end;

            if BSub_Group then begin
                Item.Validate("MASQ Sub Group", IntermediateItems."Sub Group");
                NewItem.Validate("MASQ Sub Group", IntermediateItems."Sub Group");
            end;

            if BMain_Group then begin
                Item.Validate("MASQ Main Group", IntermediateItems."Main Group");
                NewItem.Validate("MASQ Main Group", IntermediateItems."Main Group");
            end;

            if BItem_Category_Code then begin
                Item.Validate("Item Category Code", IntermediateItems."Item Category Code");
                NewItem.Validate("Item Category Code", IntermediateItems."Item Category Code");
            end;

            if BGear_Ballast then begin
                Item.Validate("Meg Gear / Ballast", IntermediateItems."Gear / Ballast");
                NewItem.Validate("Meg Gear / Ballast", IntermediateItems."Gear / Ballast");
            end;

            if BInstallation then begin
                Item.Validate("Meg Installation", IntermediateItems.Installation);
                NewItem.Validate("Meg Installation", IntermediateItems.Installation);
            end;

            if BDriver then begin
                Item.Validate("Meg Driver", IntermediateItems.Driver);
                NewItem.Validate("Meg Driver", IntermediateItems.Driver);
            end;

            if BHousing then begin
                Item.Validate("Meg Housing", IntermediateItems.Housing);
                NewItem.Validate("Meg Housing", IntermediateItems.Housing);
            end;

            if BReflector then begin
                Item.Validate("Meg Reflector", IntermediateItems.Reflector);
                NewItem.Validate("Meg Reflector", IntermediateItems.Reflector);
            end;

            if BOptic_Diffuser then begin
                Item.Validate("MASQ Optic/Diffuser", IntermediateItems."Optic/Diffuser");
                NewItem.Validate("MASQ Optic/Diffuser", IntermediateItems."Optic/Diffuser");
            end;

            if BFrame then begin
                Item.Validate("Meg Frame", IntermediateItems.Frame);
                NewItem.Validate("Meg Frame", IntermediateItems.Frame);
            end;

            if BBracket then begin
                Item.Validate("Meg Bracket", IntermediateItems.Bracket);
                NewItem.Validate("Meg Bracket", IntermediateItems.Bracket);
            end;

            if BIP_Rating then begin
                Item.Validate("MASQ IP Rating", IntermediateItems."IP Rating");
                NewItem.Validate("MASQ IP Rating", IntermediateItems."IP Rating");
            end;

            if BBeam_Type then begin
                Item.Validate("Meg Beam Type", IntermediateItems."Beam Type");
                NewItem.Validate("Meg Beam Type", IntermediateItems."Beam Type");
            end;

            if BFitting_Color then begin
                Item.Validate("Meg Fitting Color", IntermediateItems."Fitting Color");
                NewItem.Validate("Meg Fitting Color", IntermediateItems."Fitting Color");
            end;

            if BCRI then begin
                Item.Validate("Meg CRI", IntermediateItems.CRI);
                NewItem.Validate("Meg CRI", IntermediateItems.CRI);
            end;

            if BBeam_Angle then begin
                Item.Validate("Meg Beam Angle", IntermediateItems."Beam Angle");
                NewItem.Validate("Meg Beam Angle", IntermediateItems."Beam Angle");
            end;

            if BLamp_Source then begin
                Item.Validate("Meg Lamp Source", IntermediateItems."Lamp Source");
                NewItem.Validate("Meg Lamp Source", IntermediateItems."Lamp Source");
            end;

            if BBase then begin
                Item.Validate("Meg Base", IntermediateItems.Base);
                NewItem.Validate("Meg Base", IntermediateItems.Base);
            end;

            if BColor_Temp then begin
                Item.Validate("Meg Color Temp", IntermediateItems."Color Temp");
                NewItem.Validate("Meg Color Temp", IntermediateItems."Color Temp");
            end;

            if BLamps_Count then begin
                Item.Validate("Meg Lamps Count", IntermediateItems."Lamps Count");
                NewItem.Validate("Meg Lamps Count", IntermediateItems."Lamps Count");
            end;

            if BWattage then begin
                Item.Validate("Meg Wattage", IntermediateItems.Wattage);
                NewItem.Validate("Meg Wattage", IntermediateItems.Wattage);
            end;

            if BTotal_Wattage then begin
                Item.Validate("Meg Total Wattage", IntermediateItems."Total Wattage");
                NewItem.Validate("Meg Total Wattage", IntermediateItems."Total Wattage");
            end;

            if BVoltage then begin
                Item.Validate("Meg Voltage", IntermediateItems.Voltage);
                NewItem.Validate("Meg Voltage", IntermediateItems.Voltage);
            end;

            if BShape then begin
                Item.Validate("Meg Shape", IntermediateItems.Shape);
                NewItem.Validate("Meg Shape", IntermediateItems.Shape);
            end;

            if BDiameter_in_mm then begin
                Item.Validate("Meg Diameter", IntermediateItems."Diameter in mm");
                NewItem.Validate("Meg Diameter", IntermediateItems."Diameter in mm");
            end;

            if BCutout_Length then begin
                Item.Validate("Meg Cutout Length", IntermediateItems."Cutout Length");
                NewItem.Validate("Meg Cutout Length", IntermediateItems."Cutout Length");
            end;

            if BCutout_Width then begin
                Item.Validate("Meg Cutout Width", IntermediateItems."Cutout Width");
                NewItem.Validate("Meg Cutout Width", IntermediateItems."Cutout Width");
            end;

            if BCutout_Height then begin
                Item.Validate("Meg Cutout Height", IntermediateItems."Cutout Height");
                NewItem.Validate("Meg Cutout Height", IntermediateItems."Cutout Height");
            end;

            if BCutout_Diameter then begin
                Item.Validate("MEg Cutout Diameter", IntermediateItems."Cutout Diameter");
                NewItem.Validate("MEg Cutout Diameter", IntermediateItems."Cutout Diameter");
            end;

            if BCover_Color then begin
                Item.Validate("MASQ Cover Color", IntermediateItems."Cover Color");
                NewItem.Validate("MASQ Cover Color", IntermediateItems."Cover Color");
            end;

            if BLuminous_Flux_Lm then begin
                Item.Validate("MASQ Luminous Flux (Lm)", IntermediateItems."Luminous Flux (Lm)");
                NewItem.Validate("MASQ Luminous Flux (Lm)", IntermediateItems."Luminous Flux (Lm)");
            end;

            if BViewing_Distance then begin
                Item.Validate("Viewing Distance", IntermediateItems."Viewing Distance");
                NewItem.Validate("Viewing Distance", IntermediateItems."Viewing Distance");
            end;

            if BLifespan then begin
                Item.Validate(Lifespan, IntermediateItems.Lifespan);
                NewItem.Validate(Lifespan, IntermediateItems.Lifespan);
            end;

            // if BProcessed then begin
            //     Item.Validate(Processed, IntermediateItems.Processed);
            // end;

            if BVendor_Custom_Code then begin
                Item.Validate("Vendor Custom Code", IntermediateItems."Vendor Custom Code");
                NewItem.Validate("Vendor Custom Code", IntermediateItems."Vendor Custom Code");
            end;

            // if BDynamics_Number then begin
            //     Item.Validate("Dynamics Number", IntermediateItems."Dynamics Number");
            // end;

            // if BAPI_Status then begin
            //     Item.Validate("API Status", IntermediateItems."API Status");
            // end;

            if Lob then begin
                Item.Validate("Global Dimension 2 Code", IntermediateItems.LOB);
                NewItem.Validate("Global Dimension 2 Code", IntermediateItems.LOB);
            end;

            // if BApollo_User_Name then begin
            //     Item.Validate("Apollo User Name", IntermediateItems."Apollo User Name");
            // end;

            // if BProject_Number then begin
            //     Item.Validate("Project Number", IntermediateItems."Project Number");
            // end;

            // if BApollo_Project_Number then begin
            //     Item.Validate("Apollo Project Number", IntermediateItems."Apollo Project Number");
            // end;

            // if BComments_to_Apollo then begin
            //     Item.Validate("Comments to Apollo", IntermediateItems."Comments to Apollo");
            // end;


            Item.Modify();
            NewItem.Modify();
            //AN 04/09/2025 //to make Lob Mandatory in main company 
            if Lob then begin
                Clear(OldDefaultDimension);
                if OldDefaultDimension.Get(Item.RecordId().TableNo(), Item."No.", 'LOB') then begin
                    OldDefaultDimension.Validate("Value Posting", OldDefaultDimension."Value Posting"::"Code Mandatory");
                    OldDefaultDimension.Modify();
                end;
            end;
            IntermediateItems.Processed := true;
            IntermediateItems.Modify();

            //AN 04/09/2025 
            //Brand
            // DefaultDimension.RESET();
            if BBrand then begin
                DefaultDimension.SetRange("Table ID", NewItem.RecordId().TableNo());
                DefaultDimension.SetRange("No.", NewItem."No.");
                DefaultDimension.SetRange("Dimension Code", 'BRAND');
                if not DefaultDimension.FindFirst() then begin
                    DefaultDimension.Init();
                    DefaultDimension."Table ID" := NewItem.RecordId().TableNo();
                    DefaultDimension."No." := NewItem."No.";
                    DefaultDimension."Dimension Code" := 'BRAND';
                    DefaultDimension.Insert();
                end;
                DefaultDimension.Validate("Dimension Value Code", NewItem."Meg Brand");
                DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
                DefaultDimension.Modify();
            end;

            //LOB 
            if Lob then begin
                if not HasGotGLSetup then begin
                    GLSetup.Get();
                    GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
                    GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
                    GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
                    GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
                    GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
                    GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
                    GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
                    GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
                    HasGotGLSetup := true;
                end;
                if NewItem."Global Dimension 2 Code" <> '' then begin
                    if DefaultDimension.Get(NewItem.RecordId().TableNo(), NewItem."No.", GLSetupShortcutDimCode[2])
                    then begin
                        DefaultDimension.Validate("Dimension Value Code", NewItem."Global Dimension 2 Code");
                        DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
                        DefaultDimension.Modify();
                    end else begin
                        DefaultDimension.Init();
                        DefaultDimension.Validate("Table ID", NewItem.RecordId().TableNo());
                        DefaultDimension.Validate("No.", NewItem."No.");
                        DefaultDimension.Validate("Dimension Code", GLSetupShortcutDimCode[2]);
                        DefaultDimension.Validate("Dimension Value Code", NewItem."Global Dimension 2 Code");
                        DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
                        DefaultDimension.Insert();
                    end;
                end else
                    if DefaultDimension.Get(NewItem.RecordId().TableNo(), NewItem."No.", GLSetupShortcutDimCode[2]) then
                        DefaultDimension.Delete();
            end;
        end
        else
            Error('Can''t find this Item in both companies!');
    end;


    procedure GetRecord(IntermediateItemsP: Record "Intermediate Items")
    begin
        IntermediateItems := IntermediateItemsP;
    end;

    var
        IntermediateItems: Record "Intermediate Items";
        BNo: Boolean;
        BNo_2: Boolean;
        BDescription: Boolean;
        BSearch_Description: Boolean;
        BUpdated_Date: Boolean;
        BVendor_No: Boolean;
        BSupplier_Currency: Boolean;
        BBase_Unit_of_Measure: Boolean;
        BType: Boolean;
        BInventory_Posting_Group: Boolean;
        BHS_Code: Boolean;
        BLength_in_mm: Boolean;
        BWidth_in_mm: Boolean;
        BHeight_in_mm: Boolean;
        BUnit_Cost: Boolean;
        BCosting_Method: Boolean;
        BVAT_Prod_Posting_Group: Boolean;
        BBrand: Boolean;
        BVendor_Item_No: Boolean;
        BFamily: Boolean;
        BSub_Group: Boolean;
        BMain_Group: Boolean;
        BItem_Category_Code: Boolean;
        BGear_Ballast: Boolean;
        BInstallation: Boolean;
        BDriver: Boolean;
        BHousing: Boolean;
        BReflector: Boolean;
        BOptic_Diffuser: Boolean;
        BFrame: Boolean;
        BBracket: Boolean;
        BIP_Rating: Boolean;
        BBeam_Type: Boolean;
        BFitting_Color: Boolean;
        BCRI: Boolean;
        BBeam_Angle: Boolean;
        BLamp_Source: Boolean;
        BBase: Boolean;
        BColor_Temp: Boolean;
        BLamps_Count: Boolean;
        BWattage: Boolean;
        BTotal_Wattage: Boolean;
        BVoltage: Boolean;
        BShape: Boolean;
        BDiameter_in_mm: Boolean;
        BCutout_Length: Boolean;
        BCutout_Width: Boolean;
        BCutout_Height: Boolean;
        BCutout_Diameter: Boolean;
        BCover_Color: Boolean;
        BLuminous_Flux_Lm: Boolean;
        BViewing_Distance: Boolean;
        BLifespan: Boolean;
        BProcessed: Boolean;
        BVendor_Custom_Code: Boolean;
        BDynamics_Number: Boolean;
        BAPI_Status: Boolean;
        BLOB: Boolean;
        BApollo_User_Name: Boolean;
        BProject_Number: Boolean;
        BApollo_Project_Number: Boolean;
        BComments_to_Apollo: Boolean;
        Lob: Boolean;
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];
}
