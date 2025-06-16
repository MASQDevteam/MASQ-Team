table 70115 "Intermediate Items"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "No. 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Search Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Updated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }

        field(7; "Supplier Currency"; Code[30])
        {
            Caption = 'Supplier Currency';
            TableRelation = Currency;
        }

        field(8; "Base Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }

        field(9; "Type"; Enum "Item Type")
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Inventory Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group";
        }

        field(11; "HS Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Meg Attributes".Value where(Type = const('HS CODE'));

        }

        field(12; "Length in mm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Width in mm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Height in mm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Costing Method"; Enum "Costing Method")
        {
            DataClassification = ToBeClassified;
        }

        field(17; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }

        field(19; "Brand"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRAND'));
        }

        field(20; "Vendor Item No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        // field(21; "Vendor Item Code"; Code[20])//duplicate
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(22; "Family"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Sub Group"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Main Group"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }

        field(26; "Gear / Ballast"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // field(27; "Thumbnail"; Blob)
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(28; "Quick Description"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(29; "Supply Power"; Text[100])//obselete
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(30; "Supply Current"; Text[100])//obselete
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(31; "Installation"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(32; "Driver"; Text[50])
        {
            Caption = 'Driver';
            TableRelation = "Meg Attributes".Value where(Type = const('DRIVER'));
            ValidateTableRelation = false;
        }

        field(33; "Housing"; Code[50])
        {
            Caption = 'Housing';
            TableRelation = "Meg Attributes".Value where(Type = const('HOUSING'));
            ValidateTableRelation = false;
        }

        field(34; "Reflector"; Code[50])
        {
            Caption = 'Reflector';
            TableRelation = "Meg Attributes".Value where(Type = const('REFLECTOR'));
            ValidateTableRelation = false;
        }

        field(35; "Optic/Diffuser"; Code[50])
        {
            Caption = 'Diffuser';
            TableRelation = "Meg Attributes".Value where(Type = const('DIFFUSER'));
            ValidateTableRelation = false;
        }

        field(36; "Frame"; Code[50])
        {
            Caption = 'Frame';
            ValidateTableRelation = false;
            TableRelation = "Meg Attributes".Value where(Type = const('FRAME'));
        }

        field(37; "Bracket"; Code[50])
        {
            Caption = 'Bracket';
            ValidateTableRelation = false;
            TableRelation = "Meg Attributes".Value where(Type = const('BRACKET'));
        }

        field(38; "IP Rating"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(39; "Beam Type"; Code[50])
        {
            Caption = 'Beam Type';
            ValidateTableRelation = false;
            TableRelation = "Meg Attributes".Value where(Type = const('BEAM TYPE'));
        }

        field(40; "Fitting Color"; Code[50])
        {
            ValidateTableRelation = false;
            TableRelation = "Meg Attributes".Value where(Type = const('FITTING COLOR'));
            Caption = 'Fitting Color';
        }

        field(41; "CRI"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(42; "Beam Angle"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // field(43; "Lamp"; Code[20])//obselete
        // {
        //     Caption = 'Lamp';
        //     ValidateTableRelation = false;
        //     TableRelation = "Meg Attributes".Value where(Type = const('LAMP'));
        // }

        field(44; "Lamp Source"; Code[30])
        {
            Caption = 'Lamp Source';
            ValidateTableRelation = false;
            TableRelation = "Meg Attributes".Value where(Type = const('LAMP SOURCE'));
        }

        field(45; "Base"; Code[50])
        {
            Caption = 'Base';
            ValidateTableRelation = false;
            TableRelation = "Meg Attributes".Value where(Type = const('BASE'));
        }

        field(46; "Color Temp"; Code[50])
        {
            Caption = 'Color Temp';
            ValidateTableRelation = false;
            TableRelation = "Meg Attributes".Value where(Type = const('COLOR TEMP'));
        }

        field(47; "Lamps Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(48; "Wattage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(49; "Total Wattage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50; "Voltage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        // field(51; "Net Lumen"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(52; "LED Lumen"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(53; "Shape"; Code[50])
        {
            Caption = 'Shape';
            ValidateTableRelation = false;
            TableRelation = "Meg Attributes".Value where(Type = const('SHAPE'));
        }

        field(54; "Diameter in mm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(55; "Cutout Length"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(56; "Cutout Width"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(57; "Cutout Height"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(58; "Cutout Diameter"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(59; "Cover Color"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(60; "Luminous Flux (Lm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }



        field(63; "Viewing Distance"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(64; "Lifespan"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(65; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Vendor Custom Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Dynamics Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "API Status"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "LOB"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('LOB'));
        }
        field(70; "Apollo User Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Project Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Job;
        }
        field(72; "Apollo Project Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Comments to Apollo"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(74; MASQ_Picture; MediaSet)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
        }
        field(75; "Gen. Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    //AN 03/05/25 
    trigger OnInsert()
    begin
        MASQEmail.SendEmailIntermediateItem(Rec);
    end;

    // trigger OnModify()
    // var
    //     myInt: Integer;
    // begin
    //     MASQEmail.SendEmailIntermediateItem(Rec);
    // end;

    var
        MASQEmail: Codeunit "MASQ Email";

    /*   trigger OnInsert()
       var
           ItemRec: Record Item;
       begin
           IF Rec."Vendor Item No." <> '' then begin
               Clear(ItemRec);
               ItemRec.SetRange("Meg Vendor Item Code", Rec."Vendor Item No.");
               IF ItemRec.FindFirst() then
                   Error('Vendor item Code already exist in this database');
           end
       end;

       trigger OnModify()
       var
           ItemRec: Record Item;
       begin
           IF Rec."Vendor Item No." <> '' then begin
               Clear(ItemRec);
               ItemRec.SetRange("Meg Vendor Item Code", Rec."Vendor Item No.");
               IF ItemRec.FindFirst() then
                   Error('Vendor item Code already exist in this database');
           end

       end;*/
    // procedure SetPictureFromBlob(TempBlob: Codeunit "Temp Blob")
    // var
    //     RecordRef: RecordRef;
    // begin
    //     RecordRef.GetTable(Rec);
    //     TempBlob.ToRecordRef(RecordRef, FieldNo(MASQ_Picture));
    //     RecordRef.SetTable(Rec);
    // end;

    var
        PictureUpdated: Boolean;
}
