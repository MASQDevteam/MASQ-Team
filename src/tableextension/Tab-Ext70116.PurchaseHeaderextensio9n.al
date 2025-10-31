tableextension 70116 "Purchase Header extensio9n" extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(70110; "Request for Payments"; Integer)
        {
            //  DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = count("SUPPLIER PAYMENT REQUEST" where("PO#" = field("No.")));
        }
        field(70111; "Initial ETR"; Date)//Created on 28/10/2024 with Nathalie
        {
            Caption = 'Initial ETR';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("Document Type", Rec."Document Type");
                PurchaseLine.SetRange("Document No.", Rec."No.");
                //  PurchaseLine.ModifyAll("Initial ETR", REc."Initial ETR");
                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec."Initial ETA" <> 0D) AND (Rec."Initial ETAW" <> 0D) AND (Rec."Initial ETR" <> 0D) AND (Rec."Initial ETD" <> 0D) then begin
                            clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := PurchaseLine."BL/AWB ID";
                            ShippingDateLOG."Container Number" := PurchaseLine."Container ID";
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Initial ETR" := Rec."Initial ETR";
                            ShippingDateLOG."Initial ETD" := Rec."Initial ETD";
                            ShippingDateLOG."Initial ETA" := Rec."Initial ETA";
                            ShippingDateLOG."Initial ETAW" := Rec."Initial ETAW";
                            ShippingDateLOG.Insert(true);


                        end;
                        PurchaseLine."Initial ETR" := REc."Initial ETR";
                        PurchaseLine.Modify();
                    until PurchaseLine.Next() = 0;


                //  end;
            end;
        }
        field(70112;
        "Initial ETD";
        Date)
        {
            Caption = 'Initial ETD';
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("Document Type", Rec."Document Type");
                PurchaseLine.SetRange("Document No.", Rec."No.");
                //  PurchaseLine.ModifyAll("Initial ETR", REc."Initial ETR");
                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec."Initial ETA" <> 0D) AND (Rec."Initial ETAW" <> 0D) AND (Rec."Initial ETR" <> 0D) AND (Rec."Initial ETD" <> 0D) then begin
                            clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := PurchaseLine."BL/AWB ID";
                            ShippingDateLOG."Container Number" := PurchaseLine."Container ID";
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Initial ETR" := Rec."Initial ETR";
                            ShippingDateLOG."Initial ETD" := Rec."Initial ETD";
                            ShippingDateLOG."Initial ETA" := Rec."Initial ETA";
                            ShippingDateLOG."Initial ETAW" := Rec."Initial ETAW";
                            ShippingDateLOG.Insert(true);
                        end;
                        PurchaseLine."Initial ETD" := REc."Initial ETD";
                        PurchaseLine.Modify();
                    until PurchaseLine.Next() = 0;


                //  end;
            end;
            /*  trigger OnValidate()
              var
                  PurchaseLine: Record "Purchase Line";
              begin
                  Clear(PurchaseLine);
                  PurchaseLine.SetRange("Document Type", Rec."Document Type");
                  PurchaseLine.SetRange("Document No.", Rec."No.");
                  PurchaseLine.ModifyAll("Initial ETD", REc."Initial ETD");
              end;*/
        }
        field(70113; "Initial ETA"; Date)
        {
            Caption = 'Initial ETA';
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("Document Type", Rec."Document Type");
                PurchaseLine.SetRange("Document No.", Rec."No.");
                //  PurchaseLine.ModifyAll("Initial ETR", REc."Initial ETR");
                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec."Initial ETA" <> 0D) AND (Rec."Initial ETAW" <> 0D) AND (Rec."Initial ETR" <> 0D) AND (Rec."Initial ETD" <> 0D) then begin
                            clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := PurchaseLine."BL/AWB ID";
                            ShippingDateLOG."Container Number" := PurchaseLine."Container ID";
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Initial ETR" := Rec."Initial ETR";
                            ShippingDateLOG."Initial ETD" := Rec."Initial ETD";
                            ShippingDateLOG."Initial ETA" := Rec."Initial ETA";
                            ShippingDateLOG."Initial ETAW" := Rec."Initial ETAW";
                            ShippingDateLOG.Insert(true);


                        end;
                        PurchaseLine."Initial ETA" := REc."Initial ETA";
                        PurchaseLine.Modify();
                    until PurchaseLine.Next() = 0;


                //  end;
            end;
            /*   trigger OnValidate()
               var
                   PurchaseLine: Record "Purchase Line";
               begin
                   Clear(PurchaseLine);
                   PurchaseLine.SetRange("Document Type", Rec."Document Type");
                   PurchaseLine.SetRange("Document No.", Rec."No.");
                   PurchaseLine.ModifyAll("Initial ETA", REc."Initial ETA");
               end;*/
        }
        field(70114; "Initial ETAW"; Date)
        {
            Caption = 'Initial ETAW';
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("Document Type", Rec."Document Type");
                PurchaseLine.SetRange("Document No.", Rec."No.");
                //  PurchaseLine.ModifyAll("Initial ETR", REc."Initial ETR");
                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec."Initial ETA" <> 0D) AND (Rec."Initial ETAW" <> 0D) AND (Rec."Initial ETR" <> 0D) AND (Rec."Initial ETD" <> 0D) then begin
                            clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := PurchaseLine."BL/AWB ID";
                            ShippingDateLOG."Container Number" := PurchaseLine."Container ID";
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Initial ETR" := Rec."Initial ETR";
                            ShippingDateLOG."Initial ETD" := Rec."Initial ETD";
                            ShippingDateLOG."Initial ETA" := Rec."Initial ETA";
                            ShippingDateLOG."Initial ETAW" := Rec."Initial ETAW";
                            ShippingDateLOG.Insert(true);


                        end;
                        PurchaseLine."Initial ETAW" := REc."Initial ETAW";
                        PurchaseLine.Modify();
                    until PurchaseLine.Next() = 0;


                //  end;
            end;
            /*   trigger OnValidate()
               var
                   PurchaseLine: Record "Purchase Line";
               begin
                   Clear(PurchaseLine);
                   PurchaseLine.SetRange("Document Type", Rec."Document Type");
                   PurchaseLine.SetRange("Document No.", Rec."No.");
                   PurchaseLine.ModifyAll("Initial ETAW", REc."Initial ETAW");
               end;*/
        }
        field(70115; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70116; "Document Attachment ID"; Integer)
        {

        }
        field(70117; "Document Attachment Table ID"; Integer)
        {

        }
        field(70118; "Document Attachment No."; Code[20])
        {

        }
        field(70119; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(70120; "Document Attachment Line No."; Integer)
        {
        }
        field(70121; "MASQ Sales Order No."; Code[20])
        {
            //    DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."MASQ Sales Order No." where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(70122; "Shipping Quotation No."; Text[250])
        {
            Editable = false;
        }

        field(70123; "Freight Charges"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Data MASQ Lookup".Code where(Type = const(Freight));
        }
        field(70124; "Documentation Charges"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Data MASQ Lookup".Code where(Type = const(Documentation));
        }
        field(70125; "Freight Charges Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalculateTotalWithCharge();
            end;
        }
        field(70126; "TotalWithCharges"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70127; "Documentation Charges Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalculateTotalWithCharge();
            end;
        }
        field(70128; "PO Type"; Option)
        {
            OptionMembers = " ","Sample","Mockup","Main Project";
        }
        // FQ MASQ ** Start ** added new fields
        field(70129; "Other Charges"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Data MASQ Lookup".Code where(Type = const("OTHER Charges"));
        }
        field(70130; "Other Charges Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalculateTotalWithCharge();
            end;
        }
        field(70131; "Acknowledgement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70132; "Custom Status"; Enum "Custom Purchase Status")
        {
            Caption = 'Custom Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70133; "SCC Count"; Integer)
        {
            Caption = 'Shipping Conformity Certificates';
            FieldClass = FlowField;
            CalcFormula = count("SCC Order Line" where("Purchase Order No." = field("No.")));
            Editable = false;
        }
        field(70134; "Shipment Mode"; Enum "SCC Shipment Mode")
        {
            DataClassification = ToBeClassified;
        }
        /*  modify("Assigned User ID")
         {
             trigger OnAfterValidate()
             var
                 user: Record User;
             begin
                 // The "Assigned User ID" stores the User Name (not the GUID SystemId).
                 // Look up by User Name and normalize to the exact User Name value.
                 user.Reset();
                 user.SetRange("User Name", "Assigned User ID");
                 if user.FindFirst() then
                     "Assigned User ID" := user."Full Name";
             end;
         } */
        // FQ MASQ ** END **

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    //FQ MASQ** START
    trigger OnAfterInsert()
    begin
        InitializeCustomStatus();
    end;

    trigger OnAfterModify()
    begin
        // Update custom status when standard Status field changes
        if Rec.Status <> xRec.Status then
            UpdateStatusBasedOnDocumentStatus();
    end;

    local procedure InitializeCustomStatus()
    begin
        case Status of
            Status::Open:
                "Custom Status" := "Custom Status"::Open;
            Status::Released:
                "Custom Status" := "Custom Status"::Released;
            else
                "Custom Status" := "Custom Status"::Open;
        end;
    end;

    local procedure UpdateStatusBasedOnDocumentStatus()
    begin
        // Only update if we're in a basic state (Open/Released) without posting activity
        if "Custom Status" in ["Custom Status"::Open, "Custom Status"::Released,
                                "Custom Status"::"Pending Approval", "Custom Status"::"Pending Prepayment"] then
            case Status of
                Status::Open:
                    "Custom Status" := "Custom Status"::Open;
                Status::Released:
                    "Custom Status" := "Custom Status"::Released;
            end;
    end;
    //FQ MASQ **END**
    procedure CalculateTotalWithCharge()
    var
    begin
        CalcFields("Amount Including VAT");
        TotalWithCharges := ("Amount Including VAT" + Rec."Freight Charges Value" + Rec."Documentation Charges Value" + Rec."Other Charges Value");//FQ MASQ  
        Modify();
    end;


    var
        MASQEmail: Codeunit "MASQ Email";
}