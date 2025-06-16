tableextension 70133 "Job ledger entry extension" extends "Job Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Actual (Total Cost) Freight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70101; "Actual (Total Cost) Custom"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Actual (Total Cost) Clearance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70103; "Actual (Total Cost) Others"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70104; "Actual (Total Cost) Insurance"; Decimal)//added on 10022025
        {
            DataClassification = ToBeClassified;
        }
        field(70105; "Project Plannig Line No."; Integer)//added to link the cost of the project planning lines
        {
            //   DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Job Usage Link"."Line No." where("Entry No." = field("Entry No.")));
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