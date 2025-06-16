table 70133 "Shipping Quotation Project"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Comparison ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            //  TableRelation = "Dimension Value".Code where("Dimension Code" = const('Project'));
            // Editable = false;e
        }

        // New Fields being added
        field(3; "Quotation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Clearance,Sea,Air,Inland;//added inland on 17/01/2025
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Status"; Enum "Approval Status")//added on 19/03/2025
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Shipping Quotation".Status where("Comparison ID" = field("Comparison ID"), "Quotation Type" = field("Quotation Type")));
        }
    }

    keys
    {
        key(Key1; "Comparison ID", "Quotation Type", "Project Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}