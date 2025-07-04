table 70108 "BL Details"
//Created on 28/10/2024 with Nathalie


{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Liner"; Code[50])
        {
            Caption = 'Liner';
            // Set up a lookup to your master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Liner));
        }
        field(2; "Free Demurrage Days"; Integer)
        {
            Caption = 'Free Demurrage Days';
            // Set up a lookup to your vessel/airline master table here
        }
        field(3; "Vessel"; Text[100])
        {
            Caption = 'Vessel';
        }
        field(4; "Voyage Number"; Text[50])
        {
            Caption = 'Voyage Number';
        }
        field(5; "Cargo Description"; Text[250])
        {
            Caption = 'Cargo Description';
        }
        field(6; "Origin"; Code[50])
        {
            Caption = 'Origin';
            // Set up a lookup to your origin master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Origin));
        }
        field(7; "Port of Loading"; Code[50])
        {
            Caption = 'Port of Loading';
            // Set up a lookup to your port master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Port), ORIGINS = field(Origin));
        }
        field(8; "Port of Discharge"; Code[50])
        {
            Caption = 'Port of Discharge';
            // Set up a lookup to your port master table here
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
        }
        field(9; "BL"; Date)
        {
            Caption = 'BL';
        }
        field(10; "Clearing Agent"; Code[50])
        {
            Caption = 'Clearing Agent';
            //
            //Drop down can be handled with lookup
            // TableRelation = "MASQ Lookup".Code where(Type = const("Clearing Agent")); 
            TableRelation = Vendor where(Category = const("SHIPPING & CLEARING"));
        }
        field(11; "Docs Sent to Entity Date"; Date)
        {
            Caption = 'Docs Sent to Entity Date';
        }
        field(12; "Docs Received in Entity Date"; Date)
        {
            Caption = 'Docs Received in Entity Date';
        }
        field(13; "Docs AWB No"; Text[50])
        {
            Caption = 'Docs AWB No';
        }
        field(14; "Copy Docs Sent to Agent Date"; Date)
        {
            Caption = 'Copy Docs Sent to Agent Date';
        }
        field(15; "Docs Delivered to Clearing Agent"; Date)
        {
            Caption = 'Docs Delivered to Clearing Agent';
        }
        field(16; "Assessment Date"; Date)
        {
            Caption = 'Assessment Date';
        }
        field(17; "Duty Paid Date"; Date)
        {
            Caption = 'Duty Paid Date';
        }
        field(18; "Duty Receipt sent to agent"; Date)
        {
            Caption = 'Duty Receipt sent to agent';
        }
        field(19; "Remarks"; Text[500])
        {
            Caption = 'Remarks';
        }

        field(23; "Loading Type"; Option)
        {
            OptionMembers = LCL,FCL; // Add more options if needed
        }
        field(24; "Transshipment"; Option)
        {
            OptionMembers = "Yes","No"; // Add more options if needed
        }
        field(25; "BL ID"; Code[20])
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
        field(33; "BL Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Agent"; Code[50])
        {
            Caption = 'Agent';
            //
            //Drop down can be handled with lookup
            TableRelation = "MASQ Lookup".Code where(Type = const("Agent"));
        }
        // field(34; "Container ID"; Code[50])
        // {
        //     //  DataClassification = ToBeClassified;

        //     //    FieldClass = FlowField;
        //     //  CalcFormula = lookup("Container Details"."Container ID" where("BL ID" = field("BL ID"), Selected = const(true)));
        // }
        field(35; "Shipping Quotation Reference"; Code[50])
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
                PurchaseLine.SetRange("BL/AWB ID", Rec."BL ID");
                if PurchaseLine.FindFirst() then
                    repeat
                        if PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then
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
                PurchaseLine.SetRange("BL/AWB ID", Rec."BL ID");
                if PurchaseLine.FindFirst() then
                    repeat
                        if Location.Get(PurchaseLine."Location Code") then
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
                PurchaseLine.SetRange("BL/AWB ID", Rec."BL ID");
                if PurchaseLine.FindFirst() then
                    repeat
                        if Job.Get(PurchaseLine."Job No.") then
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
        field(44; "Transhipment Port"; Text[1000])
        {
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                MASQLookupRec: Record "MASQ Lookup";
                MASQLookup: Page "MASQ Lookup";
            begin
                Rec."Transhipment Port" := '';
                Clear(MASQLookupRec);
                MASQLookupRec.SetRange(Type, MASQLookupRec.Type::"Port");
                MASQLookup.SetTableView(MASQLookupRec);
                MASQLookup.LookupMode(true);
                IF MASQLookup.RunModal() = Action::LookupOK then begin
                    MASQLookup.SetSelectionFilter(MASQLookupRec);
                    if MASQLookupRec.FindSet() then
                        repeat
                            Rec."Transhipment Port" += MASQLookupRec.Code + ' , ';
                        until MASQLookupRec.Next() = 0;

                end;
                If Rec."Transhipment Port" <> '' then
                    Rec."Transhipment Port" := CopyStr(Rec."Transhipment Port", 1, StrLen(Rec."Transhipment Port") - 3);
            end;
        }
    }

    keys
    {
        key(Key1; "BL ID")
        {
        }
        key(key2; "BL Number")
        { }
    }


    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        "BL": Record "BL Details";
    begin
        if "BL ID" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("BL No. Series");

            if NoSeries.AreRelated(GLSetup."BL No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."BL No. Series";

            Rec."BL ID" := NoSeries.GetNextNo(Rec."No. Series");

            //   end;
        end;
    end;
}
