table 70126 "Purchase Request Header"
{
    Caption = 'Purchase Request Header';
    DataCaptionFields = "No.", Requester;
    LookupPageID = "Purchase Request Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Date; Date)
        {
            Editable = false;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Closed,Pending Approval,Released,Declined';
            OptionMembers = Open,Closed,"Pending Approval",Released,Declined;
        }
        field(4; "Vendor No."; Code[20])
        {
            Editable = false;
            TableRelation = Vendor;
        }
        field(5; Requester; Code[50])
        {
            Editable = false;
            TableRelation = User."User Name";

            // trigger OnValidate()
            // begin
            //     UserSetup.RESET;
            //     UserSetup.SETRANGE("User ID", Requester);
            //     IF UserSetup.FINDFIRST THEN BEGIN
            //         "Approver ID" := UserSetup."Approver ID";
            //         VALIDATE("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            //         VALIDATE("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            //     END;
            // end;
        }
        field(6; "Lines Need Approve Exist"; Boolean)
        {
            CalcFormula = Exist("Purchase Request Line" WHERE("Document No." = FIELD("No."), Assigned = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                IF "Currency Code" <> xRec."Currency Code" THEN
                    UpdateAllLineCurr;
            end;
        }
        field(11; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(50000; "Approved By"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(50001; "Approved By Admin"; Boolean)
        {
        }
        field(50002; "Rejected By"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(50003; Editable; Boolean)
        {
            Editable = false;
        }
        field(50004; "Approver ID"; Code[50])
        {
            Editable = false;
        }
        field(50005; NoApproved; Integer)
        {
        }
        field(50006; Reason; Text[50])
        {
        }
        field(50007; "Total Amount Assigned"; Decimal)
        {
            CalcFormula = Sum("Purchase Request Line"."Total Cost" WHERE("Document No." = FIELD("No."), Assigned = CONST(true)));
            FieldClass = FlowField;
        }
        field(50008; "Total Line Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("Purchase Request Line"."Line Amount (LCY)" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50009; "Total Amount Assigned (LCY)"; Decimal)
        {
            CalcFormula = Sum("Purchase Request Line"."Line Amount (LCY)" WHERE("Document No." = FIELD("No."), Assigned = CONST(true)));
            FieldClass = FlowField;
        }
        field(50010; "Total Line Amount"; Decimal)
        {
            CalcFormula = Sum("Purchase Request Line"."Total Cost" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50011; "Dimension Set ID"; Integer)
        {


        }
        field(50012; "Progress Status"; Option)
        {
            OptionCaption = 'Waiting release,Waiting invoice,waiting quotation';
            OptionMembers = "Waiting release","Waiting invoice","waiting quotation";
        }
        field(50013; "Total Line Expected Amount"; Decimal)
        {
            CalcFormula = Sum("Purchase Request Line"."Expected Total Cost" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50014; "Status Details"; Boolean)
        {
            CalcFormula = Exist("Approval Entry" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Marked for Approval"; Boolean)
        {
            Editable = false;
        }
        field(50016; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            TableRelation = "Incoming Document";

        }
        field(50017; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

        }
        field(50018; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(50019; "First Item Description"; Text[100])
        {
            CalcFormula = Lookup("Purchase Request Line"."Item Description" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50020; "Total Line Amount Inc. VAT"; Decimal)
        {
            CalcFormula = Sum("Purchase Request Line"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50021; "Sender Id"; Code[50])
        {
        }
        field(50022; "Sales Order No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Assigned"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Project No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
        }
        //AN 06/27/2025+
        field(50052; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Total Line Amount" <> 0 then
                    "Discount Amount" := Round(("Total Line Amount" * "Discount %") / 100, 0.01);

                RecalculateDiscountTotals();
            end;
        }

        field(50053; "Discount Amount"; Decimal)
        {
            Caption = 'Discount Amount';

            trigger OnValidate()
            begin
                if "Total Line Amount" <> 0 then
                    "Discount %" := Round(("Discount Amount" / "Total Line Amount") * 100, 0.01);

                RecalculateDiscountTotals();
            end;
        }

        field(50054; "Total After Discount"; Decimal)
        {
            Caption = 'Total After Discount';
            Editable = false;
        }

        field(50055; "Total After Discount Incl. VAT"; Decimal)
        {
            Caption = 'Total After Discount Incl. VAT';
            Editable = false;
        }
        //AN 06/27/2025-
    }


    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);

        // IF UserSetup.GET(USERID) THEN
        //     IF NOT UserSetup."Allow Delete Purch. Request" THEN
        //         ERROR(CannotDelete);

        // //IF "Req. Status"="Req. Status"::New THEN BEGIN
        // PurchReqLine.SETRANGE("Document No.", "No.");
        // PurchReqLine.DELETEALL(TRUE);
        // //END
        // //ELSE ERROR('! No Permission');
    end;

    trigger OnInsert()
    begin
        PurchaseSetup.GET();
        IF "No." = '' THEN BEGIN
            PurchaseSetup.TESTFIELD(PurchaseSetup."Purchase Request Nos.");
            "No." := NoSeriesMgt.GetNextNo(PurchaseSetup."Purchase Request Nos.", WORKDATE, TRUE);
        END;

        VALIDATE(Date, WORKDATE);

        PageStartup := TRUE;
        VALIDATE(Requester, USERID);
        PageStartup := FALSE;

        //EDM
        Editable := TRUE;
        //EDM
    end;

    trigger OnModify()
    begin
        IF Status = Status::Closed THEN
            ERROR('Cannot modify closed Request');

        //IF Status=Status::"Pending Approval" THEN
        //  ERROR('Request is pending approval');
    end;

    //AN 06/27/2025+
    procedure RecalculateDiscountTotals()
    var
        VATAmount: Decimal;
    begin
        CalcFields("Total Line Amount", "Total Line Amount Inc. VAT");
        "Total After Discount" := "Total Line Amount" - "Discount Amount";
        VATAmount := "Total Line Amount Inc. VAT" - "Total Line Amount";
        "Total After Discount Incl. VAT" := "Total After Discount" + VATAmount;
    end;
    //AN 06/27/2025-
    var
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        PurchReqLine: Record "Purchase Request Line";
        DimMgt: Codeunit DimensionManagement;
        Text051: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        User: Record User;
        InsertFromPortal: Boolean;
        PageStartup: Boolean;
        Text052: Label 'Changing the currency code will force amount of all lines to be reset to 0.\\Do you want to proceed?';
        Text053: Label 'You must reset the amount before changing the currency code.';
        Text054: Label 'You may have changed dimensions. This will affect budgets in line allocation.\Do you want to update lines allocation budgets?';
        Text025: Label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: Label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        CannotDelete: Label 'User has no permission to delete Purchase Request';

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        IF NOT PageStartup THEN BEGIN
            IF "No." <> '' THEN
                MODIFY;

            IF (OldDimSetID <> "Dimension Set ID") AND (NOT InsertFromPortal) THEN BEGIN
                MODIFY;
                IF PurchLinesExist THEN BEGIN
                    UpdateAllLineDim("Dimension Set ID", OldDimSetID);
                    //IF FieldNumber = 1 THEN //Updating Activities Code in Purchase Request Header => Update Lines Allocation Budgets
                    //   UpdateAllLineAllocJobAndDimension;
                END;
            END;
        END;
    end;


    procedure PurchLinesExist(): Boolean
    begin
        PurchReqLine.RESET;
        PurchReqLine.SETRANGE("Document No.", "No.");
        EXIT(PurchReqLine.FINDFIRST);
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
    begin
        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;
        IF NOT CONFIRM(Text051) THEN
            EXIT;

        PurchReqLine.RESET;
        PurchReqLine.SETRANGE("Document No.", "No.");
        PurchReqLine.LOCKTABLE;
        IF PurchReqLine.FIND('-') THEN
            REPEAT
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchReqLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF PurchReqLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    PurchReqLine."Dimension Set ID" := NewDimSetID;

                    //IF NOT HideValidationDialog AND GUIALLOWED THEN
                    //  VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchReqLine."Dimension Set ID", PurchReqLine."Shortcut Dimension 1 Code", PurchReqLine."Shortcut Dimension 2 Code");
                    //IF "Global Dimension 2 Code" <> PurchReqLine."Job No." THEN
                    //  PurchReqLine.VALIDATE("Job No.", "Global Dimension 2 Code");
                    PurchReqLine.MODIFY;
                END;
            UNTIL PurchReqLine.NEXT = 0;
    end;



    procedure SetPortalVariables()
    begin
        InsertFromPortal := TRUE;
    end;

    local procedure UpdateAllLineCurr()
    begin
        //TESTFIELD(Status, Status::Open);

        IF CONFIRM(Text052) THEN BEGIN
            PurchReqLine.RESET;
            PurchReqLine.SETRANGE("Document No.", "No.");
            PurchReqLine.LOCKTABLE;
            IF PurchReqLine.FINDFIRST THEN
                REPEAT
                    PurchReqLine.CALCFIELDS("Currency Code");
                    PurchReqLine.VALIDATE("Expected Unit Cost", 0);
                    PurchReqLine.VALIDATE("Unit Cost", 0);
                    PurchReqLine.MODIFY;
                UNTIL PurchReqLine.NEXT = 0;
        END ELSE
            ERROR(Text053);
    end;

}

