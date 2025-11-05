tableextension 70139 "Sales Header Extension" extends "Sales Header"
{
    fields
    {
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

        field(70105; "Order Coming into force"; Date)
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Pending;
            ObsoleteReason = 'The user no longer wants this field';
            ObsoleteTag = '25.0.1.131';
        }
        field(70106; "Custom Status"; Enum "Custom Sales Status")
        {
            Caption = 'Custom Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
            begin
                UpdateMegOCNo();
            end;
        }
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

    //FQ MASQ ** START
    trigger OnAfterInsert()
    begin
        InitializeCustomStatus();
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if rec."Custom Status" = rec."Custom Status"::"Fully Delivered/Fully Invoiced" then begin
            Error('You cannot Delete a SO once it has been fully Delivered and fully invoiced.');
        end;
    end;

    trigger OnAfterModify()
    begin
        // Update custom status when standard Status field changes
        if Rec.Status <> xRec.Status then
            UpdateStatusBasedOnDocumentStatus();
    end;

    local procedure InitializeCustomStatus()
    begin
        case Status of
            Status::Open:
                "Custom Status" := "Custom Status"::Open;
            Status::Released:
                "Custom Status" := "Custom Status"::Released;
            else
                "Custom Status" := "Custom Status"::Open;
        end;
    end;

    local procedure UpdateStatusBasedOnDocumentStatus()
    begin
        // Only update if we're in a basic state (Open/Released) without posting activity
        if "Custom Status" in ["Custom Status"::Open, "Custom Status"::Released,
                                "Custom Status"::"Pending Approval", "Custom Status"::"Pending Prepayment"] then
            case Status of
                Status::Open:
                    "Custom Status" := "Custom Status"::Open;
                Status::Released:
                    "Custom Status" := "Custom Status"::Released;
            end;
    end;

    local procedure UpdateMegOCNo()
    begin
        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", 'PROJECT');
        DimensionValue.SetRange(Code, Rec."Shortcut Dimension 1 Code");
        if DimensionValue.FindFirst() then begin
            if Rec."Meg OC No." = '' then begin
                rec."Meg OC No." := Rec."Shortcut Dimension 1 Code" + '-' + DimensionValue.Name;
                rec.Modify();
            end;
        end;
    end;
    //FQ MASQ ** END


    var
        MASQEmail: Codeunit "MASQ Email";
        DimensionValue: Record "Dimension Value";
}