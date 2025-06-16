tableextension 70143 "Job Ext" extends "Job"
{
    fields
    {
        field(70122; "Shipping Quotation No."; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Shipping Quotation Project"."Comparison ID" where("Project Name" = field("No.")));
        }
    }
}
