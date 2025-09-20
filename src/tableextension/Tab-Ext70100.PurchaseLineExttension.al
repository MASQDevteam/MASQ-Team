tableextension 70100 "Purchase Line Exttension" extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here       


        field(70100; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(3)));
        }
        field(70101; "Posting Date"; Date)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Posting Date" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(70102; "Currency Factor"; Decimal)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Currency Factor" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(70103; "MoonLight Item Type"; Code[50])
        {
            Caption = 'MoonLight Item Type';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value"."Moonlight Item Type" where("Dimension Code" = const('ITEMTYPE'), Code = field("Meg Item Type")));
        }
        field(70104; "MoonLight Brand"; Code[50])
        {
            Caption = 'MoonLight Brand';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value"."Moonlight Brand" where("Dimension Code" = const('BRAND'), Code = field("Shortcut Dimension 3 Code")));
        }
        field(70105; "Initial ETR"; Date)//Created on 28/10/2024 with Nathalie
        {
            Caption = 'Initial ETR';

            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                IF (Rec."Initial ETA" <> 0D) AND (Rec."Initial ETAW" <> 0D) AND (Rec."Initial ETR" <> 0D) AND (Rec."Initial ETD" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Initial ETR" := Rec."Initial ETR";
                    ShippingDateLOG."Initial ETD" := Rec."Initial ETD";
                    ShippingDateLOG."Initial ETA" := Rec."Initial ETA";
                    ShippingDateLOG."Initial ETAW" := Rec."Initial ETAW";
                    ShippingDateLOG.Insert(true);

                end;


            end;
        }
        field(70106; "Initial ETD"; Date)
        {
            Caption = 'Initial ETD';
            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                IF (Rec."Initial ETA" <> 0D) AND (Rec."Initial ETAW" <> 0D) AND (Rec."Initial ETR" <> 0D) AND (Rec."Initial ETD" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Initial ETR" := Rec."Initial ETR";
                    ShippingDateLOG."Initial ETD" := Rec."Initial ETD";
                    ShippingDateLOG."Initial ETA" := Rec."Initial ETA";
                    ShippingDateLOG."Initial ETAW" := Rec."Initial ETAW";
                    ShippingDateLOG.Insert(true);

                end;


            end;
        }
        field(70107; "Initial ETA"; Date)
        {
            Caption = 'Initial ETA';
            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                IF (Rec."Initial ETA" <> 0D) AND (Rec."Initial ETAW" <> 0D) AND (Rec."Initial ETR" <> 0D) AND (Rec."Initial ETD" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Initial ETR" := Rec."Initial ETR";
                    ShippingDateLOG."Initial ETD" := Rec."Initial ETD";
                    ShippingDateLOG."Initial ETA" := Rec."Initial ETA";
                    ShippingDateLOG."Initial ETAW" := Rec."Initial ETAW";
                    ShippingDateLOG.Insert(true);

                end;


            end;
        }
        field(70108; "Initial ETAW"; Date)
        {
            Caption = 'Initial ETAW';
            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                IF (Rec."Initial ETA" <> 0D) AND (Rec."Initial ETAW" <> 0D) AND (Rec."Initial ETR" <> 0D) AND (Rec."Initial ETD" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Initial ETR" := Rec."Initial ETR";
                    ShippingDateLOG."Initial ETD" := Rec."Initial ETD";
                    ShippingDateLOG."Initial ETA" := Rec."Initial ETA";
                    ShippingDateLOG."Initial ETAW" := Rec."Initial ETAW";
                    ShippingDateLOG.Insert(true);

                end;


            end;
        }
        field(70109; "BL/AWB ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "Container ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70111; "MASQ Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70112; "MASQ Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70113; "Quantity Shipped"; Decimal)//from the vendor's country
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(70114; "Remaining Quantity Shipped"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(70115; "Line is Splitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70116; "Splitted Line No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70117; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70118; "Original Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70119; "Disable fields after Shipping"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70120; "Final ETR"; Date)
        {
            Caption = 'Final ETR';

            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Final ETR" := Rec."Final ETR";
                    ShippingDateLOG."Final ETD" := Rec."Final ETD";
                    ShippingDateLOG."Final ETA" := Rec."Final ETA";
                    ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                    ShippingDateLOG.ATA := Rec.ATA;
                    ShippingDateLOG.Insert(true);
                end;
            end;
        }
        field(70121; "Final ETD"; Date)
        {
            Caption = 'Final ETD';
            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Final ETR" := Rec."Final ETR";
                    ShippingDateLOG."Final ETD" := Rec."Final ETD";
                    ShippingDateLOG."Final ETA" := Rec."Final ETA";
                    ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                    ShippingDateLOG.ATA := Rec.ATA;
                    ShippingDateLOG.Insert(true);
                end;
            end;
        }
        field(70122; "Final ETA"; Date)
        {
            Caption = 'Final ETA';
            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Final ETR" := Rec."Final ETR";
                    ShippingDateLOG."Final ETD" := Rec."Final ETD";
                    ShippingDateLOG."Final ETA" := Rec."Final ETA";
                    ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                    ShippingDateLOG.ATA := Rec.ATA;
                    ShippingDateLOG.Insert(true);
                end;
            end;
        }
        field(70123; "ATA"; Date)
        {
            Caption = 'ATA';
            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Final ETR" := Rec."Final ETR";
                    ShippingDateLOG."Final ETD" := Rec."Final ETD";
                    ShippingDateLOG."Final ETA" := Rec."Final ETA";
                    ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                    ShippingDateLOG.ATA := Rec.ATA;
                    ShippingDateLOG.Insert(true);
                end;
            end;
        }
        field(70124; "Final ETAW"; Date)
        {
            Caption = 'Final ETAW';
            trigger OnValidate()
            var
                ShippingDateLOG: Record "Supply Chain LOG";
                SalesLine: Record "Sales Line";
            begin
                //AN 06/11/2024: Check if the Final ETAW is greater than the Shipment Date on Sales Order
                if SalesLine.Get(SalesLine."Document Type"::Order, Rec."MASQ Sales Order No.", Rec."MASQ Sales Order Line No.") then
                    if SalesLine."Shipment Date" <> 0D then
                        if Rec."Final ETAW" > SalesLine."Shipment Date" then
                            Message('Final ETAW cannot be greater than Shipment Date on Sales Order %1 Line %2', Rec."MASQ Sales Order No.", Rec."MASQ Sales Order Line No.");

                IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                    ShippingDateLOG.Init();
                    ShippingDateLOG."BL/AWB ID" := Rec."BL/AWB ID";
                    ShippingDateLOG."Container Number" := Rec."Container ID";
                    ShippingDateLOG."PO Number" := Rec."Document No.";
                    ShippingDateLOG."PO Line Number" := Rec."Line No.";
                    ShippingDateLOG."Final ETR" := Rec."Final ETR";
                    ShippingDateLOG."Final ETD" := Rec."Final ETD";
                    ShippingDateLOG."Final ETA" := Rec."Final ETA";
                    ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                    ShippingDateLOG.ATA := Rec.ATA;
                    ShippingDateLOG.Insert(true);
                end;
            end;
        }
        field(70125; "Container Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70126; "VO Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70127; "Batch Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70128; "Truck WayBill ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70129; "Truck Details ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70130; "Truck Details Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70131; "Subjob ID"; Integer)//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Subjob ID';
        }
        field(70132; "Job#"; Code[20])//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            Caption = 'Job ID';
        }
        field(70133; "Shipping By"; Option)//added on 27/01/2025
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Sea,Air,InLand;
        }

        field(70134; "GROSS Weight in KG"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."GROSS Weight in KG" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70135; "VOLUMETRIC Weight in KG"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."VOLUMETRIC Weight in KG" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70136; "NET Weight in KG"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."NET Weight in KG" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70137; "AirPort of Loading"; Code[50])
        {
            Caption = 'AirPort of Loading';
            // Set up a lookup to your port master table here    
            TableRelation = "MASQ Lookup".Code where(Type = const("Air Port"));
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."Port of Loading" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70138; "AirPort of Discharge"; Code[50])
        {
            Caption = 'AirPort of Discharge';
            // Set up a lookup to your port master table here    
            TableRelation = "MASQ Lookup".Code where(Type = const("Air Port"));
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."Port of Discharge" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70139; "Port of Loading"; Code[50])
        {
            Caption = 'Port of Loading';
            // Set up a lookup to your port master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
            FieldClass = FlowField;
            CalcFormula = lookup("BL Details"."Port of Loading" where("BL ID" = field("BL/AWB ID")));
        }
        field(70140; "Port of Discharge"; Code[50])
        {
            Caption = 'Port of Discharge';
            // Set up a lookup to your port master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
            FieldClass = FlowField;
            CalcFormula = lookup("BL Details"."Port of Discharge" where("BL ID" = field("BL/AWB ID")));
        }

        // field(70141; "Buy-from Vendor Name"; Code[100])
        // {
        //     Caption = 'Buy-from Vendor Name';
        //     //  Editable = false;
        //     //  TableRelation = Vendor;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Vendor.Name where("No." = field("Buy-from Vendor No.")));
        // }
        field(70142; "Liner"; Code[50])
        {
            // DataClassification = ToBeClassified;
            //           TableRelation = "MASQ Lookup".Code where(Type = const(Port));
            FieldClass = FlowField;
            CalcFormula = lookup("BL Details".Liner where("BL ID" = field("BL/AWB ID")));
        }
        field(70143; "Airline"; Code[50])
        {
            // DataClassification = ToBeClassified;
            //           TableRelation = "MASQ Lookup".Code where(Type = const(Port));
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details".Airline where("AWB ID" = field("BL/AWB ID")));
        }

        field(70144; "Line Amount LCY"; Decimal)   //added on 19/02/82025
        {
            //   AutoFormatExpression = Rec."Currency Code";
            //  AutoFormatType = 1;
            //  CaptionClass = GetCaptionClass(FieldNo("Line Amount"));
            Caption = 'Line Amount LCY';
        }


        field(70145; "Direct Unit Cost LCY"; Decimal)   //added on 19/02/82025
        {
            //  AutoFormatExpression = Rec."Currency Code";
            //    AutoFormatType = 2;
            //   CaptionClass = GetCaptionClass(FieldNo("Direct Unit Cost"));
        }
        field(70146; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(4)));
        }
        field(70147; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(5)));
        }
        field(70148; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(6)));
        }
        field(70149; "CHARGABLE Weight in KG"; Decimal)//added on 02/04/2025
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."CHARGABLE Weight in KG" where("AWB ID" = field("BL/AWB ID")));
        }
        field(70150; "InLand ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70151; "Inland Details Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        //NB MASQ Start
        field(70152; "AWB Number"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "AWB Details"."AWB Number";
            ValidateTableRelation = false;
        }
        field(70153; "AWB PO No."; Text[1000])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("AWB Details"."PO No." where("AWB Number" = field("AWB Number")));
            Editable = false;
        }
        field(70154; "Vendor Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Buy-from Vendor Name" where("No." = field("AWB PO No.")));
            Editable = false;
        }
        field(70155; "Project Code"; Code[20])
        {
            Editable = false;
        }
        //NB MASQ End

        // modify("Amount Including VAT")
        // {
        //AN 07/04/2025
        // trigger OnAfterValidate()
        // var
        //     PurchaseHeader: Record "Purchase Header";
        // begin
        //     if PurchaseHeader.get(Rec."Document Type", Rec."Document No.") then begin
        //         PurchaseHeader.CalculateTotalWithCharge();
        //     end;
        // end;
        //    / }
        modify("No.")
        {
            trigger OnAfterValidate()
            var

                SalesLine: Record "Sales Line";
                ProjectLine: Record "Job Planning Line";
                ProjectLineunitCost: Decimal;
                PurchLineunitCost: Decimal;
                ProjectLocationCode: code[20];//added on 07/05/2025
                ProjectDim1: Code[20];
                ProjectDim2: Code[20];
                ProjectDim3: Code[20];
                ProjectDim4: Code[20];
                ProjectDim5: Code[20];
                ProjectDim6: Code[20];
                CostVariationLOG: Record "Cost Variation LOG";
            begin
                ProjectLineunitCost := 0;
                PurchLineunitCost := 0;
                ProjectLocationCode := '';//added on 07/05/2025
                ProjectDim1 := '';
                ;
                ProjectDim2 := '';
                ;
                ProjectDim3 := '';
                ;
                ProjectDim4 := '';
                ;
                ProjectDim5 := '';
                ;
                ProjectDim6 := '';
                ;
                Clear(SalesLine);
                clear(ProjectLine);
                IF rec."MASQ Sales Order No." = '' then begin
                    rec."MASQ Sales Order No." := xRec."MASQ Sales Order No.";
                end;

                IF rec."MASQ Sales Order Line No." = 0 then begin//below get return empty record if the line is not found in the sales line table
                    rec."MASQ Sales Order Line No." := xRec."MASQ Sales Order Line No.";
                end;
                IF SalesLine.get(SalesLine."Document Type"::Order, Rec."MASQ Sales Order No.", Rec."MASQ Sales Order Line No.") then begin
                    IF Rec."No." <> '' then begin
                        IF Rec."No." <> SalesLine."No." then begin
                            IF Confirm(StrSubstNo('Warninig! the Item Number in the sales %1 line %2 is different from the purchase line. Do you want to update the item Number on the Sales Line too?', Rec."MASQ Sales Order No.", Rec."MASQ Sales Order Line No.")) then begin
                                IF ProjectLine.Get(SalesLine."Job No.", SalesLine."Job Task No.", SalesLine."Job Planning Line No.") then begin
                                    ProjectLineunitCost := ProjectLine."Unit Cost";//added on 07/05/2025
                                    ProjectLocationCode := ProjectLine."Location Code";//added on 07/05/2025
                                    ProjectDim1 := ProjectLine."Shortcut Dimension 1 Code";
                                    ProjectDim2 := ProjectLine."Shortcut Dimension 2 Code";
                                    ProjectDim3 := ProjectLine."Shortcut Dimension 3 Code";
                                    ProjectDim4 := ProjectLine."Shortcut Dimension 4 Code";
                                    ProjectDim5 := ProjectLine."Shortcut Dimension 5 Code";
                                    ProjectDim6 := ProjectLine."Shortcut Dimension 6 Code";

                                    ProjectLine.Validate("No.", Rec."No.");
                                    ProjectLine.Validate("Unit Price", SalesLine."Unit Price");//added on 07/05/2025

                                    IF (ProjectLocationCode <> '') and (ProjectLine."Location Code" = '') then//added on 07/05/2025
                                        ProjectLine.Validate("Location Code", ProjectLocationCode);

                                    IF (ProjectDim1 <> '') and (ProjectLine."Shortcut Dimension 1 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 1 Code", ProjectDim1);

                                    IF (ProjectDim2 <> '') and (ProjectLine."Shortcut Dimension 2 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 2 Code", ProjectDim2);

                                    IF (ProjectDim3 <> '') and (ProjectLine."Shortcut Dimension 3 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 3 Code", ProjectDim3);

                                    IF (ProjectDim4 <> '') and (ProjectLine."Shortcut Dimension 4 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 4 Code", ProjectDim4);

                                    IF (ProjectDim5 <> '') and (ProjectLine."Shortcut Dimension 5 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 5 Code", ProjectDim5);

                                    IF (ProjectDim6 <> '') and (ProjectLine."Shortcut Dimension 6 Code" = '') then
                                        ProjectLine.Validate("Shortcut Dimension 6 Code", ProjectDim6);


                                    IF ProjectLineunitCost <> 0 then//added on 07/05/2025
                                        ProjectLine.Validate("Unit Cost", ProjectLineunitCost);//added on 07/05/2025

                                    ProjectLine.Modify();

                                end;

                                SalesLine.Validate("No.", Rec."No.");
                                SalesLine.Modify();

                                CostVariationLOG.Init();
                                CostVariationLOG."Item Number" := Rec."No.";
                                CostVariationLOG."old Item number" := xRec."No.";
                                CostVariationLOG."new Item number" := Rec."No.";
                                CostVariationLOG."PO Number" := Rec."Document No.";
                                CostVariationLOG."PO Line Number" := Rec."Line No.";
                                CostVariationLOG."Project No." := Rec."Job No.";
                                CostVariationLOG."Project planning Line No." := Rec."Job Planning Line No.";
                                CostVariationLOG."Created By" := UserId;
                                CostVariationLOG.Insert(true);

                            end;
                        end;
                    end;
                end;


                IF rec."BL/AWB ID" = '' then begin//transfer fields after validating fields that has impact on other fields
                    rec."BL/AWB ID" := xRec."BL/AWB ID";
                end;

                IF rec."Container ID" = '' then begin//transfer fields after validating fields that has impact on other fields
                    rec."Container ID" := xRec."Container ID";
                end;

                IF rec."MASQ Sales Order No." = '' then begin//transfer fields after validating fields that has impact on other fields
                    rec."MASQ Sales Order No." := xRec."MASQ Sales Order No.";
                end;

                IF rec."MASQ Sales Order Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."MASQ Sales Order Line No." := xRec."MASQ Sales Order Line No.";
                end;

                IF rec."Quantity Shipped" = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."Quantity Shipped" := xRec."Quantity Shipped";
                end;

                IF rec."Remaining Quantity Shipped" = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."Remaining Quantity Shipped" := xRec."Remaining Quantity Shipped";
                end;

                IF rec."Line is Splitted" = false then begin//transfer fields after validating fields that has impact on other fields
                    rec."Line is Splitted" := xRec."Line is Splitted";
                end;
                IF rec."Splitted Line No." = '' then begin//transfer fields after validating fields that has impact on other fields
                    rec."Splitted Line No." := xRec."Splitted Line No.";
                end;
                IF rec."Original Quantity" = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."Original Quantity" := xRec."Original Quantity";
                end;
                IF rec."Original Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."Original Line No." := xRec."Original Line No.";
                end;
                IF rec."Disable fields after Shipping" = false then begin//transfer fields after validating fields that has impact on other fields
                    rec."Disable fields after Shipping" := xRec."Disable fields after Shipping";
                end;
                IF rec."Container Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."Container Line No." := xRec."Container Line No.";
                end;
                IF rec."Initial ETA" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Initial ETA" := xRec."Initial ETA";
                end;
                IF rec."Initial ETD" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Initial ETD" := xRec."Initial ETD";
                end;
                IF rec."Initial ETR" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Initial ETR" := xRec."Initial ETR";
                end;
                IF rec."Initial ETAW" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Initial ETAW" := xRec."Initial ETAW";
                end;
                IF rec."Initial ETA" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Initial ETA" := xRec."Initial ETA";
                end;

                IF rec."Final ETA" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Final ETA" := xRec."Final ETA";
                end;
                IF rec."Final ETD" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Final ETD" := xRec."Final ETD";
                end;
                IF rec."Final ETR" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Final ETR" := xRec."Final ETR";
                end;
                IF rec."Final ETAW" = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec."Final ETAW" := xRec."Final ETAW";
                end;
                IF rec.ATA = 0D then begin//transfer fields after validating fields that has impact on other fields
                    rec.ATA := xRec.ATA;
                end;

                IF Rec."VO Number" = '' then begin
                    Rec."VO Number" := xRec."VO Number";
                end;

                IF rec."Meg Item Type" = '' then begin
                    Rec."Meg Item Type" := xRec."Meg Item Type";
                end;


                IF (rec."Job No." = '') AND (xRec."Job No." <> '') then//updated on 27/02/2025 since validating on job no. = '' is removing the dimensions on after validate on level purchase line
                    Rec.Validate("Job No.", xRec."Job No.");

                IF (rec."Job Task No." = '') AND (xRec."Job Task No." <> '') then
                    Rec.Validate("Job Task No.", xRec."Job Task No.");

                IF (rec."Job Planning Line No." = 0) AND (xRec."Job Planning Line No." <> 0) then
                    Rec.Validate("Job Planning Line No.", xRec."Job Planning Line No.");


                //added on 25/02/2025
                IF Rec."Job#" = '' then
                    Rec."Job#" := Xrec."Job#";

                IF Rec."Subjob ID" = 0 then
                    Rec."Subjob ID" := xRec."Subjob ID";

                IF Rec."Truck WayBill ID" = '' then
                    Rec."Truck WayBill ID" := xRec."Truck WayBill ID";

                IF Rec."Truck Details ID" = '' then
                    Rec."Truck Details ID" := xRec."Truck Details ID";

                IF Rec."Truck Details Line No." = 0 then
                    Rec."Truck Details Line No." := Xrec."Truck Details Line No.";



            end;






        }

        // modify(Quantity)//moved to page subform
        // {
        //     trigger OnAfterValidate()
        //     var
        //     begin
        //         if "MASQ Sales Order Line No." <> 0 then
        //             Error(Text002, FieldCaption(Quantity), "MASQ Sales Order No.", "MASQ Sales Order Line No.");
        //     end;

        // }

        //AN 04/22/2025
        /*modify("Direct Unit Cost")//moved to page by AI
        {
            trigger OnAfterValidate()
            var
                CostVariationLOG: Record "Cost Variation LOG";
            begin
                if xRec."Direct Unit Cost" <> 0 then begin
                    CostVariationLOG.Init();
                    CostVariationLOG."Item Number" := Rec."No.";
                    CostVariationLOG."New Cost" := Rec."Direct Unit Cost";
                    CostVariationLOG."Old Cost" := xRec."Direct Unit Cost";
                    CostVariationLOG."PO Number" := Rec."Document No.";
                    CostVariationLOG."PO Line Number" := Rec."Line No.";
                    CostVariationLOG."Project No." := Rec."Job No.";
                    CostVariationLOG."Project planning Line No." := Rec."Job Planning Line No.";
                    CostVariationLOG."Created By" := UserId;
                    CostVariationLOG.Insert(true);
                end;
            end;
        }*/
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    trigger OnModify()
    var
    begin
        IF rec."BL/AWB ID" = '' then begin//transfer fields after validating fields that has impact on other fields
            rec."BL/AWB ID" := xRec."BL/AWB ID";
        end;

        IF rec."Container ID" = '' then begin//transfer fields after validating fields that has impact on other fields
            rec."Container ID" := xRec."Container ID";
        end;
        IF rec."MASQ Sales Order No." = '' then begin//transfer fields after validating fields that has impact on other fields
            rec."MASQ Sales Order No." := xRec."MASQ Sales Order No.";
        end;
        IF rec."MASQ Sales Order Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
            rec."MASQ Sales Order Line No." := xRec."MASQ Sales Order Line No.";
        end;

        IF rec."Quantity Shipped" = 0 then begin//transfer fields after validating fields that has impact on other fields
            rec."Quantity Shipped" := xRec."Quantity Shipped";
        end;

        IF rec."Remaining Quantity Shipped" = 0 then begin//transfer fields after validating fields that has impact on other fields
            rec."Remaining Quantity Shipped" := xRec."Remaining Quantity Shipped";
        end;

        IF rec."Line is Splitted" = false then begin//transfer fields after validating fields that has impact on other fields
            rec."Line is Splitted" := xRec."Line is Splitted";
        end;
        IF rec."Splitted Line No." = '' then begin//transfer fields after validating fields that has impact on other fields
            rec."Splitted Line No." := xRec."Splitted Line No.";
        end;
        IF rec."Original Quantity" = 0 then begin//transfer fields after validating fields that has impact on other fields
            rec."Original Quantity" := xRec."Original Quantity";
        end;
        IF rec."Original Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
            rec."Original Line No." := xRec."Original Line No.";
        end;
        IF rec."Disable fields after Shipping" = false then begin//transfer fields after validating fields that has impact on other fields
            rec."Disable fields after Shipping" := xRec."Disable fields after Shipping";
        end;
        IF rec."Container Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
            rec."Container Line No." := xRec."Container Line No.";
        end;
        IF rec."Initial ETA" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Initial ETA" := xRec."Initial ETA";
        end;
        IF rec."Initial ETD" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Initial ETD" := xRec."Initial ETD";
        end;
        IF rec."Initial ETR" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Initial ETR" := xRec."Initial ETR";
        end;
        IF rec."Initial ETAW" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Initial ETAW" := xRec."Initial ETAW";
        end;
        IF rec."Initial ETA" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Initial ETA" := xRec."Initial ETA";
        end;

        IF rec."Final ETA" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Final ETA" := xRec."Final ETA";
        end;
        IF rec."Final ETD" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Final ETD" := xRec."Final ETD";
        end;
        IF rec."Final ETR" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Final ETR" := xRec."Final ETR";
        end;
        IF rec."Final ETAW" = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec."Final ETAW" := xRec."Final ETAW";
        end;
        IF rec.ATA = 0D then begin//transfer fields after validating fields that has impact on other fields
            rec.ATA := xRec.ATA;
        end;

        IF Rec."VO Number" = '' then begin
            Rec."VO Number" := xRec."VO Number";
        end;
        IF rec."Meg Item Type" = '' then begin
            Rec."Meg Item Type" := xRec."Meg Item Type";
        end;
        IF (Rec."Direct Unit Cost" = 0) AND (xRec."Direct Unit Cost" <> 0) then//may be removed case VO replace item//added on 27/03/2025
            Rec.Validate("Direct Unit Cost", xRec."Direct Unit Cost");

        IF (rec."Location Code" = '') and (xRec."Location Code" <> '') then//added on 27/03/2025
            Rec.Validate("Location Code", xRec."Location Code");

        IF (rec."Job No." = '') AND (xRec."Job No." <> '') then//updated on 27/02/2025 since validating on job no. = '' is removing the dimensions on after validate on level purchase line
            Rec.Validate("Job No.", xRec."Job No.");

        IF (rec."Job Task No." = '') AND (xRec."Job Task No." <> '') then
            Rec.Validate("Job Task No.", xRec."Job Task No.");

        IF (rec."Job Planning Line No." = 0) AND (xRec."Job Planning Line No." <> 0) then
            Rec.Validate("Job Planning Line No.", xRec."Job Planning Line No.");


        //added on 25/02/2025
        IF Rec."Job#" = '' then
            Rec."Job#" := Xrec."Job#";

        IF Rec."Subjob ID" = 0 then
            Rec."Subjob ID" := xRec."Subjob ID";

        IF Rec."Truck WayBill ID" = '' then
            Rec."Truck WayBill ID" := xRec."Truck WayBill ID";

        IF Rec."Truck Details ID" = '' then
            Rec."Truck Details ID" := xRec."Truck Details ID";

        IF Rec."Truck Details Line No." = 0 then
            Rec."Truck Details Line No." := Xrec."Truck Details Line No.";



    end;

    trigger OnDelete()
    var
        SalesLine: Record "Sales Line";
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        UserSetup.Get(UserId);

        //NB MASQ Start
        IF (NOT UserSetup."Can Edit SO/PO Details") then begin
            IF Rec."Document Type" = REc."Document Type"::Order then
                IF Rec."MASQ Sales Order Line No." <> 0 then
                    if SalesLine.Get(SalesLine."Document Type"::Order, "MASQ Sales Order No.", "MASQ Sales Order Line No.") then
                        Error(Text000, "MASQ Sales Order No.", "MASQ Sales Order Line No.");
        end else begin
            if SalesLine.Get(SalesLine."Document Type"::Order, "MASQ Sales Order No.", "MASQ Sales Order Line No.") then begin
                SalesLine.Validate("MASQ Purchase Order No.", '');
                SalesLine.Validate("MASQ Purchase Order Line No.", 0);
                SalesLine.Validate("Sent to PO", false);
                SalesLine.Modify(true);
            end;
        end;
        //NB MASQ End

    end;

    //AN 8/1/2025
    trigger OnAfterModify()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if PurchaseHeader.Get("Document Type", "Document No.") then
            PurchaseHeader.CalculateTotalWithCharge();
    end;

    trigger OnAfterDelete()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if PurchaseHeader.Get("Document Type", "Document No.") then
            PurchaseHeader.CalculateTotalWithCharge();
    end;

    var
        Text000: Label 'You cannot delete the order line because it is associated with Sales order %1 line %2.';
        Text002: Label 'You can''t change %1 because the order line is associated with Sales order %2 line %3.', Comment = '%1=field name, %2=Document No., %3=Line No.';

}