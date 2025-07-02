table 70110 "AWB Details"
//Created on 28/10/2024 with Nathalie


{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Airline"; Code[50])
        {
            Caption = 'Airline';
            // Set up a lookup to your airline master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Airline));
        }
        field(2; "Free Demurrage Days"; Integer)
        {
            Caption = 'Free Demurrage Days';
            // Set up a lookup to your vessel/airline master table here
        }
        field(3; "Voyage Number"; Text[50])
        {
            Caption = 'Voyage Number';
        }
        field(4; "Cargo Description"; Code[50])
        {
            Caption = 'Cargo Description';
        }
        field(5; "Origin"; Code[50])
        {
            Caption = 'Origin';
            // Set up a lookup to your origin master table here   
            TableRelation = "MASQ Lookup".Code where(Type = const(Origin));
        }
        field(6; "Port of Loading"; Code[50])
        {
            Caption = 'Air Port of Loading';
            // Set up a lookup to your port master table here    
            TableRelation = "MASQ Lookup".Code where(Type = const("Air Port"), ORIGINS = field(Origin));
        }
        field(7; "Port of Discharge"; Code[50])
        {
            Caption = 'Air Port of Discharge';
            // Set up a lookup to your port master table here    
            TableRelation = "MASQ Lookup".Code where(Type = const("Air Port"));
        }
        field(8; "AWB"; Date)
        {
            Caption = 'AWB';
        }
        field(9; "Clearing Agent"; Code[50])
        {
            Caption = 'Clearing Agent';// Drop down can be handled with lookupr
                                       //  TableRelation = "MASQ Lookup".Code where(Type = const("Clearing Agent"));
            TableRelation = Vendor where(Category = const("SHIPPING & CLEARING"));
        }
        field(10; "Docs Sent to Entity Date"; Date)
        {
            Caption = 'Docs Sent to Entity Date';
        }
        field(11; "Docs Received in Entity Date"; Date)
        {
            Caption = 'Docs Received in Entity Date';
        }
        field(12; "Docs AWB No"; Text[50])
        {
            Caption = 'Docs AWB No';
        }
        field(13; "Copy Docs Sent to Agent Date"; Date)
        {
            Caption = 'Copy Docs Sent to Agent Date';
        }
        field(14; "Docs Delivered to Clearing Agent"; Date)
        {
            Caption = 'Docs Delivered to Clearing Agent';
        }
        field(15; "Assessment Date"; Date)
        {
            Caption = 'Assessment Date';
        }
        field(16; "Duty Paid Date"; Date)
        {
            Caption = 'Duty Paid Date';
        }
        field(17; "Duty Receipt sent to agent"; Date)
        {
            Caption = 'Duty Receipt sent to agent';
        }
        field(18; "Remarks"; Text[500])
        {
            Caption = 'Remarks';
        }
        field(19; "Final ETR"; Date)
        {
            Caption = 'Final ETR';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                // IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."AWB ID");
                PurchaseLine.SetRange("Container ID", '');
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."AWB ID";
                            ShippingDateLOG."Container Number" := '';
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Final ETR" := Rec."Final ETR";
                            ShippingDateLOG."Final ETD" := Rec."Final ETD";
                            ShippingDateLOG."Final ETA" := Rec."Final ETA";
                            ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                            ShippingDateLOG.ATA := Rec.ATA;
                            ShippingDateLOG.Insert(true);
                        end;


                        PurchaseLine."Final ETR" := rec."Final ETR";
                        PurchaseLine.Modify();


                    until PurchaseLine.Next() = 0;

                // end;

            end;
        }
        field(20; "Final ETD"; Date)
        {
            Caption = 'Final ETD';
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                // IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."AWB ID");
                PurchaseLine.SetRange("Container ID", '');
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."AWB ID";
                            ShippingDateLOG."Container Number" := '';
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Final ETR" := Rec."Final ETR";
                            ShippingDateLOG."Final ETD" := Rec."Final ETD";
                            ShippingDateLOG."Final ETA" := Rec."Final ETA";
                            ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                            ShippingDateLOG.ATA := Rec.ATA;
                            ShippingDateLOG.Insert(true);
                        end;


                        PurchaseLine."Final ETD" := rec."Final ETD";
                        PurchaseLine.Modify();


                    until PurchaseLine.Next() = 0;

                // end;

            end;
        }
        field(21; "Final ETA"; Date)
        {
            Caption = 'Final ETA';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                //  IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."AWB ID");
                PurchaseLine.SetRange("Container ID", '');
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."AWB ID";
                            ShippingDateLOG."Container Number" := '';
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Final ETR" := Rec."Final ETR";
                            ShippingDateLOG."Final ETD" := Rec."Final ETD";
                            ShippingDateLOG."Final ETA" := Rec."Final ETA";
                            ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                            ShippingDateLOG.ATA := Rec.ATA;
                            ShippingDateLOG.Insert(true);
                        end;


                        PurchaseLine."Final ETA" := rec."Final ETA";
                        PurchaseLine.Modify();


                    until PurchaseLine.Next() = 0;

                //  end;

            end;
        }
        field(22; "ATA"; Date)
        {
            Caption = 'ATA';
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                //  IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."AWB ID");
                PurchaseLine.SetRange("Container ID", '');
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."AWB ID";
                            ShippingDateLOG."Container Number" := '';
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Final ETR" := Rec."Final ETR";
                            ShippingDateLOG."Final ETD" := Rec."Final ETD";
                            ShippingDateLOG."Final ETA" := Rec."Final ETA";
                            ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                            ShippingDateLOG.ATA := Rec.ATA;
                            ShippingDateLOG.Insert(true);
                        end;


                        PurchaseLine.ATA := rec.ATA;
                        PurchaseLine.Modify();


                    until PurchaseLine.Next() = 0;

                //  end;

            end;
        }
        field(23; "Final ETAW"; Date)
        {
            Caption = 'Final ETAW';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                // IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."AWB ID");
                PurchaseLine.SetRange("Container ID", '');
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."AWB ID";
                            ShippingDateLOG."Container Number" := '';
                            ShippingDateLOG."PO Number" := PurchaseLine."Document No.";
                            ShippingDateLOG."PO Line Number" := PurchaseLine."Line No.";
                            ShippingDateLOG."Final ETR" := Rec."Final ETR";
                            ShippingDateLOG."Final ETD" := Rec."Final ETD";
                            ShippingDateLOG."Final ETA" := Rec."Final ETA";
                            ShippingDateLOG."Final ETAW" := Rec."Final ETAW";
                            ShippingDateLOG.ATA := Rec.ATA;
                            ShippingDateLOG.Insert(true);
                        end;


                        PurchaseLine."Final ETAW" := rec."Final ETAW";
                        PurchaseLine.Modify();


                    until PurchaseLine.Next() = 0;

                // end;

            end;
        }
        field(24; "NET Weight in KG"; Decimal) { }//no need to add weight in BL since container is a container ma byetala3o b weights mmesh metil airwabel
        // field(24; "Document Type"; Enum "Purchase Document Type")
        // {
        //     Caption = 'Document Type';
        // }
        // field(25; "Document No."; Code[20])
        // {
        //     Caption = 'Document No.';
        //     TableRelation = "Purchase Header"."No." where("Document Type" = field("Document Type"));
        // }
        // field(26; "Line No."; Integer)
        // {
        //     Caption = 'Line No.';
        // }
        field(25; "AWB ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;


        }
        field(27; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Document Attachment ID"; Integer)
        {

        }
        field(29; "Document Attachment Table ID"; Integer)
        {

        }
        field(30; "Document Attachment No."; Code[20])
        {

        }
        field(31; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(32; "Document Attachment Line No."; Integer)
        {
        }
        field(33; "AWB Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "GROSS Weight in KG"; Decimal) { }
        field(35; "VOLUMETRIC Weight in KG"; Decimal) { }
        field(36; "Agent"; Code[50])
        {
            Caption = 'Agent';
            //
            //Drop down can be handled with lookup
            TableRelation = "MASQ Lookup".Code where(Type = const("Agent"));
        }
        field(37; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Express","Cargo";
        }
        field(38; "CHARGABLE Weight in KG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Shipping Quotation Reference"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Quotation";
        }
        field(40; "PO No."; Text[1000])
        {
            trigger OnLookup()
            var
                PurchaseHeader: Record "Purchase Header";
                PurchaseLine: Record "Purchase Line";
                PurchaseOrderList: Page "Purchase Order List";
            begin
                Rec."PO No." := '';
                Clear(PurchaseOrderList);
                Clear(PurchaseLine);
                Clear(PurchaseHeader);
                PurchaseLine.SetRange("BL/AWB ID", Rec."AWB ID");
                if PurchaseLine.FindFirst() then
                    repeat
                        PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
                        PurchaseHeader.Mark(true);
                    until PurchaseLine.Next() = 0;

                PurchaseHeader.MarkedOnly(true);
                PurchaseOrderList.SetTableView(PurchaseHeader);
                PurchaseOrderList.LookupMode(true);
                IF PurchaseOrderList.RunModal() = Action::LookupOK then begin
                    PurchaseOrderList.SetSelectionFilter(PurchaseHeader);
                    if PurchaseHeader.FindSet() then
                        repeat
                            Rec."PO No." += PurchaseHeader."No." + ' , ';
                        until PurchaseHeader.Next() = 0;
                end;
                If Rec."PO No." <> '' then
                    Rec."PO No." := CopyStr(Rec."PO No.", 1, StrLen(Rec."PO No.") - 3);
            end;
        }
        field(41; "Location Code"; Text[1000])
        {
            Caption = 'Apollo Project No';
            trigger OnLookup()
            var
                Location: Record Location;
                PurchaseLine: Record "Purchase Line";
                LocationList: Page "Location List";
            begin
                Rec."Location Code" := '';
                Clear(LocationList);
                Clear(PurchaseLine);
                Clear(Location);
                PurchaseLine.SetRange("BL/AWB ID", Rec."AWB ID");
                if PurchaseLine.FindFirst() then
                    repeat
                        Location.Get(PurchaseLine."Location Code");
                        Location.Mark(true);
                    until PurchaseLine.Next() = 0;

                Location.MarkedOnly(true);
                LocationList.SetTableView(Location);
                LocationList.LookupMode(true);
                IF LocationList.RunModal() = Action::LookupOK then begin
                    LocationList.SetSelectionFilter(Location);
                    if Location.FindSet() then
                        repeat
                            Rec."Location Code" += Location.Code + ' , ';
                        until Location.Next() = 0;
                end;
                If Rec."Location Code" <> '' then
                    Rec."Location Code" := CopyStr(Rec."Location Code", 1, StrLen(Rec."Location Code") - 3);
            end;
        }

        field(42; "Project No."; Text[1000])
        {
            trigger OnLookup()
            var
                Job: Record Job;
                PurchaseLine: Record "Purchase Line";
                JobList: Page "Job List";
            begin
                Rec."Project No." := '';
                Clear(JobList);
                Clear(PurchaseLine);
                Clear(Job);
                PurchaseLine.SetRange("BL/AWB ID", Rec."AWB ID");
                if PurchaseLine.FindFirst() then
                    repeat
                        Job.Get(PurchaseLine."Job No.");
                        Job.Mark(true);
                    until PurchaseLine.Next() = 0;

                Job.MarkedOnly(true);
                JobList.SetTableView(Job);
                JobList.LookupMode(true);
                IF JobList.RunModal() = Action::LookupOK then begin
                    JobList.SetSelectionFilter(Job);
                    if Job.FindSet() then
                        repeat
                            Rec."Project No." += Job."No." + ' , ';
                        until Job.Next() = 0;
                end;
                If Rec."Project No." <> '' then
                    Rec."Project No." := CopyStr(Rec."Project No.", 1, StrLen(Rec."Project No.") - 3);
            end;
        }
        field(43; "Invoiced Received Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Received Date';
        }
    }

    keys
    {
        key(Key1; "AWB ID")
        {
        }
        key(key2; "AWB Number")
        { }
    }


    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        "AWBDetails": Record "AWB Details";
        "No. Series": Codeunit "No. Series";
    begin
        if "AWB ID" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("AWB No. Series");
            if NoSeries.AreRelated(GLSetup."AWB No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."AWB No. Series";

            Rec."AWB ID" := NoSeries.GetNextNo(Rec."No. Series");

            //   end;
        end;
    end;
}
