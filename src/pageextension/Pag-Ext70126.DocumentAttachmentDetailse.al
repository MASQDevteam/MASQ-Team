pageextension 70126 "Document Attachment Details e" extends "Document Attachment Details"
{    //Atatchment default
    layout
    {
        // Add changes to page layout here
        addbefore(Name)
        {
            field("Attachment ID"; Rec."Attachment ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Attachment ID field.', Comment = '%';
                //  Editable = NOT Rec."to be removed"; 
                Editable = EditableID;
                Enabled = true;
            }
        }
        //AN 03/07/25
        addafter("File Type")
        {
            field(FileSizeTxt; Rec.FileSizeTxt)
            {
                ApplicationArea = All;
                Caption = 'File Size';
                Editable = false;
                ToolTip = 'The size of the file in KB or MB';
            }
        }

    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        EditableID := UserSetup."Can Edit Attachment ID";
    end;

    trigger OnAfterGetCurrRecord()
    var
        Project: Record Job;
        PurchaseOrder: Record "Purchase Header";
      //  FinanceDetails: Record "Finance Details";
        BLDetails: Record "BL Details";
        AWBDetails: Record "AWB Details";
        VariationOrder: Record "Variation Order";
        TravelRequest: Record "Travel Request";
        SQ: Record "Shipping Quotation";//added on 19032025
        TruckWayBill: Record "Truck WayBill"; //AN 04/03/2025
    begin
        IF Rec."Table ID" = Database::Job then begin
            Clear(Project);
            Project.Get(Rec."No.");
            Project."Attachment ID" := '';

            Project."Document Attachment Table ID" := 0;
            Project."Document Attachment No." := '';
            Project."Document Attachment Doc. Type" := Rec."Document Type"::Quote;
            Project."Document Attachment Line No." := 0;
            Project."Document Attachment ID" := 0;
            Project.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin


                Project."Attachment ID" := Rec."Attachment ID";

                Project."Document Attachment Table ID" := Rec."Table ID";
                Project."Document Attachment No." := Rec."No.";
                Project."Document Attachment Doc. Type" := Rec."Document Type";
                Project."Document Attachment Line No." := Rec."Line No.";
                Project."Document Attachment ID" := REc.ID;
                Project.Modify();
            end
        end;
        IF (Rec."Table ID" = Database::"Purchase Header") AND (Rec."Document Type" = Rec."Document Type"::Order) then begin
            Clear(PurchaseOrder);
            PurchaseOrder.Get(Rec."Document Type", Rec."No.");
            PurchaseOrder."Attachment ID" := '';

            PurchaseOrder."Document Attachment Table ID" := 0;
            PurchaseOrder."Document Attachment No." := '';
            PurchaseOrder."Document Attachment Doc. Type" := Rec."Document Type"::Quote;
            PurchaseOrder."Document Attachment Line No." := 0;
            PurchaseOrder."Document Attachment ID" := 0;
            PurchaseOrder.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                PurchaseOrder."Attachment ID" := Rec."Attachment ID";

                PurchaseOrder."Document Attachment Table ID" := Rec."Table ID";
                PurchaseOrder."Document Attachment No." := Rec."No.";
                PurchaseOrder."Document Attachment Doc. Type" := Rec."Document Type";
                PurchaseOrder."Document Attachment Line No." := Rec."Line No.";
                PurchaseOrder."Document Attachment ID" := REc.ID;
                PurchaseOrder.Modify();
            end
        end;

      /*  IF (Rec."Table ID" = Database::"Finance Details") then begin
            Clear(FinanceDetails);
            FinanceDetails.Get(Rec."No.");
            FinanceDetails."Attachment ID" := '';

            FinanceDetails."Document Attachment Table ID" := 0;
            FinanceDetails."Document Attachment No." := '';
            FinanceDetails."Document Attachment Doc. Type" := Rec."Document Type"::Quote;
            FinanceDetails."Document Attachment Line No." := 0;
            FinanceDetails."Document Attachment ID" := 0;
            FinanceDetails.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                FinanceDetails."Attachment ID" := Rec."Attachment ID";

                FinanceDetails."Document Attachment Table ID" := Rec."Table ID";
                FinanceDetails."Document Attachment No." := Rec."No.";
                FinanceDetails."Document Attachment Doc. Type" := Rec."Document Type";
                FinanceDetails."Document Attachment Line No." := Rec."Line No.";
                FinanceDetails."Document Attachment ID" := REc.ID;
                FinanceDetails.Modify();
            end
        end;*/

        IF (Rec."Table ID" = Database::"BL Details") then begin
            Clear(BLDetails);
            BLDetails.Get(Rec."No.");
            BLDetails."Attachment ID" := '';

            BLDetails."Document Attachment Table ID" := 0;
            BLDetails."Document Attachment No." := '';
            BLDetails."Document Attachment Doc. Type" := Rec."Document Type"::Quote;
            BLDetails."Document Attachment Line No." := 0;
            BLDetails."Document Attachment ID" := 0;
            BLDetails.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                BLDetails."Attachment ID" := Rec."Attachment ID";

                BLDetails."Document Attachment Table ID" := Rec."Table ID";
                BLDetails."Document Attachment No." := Rec."No.";
                BLDetails."Document Attachment Doc. Type" := Rec."Document Type";
                BLDetails."Document Attachment Line No." := Rec."Line No.";
                BLDetails."Document Attachment ID" := REc.ID;
                BLDetails.Modify();
            end
        end;

        IF (Rec."Table ID" = Database::"AWB Details") then begin
            Clear(AWBDetails);
            AWBDetails.Get(Rec."No.");
            AWBDetails."Attachment ID" := '';

            AWBDetails."Document Attachment Table ID" := 0;
            AWBDetails."Document Attachment No." := '';
            AWBDetails."Document Attachment Doc. Type" := Rec."Document Type"::Quote;
            AWBDetails."Document Attachment Line No." := 0;
            AWBDetails."Document Attachment ID" := 0;
            AWBDetails.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                AWBDetails."Attachment ID" := Rec."Attachment ID";

                AWBDetails."Document Attachment Table ID" := Rec."Table ID";
                AWBDetails."Document Attachment No." := Rec."No.";
                AWBDetails."Document Attachment Doc. Type" := Rec."Document Type";
                AWBDetails."Document Attachment Line No." := Rec."Line No.";
                AWBDetails."Document Attachment ID" := REc.ID;
                AWBDetails.Modify();
            end
        end;

        //AN 03/06/25
        IF (Rec."Table ID" = Database::"Variation Order") then begin
            Clear(VariationOrder);
            // VariationOrder.Get(Rec."No.");
            VariationOrder.SetRange(Number, Rec."No.");
            VariationOrder.FindFirst();
            VariationOrder."Attachment ID" := '';

            VariationOrder."Document Attachment Table ID" := 0;
            VariationOrder."Document Attachment No." := '';
            VariationOrder."Document Attachment Doc. Type" := Rec."Document Type"::Order;
            VariationOrder."Document Attachment Line No." := 0;
            VariationOrder."Document Attachment ID" := 0;
            VariationOrder.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                VariationOrder."Attachment ID" := Rec."Attachment ID";

                VariationOrder."Document Attachment Table ID" := Rec."Table ID";
                VariationOrder."Document Attachment No." := Rec."No.";
                VariationOrder."Document Attachment Doc. Type" := Rec."Document Type";
                VariationOrder."Document Attachment Line No." := Rec."Line No.";
                VariationOrder."Document Attachment ID" := REc.ID;
                VariationOrder.Modify();
            end
        end;

        //AN 03/11/25
        IF (Rec."Table ID" = Database::"Travel Request") then begin
            Clear(TravelRequest);
            // VariationOrder.Get(Rec."No.");
            TravelRequest.SetRange(Number, Rec."No.");
            TravelRequest.FindFirst();
            TravelRequest."Attachment ID" := '';

            TravelRequest."Document Attachment Table ID" := 0;
            TravelRequest."Document Attachment No." := '';
            TravelRequest."Document Attachment Doc. Type" := Rec."Document Type"::Order;
            TravelRequest."Document Attachment Line No." := 0;
            TravelRequest."Document Attachment ID" := 0;
            TravelRequest.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                TravelRequest."Attachment ID" := Rec."Attachment ID";

                TravelRequest."Document Attachment Table ID" := Rec."Table ID";
                TravelRequest."Document Attachment No." := Rec."No.";
                TravelRequest."Document Attachment Doc. Type" := Rec."Document Type";
                TravelRequest."Document Attachment Line No." := Rec."Line No.";
                TravelRequest."Document Attachment ID" := REc.ID;
                TravelRequest.Modify();
            end
        end;
        //updated on 20/03/2025 AI
        IF Rec."Table ID" = Database::"Shipping Quotation" then begin
            Clear(SQ);
            SQ.Get(Rec."No.");
            SQ."Attachment ID" := '';

            SQ."Document Attachment Table ID" := 0;
            SQ."Document Attachment No." := '';
            SQ."Document Attachment Doc. Type" := Rec."Document Type"::Quote;
            SQ."Document Attachment Line No." := 0;
            SQ."Document Attachment ID" := 0;
            SQ.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin


                SQ."Attachment ID" := Rec."Attachment ID";

                SQ."Document Attachment Table ID" := Rec."Table ID";
                SQ."Document Attachment No." := Rec."No.";
                SQ."Document Attachment Doc. Type" := Rec."Document Type";
                SQ."Document Attachment Line No." := Rec."Line No.";
                SQ."Document Attachment ID" := REc.ID;
                SQ.Modify();
            end
        end;
        //AN 04/03/2025
        IF (Rec."Table ID" = Database::"Truck WayBill") then begin
            Clear(TruckWayBill);
            // VariationOrder.Get(Rec."No.");
            TruckWayBill.SetRange("Truck WayBill ID", Rec."No.");
            TruckWayBill.FindFirst();
            TruckWayBill."Attachment ID" := '';

            TruckWayBill."Document Attachment Table ID" := 0;
            TruckWayBill."Document Attachment No." := '';
            TruckWayBill."Document Attachment Doc. Type" := Rec."Document Type"::Order;
            TruckWayBill."Document Attachment Line No." := 0;
            TruckWayBill."Document Attachment ID" := 0;
            TruckWayBill.Modify();
            IF (NOT Rec.HasContent()) AND (Rec."to be removed") then begin

                TruckWayBill."Attachment ID" := Rec."Attachment ID";

                TruckWayBill."Document Attachment Table ID" := Rec."Table ID";
                TruckWayBill."Document Attachment No." := Rec."No.";
                TruckWayBill."Document Attachment Doc. Type" := Rec."Document Type";
                TruckWayBill."Document Attachment Line No." := Rec."Line No.";
                TruckWayBill."Document Attachment ID" := REc.ID;
                TruckWayBill.Modify();
            end
        end;
    end;

    var
        EditableID: Boolean;
}
