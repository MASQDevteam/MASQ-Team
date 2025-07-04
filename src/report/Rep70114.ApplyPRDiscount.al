namespace MASQTeam.MASQTeam;

report 70114 "Apply PR Discount"
{
    ApplicationArea = All;
    Caption = 'Apply PR Discount';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Purchase Request Line"; "Purchase Request Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.");

            trigger OnAfterGetRecord()
            begin
                ApplyDiscountToLine();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(DiscountPercentage; DiscountPercentage)
                    {
                        ApplicationArea = All;
                        Caption = 'Discount %';
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if (DiscountPercentage > 100) or (DiscountPercentage < 0) then
                                ERROR('Discount percentage cannot be greater than 100 or less than 0.');
                        end;
                    }
                }
            }
        }

    }

    var
        DiscountPercentage: Decimal;

    procedure ApplyDiscountToLine()
    var
        PRLine: Record "Purchase Request Line";
    begin
        if DiscountPercentage = 0 then
            exit;

        PRLine.SetRange("Document No.", "Purchase Request Line"."Document No.");
        if PRLine.FindFirst() then
            repeat
                PRLine.Validate("Discount %", DiscountPercentage);
                PRLine.Modify(true);
            until PRLine.Next() = 0;
    end;
}
