tableextension 70125 "Requisition Line extension" extends "Requisition Line"
{
    fields
    {
        // Add changes to table fields here      
        field(70100;
        "Meg Item Type";
        Code[50])
        {
            Caption = 'Item Type';
            Description = 'Used in Delivery Order report';
        }
        field(70101; "MASQ Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "MASQ Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70103; "Include"; Boolean)//if  = yes will be send to the PO Line 
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            begin
                IF Rec.Include = true then begin
                    IF NOT Rec."Sent to PO" then
                        Rec.Validate(Quantity, Rec."Demand Quantity") else
                        Rec.Validate(Quantity, 0);
                end else
                    Rec.Validate(Quantity, 0);

                Rec.Modify();
            end;
        }
        field(70104; "Sent to PO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70105; "Job No."; Code[20])
        {
            Caption = 'Project No.';
            Editable = false;
            TableRelation = Job;
        }
        field(70106; "Job Task No."; Code[20])
        {
            Caption = 'Project Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(70107; "Job Planning Line No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            BlankZero = true;
            Caption = 'Project Planning Line No.';
        }

        field(70108; "Shortcut Dimension 1 Code MASQ"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }

        field(70109; "Shortcut Dimension 2 Code MASQ"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(70110; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                          Blocked = const(false));
        }
        field(70111; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                          Blocked = const(false));
        }
        field(70112; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                          Blocked = const(false));
        }
        field(70113; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                          Blocked = const(false));
        }
        field(70114; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                          Blocked = const(false));
        }
        field(70115; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                          Blocked = const(false));
        }
        field(70116; "PO from PR"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ProjectPlanningLines: Record "Job Planning Line";
                PurchaseRequest: Record "Purchase Request Header";
                PurchaseRequestLine: Record "Purchase Request Line";
            begin
                Clear(ProjectPlanningLines);//01012025
                IF ProjectPlanningLines.Get(Rec."Job No.", Rec."Job Task No.", Rec."Job Planning Line No.") then begin
                    IF Rec."Currency Code" = '' then
                        Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost (LCY)")//01/01/2025
                    else
                        Rec.Validate("Direct Unit Cost", ProjectPlanningLines."Unit Cost in Vendor Currency");
                end;
                Rec.Modify();

            end;
        }
        field(70117; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Purchase Header";
        }
        field(70118; "PO Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50046; "Append to PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Buy-from Vendor No." = field("Vendor No."));
            trigger OnValidate()
            var
                PurchaseRequestHeader: Record "Purchase Request Header";
                PurchaseHeader: Record "Purchase Header";
            begin
                if "Append to PO No." = '' then exit;
                if ("PO No." <> '') and (("PO from PR" = true) or (Include = true)) then
                    Error('Already linked to a PO!');
                PurchaseHeader.SetRange("No.", Rec."Append to PO No.");
                PurchaseHeader.SetRange("Buy-from Vendor No.", Rec."Vendor No.");
                if not PurchaseHeader.FindFirst() then
                    Error('Please choose another PO having same vendor!');

            end;
        }
        //AN 06/19/2025
        field(70119; "Meg Vendor Item Code"; Code[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Item Code';
            Editable = false;
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