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
                GenJournalLine: Record "Gen. Journal Line"; //NB MASQ
            begin
                Modify();
                PaymentLine.SetRange(Number, Rec.Number);
                if PaymentLine.FindFirst() then
                    repeat
                        PaymentLine.CalcSums("Payment Value");
                        if PaymentLine."Payment Value" > "PO Value" then
                            Error('Sum of Payments must be equal to the PO Value');
                    until PaymentLine.Next() = 0;
                if "PO Value" <> 0 then
                    "Payment %" := ("Payment Value" * 100) / "PO Value";

                //NB MASQ Start
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                GenJournalLine.SetRange("Journal Batch Name", 'GLENDA RFP');
                GenJournalLine.SetRange("Document No.", Rec.Number);
                GenJournalLine.SetRange("Source Line No.", Rec."Line No");
                if GenJournalLine.FindSet() then
                    repeat
                        if GenJournalLine."Source Code" = 'PAYMENTJNL' then
                            GenJournalLine.Validate(Amount, Rec."Payment Value");
                        if GenJournalLine."Source Code" = 'GENJNL' then
                            GenJournalLine.Validate(Amount, -Rec."Payment Value");
                        GenJournalLine.Modify(true);
                    until GenJournalLine.Next() = 0;
                //NB MASQ End
            end;
        }
        field(5; "Payment %"; Decimal)
        {
            Caption = 'Payment %';
            Editable = false;
        }
        field(6; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            //NB MASQ Start
            trigger OnValidate()
            var
                GenJournalLine: Record "Gen. Journal Line";
            begin
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                GenJournalLine.SetRange("Journal Batch Name", 'GLENDA RFP');
                GenJournalLine.SetRange("Document No.", Rec.Number);
                GenJournalLine.SetRange("Source Line No.", Rec."Line No");
                if GenJournalLine.FindSet() then
                    repeat
                        GenJournalLine.Validate("Document Date", Rec."Payment Date");
                        GenJournalLine.Modify(true);
                    until GenJournalLine.Next() = 0;
            end;
            //NB MASQ End
        }
        field(7; "Payment Status"; Enum "Document Status")
        {
            Caption = 'Payment Status';
            Editable = false; //NB MASQ
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
        field(13; "Requested By (Person)"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }

        //NB MASQ Start
        field(14; "Sent to journals"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Bank Number"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(16; "RFP Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Supplier payment","Non-Supplier payment";
        }
        field(17; "Executed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Branch"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
        }
        field(19; "Payment Method"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(20; "Requested By / Department"; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(21; "Payment Terms"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(22; Comment; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        //NB MASQ End

    }
    keys
    {
        key(PK; Number, "Line No")
        {
            Clustered = true;
        }
    }

    //NB MASQ Start
    procedure SendtoPaymentJournal()
    var
        GenJnlLines: Record "Gen. Journal Line";
        LineNo: Integer;
        GenJnlLinesCheck: Record "Gen. Journal Line";
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);

        Clear(GenJnlLinesCheck);
        GenJnlLinesCheck.SetRange("Journal Template Name", UserSetup."Payment Journal Template");
        GenJnlLinesCheck.SetRange("Journal Batch Name", UserSetup."Payment Journal Batch");
        IF GenJnlLinesCheck.FindLast() then
            LineNo += GenJnlLinesCheck."Line No." + 10000 else
            LineNo := 0;

        CLEAR(GenJnlLines);
        GenJnlLines.INIT;
        GenJnlLines.VALIDATE("Journal Template Name", UserSetup."Payment Journal Template");
        GenJnlLines.VALIDATE("Journal Batch Name", UserSetup."Payment Journal Batch");

        LineNo += 10000;
        GenJnlLines."Line No." := LineNo;

        GenJnlLines.VALIDATE("Document Date", Rec."Payment Date");
        GenJnlLines.VALIDATE("Posting Date", TODAY);
        GenJnlLines.Validate("Document Type", GenJnlLines."Document Type"::Payment);
        GenJnlLines.VALIDATE("Document No.", Rec.Number);
        GenJnlLines.Validate("Source Line No.", Rec."Line No");
        GenJnlLines.VALIDATE("Source Code", 'PAYMENTJNL');
        GenJnlLines.VALIDATE("Account Type", GenJnlLines."Account Type"::Vendor);
        GenJnlLines.VALIDATE("Account No.", Rec.Supplier);
        GenJnlLines.VALIDATE("Currency Code", Rec.Currency);
        GenJnlLines.VALIDATE(Amount, Rec."Payment Value");
        GenJnlLines.VALIDATE("Shortcut Dimension 1 Code", Rec."Project Name");
        GenJnlLines.ValidateShortcutDimCode(4, Rec.Branch);
        GenJnlLines.ValidateShortcutDimCode(5, Rec."Requested By / Department");
        GenJnlLines.Validate("Payment Method Code", rec."Payment Method");
        GenJnlLines.Validate("Payment Terms Code", Rec."Payment Terms");
        GenJnlLines.INSERT(TRUE);

        // Credit Line for Vendor Invoice
        CLEAR(GenJnlLines);
        GenJnlLines.INIT;
        GenJnlLines.VALIDATE("Journal Template Name", UserSetup."Payment Journal Template");
        GenJnlLines.VALIDATE("Journal Batch Name", UserSetup."Payment Journal Batch");

        LineNo += 10000;
        GenJnlLines."Line No." := LineNo;

        GenJnlLines.VALIDATE("Document Date", Rec."Payment Date");
        GenJnlLines.VALIDATE("Posting Date", TODAY);
        GenJnlLines.Validate("Document Type", GenJnlLines."Document Type"::Payment);
        GenJnlLines.VALIDATE("Document No.", Rec.Number);
        GenJnlLines.Validate("Source Line No.", Rec."Line No");
        GenJnlLines.VALIDATE("Source Code", 'GENJNL');
        GenJnlLines.VALIDATE("Account Type", GenJnlLines."Account Type"::"Bank Account");
        GenJnlLines.VALIDATE("Account No.", Rec."Bank Number");
        GenJnlLines.VALIDATE("Currency Code", Rec.Currency);
        GenJnlLines.VALIDATE(Amount, -Rec."Payment Value");
        GenJnlLines.VALIDATE("Shortcut Dimension 1 Code", Rec."Project Name");
        GenJnlLines.ValidateShortcutDimCode(4, Rec.Branch);
        GenJnlLines.ValidateShortcutDimCode(5, Rec."Requested By / Department");
        GenJnlLines.Validate("Payment Method Code", rec."Payment Method");
        GenJnlLines.Validate("Payment Terms Code", Rec."Payment Terms");
        GenJnlLines.INSERT(TRUE);

        Message('Payment Journal Lines Are Inserted');
    end;
    //NB MASQ End

}
