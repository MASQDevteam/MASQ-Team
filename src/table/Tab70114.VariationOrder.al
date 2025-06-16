table 70114 "Variation Order"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Number"; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Project Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('PROJECT'));
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record Job;
            begin

                IF "Project Code" <> '' then begin
                    Clear(Job);
                    Job.Get("Project Code");
                    Rec.Validate("Apollo project Number", Job."Apollo Project Number");
                end;

                UpdateVORemark;
            end;
        }
        field(3; "Item Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where("Sales Blocked" = const(false), Blocked = const(false));

            trigger
            OnValidate()
            var
                ItemRec: Record Item;
            begin
                IF Rec."Item Number" <> '' then begin
                    Clear(ItemRec);
                    ItemRec.Get(rec."Item Number");
                    Rec."Vendor Item Code" := ItemRec."Meg Vendor Item Code";
                end;
                UpdateVORemark;
            end;
        }
        field(4; "Variation Action(Replace Item)"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Variation Action(Change Qty)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Variation Action(Change Price)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Variation Action(Change UOM)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "New Item Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where("Sales Blocked" = const(false), Blocked = const(false));

            trigger OnValidate()
            var
                ItemRec: Record Item;
            begin

                IF Rec."New Item Number" <> '' then begin
                    Clear(ItemRec);
                    ItemRec.Get(rec."New Item Number");
                    Rec."New Vendor Item Code" := ItemRec."Meg Vendor Item Code";
                end;


                UpdateVORemark;
            end;
        }
        field(9; "New Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                UpdateVORemark;
            end;
        }
        field(10; "New Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                UpdateVORemark;

            end;
        }
        field(11; "New UOM"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Unit of Measure".Code where
            ("Item No." = field("Item Number"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
            begin
                UpdateVORemark;
            end;
        }
        field(12; "Remarks"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Executed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Status; Enum "Variation Document Status")
        {
            Caption = 'Status';
            //  Editable = false;
        }
        field(15; "Variation Action(Add Item)"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Sales Order No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Variation Action(Change Cost)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "New Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                UpdateVORemark;
            end;
        }
        field(20; "Cost Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Absorb Cost","Charge New Cost";
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
        field(33; "MASQ Item Type"; Code[20])//added on 25/03/2025
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                UpdateVORemark;
            end;
        }
        field(34; "Currency Code"; Code[20])//added on 25/03/2025
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
            trigger OnValidate()
            var
            begin
                UpdateVORemark;
            end;
        }
        field(35; "Apollo project Number"; code[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                UpdateVORemark;

            end;
        }
        field(36; "Email Address"; Text[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(37; "Vendor Item Code"; Text[50])
        {

        }
        field(38; "New Vendor Item Code"; Text[50])
        {

        }
    }

    keys
    {
        key(Key1; "Number", "Item Number")
        {
            Clustered = true;
        }
        key(key2; Number, executed, status)
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        MASQEmail: Codeunit "MASQ Email";
        USer: Record User;

    trigger OnInsert()
    var
        Job: Record Job;
    begin
        //USer.Get(UserId);
        // MASQEmail.SendEmailVariationOrder(Rec);
        IF "Project Code" <> '' then begin
            Clear(Job);
            Job.Get("Project Code");
            Rec."Apollo project Number" := Job."Apollo Project Number";

        end;

        UpdateVORemark;
        //modified by aya on 6/10/2025
        MASQEmail.SendEmailVariationOrder(Rec);
    end;

    trigger OnModify()
    var
        Job: Record Job;
    begin


        IF "Project Code" <> '' then begin
            Clear(Job);
            Job.Get("Project Code");
            Rec."Apollo project Number" := Job."Apollo Project Number";

        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    Local procedure UpdateVORemark()
    var
    begin
        IF REc."Variation Action(Change UOM)" then
            rec.Remarks := StrSubstNo('change the UOM to %1 for Item %2 on Project number %3', REc."New UOM", Rec."Vendor Item Code", Rec."Apollo PRoject Number");

        IF REc."Variation Action(Replace Item)" then
            rec.Remarks := StrSubstNo('Replace the Item %1 with Item %2 on Project number %3', REc."Vendor Item Code", Rec."New Vendor Item Code", Rec."Apollo PRoject Number");

        IF REc."Variation Action(Change Price)" then
            rec.Remarks := StrSubstNo('change the Price to %1 for Item %2 on Project number %3', REc."New Price", Rec."Vendor Item Code", Rec."Apollo PRoject Number");

        IF REc."Variation Action(Change Qty)" then
            rec.Remarks := StrSubstNo('change the Quantity to %1 for Item %2 on Project number %3', REc."New Qty", Rec."Vendor Item Code", Rec."Apollo PRoject Number");

        IF REc."Variation Action(Change Cost)" then
            rec.Remarks := StrSubstNo('change the Cost to %1 for Item %2 on Project number %3', REc."New Cost", Rec."Vendor Item Code", Rec."Apollo PRoject Number");

        IF Rec."Variation Action(Add Item)" then
            rec.Remarks := StrSubstNo('add Item %1 with Quantity of %2 @Cost %3  %4, @Selling price %5 and item Type equal to %6 ', Rec."New Vendor Item Code", Rec."New Qty", Rec."New Cost", Rec."Currency Code", Rec."New Price", Rec."MASQ Item Type");


    end;

}