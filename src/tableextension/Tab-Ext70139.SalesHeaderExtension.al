tableextension 70139 "Sales Header Extension" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        // field(70100; "PO from PR"; Boolean)//this fields will be used to crerate the PO from the PR if needed
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(70101; "Pro-Forma Description"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Apollo Total Offer Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70103; "SO Type"; Option)
        {
            OptionMembers = "","Sample","Mockup","Main Project";
        }

        //NB MASQ Start
        field(70104; "Logistics Coordinator"; Enum "Logistics Coordinator")
        {
            DataClassification = CustomerContent;
        }
        //NB MASQ End
        // FQ MASQ ** Start
        /* modify("Assigned User ID")
        {
            trigger OnAfterValidate()
            var
                user: Record User;
            begin
                // The "Assigned User ID" stores the User Name (not the GUID SystemId).
                // Look up by User Name and normalize to the exact User Name value.
                user.Reset();
                user.SetRange("User Name", "Assigned User ID");
                if user.FindFirst() then
                    "Assigned User ID" := user."Full Name";
            end;
        } */
        // FQ MASQ ** END
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    //AN 03/05/25 
    // trigger OnInsert()
    // var
    //     myInt: Integer;
    // begin
    //     if Rec."Document Type" = Rec."Document Type"::Order then
    //         MASQEmail.SendEmailSalesOrder(Rec);
    //     if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then
    //         MASQEmail.SendEmailSalesCrMemo(Rec);
    // end;

    var
        MASQEmail: Codeunit "MASQ Email";
}