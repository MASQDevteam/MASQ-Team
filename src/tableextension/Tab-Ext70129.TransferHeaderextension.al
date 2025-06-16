tableextension 70129 "Transfer Header extension" extends "Transfer Header"
{
    fields
    {
        // Add changes to table fields here
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            var
                TransferLines: Record "Transfer Line";
            begin
                IF Rec."Transfer-from Code" <> xRec."Transfer-from Code" then begin
                    Clear(TransferLines);
                    TransferLines.SetRange("Document No.", Rec."No.");
                    TransferLines.ModifyAll("MASQ Purchase Order Line No.", 0);
                    TransferLines.ModifyAll("MASQ Purchase Order No.", '');
                    TransferLines.ModifyAll("Batch Number", '');
                end;
            end;
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

    var
        myInt: Integer;
}