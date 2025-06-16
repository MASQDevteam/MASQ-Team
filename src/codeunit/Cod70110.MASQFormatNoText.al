

codeunit 70110 "MASQ Format No Text"
{
    Access = Internal;

    internal procedure FormatNoTextWithCurrency(var NoText: Text[200]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        CurrencyDescription: Text[60];
        NumberText: Text;
    begin
        InitTextVariable();

        AddToNoText(NoText, PrintExponent, CurrencyCode + ' / ');

        if No < 1 then
            AddToNoText(NoText, PrintExponent, ZEROText)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;

                if Hundreds > 0 then begin
                    AddToNoText(NoText, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, PrintExponent, HUNDREDText);
                end;

                if Tens >= 2 then begin
                    AddToNoText(NoText, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, PrintExponent, OnesText[Tens * 10 + Ones]);

                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, PrintExponent, ExponentText[Exponent]);

                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        No := No * 100;

        if (No > 0) then begin
            AddToNoText(NoText, PrintExponent, ANDText);

            if No < 10 then
                NumberText := '0' + Format(No) + '/100'
            else
                NumberText := Format(No) + '/100';

            AddToNoText(NoText, PrintExponent, NumberText);
        end;
    end;

    local procedure AddToNoText(var NoText: Text[200]; var PrintExponent: Boolean; AddText: Text[100])
    begin
        PrintExponent := true;

        NoText := DelChr(NoText + ' ' + AddText, '<');
    end;

    local procedure InitTextVariable()
    begin
        OnesText[1] := ONEText;
        OnesText[2] := TWOText;
        OnesText[3] := THREEText;
        OnesText[4] := FOURText;
        OnesText[5] := FIVEText;
        OnesText[6] := SIXText;
        OnesText[7] := SEVENText;
        OnesText[8] := EIGHTText;
        OnesText[9] := NINEText;
        OnesText[10] := TENText;
        OnesText[11] := ELEVENText;
        OnesText[12] := TWELVEText;
        OnesText[13] := THIRTEENText;
        OnesText[14] := FOURTEENText;
        OnesText[15] := FIFTEENText;
        OnesText[16] := SIXTEENText;
        OnesText[17] := SEVENTEENText;
        OnesText[18] := EIGHTEENText;
        OnesText[19] := NINETEENText;

        TensText[1] := '';
        TensText[2] := TWENTYText;
        TensText[3] := THIRTYText;
        TensText[4] := FORTYText;
        TensText[5] := FIFTYText;
        TensText[6] := SIXTYText;
        TensText[7] := SEVENTYText;
        TensText[8] := EIGHTYText;
        TensText[9] := NINETYText;

        ExponentText[1] := '';
        ExponentText[2] := THOUSANDText;
        ExponentText[3] := MILLIONText;
        ExponentText[4] := BILLIONText;
    end;

    ///<summary>Meg02.00</summary>
    local procedure InitTextVariableAR()
    begin
        OnesTextAR[1] := ONETextAR;
        OnesTextAR[2] := TWOTextAR;
        OnesTextAR[3] := THREETextAR;
        OnesTextAR[4] := FOURTextAR;
        OnesTextAR[5] := FIVETextAR;
        OnesTextAR[6] := SIXTextAR;
        OnesTextAR[7] := SEVENTextAR;
        OnesTextAR[8] := EIGHTTextAR;
        OnesTextAR[9] := NINETextAR;
        OnesTextAR[10] := TENTextAR;
        OnesTextAR[11] := ELEVENTextAR;
        OnesTextAR[12] := TWELVETextAR;
        OnesTextAR[13] := THIRTEENTextAR;
        OnesTextAR[14] := FOURTEENTextAR;
        OnesTextAR[15] := FIFTEENTextAR;
        OnesTextAR[16] := SIXTEENTextAR;
        OnesTextAR[17] := SEVENTEENTextAR;
        OnesTextAR[18] := EIGHTEENTextAR;
        OnesTextAR[19] := NINETEENTextAR;

        TensTextAR[1] := '';
        TensTextAR[2] := TWENTYTextAR;
        TensTextAR[3] := THIRTYTextAR;
        TensTextAR[4] := FORTYTextAR;
        TensTextAR[5] := FIFTYTextAR;
        TensTextAR[6] := SIXTYTextAR;
        TensTextAR[7] := SEVENTYTextAR;
        TensTextAR[8] := EIGHTYTextAR;
        TensTextAR[9] := NINETYTextAR;

        HundredsTextAR[1] := OneHundredTextAR;
        HundredsTextAR[2] := TwoHundredTextAR;
        HundredsTextAR[3] := ThreeHundredTextAR;
        HundredsTextAR[4] := FourHundredTextAR;
        HundredsTextAR[5] := FiveHundredTextAR;
        HundredsTextAR[6] := SixHundredTextAR;
        HundredsTextAR[7] := SevenHundredTextAR;
        HundredsTextAR[8] := EightHundredTextAR;
        HundredsTextAR[9] := NineHundredTextAR;

        ExponentTextAR[1] := '';
        ExponentTextAR[2] := THOUSANDTextAR;
        ExponentTextAR[3] := MILLIONTextAR;
        ExponentTextAR[4] := BILLIONTextAR;
    end;

    ///<summary>Meg02.00</summary>
    internal procedure FormatNoTextWithoutCurrency(var NoText: Text[200]; No: Decimal)
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        CurrencyDescription: Text[60];
        NumberText: Text;
    begin
        InitTextVariable();

        if No < 1 then
            AddToNoText(NoText, PrintExponent, ZEROText)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;

                if Hundreds > 0 then begin
                    AddToNoText(NoText, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, PrintExponent, HUNDREDText);
                end;

                if Tens >= 2 then begin
                    AddToNoText(NoText, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, PrintExponent, OnesText[Tens * 10 + Ones]);

                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, PrintExponent, ExponentText[Exponent]);

                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        No := No * 100;

        if (No > 0) then begin
            AddToNoText(NoText, PrintExponent, ANDText);

            if No < 10 then
                NumberText := '0' + Format(No) + '/100'
            else
                NumberText := Format(No) + '/100';

            AddToNoText(NoText, PrintExponent, NumberText);
        end;
    end;

    ///<summary>Meg02.00</summary>
    internal procedure FormatNoTextWithoutCurrencyArabic(var NoText: Text[200]; No: Decimal)
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        CurrencyDescription: Text[60];
        NumberText: Text;
        IsExponentEntered: Boolean;
    begin
        InitTextVariableAR();

        if (No < 1) then
            AddToNoText(NoText, PrintExponent, ZEROTextAR)
        else
            for Exponent := 4 downto 1 do begin
                IsExponentEntered := false;
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;

                if (Hundreds > 0) then begin
                    if (NoText <> '') then
                        AddToNoText(NoText, PrintExponent, ANDTextAR);

                    AddToNoText(NoText, PrintExponent, HundredsTextAR[Hundreds]);
                end;

                if (PrintExponent and (Exponent > 1)) then begin
                    if (Tens >= 2) then begin
                        if (Ones > 0) then begin
                            AddToNoText(NoText, PrintExponent, OnesTextAR[Ones]);
                            AddToNoText(NoText, PrintExponent, ANDTextAR);
                        end;

                        AddToNoText(NoText, PrintExponent, TensTextAR[Tens]);
                    end else begin
                        if ((Tens * 10 + Ones) > 0) then
                            case true of
                                (Ones = 1) and (Tens = 0) and (Exponent = 2):
                                    begin
                                        AddToNoText(NoText, PrintExponent, THOUSANDTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 2) and (Tens = 0) and (Exponent = 2):
                                    begin
                                        AddToNoText(NoText, PrintExponent, TwoThousandTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 1) and (Tens = 0) and (Exponent = 3):
                                    begin
                                        AddToNoText(NoText, PrintExponent, MILLIONTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 2) and (Tens = 0) and (Exponent = 3):
                                    begin
                                        AddToNoText(NoText, PrintExponent, TwoMillionTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 1) and (Tens = 0) and (Exponent = 4):
                                    begin
                                        AddToNoText(NoText, PrintExponent, BILLIONTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 2) and (Tens = 0) and (Exponent = 4):
                                    begin
                                        AddToNoText(NoText, PrintExponent, TwoBillionTextAR);
                                        IsExponentEntered := true;
                                    end;

                                else begin
                                    AddToNoText(NoText, PrintExponent, OnesTextAR[Tens * 10 + Ones]);

                                    if (PrintExponent and (Exponent > 1)) then
                                        AddToNoText(NoText, PrintExponent, ExponentTextAR[Exponent]);

                                    IsExponentEntered := true;
                                end;
                            end;
                    end;

                    if (not IsExponentEntered) then
                        if (PrintExponent and (Exponent > 1)) then
                            AddToNoText(NoText, PrintExponent, ExponentTextAR[Exponent]);
                end else begin
                    if (Tens >= 2) then begin
                        if (Ones > 0) then begin
                            AddToNoText(NoText, PrintExponent, OnesTextAR[Ones]);
                            AddToNoText(NoText, PrintExponent, ANDTextAR);
                        end;

                        AddToNoText(NoText, PrintExponent, TensTextAR[Tens]);
                    end else
                        if ((Tens * 10 + Ones) > 0) then
                            case true of
                                (Ones = 1) and (Tens = 0) and (Exponent = 2):
                                    begin
                                        AddToNoText(NoText, PrintExponent, THOUSANDTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 2) and (Tens = 0) and (Exponent = 2):
                                    begin
                                        AddToNoText(NoText, PrintExponent, TwoThousandTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 1) and (Tens = 0) and (Exponent = 3):
                                    begin
                                        AddToNoText(NoText, PrintExponent, MILLIONTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 2) and (Tens = 0) and (Exponent = 3):
                                    begin
                                        AddToNoText(NoText, PrintExponent, TwoMillionTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 1) and (Tens = 0) and (Exponent = 4):
                                    begin
                                        AddToNoText(NoText, PrintExponent, BILLIONTextAR);
                                        IsExponentEntered := true;
                                    end;

                                (Ones = 2) and (Tens = 0) and (Exponent = 4):
                                    begin
                                        AddToNoText(NoText, PrintExponent, TwoBillionTextAR);
                                        IsExponentEntered := true;
                                    end;

                                else begin
                                    AddToNoText(NoText, PrintExponent, OnesTextAR[Tens * 10 + Ones]);

                                    if (PrintExponent and (Exponent > 1)) then
                                        AddToNoText(NoText, PrintExponent, ExponentTextAR[Exponent]);

                                    IsExponentEntered := true;
                                end;
                            end;

                    if (not IsExponentEntered) then
                        if (PrintExponent and (Exponent > 1)) then
                            AddToNoText(NoText, PrintExponent, ExponentTextAR[Exponent]);
                end;

                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        No := No * 100;

        if (No > 0) then begin
            AddToNoText(NoText, PrintExponent, ANDTextAR);

            if (No < 10) then
                NumberText := '0' + Format(No) + '/100'
            else
                NumberText := Format(No) + '/100';

            AddToNoText(NoText, PrintExponent, NumberText);
        end;
    end;

    ///<summary>Meg02.00</summary>
    internal procedure CurrencyDescInArabic(CurrencyCode: Code[10]): Text[30]
    begin
        case CurrencyCode of
            'QAR':
                exit('ريال قطري');

            'SAR':
                exit('ريال سعودي');

            'USD':
                exit('دولار أمريكي');

            'EUR':
                exit('يورو');

            'AED':
                exit('درهم اماراتي');
        end;
    end;

    var
        ZEROText: Label 'no';
        ZEROTextAR: Label 'لا';             //Meg02.00
        HUNDREDText: Label 'hundred';
        HUNDREDTextAR: Label 'مائة';                //Meg02.00
        ANDText: Label 'and';
        ANDTextAR: Label 'و';               //Meg02.00
        ONEText: Label 'one';
        ONETextAR: Label 'واحد';                //Meg02.00
        TWOText: Label 'two';
        TWOTextAR: Label 'اثنين';               //Meg02.00
        THREEText: Label 'three';
        THREETextAR: Label 'ثلاثة';              //Meg02.00
        FOURText: Label 'four';
        FOURTextAR: Label 'أربعة';              //Meg02.00
        FIVEText: Label 'five';
        FIVETextAR: Label 'خمسة';               //Meg02.00
        SIXText: Label 'six';
        SIXTextAR: Label 'ستة';                 //Meg02.00
        SEVENText: Label 'seven';
        SEVENTextAR: Label 'سبعة';             //Meg02.00
        EIGHTText: Label 'eight';
        EIGHTTextAR: Label 'ثمانية';               //Meg02.00
        NINEText: Label 'nine';
        NINETextAR: Label 'تسعة';                   //Meg02.00
        TENText: Label 'ten';
        TENTextAR: Label 'عشرة';               //Meg02.00
        ELEVENText: Label 'eleven';
        ELEVENTextAR: Label 'أحد عشر';              //Meg02.00
        TWELVEText: Label 'twelve';
        TWELVETextAR: Label 'اثني عشر';             //Meg02.00
        THIRTEENText: Label 'thirteen';
        THIRTEENTextAR: Label 'ثلاثة عشر';              //Meg02.00
        FOURTEENText: Label 'fourteen';
        FOURTEENTextAR: Label 'أربعة عشر';              //Meg02.00
        FIFTEENText: Label 'fifteen';
        FIFTEENTextAR: Label 'خمسة عشر';                //Meg02.00
        SIXTEENText: Label 'sixteen';
        SIXTEENTextAR: Label 'ستة عشر';             //Meg02.00
        SEVENTEENText: Label 'seventeen';
        SEVENTEENTextAR: Label 'سبعة عشر';         //Meg02.00
        EIGHTEENText: Label 'eighteen';
        EIGHTEENTextAR: Label 'ثمانية عشر';             //Meg02.00
        NINETEENText: Label 'nineteen';
        NINETEENTextAR: Label 'تسعة عشر';           //Meg02.00
        TWENTYText: Label 'twenty';
        TWENTYTextAR: Label 'عشرين';             //Meg02.00
        THIRTYText: Label 'thirty';
        THIRTYTextAR: Label 'ثلاثين';             //Meg02.00
        FORTYText: Label 'forty';
        FORTYTextAR: Label 'أربعين';               //Meg02.00
        FIFTYText: Label 'fifty';
        FIFTYTextAR: Label 'خمسون';             //Meg02.00
        SIXTYText: Label 'sixty';
        SIXTYTextAR: Label 'ستين';              //Meg02.00
        SEVENTYText: Label 'seventy';
        SEVENTYTextAR: Label 'سبعون';               //Meg02.00
        EIGHTYText: Label 'eighty';
        EIGHTYTextAR: Label 'ثمانون';               //Meg02.00
        NINETYText: Label 'ninety';
        NINETYTextAR: Label 'تسعون';                //Meg02.00
        THOUSANDText: Label 'thousand';
        THOUSANDTextAR: Label 'ألف';             //Meg02.00
        MILLIONText: Label 'million';
        MILLIONTextAR: Label 'مليون';             //Meg02.00
        BILLIONText: Label 'billion';
        BILLIONTextAR: Label 'مليار';               //Meg02.00
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        //Meg02.00++
        OneHundredTextAR: Label 'مائة';
        TwoHundredTextAR: Label 'مائتي';
        ThreeHundredTextAR: Label 'ثلاثمائة';
        FourHundredTextAR: Label 'أربعمائة';
        FiveHundredTextAR: Label 'خمسمائة';
        SixHundredTextAR: Label 'ستمائة';
        SevenHundredTextAR: Label 'سبعمائة';
        EightHundredTextAR: Label 'ثمانمائة';
        NineHundredTextAR: Label 'تسعمائة';
        TwoThousandTextAR: Label 'ألفين';
        TwoMillionTextAR: Label 'مليونين';
        TwoBillionTextAR: Label 'مليارين';
        OnesTextAR: array[20] of Text[30];
        TensTextAR: array[10] of Text[30];
        HundredsTextAR: array[10] of Text[30];
        ExponentTextAR: array[5] of Text[30];
    //Meg02.00--
}