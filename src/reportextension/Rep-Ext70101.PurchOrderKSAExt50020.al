reportextension 70101 "Purch Order KSA Ext" extends "Meg Purchase Order KSA Draft"
{
    RDLCLayout = 'MegPurchaseOrderKSADraftNew.rdl';
    dataset
    {
        add("Purchase Header")
        {
            column(Order_Date; "Order Date")
            {

            }
            column(Other_Charges_Value; "Other Charges Value") { }//FQ MASQ
            column(Other_Charges_caption; Other_Caption) { }//FQ MASQ

            //NB MASQ Start
            column(SystemCreatedByVar; SystemCreatedByVar)
            {

            }
            column(Assigned_User_ID; "Assigned User ID")
            {

            }
            //NB MASQ End

        }
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

        //NB MASQ Start
        modify("Purchase Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                User: Record User;
            begin
                if User.Get(SystemCreatedBy) then
                    SystemCreatedByVar := User."User Name";
            end;
        }
        //NB MASQ End

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
        Other_Caption: Label 'Other Charges';// FQ MASQ
        SystemCreatedByVar: Text; //NB MASQ
}
