
table 70128 "Truck WayBill"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Truck WayBill"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line"; Code[50])
        {
            TableRelation = "MASQ Lookup".Code where(Type = const(Liner));
        }
        field(3; "Free Demurrage Days"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Voyage Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Cargo Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Origin"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const(Origin));
        }
        field(7; "Port of Loading"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
        }
        field(8; "Port of Discharge"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
        }
        field(9; "Waybill Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Clearing Agent"; code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Vendor where(Category = const('SHIPPING&CLEARING'));
        }
        field(11; "Docs Sent to Entity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Docs Received in Entity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Docs AWB No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Copy Docs Sent to Agent Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Docs Delivered to Clearing Agent"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Assessment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Duty Paid Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Duty Receipt sent to agent"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Truck WayBill ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;

        }
        field(22; "Shipping Quotation Reference"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Quotation";
        }
        field(37; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Document Attachment ID"; Integer)
        {

        }
        field(39; "Document Attachment Table ID"; Integer)
        {

        }
        field(40; "Document Attachment No."; Code[20])
        {

        }
        field(41; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(42; "Document Attachment Line No."; Integer)
        {
        }
        field(43; "PO No."; Text[1000])
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
                PurchaseLine.SetRange("Truck WayBill ID", Rec."Truck WayBill ID");
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
        field(44; "Location Code"; Text[1000])
        {
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
                PurchaseLine.SetRange("Truck WayBill ID", Rec."Truck WayBill ID");
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

        field(45; "Project No."; Text[1000])
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
                PurchaseLine.SetRange("Truck WayBill ID", Rec."Truck WayBill ID");
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
        field(46; "In Land"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "From Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(48; "To Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(49; "Invoiced Received Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Received Date';
        }
        field(50; "WayBill Type"; Option)
        {
            OptionMembers = " ","Express","Cargo","MASQ";
        }
        field(51; "Agent"; Option)
        {
            OptionMembers = " ","Net weight","Gross","Volumetric";
        }
        field(52; "Packing Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }
    }

    keys
    {
        key(PK; "Truck WayBill ID")
        { }
    }
}
