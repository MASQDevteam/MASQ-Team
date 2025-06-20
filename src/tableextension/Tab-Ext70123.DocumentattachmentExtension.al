tableextension 70123 "Document attachment Extension" extends "Document Attachment"
{    //Atatchment default
    fields
    {
        // Add changes to table fields here
        field(70100; "Attachment ID"; text[50])//Added on 29/10/2024 for init of attachment on the modules
        {
            DataClassification = ToBeClassified;
        }
        field(70101; "to be removed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Attachment Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //AN 03/07/25
        field(70103; FileSizeTxt; Text[100])
        {
            Caption = 'File Size';
            Editable = false;
            DataClassification = CustomerContent;
        }
        // modify("File Name")
        // {

        // trigger OnBeforeValidate()
        // var
        // begin
        //     Message(Rec."Attachment ID");
        // end;
        //}

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    //AN 03/07/25
    trigger OnInsert()
    var
        myInt: Integer;
    begin

    end;

    trigger OnAfterInsert()
    var
        FinanceDetails: Record "Finance Details";
    begin
        IF Rec."Table ID" = Database::"Finance Details" then begin
            FinanceDetails.Get(Rec."No.");
            Clear(DocumentAttachment1);
            DocumentAttachment1.SetRange("Table ID", Database::"Finance Details");
            DocumentAttachment1.SetRange("No.", Rec."No.");
            DocumentAttachment1.SetFilter("File Name", '<> %1', '');
            FinanceDetails."# of Amendment" := DocumentAttachment1.Count;
            FinanceDetails.Modify();
        end;
    end;

    var
        myInt: Integer;
        DocumentAttachment: page "Document Attachment Details";
        DocumentAttachment1: Record "Document Attachment";
}