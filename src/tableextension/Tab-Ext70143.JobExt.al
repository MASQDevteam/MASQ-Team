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
    }
}
