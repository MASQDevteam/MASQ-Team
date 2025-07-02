table 70120 "Shipping Quotation"
{
    DataClassification = ToBeClassified;


    LookupPageId = "Shipping Quotations List";
    DrillDownPageId = "Shipping Quotations List";

    fields
    {


        /* field(2; "Project Name"; Text[100])
         {
             DataClassification = ToBeClassified;
             //  TableRelation = Job;
             //  TableRelation = "Dimension Value".Code where("Dimension Code" = const('Project'));
             // Editable = false;e

             trigger OnLookup()

             var
                 Job: Record Job;
                 JobListPage: page "Job List";
             begin
                 "Project Name" := '';
                 Clear(Job);
                 Clear(JobListPage);
                 JobListPage.SetTableView(job);
                 JobListPage.LookupMode(true);
                 IF JobListPage.RunModal() = Action::LookupOK then begin

                     JobListPage.SetSelectionFilter(Job);
                     if job.FindSet() then
                         repeat
                             "Project Name" += job."No." + ' | ';
                         until Job.Next() = 0;

                 end;

                 "Project Name" := CopyStr("Project Name", 1, StrLen("Project Name") - 3);
             end;
         }*/

        // New Fields being added
        field(3; "Comparison ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "AOD"; Code[100])
        {

            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const("Air Port"));
            //Aiport of Discharge
        }

        field(5; "NW (Net Weight)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Incoterm"; code[50])
        {
            TableRelation = "MASQ Lookup".Code where(Type = const(Incoterm));
            //    OptionCaption = 'EXW, FCA, CPT, CIP, DAP, DPU, DDP, FAS, FOB, CFR, CIF';
            //    OptionMembers = EXW,FCA,CPT,CIP,DAP,DPU,DDP,FAS,FOB,CFR,CIF;
            DataClassification = ToBeClassified;
        }

        field(7; "GW (Gross Weight)"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                IF (Rec."GW (Gross Weight)" <> 0) and (Rec."Volumetric Weight" <> 0) then begin
                    IF Rec."GW (Gross Weight)" >= Rec."Volumetric Weight" then
                        Rec."Chargeable Weight" := Rec."GW (Gross Weight)" else
                        Rec."Chargeable Weight" := Rec."Volumetric Weight";
                end;
            end;
        }

        field(8; "Option"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Volumetric Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                IF (Rec."GW (Gross Weight)" <> 0) and (Rec."Volumetric Weight" <> 0) then begin
                    IF Rec."GW (Gross Weight)" >= Rec."Volumetric Weight" then
                        Rec."Chargeable Weight" := Rec."GW (Gross Weight)" else
                        Rec."Chargeable Weight" := Rec."Volumetric Weight";
                end;
            end;
        }

        field(10; "Chargeable Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "AOL"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const("Air Port"));
            //airport of loading
        }
        field(12; "Qty of CTR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "POL (Port of Loading)"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
        }


        field(14; "POD (Port of Discharge)"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const(Port));
        }
        field(15; "Fitting"; Code[50])
        {
            Caption = 'Fitting';
            // Set up a lookup to your fitting master table here 
            TableRelation = "MASQ Lookup".Code where(Type = const(Fitting));
        }
        field(16; "Quotation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Clearance,Sea,Air,Inland;//added inland on 17/01/2025
        }
        field(17; Status; Enum "Approval Status")
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Attachment ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Document Attachment ID"; Integer)
        {

        }
        field(20; "Document Attachment Table ID"; Integer)
        {

        }
        field(21; "Document Attachment No."; Code[20])
        {

        }
        field(22; "Document Attachment Doc. Type"; Enum "Attachment Document Type")
        {

        }
        field(23; "Document Attachment Line No."; Integer)
        {
        }
        field(24; "Document Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Decision"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Reason Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(27; "Agent"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "MASQ Lookup".Code where(Type = const("Agent"));
        }
        field(28; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Express","Cargo";
        }
        // Existing fields (not changed):
        /*    field(12; "Shipping Cost"; Decimal)
            {
                DataClassification = ToBeClassified;
            }

            field(13; "Insurance Cost"; Decimal)
            {
                DataClassification = ToBeClassified;
            }

            field(14; "Import Duties"; Decimal)
            {
                DataClassification = ToBeClassified;
            }

            field(15; "Total Cost"; Decimal)
            {
                DataClassification = ToBeClassified;
            }*/

        /*    field(16; "Incoterm Description"; Text[250])
            {
                DataClassification = ToBeClassified;
            }

            field(17; "Delivery Address"; Text[200])
            {
                DataClassification = ToBeClassified;
            }

            field(18; "Delivery Date"; Date)
            {
                DataClassification = ToBeClassified;
            }

            field(19; "Validity Date"; Date)
            {
                DataClassification = ToBeClassified;
            }*/
        field(30; "Document Reference"; Text[1000])
        {
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                PurchaseHeader: Record "Purchase Header";
                PurchaseOrders: page "Purchase Order List";
            begin
                Rec."Document Reference" := '';
                Clear(PurchaseHeader);
                Clear(PurchaseOrders);
                PurchaseOrders.SetTableView(PurchaseHeader);
                PurchaseOrders.LookupMode(true);
                IF PurchaseOrders.RunModal() = Action::LookupOK then begin

                    PurchaseOrders.SetSelectionFilter(PurchaseHeader);
                    if PurchaseHeader.FindSet() then
                        repeat
                            Rec."Document Reference" += PurchaseHeader."No." + ' , ';
                        until PurchaseHeader.Next() = 0;

                end;
                if Rec."Document Reference" <> '' then
                    Rec."Document Reference" := CopyStr(Rec."Document Reference", 1, StrLen(Rec."Document Reference") - 3);
            end;
        }
        field(31; "Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Project No."; Text[100])
        {
            Editable = false;
            CalcFormula = lookup("Shipping Quotation Project"."Project Name" where("Comparison ID" = field("Comparison ID")));
            FieldClass = FlowField;
            Caption = 'Apollo Project No.';
        }
        field(34; Transhipment; Option)
        {
            OptionMembers = Direct,Indirect;
        }
    }

    keys
    {
        key(PK; "Comparison ID")
        {
            Clustered = true;
        }
    }
}
