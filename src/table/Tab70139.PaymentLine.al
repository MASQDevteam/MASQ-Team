table 70139 "Payment Line"
{
    Caption = 'Payment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Number; Code[20])
        {
            Caption = 'Number';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(3; "PO Value"; Decimal)
        {
            Caption = 'PO Value';
        }
        field(4; "Payment Value"; Decimal)
        {
            Caption = 'Payment Value';
            trigger OnValidate()
            var
                PaymentLine: Record "Payment Line";
            begin
                Modify();
                if PaymentLine.FindFirst() then
                    repeat
                        PaymentLine.CalcSums("Payment Value");
                        if PaymentLine."Payment Value" > "PO Value" then
                            Error('Sum of Payments must be equal to the PO Value');
                    until PaymentLine.Next() = 0;
            end;
        }
        field(5; "Payment %"; Decimal)
        {
            Caption = 'Payment %';
        }
        field(6; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(7; "Payment Status"; Enum "Document Status")
        {
            Caption = 'Payment Status';
        }
        field(8; "Currency"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(9; "Supplier"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(10; "PO#"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = const(Order), "Buy-from Vendor No." = field(Supplier));
        }
        field(11; "Level of Urgency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "0. ","1. Critical","2. Major","3. Medium","4. Minor";
        }

        field(12; "Project Name"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('PROJECT'));
        }
    }
    keys
    {
        key(PK; Number, "Line No")
        {
            Clustered = true;
        }
    }
}
