reportextension 70101 "Purch Order KSA Ext" extends "Meg Purchase Order KSA Draft"
{
    RDLCLayout = 'MegPurchaseOrderKSADraftNew.rdl';
    dataset
    {
        add("Purchase Line")
        {
            column(PurchLineType; Type)
            {

            }
            column(ProjNo; ProjNo)
            {
            }
            column(PNo_; "No.")
            {

            }
            column(PDescription; Description)
            {

            }
        }
        modify("Purchase Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                myInt: Integer;
            begin
                if ("Purchase Line"."Job No." <> '') and ("Purchase Line"."Shortcut Dimension 1 Code" <> '') then
                    ProjNo := "Purchase Line"."Job No." + ' - ' + "Purchase Line"."Shortcut Dimension 1 Code";
                if ("Purchase Line"."Job No." <> '') and ("Purchase Line"."Shortcut Dimension 1 Code" = '') then
                    ProjNo := "Purchase Line"."Job No.";
                if ("Purchase Line"."Job No." = '') and ("Purchase Line"."Shortcut Dimension 1 Code" <> '') then
                    ProjNo := "Purchase Line"."Shortcut Dimension 1 Code";
            end;
        }
    }
    var
        ProjNo: Code[20];
}
