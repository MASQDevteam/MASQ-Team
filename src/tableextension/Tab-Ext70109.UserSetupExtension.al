tableextension 70109 "User Setup Extension" extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Travel request Position"; Option)
        {
            Caption = 'Travel request Position';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Manager","Project Manager","Finance";
        }
        field(70101; "Can edit RFP fields after post"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Remove PO lines from Container"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Can Remove PO lines from Container';
        }
        field(70103; "Change Status of VO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70104; "Can Restore Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70105; "Can Remove Line in BL/AWB"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70106; "Change Status of SQ"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70107; "Can Edit Qty\Cost Released PR"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70108; "Can Edit Budget Control"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70109; "Can Change Agent From Header"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "Can Submit Purchase Request"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //AN 03/05/25 +
        field(70111; "Reciever"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'SO Reciever';
        }
        field(70112; "Submittal Cmt Rec"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'SubmittalComment Reciever';
        }
        field(70113; "InterItem Reciever"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Intermediate Item Reciever';
        }
        field(70114; "InterCust Reciever"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Intermediate Customer Reciever';
        }
        field(70115; "InterVend Reciever"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Intermediate Vendor Reciever';
        }
        field(70116; "VO Reciever"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Variation Order Reciever';
        }
        field(70117; "PO Reciever"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'PO Reciever';
        }
        //AN 03/05/25-
        field(70118; "Input DynamicNum to Intermed."; Boolean)//added on 10/03/2025
        {
            DataClassification = ToBeClassified;
        }
        field(70119; "Send Data to Other Companies"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70120; "Can AttachFilesGreaterthan3MB"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Can Attach Files Greater than 3MB';
        }
        field(70121; "Can Edit SO/PO Details"; Boolean)//added on 26/03/2025
        {
            DataClassification = ToBeClassified;
        }
        field(70122; "Can Split SO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70123; "Can Edit Attachment ID"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70124; "Projects Reciever"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70125; "Hide/Unhide Accounts in COA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70126; "Sent Email Approved SQ"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70127; "Sent Email Project Card"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        //NB MASQ Start
        field(70128; "Edit Payment Line"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(70129; "Payment Journal Template"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template" where(Type = const(Payments));
        }
        field(70130; "Payment Journal Batch"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));
            ValidateTableRelation = false;
        }
        //NB MASQ End
        // FQ MASQ Start
        field(70131; "BypassCustOnProject"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70132; "Can View SO Customer Fields"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Can Edit SO Customer Fields';
        }
        // FQ MASQ End
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