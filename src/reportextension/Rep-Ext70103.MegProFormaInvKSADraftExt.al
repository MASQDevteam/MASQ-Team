reportextension 70103 "Meg Pro Forma Inv KSADraft Ext" extends "Meg Pro Forma Invoice KSADraft"
{
    RDLCLayout = 'MegProFormaInvoiceKSADraft.rdl';
    dataset
    {
        modify("Sales Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                SalesLine: Record "Sales Line";
                FormatNoTextCod: Codeunit "MASQ Format No Text";
                GLSetup: Record "General Ledger Setup";
            begin
                VatPerc := 0;
                NetAmountInWordsNew := '';
                GrossAmountNew := 0;
                GrossAmountPerc := 0;
                GLSetup.Get();
                CurrencyCodeNew := "Sales Header"."Currency Code";

                if (CurrencyCodeNew = '') then begin
                    GLSetup.Get();
                    GLSetup.TestField("LCY Code");
                    CurrencyCodeNew := GLSetup."LCY Code"
                end;
                SalesLine.Reset();

                SalesLine.SetRange("Document Type", "Sales Header"."Document Type");
                SalesLine.SetRange("Document No.", "Sales Header"."No.");

                if SalesLine.FindSet() then
                    repeat
                        GrossAmountNew += Round(SalesLine."Amount Including VAT", GLSetup."Amount Rounding Precision");
                    until (SalesLine.Next() = 0);
                if (Percentage <> 0) and (varAmount = 0) then
                    GrossAmountPerc := (GrossAmountNew * Percentage) / 100
                else
                    if (Percentage = 0) and (varAmount = 0) then
                        GrossAmountPerc := GrossAmountNew
                    else
                        //AN 05/03/25
                        if varAmount <> 0 then
                            GrossAmountPerc := varAmount + VatPerc / 100;
                FormatNoTextCod.FormatNoTextWithCurrency(NetAmountInWordsNew, GrossAmountPerc, CurrencyCodeNew);

                VATPostingSetup.Get('LOCAL', 'GOODSVAT');
                VatPerc := VATPostingSetup."VAT %";
            end;
        }
        add("Sales Header")
        {
            column(Percentage; Percentage)
            {

            }
            column(varAmount; varAmount)
            {

            }
            column(VatPerc; VatPerc)
            {

            }
            column(Pro_Forma_Description; "Pro-Forma Description")
            {

            }
            column(NetAmountInWordsNew; NetAmountInWordsNew)
            {
            }
            column(GrossAmountPerc; GrossAmountPerc)
            {
            }

        }

    }
    requestpage
    {
        layout
        {

            addfirst(Content)
            {
                group(Others)
                {
                    field(Percentage; Percentage)
                    {
                        ApplicationArea = All;
                    }
                    field(varAmount; varAmount)
                    {
                        ApplicationArea = All;
                        Caption = 'Amount';
                    }
                }
            }
        }
    }
    var
        Percentage: Decimal;
        GrossAmountNew: Decimal;
        NetAmountInWordsNew: Text[200];
        CurrencyCodeNew: Code[10];
        GrossAmountPerc: Decimal;
        varAmount: Decimal;
        VATPostingSetup: Record "VAT Posting Setup";
        VatPerc: Decimal;
}