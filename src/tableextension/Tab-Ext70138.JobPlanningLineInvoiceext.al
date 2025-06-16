tableextension 70138 "Job Planning Line Invoice ext" extends "Job Planning Line Invoice"
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Item no."; Code[50])
        {
            //  DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Job Planning Line"."No." where("Job No." = field("Job No."), "Job Task No." = field("Job Task No."), "Line No." = field("Job Planning Line No.")));
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