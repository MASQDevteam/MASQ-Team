tableextension 70110 "Approval Entries extension" extends "Approval Entry"
{
    fields
    {
        // Add changes to table fields here
        field(70110; "Travel Request Position"; Option)
        {
            OptionMembers = " ","Manager","Project Manager","Finance";
            FieldClass = FlowField;
            CalcFormula = lookup("User Setup"."Travel request Position" where("User ID" = field("Approver ID")));
        }
        field(70111; "Supplier Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                Vendor: Record Vendor;
            begin
                Clear(Vendor);
                Vendor.Get(Rec."Supplier Number");
                Page.Run(page::"Vendor Card", Vendor);

            end;

        }
        field(70112; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70113; "PO Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70114; "Supplier Name"; Text[250])
        {
            DataClassification = ToBeClassified;

        }

        field(70115; "RFP 1st Payment Date"; Date)
        {
            //OptionMembers = " ","Manager","Project Manager","Finance";
            FieldClass = FlowField;
            CalcFormula = lookup("SUPPLIER PAYMENT REQUEST"."1st Payment Date" where(Number = field("Document No.")));
        }


        field(70116; "RFP 2nd Payment Date"; Date)
        {
            //OptionMembers = " ","Manager","Project Manager","Finance";
            FieldClass = FlowField;
            CalcFormula = lookup("SUPPLIER PAYMENT REQUEST"."2nd Payment Date" where(Number = field("Document No.")));
        }

        field(70117; "RFP 3rd Payment Date"; Date)
        {
            //OptionMembers = " ","Manager","Project Manager","Finance";
            FieldClass = FlowField;
            CalcFormula = lookup("SUPPLIER PAYMENT REQUEST"."3rd Payment Date" where(Number = field("Document No.")));
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