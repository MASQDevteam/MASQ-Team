table 70103 "Travel Request"
{
    DataClassification = ToBeClassified;

    // Fields definition
    fields
    {
        field(1; "Traveler's Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Traveler Name';
            Editable = false;
        }

        field(2; "Project Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECT'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if "Project Code" <> '' then begin
                    DimensionValue.SetRange(Code, Rec."Project Code");
                    if DimensionValue.FindFirst() then begin
                        "Project Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Project Name" := '';
            end;
        }

        field(3; "Branch"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if Branch <> '' then begin
                    DimensionValue.SetRange(Code, Rec.Branch);
                    if DimensionValue.FindFirst() then begin
                        "Branch Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Branch Name" := '';
            end;
        }

        field(4; "Destination"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }

        field(5; "Reason for Travel"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(6; "Departure"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(7; "Return"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(8; "Travel Advance Required"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Budget Travel Amount';
        }

        field(9; "No of Worked Holidays&Weekends"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(10; "Approved By Manager"; Code[50])
        {
            // DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field(Number), Status = const(Approved), "Travel Request Position" = const("Project Manager")));
        }

        field(11; "Approved By Project Manager"; Code[50])
        {
            // DataClassification = CustomerContent;  
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field(Number), Status = const(Approved), "Travel Request Position" = const("Project Manager")));
        }

        field(12; "Approved By Finance"; Code[50])
        {
            // DataClassification = CustomerContent;  
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field(Number), Status = const(Approved), "Travel Request Position" = const("Finance")));
        }


        field(14; "Traveling by Air"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Traveling by Air" = true then begin
                    "Traveling by Road" := false;
                    "Traveling Both" := false;
                end;
            end;
        }

        field(15; "Traveling by Road"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Traveling by Road" = true then begin
                    "Traveling by Air" := false;
                    "Traveling Both" := false;
                end;
            end;
        }

        field(16; "Traveling Both"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Traveling Both" = true then begin
                    "Traveling by Air" := false;
                    "Traveling by Road" := false;
                end;
            end;
        }

        field(17; "Airline"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(18; "Time of Departure"; Time)
        {
            DataClassification = CustomerContent;
        }

        field(19; "Time of Return"; Time)
        {
            DataClassification = CustomerContent;
        }

        field(20; "Specific Requests"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Number"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;


        }
        field(23; "Status"; Enum "Document Status")
        {
            DataClassification = ToBeClassified;
        }
        // field(24; "Status Details"; Integer)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = count("Approval Entry" WHERE("Document No." = FIELD(Number)));
        //     //  Editable = false;

        // }
        field(25; "Approval Entries"; code[50])
        {
            Caption = 'Approval Entries';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Document No." where("Document No." = field(Number)));
        }

        field(27; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(28; "Travel Type"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('TRAVEL TYPE'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if "Travel Type" <> '' then begin
                    DimensionValue.SetRange(Code, Rec."Travel Type");
                    if DimensionValue.FindFirst() then begin
                        "Travel Type Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Travel Type Name" := '';
            end;
        }
        field(29; "Travel Category"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('TRAVEL CATEGORY'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if "Travel Category" <> '' then begin
                    DimensionValue.SetRange(Code, Rec."Travel Category");
                    if DimensionValue.FindFirst() then begin
                        "Travel Category Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Travel Category Name" := '';
            end;
        }
        field(30; "Department"
        ; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if Department <> '' then begin
                    DimensionValue.SetRange(Code, Rec.Department);
                    if DimensionValue.FindFirst() then begin
                        "Department Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Department Name" := '';
            end;
        }
        field(31; "Job"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('JOB'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if Job <> '' then begin
                    DimensionValue.SetRange(Code, Rec.Job);
                    if DimensionValue.FindFirst() then begin
                        "Job Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Job Name" := '';
            end;
        }
        field(32; "Traveler Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                if "Traveler Code" <> '' then begin
                    DimensionValue.SetRange(Code, Rec."Traveler Code");
                    if DimensionValue.FindFirst() then begin
                        "Traveler's Name" := DimensionValue.Name;
                    end;
                end
                else
                    "Traveler's Name" := '';
            end;
        }
        field(34; Ticket; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                AdvanceReqCalc();
            end;
        }
        field(35; Hotel; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                AdvanceReqCalc();
            end;
        }

        field(36; "Perdiem"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                AdvanceReqCalc();
            end;
        }
        field(37; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Document Attachment ID"; Integer)
        {

        }
        field(39; "Document Attachment Table ID"; Integer)
        {

        }
        field(40; "Document Attachment No."; Code[20])
        {

        }
        field(41; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(42; "Document Attachment Line No."; Integer)
        {
        }
        field(43; "Project Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(44; "Job Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(45; "Branch Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(46; "Travel Type Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(47; "Travel Category Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(48; "Department Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(49; "Departure Country"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        //AN 03/11/25-
    }

    // Table properties
    keys
    {
        key(PK; Number)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        //NoSeriesManagement: Codeunit NoSeriesManagement;
        TravelRequest: Record "Travel Request";
    begin
        //    if "Number" = '' then begin
        GLSetup.Get();
        GLSetup.TestField("Travel Request No. Series");
        //NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(GLSetup."Travel Request No. Series", xRec."No. Series", 0D, Rec."Number", Rec."No. Series", IsHandled);
        //  if not IsHandled then begin
        if NoSeries.AreRelated(GLSetup."Travel Request No. Series", xRec."No. Series") then
            Rec."No. Series" := xRec."No. Series"
        else
            Rec."No. Series" := GLSetup."Travel Request No. Series";

        if Rec."Number" = '' then begin// FQ MASQ
            Rec."Number" := NoSeries.GetNextNo(Rec."No. Series");
            TravelRequest.ReadIsolation(IsolationLevel::ReadUncommitted);
            TravelRequest.SetLoadFields("Number");
            while TravelRequest.Get(Rec."Number") do
                Rec."Number" := NoSeries.GetNextNo(Rec."No. Series");
        End;
        // NoSeriesManagement.RaiseObsoleteOnAfterInitSeries(Rec."No. Series", GLSetup."Travel Request No. Series", 0D, Rec."Number");
        //   end;
        //  end;
    end;
    //AN 03/11/25+ 
    local procedure AdvanceReqCalc()
    var
        myInt: Integer;
    begin
        "Travel Advance Required" := Ticket + Hotel + Perdiem;
    end;

}
