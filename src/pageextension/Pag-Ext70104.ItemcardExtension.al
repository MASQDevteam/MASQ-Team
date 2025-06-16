pageextension 70104 "Item card Extension" extends "Item Card"
{
    layout
    {
        // Add changes to page layout here

        // modify("Meg Vendor Item Code")
        // {

        //     Editable = false;
        // }\
        addafter("Meg Beam Angle")
        {
            field("MASQ IP Rating"; Rec."MASQ IP Rating")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ IP Rating field.', Comment = '%';
            }
            field("MASQ Thumbnail"; Rec."MASQ Thumbnail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Thumbnail field.', Comment = '%';
            }
            field("MASQ Optic/Diffuser"; Rec."MASQ Optic/Diffuser")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Optic/Diffuser field.', Comment = '%';
            }
            field("MASQ Cover Color"; Rec."MASQ Cover Color")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Cover Color field.', Comment = '%';
            }
            field("MASQ Main Group"; Rec."MASQ Main Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Main Group field.', Comment = '%';
            }
            field(ApolloItemNo; Rec.ApolloItemNo)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Apollo Item No. field.', Comment = '%';
            }
            field("MASQ Sub Group"; Rec."MASQ Sub Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Type or Sub Group field.', Comment = '%';
            }
            field("MASQ Luminous Flux (Lm)"; Rec."MASQ Luminous Flux (Lm)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Luminous Flux (Lm) field.', Comment = '%';
            }
            field(Lifespan; Rec.Lifespan)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lifespan field.', Comment = '%';
            }
            field("Viewing Distance"; Rec."Viewing Distance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Viewing Distance field.', Comment = '%';
            }
            field("Vendor Custom Code"; Rec."Vendor Custom Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Custom Code field.', Comment = '%';
            }
        }

        // modify("Meg Vendor Item Code")
        // {

        //     trigger OnAfterValidate()
        //     var
        //     begin
        //         Clear(ItemRec);
        //         ItemRec.SetRange("Meg Vendor Item Code", Rec."Meg Vendor Item Code");
        //         ItemRec.SetFilter("No.", '<> %1', Rec."No.");

        //         IF ItemRec.FindFirst() then
        //             Error('Vendor item Code already exist in this database');
        //     end;
        // }


    }

    actions
    {
        // Add changes to page actions here

        addafter(CopyItem)
        {
            action("Sync Item to Other Companies")//added on 11/03/2025
            {
                ApplicationArea = All;
                Caption = 'Sync Item to Other Companies';
                Image = CopyItem;
                Enabled = SendDatatoOtherCompanies;
                trigger OnAction()
                begin
                    SyncItemtoOtherCompanies(Rec);
                end;
            }
        }
    }


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        DefaultDimension: Record "Default Dimension";
        text001: Label 'Please do Fill the Brand Dimension for this Item';
    begin
        IF Rec.Type <> Rec.Type::Service then begin
            DefaultDimension.RESET();
            DefaultDimension.SetRange("Table ID", Rec.RecordId().TableNo);
            DefaultDimension.SetRange("No.", Rec."No.");
            DefaultDimension.SetRange("Dimension Code", 'BRAND');
            IF NOT DefaultDimension.FindFirst() then
                Error(text001);

        end;
    end;

    Local procedure SyncItemtoOtherCompanies(ItemRec: Record Item)//added on 11/03/2025
    var
        OtherCompanyItemRec: Record Item;
    begin
        Clear(OtherCompanyItemRec);
        IF CompanyName = 'NEW MASQ-KSA' then
            OtherCompanyItemRec.ChangeCompany('NEW MASQ -QATAR')
        else IF CompanyName = 'NEW MASQ -QATAR' then
            OtherCompanyItemRec.ChangeCompany('NEW MASQ-KSA');

        OtherCompanyItemRec.Init();
        OtherCompanyItemRec.Copy(ItemRec);
        OtherCompanyItemRec.Insert();


    end;

    trigger OnOpenPage()
    var
    begin
        Clear(UserSetup);
        IF UserSetup.Get(UserId) then;
        SendDatatoOtherCompanies := UserSetup."Send Data to Other Companies";
    end;

    var
        UserSetup: Record "User Setup";
        SendDatatoOtherCompanies: Boolean;
        ItemRec: Record Item;


}