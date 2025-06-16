tableextension 70128 "Transfer Order Lines  ext" extends "Transfer Line"
{
    fields
    {
        // Add changes to table fields here
        field(70100; "MASQ Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Supply Chain LOG"."PO Number" where("Item Number" = field("Item No."), "Location Code" = field("Transfer-from Code"), "Batch Number" = filter('<> '''''));
            //  ValidateTableRelation = false;
            // Editable = false;


        }
        field(70101; "MASQ Purchase Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70102; "Batch Number";
        Code[50])
        {
            DataClassification = ToBeClassified;
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
            begin
                IF Rec."Item No." <> xRec."Item No." then begin
                    Rec."MASQ Purchase Order Line No." := 0;
                    Rec."MASQ Purchase Order No." := '';
                    Rec."Batch Number" := ''
                end;
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

    var
        myInt: Integer;
}