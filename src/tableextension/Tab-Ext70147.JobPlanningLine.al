tableextension 70147 "Job Planning Line" extends "Job Planning Line"
{
    fields
    {
        field(70147; "Apollo Total Offer Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Job."Apollo Total Offer Value" where("No." = field("Job No.")));
        }
        field(70148; "Total Exported Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Job Planning Line".Quantity where("Job No." = field("Job No."), "Job Task No." = field("Job Task No.")));
            Editable = false;
        }
    }
}
