table 70107 "PO Import Buffer"
{
    Caption = 'PO Import Buffer';
    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header"."No." where("Document Type" = field("Document Type"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Enum "Purchase Line Type")
        {
            Caption = 'Type';
        }

        field(6; "No."; Code[20])
        {
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }

        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {
        }
        field(103; "Line Amount"; Decimal)
        {
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(10; "Expected Receipt Date"; Date)
        { }
        field(5794; "Planned Receipt Date"; Date)
        {
        }
        field(5791; "Promised Receipt Date"; Date)
        {
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';

        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
        }

        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
        }
        field(42; "Shortcut Dimension 3 Code"; Code[20])
        {
        }
        field(43; "Shortcut Dimension 4 Code"; Code[20])
        {
        }
        field(44; "Shortcut Dimension 5 Code"; Code[20])
        {
        }
        field(45; "Shortcut Dimension 6 Code"; Code[20])
        {
        }
        field(46; "Shortcut Dimension 7 Code"; Code[20])
        {
        }
        field(47; "Shortcut Dimension 8 Code"; Code[20])
        {
        }
        field(48; MODIFIED; Boolean)
        {
        }
        field(49; "ITEM TYPE"; Code[20])
        {
        }
        field(50; "Initial ETR"; Date)//Created on 28/10/2024 with Nathalie
        {
            Caption = 'Initial ETR';
        }
        field(51; "Initial ETD"; Date)
        {
            Caption = 'Initial ETD';
        }
        field(52; "Initial ETA"; Date)
        {
            Caption = 'Initial ETA';
        }
        field(53; "Initial ETAW"; Date)
        {
            Caption = 'Initial ETAW';
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
        }
    }
}