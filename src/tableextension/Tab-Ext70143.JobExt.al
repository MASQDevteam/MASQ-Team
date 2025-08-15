tableextension 70143 "Job Ext" extends "Job"
{
    fields
    {
        field(70122; "Shipping Quotation No."; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Shipping Quotation Project"."Comparison ID" where("Project Name" = field("No.")));
        }
        field(70123; "Project Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "BM","PM";
        }
        field(70124; "Project Submittal Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "A","O";
        }
        field(70125; "Project Markup Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70126; "Project Markup %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70127; "Invoiced Not Delivered Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70128; "Invoiced Not Delivered %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70129; "Delivered Not Invoiced Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70130; "Delivered Not Invoiced %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70131; "Invoiced and Delivered Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70132; "Invoiced and Delivered %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70133; "Not Invoiced Not Delivered Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70134; "Not Invoiced Not Delivered %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}
