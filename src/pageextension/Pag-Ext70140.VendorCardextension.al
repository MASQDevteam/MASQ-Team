pageextension 70140 "Vendor Card extension" extends "Vendor Card"
{
    layout
    {
        addafter("Payment Terms Code")
        {
            field("Payment Terms Description"; Rec."Payment Terms Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Terms Description field.', Comment = '%';
                DrillDownPageId = "Payment Terms";
            }

        }
        // Add changes to page layout here
        addafter("Last Date Modified")
        {
            field(Category; Rec.Category)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cateogry field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Orders)
        {
            action("Sync Vendor to Other Companies")//added on 11/03/2025
            {
                ApplicationArea = All;
                Caption = 'Sync Vendor to Other Companies';
                Image = Vendor;
                Enabled = SendDatatoOtherCompanies;
                trigger OnAction()
                begin
                    SyncVendortoOtherCompanies(Rec);
                end;
            }
        }
    }
    Local procedure SyncVendortoOtherCompanies(VendorRec: Record Vendor)
    var
        OtherCompanyVendorRec: Record Vendor;
    begin
        Clear(OtherCompanyVendorRec);
        IF CompanyName = 'NEW MASQ-KSA' then
            OtherCompanyVendorRec.ChangeCompany('NEW MASQ -QATAR')
        else IF CompanyName = 'NEW MASQ -QATAR' then
            OtherCompanyVendorRec.ChangeCompany('NEW MASQ-KSA');

        OtherCompanyVendorRec.Init();
        OtherCompanyVendorRec.Copy(VendorRec);
        OtherCompanyVendorRec.Insert();


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
        myInt: Integer;
}