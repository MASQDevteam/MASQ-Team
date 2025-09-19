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
            //FQ MASQ Start
            trigger OnValidate()
            begin
                if "Project Type" = "Project Type"::BM then
                    Validate("Project Submittal Type", "Project Submittal Type"::A);
            end;
            //FQ MASQ END
        }
        field(70124; "Project Submittal Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "A","O";
        }
        //FQ MASQ Start
        field(70125; "Project Status"; Enum "Project Status")
        {
            DataClassification = ToBeClassified;
        }
        //FQ MASQ End
        // field(70125; "Project Markup Value"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70126; "Project Markup %"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70127; "Invoiced Not Delivered Value"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70128; "Invoiced Not Delivered %"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70129; "Delivered Not Invoiced Value"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70130; "Delivered Not Invoiced %"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70131; "Invoiced and Delivered Value"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70132; "Invoiced and Delivered %"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70133; "Not Invoiced Not Delivered Value"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(70134; "Not Invoiced Not Delivered %"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
    }
    //FQ MASQ Start
    trigger OnAfterInsert()
    begin
        if Rec."Project Type" = Rec."Project Type"::BM then
            if Rec."Project Submittal Type" <> Rec."Project Submittal Type"::A then begin
                Rec."Project Submittal Type" := Rec."Project Submittal Type"::A;
                Rec.Modify();
            end;
    end;
    //FQ MASQ Start

}
