table 70111 "Finance Details"
//Created on 28/10/2024 with Nathalie


{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Issuing Bank LC #"; Text[50])
        {
            Caption = 'Issuing Bank LC #';
        }
        field(2; "LC Value"; Decimal)
        {
            Caption = 'LC Value';
        }
        field(3; "Bank Name"; code[20])
        {
            Caption = 'Bank Name';
            TableRelation = "Bank Account";
            // Set up a lookup to your bank master table here
        }
        field(4; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }
        field(5; "Latest Date of Shipment"; Date)
        {
            Caption = 'Latest Date of Shipment';
        }
        field(6; "Payment Terms"; Code[10])
        {
            Caption = 'Payment Terms';


            //  OptionMembers = Cash,Credit; // Add your specific options here
            TableRelation = "Payment Terms";
        }
        field(7; "LC Type"; Option)
        {
            Caption = 'LC Type';
            OptionMembers = Sight,Usance; // Add your specific options here
        }
        field(8; "Confirmation"; Option)
        {
            Caption = 'Confirmation';
            OptionMembers = Yes,No; // Add your specific options here
        }
        field(9; "Draw Down"; Integer)
        {
            Caption = 'Draw Down';
            //    FieldClass = FlowField;
            //   TableRelation = "Purchase Line"."BL/AWB ID" where("Document No." = field("Document No."));
            Editable = false;
        }
        field(10; "Docs sent to bank"; Date)
        {
            Caption = 'Docs sent to bank';
        }
        field(11; "Docs received in Bank"; Date)
        {
            Caption = 'Docs received in Bank';
        }
        field(12; "# of Amendment"; Integer)
        {
            Caption = '# of Amendment';
            // Define logic for count of attached amendments
        }
        // field(13; "Document Type"; Enum "Purchase Document Type")
        // {
        //     Caption = 'Document Type';
        // }
        field(14; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = IF ("LC Line" = const(Export)) "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field(Beneficiary)) ELSE
            IF ("LC Line" = const(Import)) "Sales Header"."No." where("Document Type" = const(Order), "Sell-to Customer No." = field("LC Applicant"));

            trigger OnValidate()
            var
                SO: Record "Sales Header";
                PO: Record "Purchase Header";
                POlinkedtoBLAWB: Record "Purchase Line";
            begin
                Clear(so);
                Clear(po);
                IF "LC Line" = "LC Line"::Import then begin
                    so.Get(so."Document Type"::Order, "Document No.");
                    so.CalcFields(Amount);
                    "Document Amount" := so.Amount;
                end;
                IF "LC Line" = "LC Line"::Export then begin
                    PO.Get(PO."Document Type"::Order, "Document No.");
                    PO.CalcFields(Amount);
                    "Document Amount" := PO.Amount;


                    Clear(POlinkedtoBLAWB);
                    POlinkedtoBLAWB.SetRange("Document Type", POlinkedtoBLAWB."Document Type"::Order);
                    POlinkedtoBLAWB.SetRange("Document No.", Rec."Document No.");
                    POlinkedtoBLAWB.SetFilter("BL/AWB ID", '<> %1', '');
                    Rec."Draw Down" := POlinkedtoBLAWB.Count;
                end;


            end;

            /*   trigger OnLookup()
               var
                   POlinkedtoBLAWB: Record "Purchase Line";
               begin
                   Clear(POlinkedtoBLAWB);
                   POlinkedtoBLAWB.SetRange("Document Type", POlinkedtoBLAWB."Document Type"::Order);
                   POlinkedtoBLAWB.SetRange("Document No.", Rec."Document No.");
                   POlinkedtoBLAWB.SetFilter("BL/AWB ID", '<> %1', '');
                   //  Rec."Draw Down" := POlinkedtoBLAWB.Count;
                   Page.Run(Page::"Purchase Lines", POlinkedtoBLAWB);
               end;*/
        }
        field(15; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(16; "LC Line"; Option)
        {
            OptionMembers = " ",Import,Export;
        }
        field(17; "LC Applicant"; Text[20])
        {
            TableRelation = IF ("LC Line" = const(Export)) "MASQ Lookup".Code where("Type" = const("LC Applicant")) ELSE
            IF ("LC Line" = const(Import)) Customer;
        }

        field(18; "Beneficiary"; Text[20])
        {
            TableRelation = IF ("LC Line" = const(Export)) vendor ELSE
            IF ("LC Line" = const(Import)) "MASQ Lookup".Code where("Type" = const(Beneficiary));
        }
        field(19; "Docs Sent to Intermediary Bank"; Date)
        {
            // Optional: Data classification
        }


        field(20; "Docs AWB"; Text[50])
        {
            // Optional: Data classification
        }
        field(21; "Finance Rate"; Decimal)
        {
            // Use this for percentage, could have validation for range
        }
        field(22; "LC Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;


        }
        field(24; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Document Attachment ID"; Integer)
        {

        }
        field(26; "Document Attachment Table ID"; Integer)
        {

        }
        field(27; "Document Attachment No."; Code[20])
        {

        }
        field(28; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(29; "Document Attachment Line No."; Integer)
        {
        }
        field(30; "Document Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }



    keys
    {
        key(Key1; "LC Number")
        {
        }
    }
    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        //NoSeriesManagement: Codeunit NoSeriesManagement; //FQ MASQ
        "LC": Record "Finance Details";
        DocumentAttachment: Record "Document Attachment";
    //  NoSeries: Codeunit "No. Series";
    begin
        if Rec."LC Number" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("LC No. Series");
            if NoSeries.AreRelated(GLSetup."LC No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."LC No. Series";

            Rec."LC Number" := NoSeries.GetNextNo(Rec."No. Series");


        end;
    end;

}

