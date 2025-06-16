tableextension 70118 "Sales inv. header extension" extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here

        field(70100; "MASQ Delivery Order No."; Code[20])
        {
            Caption = 'Delivery Order No.';
            Description = 'Used in Delivery Order report';

        }
        field(70101; "Pro-Forma Description"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Apollo Total Offer Value"; Decimal)
        {
            DataClassification = ToBeClassified;
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
    // trigger OnInsert()
    // var
    // begin

    //     if (Rec."MASQ Delivery Order No." = '') then begin
    //         SalesSetup.Get();
    //         SalesSetup.TestField("MASQ Delivery Order Nos.");
    //         NoSeriesMgt.InitSeries(SalesSetup."MASQ Delivery Order Nos.", xRec."No. Series", Rec."Posting Date", REc."MASQ Delivery Order No.", Rec."No. Series");

    //     end;
    // end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;


}