tableextension 70102 "Sales line extension" extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here

        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            var
                PurchaseLine: Record "Purchase Line";
            begin
                if PurchaseLine.Get(PurchaseLine."Document Type"::Order, "MASQ Purchase Order No.", "MASQ Purchase Order Line No.") then
                    if PurchaseLine."Final ETAW" > Rec."Shipment Date" then
                        if PurchaseLine."Final ETAW" <> 0D then
                            Message('The Shipment Date cannot be less than the Final ETAW of the Purchase Order Line %1, %2.', Rec."MASQ Purchase Order No.", Rec."MASQ Purchase Order Line No.");
            end;
        }

        field(70102; "Currency Factor"; Decimal)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Currency Factor" where("No." = field("Document No."), "Document Type" = field("Document Type")));
        }

        field(70100; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(3)));
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
        field(70106; "Batch Number";
        Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70107; "MASQ Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70108; "MASQ Purchase Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70109; "Line is Splitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "Splitted Line No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70111; "Original PO Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70112; "Original Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70113; "VO Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70114; "Sent to PO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70115; "Job Planning Line No."; Integer)//field added to link the project planning line to the so lines
        {
            AccessByPermission = TableData Job = R;
            BlankZero = true;
            Caption = 'Project Planning Line No.';
        }
        field(70116; "Skip Line Checking "; Boolean)//this field is created to skip the line checking when sale line is linked to a job no and job task no. in case of po line splitting and edit from VO ONLY
        //else users has no permission to edit sale line linked to job
        {
            DataClassification = ToBeClassified;
        }
        field(70117; "Initial ETR"; Date)//Created on 28/10/2024 with Nathalie
        {
            Caption = 'Initial ETR';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Initial ETR" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));

        }
        field(70118; "Initial ETD"; Date)
        {
            Caption = 'Initial ETD';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Initial ETD" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));

        }
        field(70119; "Initial ETA"; Date)
        {
            Caption = 'Initial ETA';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Initial ETA" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));

        }
        field(70120; "Initial ETAW"; Date)
        {
            Caption = 'Initial ETAW';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Initial ETAW" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));

        }
        field(70121; "Final ETR"; Date)
        {
            Caption = 'Final ETR';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Final ETR" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));

        }
        field(70122; "Final ETD"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Final ETD" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));
        }
        field(70123; "Final ETA"; Date)
        {
            Caption = 'Final ETA';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Final ETA" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));
        }
        field(70124; "ATA"; Date)
        {
            Caption = 'ATA';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."ATA" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));

        }
        field(70125; "Final ETAW"; Date)
        {
            Caption = 'Final ETAW';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Final ETAW" where("MASQ Sales Order No." = field("Document No."), "MASQ Sales Order Line No." = field("Line No.")));

        }
        field(70126; "Shortcut Dimension 3 Code1"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                          Blocked = const(false));
        }
        field(70127; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                          Blocked = const(false));
        }
        field(70128; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                          Blocked = const(false));
        }
        field(70129; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                          Blocked = const(false));
        }
        field(70130; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                          Blocked = const(false));
        }
        field(70131; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                          Blocked = const(false));
        }
        field(70132; "Apollo Job Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70133; "Original Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70134; "Remaining Quantity Shipped"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;

        }
        field(70135; "Qty to Split"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70136; "MIR Due Date"; Date)
        {
            Caption = 'MIR Due Date';
        }

        field(70137; "MIR Comments"; Text[250])
        {
            Caption = 'MIR Comments';
        }
        field(70138; "Requested By"; Code[50])
        {
            Caption = 'Requested By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        }

        field(70139; "MIR Status"; Option)
        {
            Caption = 'MIR Status';
            OptionMembers = Pending,Approved,Rejected,Completed;
            OptionCaption = 'Pending,Approved,Rejected,Completed';
            DataClassification = CustomerContent;
        }
        field(70140; "MIR Approval By"; Code[50])
        {
            Caption = 'MIR Approval By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        }

        field(70141; "MIR Approval Date"; Date)
        {
            Caption = 'MIR Approval Date';
            DataClassification = CustomerContent;
        }

        //NB MASQ Start
        field(70142; "Available Inventory"; Decimal)
        {
            Editable = false;
        }
        //NB MASQ End

        modify("Planned Delivery Date")
        {
            trigger OnAfterValidate()
            var
                DeliveryDate: Date;
            begin
                DeliveryDate := Rec."Planned Delivery Date";
                if DeliveryDate <> 0D then
                    Rec."MIR Due Date" := CalcDate('14D', DeliveryDate);
            end;
        }

        //NB MASQ Start
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("No.") then begin
                    Item.CalcFields(Inventory);
                    Rec.Validate("Available Inventory", Item.Inventory);
                end;
            end;
        }
        //NB MASQ End

        //AN 04/22/2025
        /*    modify("Unit Price")//moved to page by AI
            {
                trigger OnAfterValidate()
                var
                    CostVariationLOG: Record "Cost Variation LOG";
                begin
                    if xRec."Unit Price" <> 0 then begin
                        CostVariationLOG.Init();
                        CostVariationLOG."Item Number" := Rec."No.";
                        CostVariationLOG."New Price" := Rec."Unit Price";
                        CostVariationLOG."Old Price" := xRec."Unit Price";
                        CostVariationLOG."SO Number" := Rec."Document No.";
                        CostVariationLOG."SO Line Number" := Rec."Line No.";
                        CostVariationLOG."Project No." := Rec."Job No.";
                        CostVariationLOG."Project planning Line No." := Rec."Job Planning Line No.";
                        CostVariationLOG."Created By" := UserId;
                        CostVariationLOG.Insert(true);
                    end;
                end;
            }*/
        modify("No.")
        {
            trigger OnAfterValidate()
            /*  var
                  PurchaseLine: Record "Purchase Line";
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
                  CostVariationLOG: Record "Cost Variation LOG";*/
            begin
                /*ProjectLineunitCost := 0;
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
                Clear(PurchaseLine);
                Clear(ProjectLine);
                IF rec."MASQ Purchase Order No." = '' then begin//transfer fields after validating fields that has impact on other fields
                    rec."MASQ Purchase Order No." := xRec."MASQ Purchase Order No.";
                end;
                IF rec."MASQ Purchase Order Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."MASQ Purchase Order Line No." := xRec."MASQ Purchase Order Line No.";
                end;

                IF PurchaseLine.get(PurchaseLine."Document Type"::Order, Rec."MASQ Purchase Order No.", Rec."MASQ Purchase Order Line No.") then begin
                    IF Rec."No." <> '' then begin
                        IF Rec."No." <> PurchaseLine."No." then begin
                            IF Confirm(StrSubstNo('Warninig! the Item Number in the sales Line is different from the purchase %1 line %2. Do you want to update the item Number on the Purchase Line too?', Rec."MASQ Purchase Order No.", Rec."MASQ Purchase Order Line No.")) then begin
                                IF ProjectLine.Get(PurchaseLine."Job No.", PurchaseLine."Job Task No.", PurchaseLine."Job Planning Line No.") then begin
                                    ProjectLineunitCost := ProjectLine."Unit Cost";//added on 07/05/2025
                                    ProjectLocationCode := ProjectLine."Location Code";//added on 07/05/2025
                                    ProjectDim1 := ProjectLine."Shortcut Dimension 1 Code";
                                    ProjectDim2 := ProjectLine."Shortcut Dimension 2 Code";
                                    ProjectDim3 := ProjectLine."Shortcut Dimension 3 Code";
                                    ProjectDim4 := ProjectLine."Shortcut Dimension 4 Code";
                                    ProjectDim5 := ProjectLine."Shortcut Dimension 5 Code";
                                    ProjectDim6 := ProjectLine."Shortcut Dimension 6 Code";

                                    ProjectLine.Validate("No.", Rec."No.");
                                    ProjectLine.Validate("Unit Price", Rec."Unit Price");//added on 07/05/2025

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


                                PurchaseLine.Validate("No.", Rec."No.");
                                PurchaseLine.Modify();

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
                end;*/
                IF rec."MASQ Purchase Order No." = '' then begin//transfer fields after validating fields that has impact on other fields
                    rec."MASQ Purchase Order No." := xRec."MASQ Purchase Order No.";
                end;
                IF rec."MASQ Purchase Order Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."MASQ Purchase Order Line No." := xRec."MASQ Purchase Order Line No.";
                end;


                IF rec."Line is Splitted" = false then begin//transfer fields after validating fields that has impact on other fields
                    rec."Line is Splitted" := xRec."Line is Splitted";
                end;
                IF rec."Splitted Line No." = '' then begin//transfer fields after validating fields that has impact on other fields
                    rec."Splitted Line No." := xRec."Splitted Line No.";
                end;
                IF rec."Original Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
                    rec."Original Line No." := xRec."Original Line No.";
                end;
                IF Rec."VO Number" = '' then begin
                    Rec."VO Number" := xRec."VO Number";
                end;

                IF rec."Meg Item Type" = '' then begin
                    Rec."Meg Item Type" := xRec."Meg Item Type";
                end;

                IF rec."Original PO Line No." = 0 then begin
                    Rec."Original PO Line No." := xRec."Original PO Line No.";
                end;

                IF (Rec."Unit Price" = 0) AND (xRec."Unit Price" <> 0) then//may be removed case VO replace item
                    Rec.Validate("Unit Price", xRec."Unit Price");

                IF rec."Location Code" = '' then
                    Rec.Validate("Location Code", xRec."Location Code");

                IF (rec."Job No." = '') AND (xRec."Job No." <> '') then//updated on 27/02/2025
                    Rec.Validate("Job No.", xRec."Job No.");

                IF (rec."Job Task No." = '') AND (xRec."Job Task No." <> '') then
                    Rec.Validate("Job Task No.", xRec."Job Task No.");

                IF (rec."Job Planning Line No." = 0) AND (xRec."Job Planning Line No." <> 0) then
                    Rec.Validate("Job Planning Line No.", xRec."Job Planning Line No.");

                IF (rec."Job Contract Entry No." = 0) AND (xRec."Job Contract Entry No." <> 0) then
                    Rec.Validate("Job Contract Entry No.", xRec."Job Contract Entry No.");

                //added on 25/02/2025
                If Rec."Apollo Job Unit Cost" = 0 then
                    Rec."Apollo Job Unit Cost" := xRec."Apollo Job Unit Cost";

                IF (Rec."Sent to PO" = false) and (xRec."Sent to PO") then//added on 02/04/2025
                    Rec."Sent to PO" := xRec."Sent to PO";
            end;
        }


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

        IF rec."MASQ Purchase Order No." = '' then begin//transfer fields after validating fields that has impact on other fields
            rec."MASQ Purchase Order No." := xRec."MASQ Purchase Order No.";
        end;
        IF rec."MASQ Purchase Order Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
            rec."MASQ Purchase Order Line No." := xRec."MASQ Purchase Order Line No.";
        end;


        IF rec."Line is Splitted" = false then begin//transfer fields after validating fields that has impact on other fields
            rec."Line is Splitted" := xRec."Line is Splitted";
        end;
        IF rec."Splitted Line No." = '' then begin//transfer fields after validating fields that has impact on other fields
            rec."Splitted Line No." := xRec."Splitted Line No.";
        end;
        IF rec."Original Line No." = 0 then begin//transfer fields after validating fields that has impact on other fields
            rec."Original Line No." := xRec."Original Line No.";
        end;
        IF Rec."VO Number" = '' then begin
            Rec."VO Number" := xRec."VO Number";
        end;

        /*  IF (Rec."Unit Price" = 0) AND (xRec."Unit Price" <> 0) and (Rec."Job No." <> '') then //may be removed case VO replace item 
             Rec.Validate("Unit Price", xRec."Unit Price"); *///FQ MASQ

        IF rec."Location Code" = '' then
            Rec.Validate("Location Code", xRec."Location Code");

        IF (rec."Job No." = '') AND (xRec."Job No." <> '') then//updated on 27/02/2025
            Rec.Validate("Job No.", xRec."Job No.");

        IF (rec."Job Task No." = '') AND (xRec."Job Task No." <> '') then
            Rec.Validate("Job Task No.", xRec."Job Task No.");

        IF (rec."Job Planning Line No." = 0) AND (xRec."Job Planning Line No." <> 0) then
            Rec.Validate("Job Planning Line No.", xRec."Job Planning Line No.");

        IF (rec."Job Contract Entry No." = 0) AND (xRec."Job Contract Entry No." <> 0) then
            Rec.Validate("Job Contract Entry No.", xRec."Job Contract Entry No.");

        IF (Rec."Sent to PO" = false) and (xRec."Sent to PO") then//added on 02/04/2025
            Rec."Sent to PO" := xRec."Sent to PO";

    end;

    trigger OnDelete()
    var
        PurchaseLine: Record "Purchase Line";
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        UserSetup.Get(UserId);

        IF (NOT UserSetup."Can Edit SO/PO Details") then
            IF Rec."Document Type" = REc."Document Type"::Order then
                IF Rec."MASQ Purchase Order Line No." <> 0 then
                    if PurchaseLine.Get(PurchaseLine."Document Type"::Order, "MASQ Purchase Order No.", "MASQ Purchase Order Line No.") then
                        Error(Text000, "MASQ Purchase Order No.", "MASQ Purchase Order Line No.");

    end;

    var
        Text000: Label 'You cannot delete the order line because it is associated with purchase order %1 line %2.';
        Text002: Label 'You can''t change %1 because the order line is associated with purchase order %2 line %3.', Comment = '%1=field name, %2=Document No., %3=Line No.';

}