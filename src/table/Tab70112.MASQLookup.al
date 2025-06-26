table 70112 "MASQ Lookup"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "MASQ Lookup";
    LookupPageId = "MASQ Lookup";

    fields
    {
        field(1; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Airline","Port","Air Port",Origin,"Clearing Agent",Fitting,Liner,Beneficiary,"LC Applicant","Agent","Vendor Category",Incoterm,InsuranceCompany,Shape,Reflector,Model,"Lamp Source",Lamp,"Ip Code",Installation,"Hs Code",Housing,Frame,"Fitting Color",Driver,Diffuser,"Company Subtype","Color Temp",Bracket,"Beam Type";

        }
        field(2; "Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ORIGINS"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const(Origin));

        }
        
    }

    keys
    {
        key(Key1; Type, Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


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