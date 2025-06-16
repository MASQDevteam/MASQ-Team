pageextension 70133 "Transfer order Extension" extends "Transfer Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("MASQ Purchase Order No."; Rec."MASQ Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Purchase Order No. field.', Comment = '%';

                trigger OnLookup(var Text: Text): Boolean
                var
                    POBatchLOG: Record "Supply Chain LOG";
                    POBatchLOGpage: page "PO Batch LOG";
                begin
                    Clear(POBatchLOG);
                    POBatchLOG.SetRange("Item Number", REc."Item No.");
                    POBatchLOG.SetRange("Location Code", REc."Transfer-from Code");
                    POBatchLOG.SetFilter("Batch Number", '<> %1', '');
                    POBatchLOG.SetFilter("PO Number", '<> %1', '');

                    POBatchLOG.SetFilter("PO Line Number", '<> %1', 0);

                    Clear(POBatchLOGpage);
                    POBatchLOGpage.SetTableView(POBatchLOG);
                    POBatchLOGpage.LookupMode(true);
                    IF POBatchLOGpage.RunModal() = Action::LookupOK then begin

                        POBatchLOGpage.SetSelectionFilter(POBatchLOG);
                        if POBatchLOG.FindSet() then begin
                            Rec."MASQ Purchase Order No." := POBatchLOG."PO Number";
                            rec."MASQ Purchase Order Line No." := POBatchLOG."PO Line Number";
                            Rec."Batch Number" := POBatchLOG."Batch Number";
                        end;
                    end;
                end;
            }
            field("MASQ Purchase Order Line No."; Rec."MASQ Purchase Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Purchase Order Line No. field.', Comment = '%';
            }
            field("Batch Number"; Rec."Batch Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch Number field.', Comment = '%';
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}