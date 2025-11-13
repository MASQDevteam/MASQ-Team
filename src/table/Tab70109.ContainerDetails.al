table 70109 "Container Details"
{//Created on 28/10/2024 with Nathalie


    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Type of Goods"; Option)
        {
            Caption = 'Type of Goods';
            OptionMembers = CKD,Other; // Define the options here
        }
        field(2; "Seal Number"; Text[50])
        {
            Caption = 'Seal Number';
        }
        field(3; "Fitting"; code[50])
        {
            Caption = 'Fitting';
            // Set up a lookup to your fitting master table here 
            TableRelation = "MASQ Lookup".Code where(Type = const(Fitting));
        }
        field(4; "Loaded On Board"; Date)
        {
            Caption = 'Loaded On Board';
        }
        field(5; "Terminal Delivery Order Date"; Date)
        {
            Caption = 'Terminal Delivery Order Date';
        }
        field(6; "Remarks"; Text[500])
        {
            Caption = 'Remarks';
        }
        field(7; "Final ETR"; Date)
        {
            Caption = 'Final ETR';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                // IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."BL ID");
                PurchaseLine.SetRange("Container ID", Rec."Container ID");
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."BL ID";
                            ShippingDateLOG."Container Number" := Rec."Container ID";
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
        field(8; "Final ETD"; Date)
        {
            Caption = 'Final ETD';
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                // IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."BL ID");
                PurchaseLine.SetRange("Container ID", Rec."Container ID");
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."BL ID";
                            ShippingDateLOG."Container Number" := Rec."Container ID";
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
        field(9; "Final ETA"; Date)
        {
            Caption = 'Final ETA';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                //  IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."BL ID");
                PurchaseLine.SetRange("Container ID", Rec."Container ID");
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."BL ID";
                            ShippingDateLOG."Container Number" := Rec."Container ID";
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
        field(10; "ATA"; Date)
        {
            Caption = 'ATA';
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                //  IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."BL ID");
                PurchaseLine.SetRange("Container ID", Rec."Container ID");
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."BL ID";
                            ShippingDateLOG."Container Number" := Rec."Container ID";
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
        field(11; "Final ETAW"; Date)
        {
            Caption = 'Final ETAW';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ShippingDateLOG: Record "Supply Chain LOG";
            begin
                // IF Rec."Final ETR" <> 0D then begin
                Clear(PurchaseLine);
                PurchaseLine.SetRange("BL/AWB ID", Rec."BL ID");
                PurchaseLine.SetRange("Container ID", Rec."Container ID");
                //   PurchaseLine.ModifyAll("Final ETR", REc."Final ETR");


                if PurchaseLine.FindSet() then
                    repeat
                        IF (Rec.ATA <> 0D) AND (Rec."Final ETA" <> 0D) AND (Rec."Final ETAW" <> 0D) AND (Rec."Final ETD" <> 0D) AND (Rec."Final ETR" <> 0D) then begin
                            Clear(ShippingDateLOG);
                            ShippingDateLOG.Init();
                            ShippingDateLOG."BL/AWB ID" := Rec."BL ID";
                            ShippingDateLOG."Container Number" := Rec."Container ID";
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
        // field(20; "PO Type"; Enum "Purchase Document Type")
        // {
        //     Caption = 'Document Type';
        // }
        // field(21; "PO No."; Code[20])
        // {
        //     Caption = 'Document No.';
        //     TableRelation = "Purchase Header"."No." where("Document Type" = field("PO Type"));
        // }
        // field(22; "Line No."; Integer)
        // {
        //     Caption = 'Line No.';
        // }
        field(23; "ROC Date"; Date) { }
        // field(24; "BL Reference"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(25; "SP ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Container ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "BL ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;


        }
        field(29; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Transit Time"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Final Transit Time"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "BL ID", "Line No.")
        {
        }
        key(key2; "SP ID")
        { }
    }


    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        //NoSeriesManagement: Codeunit NoSeriesManagement;
        "ContainerDetails": Record "Container Details";
    begin
        if "SP ID" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("SP ID No. Series");

            if NoSeries.AreRelated(GLSetup."SP ID No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."SP ID No. Series";

            Rec."SP ID" := NoSeries.GetNextNo(Rec."No. Series");
        end;
    end;
}
