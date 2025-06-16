table 70125 "Transitory Reference"
{
    DataClassification = ToBeClassified;

    fields
    {
        // Transitory Reference Field (Primary Key)
        field(2; "Transitory Reference"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "PO #"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = const(Order));

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
            begin
                IF (Rec."PO #" <> '') AND (Rec."Item #" <> '') then begin
                    Clear(PurchaseLine);
                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SetRange("Document No.", REc."PO #");
                    PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    PurchaseLine.SetRange("No.", Rec."Item #");
                    IF PurchaseLine.FindFirst() then begin
                        Rec.QTY := PurchaseLine.Quantity - PurchaseLine."Quantity Received";
                        Rec."Unit Price" := PurchaseLine."Direct Unit Cost";
                        Rec."Total Value" := PurchaseLine."Line Amount";
                    end;
                end;
            end;
        }

        field(4; "Item #"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("PO #" = filter('<>''''')) "Purchase Line"."No." where("Document Type" = const(Order), type = const(item), "Document No." = field("PO #")) ELSE
            Item;
            ValidateTableRelation = false;
        }

        field(5; "QTY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Total Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Supplier Claim Reference"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Supplier"; Code[50])
        {
            DataClassification = ToBeClassified;
            tablerelation = Vendor;
        }

        field(10; "Status"; Option)
        {
            OptionCaption = 'Open,Accepted,Rejected';
            OptionMembers = Open,Accepted,Rejected;
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Transitory Reference")
        {
            Clustered = true;
        }

        key(FK_JobLink; "PO #", "Item #")
        {
            Clustered = false;
        }
    }


    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        GLSetup: Record "General Ledger Setup";

    //  NoSeries: Codeunit "No. Series";
    begin
        if Rec."Transitory Reference" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("Transitory No. Series");
            if NoSeries.AreRelated(GLSetup."Transitory No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."Transitory No. Series";

            Rec."Transitory Reference" := NoSeries.GetNextNo(Rec."No. Series");


        end;
    end;
}
