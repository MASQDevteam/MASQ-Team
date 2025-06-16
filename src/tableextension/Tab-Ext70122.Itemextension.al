tableextension 70122 "Item extension" extends Item
{
    fields
    {
        field(70100; "MASQ Thumbnail"; BLOB)
        {
            Caption = 'Thumbnail';
            SubType = Bitmap;
        }
        field(70101; "MASQ Sub Group"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(70102; "MASQ Cover Color"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(70103; "MASQ Luminous Flux (Lm)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(70104; "MASQ IP Rating"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(70105; "MASQ Optic/Diffuser"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(70106; "MASQ Main Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70107; "Viewing Distance"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70108; Lifespan; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70109; "Vendor Custom Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "Apollo Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        // modify("Meg Vendor Item Code")
        // {

        //     trigger OnAfterValidate()
        //     var
        //     begin
        //         Clear(ItemRec);
        //         ItemRec.SetRange("Meg Vendor Item Code", Rec."Meg Vendor Item Code");
        //         ItemRec.SetFilter("No.", '<> %1', Rec."No.");

        //         IF ItemRec.FindFirst() then
        //             Error('Vendor item Code already exist in this database');
        //     end;
        // }
    }


    var
        ItemRec: Record Item;
}