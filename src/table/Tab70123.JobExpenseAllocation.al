table 70123 "Job Expense Allocation"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Job Expense Allocation Subform";//added to lookup flowfield
    DrillDownPageId = "Job Expense Allocation Subform";

    fields
    {
        // Expense Allocation Fields
        field(2; "Allocation ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Job#"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Information";
        }

        field(4; "Expense Type"; Option)
        {
            OptionCaption = 'Labor, Materials, Transportation, Equipment, Consulting, Travel, Insurance, Permits, Utilities, Office Supplies, Marketing, Subcontractor, Legal Fees, Miscellaneous, Contingency, Taxes, Training, Software, Maintenance, "Inbound Freight", "Outbound Freight", Warehousing, "Customs and Duties", Packaging, "Inventory Management", "Storage Fees", "Handling Fees", "Freight Insurance", "Supply Chain Consulting", TMS, "Order Fulfillment", "Cross-Docking", Repacking, "Supply Chain Technology", "Cold Storage", "Freight Charges", "Distribution Costs", "Port Fees", "Returns Management"';
            OptionMembers = Labor,Materials,Transportation,Equipment,Consulting,Travel,Insurance,Permits,Utilities,"Office Supplies",Marketing,Subcontractor,"Legal Fees",Miscellaneous,Contingency,Taxes,Training,Software,Maintenance,"Inbound Freight","Outbound Freight",Warehousing,"Customs and Duties",Packaging,"Inventory Management","Storage Fees","Handling Fees","Freight Insurance","Supply Chain Consulting",TMS,"Order Fulfillment","Cross-Docking",Repacking,"Supply Chain Technology","Cold Storage","Freight Charges","Distribution Costs","Port Fees","Returns Management";
            DataClassification = ToBeClassified;
        }



        field(5; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Subjob ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Subjob ID';
        }
        field(9; "Project Code"; Code[50])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Subjob Information"."Project Code" where("Job#" = field("Job#"), "Subjob ID" = field("Subjob ID")));
        }
    }

    keys
    {
        key(PK; "Job#", "Subjob ID", "Allocation ID")
        {
            Clustered = true;
        }

        key(FK_JobLink; "Allocation ID")
        {
            Clustered = false;
        }
    }
}
