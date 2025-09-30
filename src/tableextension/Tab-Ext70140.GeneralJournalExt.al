tableextension 70140 "General Journal Ext " extends "Gen. Journal Line"
{
    fields
    {
        field(70100; "Travel Request Code"; Code[20])
        {
            Caption = 'Travel Request Code';
            DataClassification = ToBeClassified;
            TableRelation = "Travel Request".Number;
        }
        field(70101; "Expense Category Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        //FQ MASQ **Start

        field(70103; "Related PO No."; Code[20])
        {
            Caption = 'Related PO No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Account Type" <> Rec."Account Type"::Vendor then
                    Error('Related PO No. is only allowed when Account Type is Vendor.');
            end;
        }

        field(70104; "Related SO No."; Code[20])
        {
            Caption = 'Related SO No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Account Type" <> Rec."Account Type"::Customer then
                    Error('Related SO No. is only allowed when Account Type is Customer.');
            end;
        }
        //FQ MASQ **End
    }
}
