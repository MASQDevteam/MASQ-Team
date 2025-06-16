pageextension 70101 "Sales line extension" extends "Sales Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Qty to Split"; Rec."Qty to Split")
            {
                ApplicationArea = All;
                Visible = visibleQTYSplit;
                Editable = (Rec."MASQ Purchase Order No." = '') and (Rec."Qty to Split" = 0);
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    SplitSOLines();
                end;
            }
            field("Original Quantity"; Rec."Original Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Original Quantity field.', Comment = '%';
                Editable = false;
                Enabled = false;
                BlankZero = true;
            }
            field("Remaining Quantity Shipped"; Rec."Remaining Quantity Shipped")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remaining Quantity Shipped field.', Comment = '%';
                Editable = false;
                Enabled = false;
            }
            field("Quantity Shipped"; Rec."Quantity Shipped")
            {
                ApplicationArea = All;

            }
            field("Quantity Invoiced"; Rec."Quantity Invoiced")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
            }
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
            }
            field("Line is Splitted"; Rec."Line is Splitted")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line is Splitted field.', Comment = '%';
            }
            field("Splitted Line No."; Rec."Splitted Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Splitted Line No. field.', Comment = '%';
            }
            field("MASQ Purchase Order Line No."; Rec."MASQ Purchase Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Purchase Order Line No. field.', Comment = '%';
            }
            field("MASQ Purchase Order No."; Rec."MASQ Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MASQ Purchase Order No. field.', Comment = '%';
            }
            field("Original Line No."; Rec."Original Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Original Line No. field.', Comment = '%';
            }
            field("Original PO Line No."; Rec."Original PO Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Line No. field.', Comment = '%';
            }
            field("VO Number"; Rec."VO Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VO Number field.', Comment = '%';
            }
            field("Initial ETR"; Rec."Initial ETR")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETR field.', Comment = '%';
            }
            field("Initial ETD"; Rec."Initial ETD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETD field.', Comment = '%';
            }
            field("Initial ETA"; Rec."Initial ETA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETA field.', Comment = '%';
            }
            field("Initial ETAW"; Rec."Initial ETAW")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Initial ETAW field.', Comment = '%';
            }
            field("Final ETR"; Rec."Final ETR")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETR field.', Comment = '%';
            }
            field("Final ETD"; Rec."Final ETD")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETD field.', Comment = '%';
            }
            field("Final ETA"; Rec."Final ETA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETA field.', Comment = '%';
            }
            field("Final ETAW"; Rec."Final ETAW")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final ETAW field.', Comment = '%';
            }
            field(ATA; Rec.ATA)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ATA field.', Comment = '%';
            }

        }
        modify(Quantity)
        {
            Editable = Rec."Line is Splitted" = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    local procedure SplitSOLines()
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        SalesLine4: Record "Sales Line";//added by AI on 17/04/2025
        LineSpacing: Integer;
        LinesSplitted: Boolean;

        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
    begin
        Rec.TestField("Quantity Shipped", 0);
        LinesSplitted := false;
        Rec.TestField("Qty to Split");
        IF Rec."Qty to Split" > Rec.Quantity then
            Error('Quantity shipped must be less than Quantity');
        Rec.TestField("Job No.");
        IF Rec."Line is Splitted" = false then begin
            Rec."Original Quantity" := Rec.Quantity;
            Rec."Original Line No." := Rec."Line No.";
            REc."Splitted Line No." := FORMAT(Rec."Line No.") + '0.1';
        end;
        //splitted line
        IF (Rec."Qty to Split" < Rec.Quantity) and (Rec."MASQ Purchase Order No." = '') and (Rec."Job No." <> '') then begin
            SalesLine.Init();
            SalesLine.Copy(Rec);
            SalesLine."Skip Line Checking " := true;
            //  EVALUATE(SalesLine."Line No.", IncStr(FORMAT(Rec."Line No.")));// + 1;//commented by AI on 17/04/2025 reason adding only 1 to the split line is showing error 'There is not enough space to insert correction lines.' on undo shipment

            //added by AI on 17/04/2025   
            LineSpacing := 0;
            Clear(SalesLine4);
            SalesLine4.SetRange("Document Type", SalesLine4."Document Type"::Order);
            SalesLine4.SetRange("Document No.", Rec."Document No.");
            SalesLine4."Document Type" := Rec."Document Type";
            SalesLine4."Document No." := Rec."Document No.";
            SalesLine4."Line No." := Rec."Line No.";
            SalesLine4.Find('=');
            if SalesLine4.Find('>') then begin
                LineSpacing := (SalesLine4."Line No." - Rec."Line No.") div 2;
            end else
                LineSpacing := 10000;

            SalesLine."Line No." := Rec."Line No." + LineSpacing;

            SalesLine.Validate(Quantity, SalesLine.Quantity - Rec."Qty to Split");
            SalesLine."Qty to Split" := 0;

            //SalesLine."Remaining Quantity Shipped" := SalesLine."Original Quantity" - SalesLine2."Quantity Shipped";
            SalesLine."Line is Splitted" := true;
            SalesLine."Splitted Line No." := IncStr(SalesLine."Splitted Line No.");
            SalesLine."Skip Line Checking " := false;
            SalesLine.Insert();

            LinesSplitted := true;
        end;


        Clear(SalesLine2);
        SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Order);
        SalesLine2.SetRange("Document No.", Rec."Document No.");
        SalesLine2.SetRange("Original Line No.", Rec."Original Line No.");
        SalesLine2.CalcSums("Qty to Split");

        Clear(SalesLine3);
        SalesLine3.SetRange("Document Type", SalesLine3."Document Type"::Order);
        SalesLine3.SetRange("Document No.", Rec."Document No.");
        SalesLine3.SetRange("Original Line No.", Rec."Original Line No.");
        //    PurchaseLine3.CalcSums("Quantity Shipped");
        //   Message(Format(PurchaseLine2."Quantity Shipped"));



        //line being modified
        Rec."Remaining Quantity Shipped" := Rec."Original Quantity" - SalesLine2."Qty to Split";
        IF LinesSplitted then begin
            Rec."Skip Line Checking " := true;
            Rec.Validate(Quantity, Rec."Qty to Split");
            rec."Line is Splitted" := true;
            Rec."Skip Line Checking " := false;
            REc.Modify();
        end;
        //  Rec."Disable fields after Shipping" := true;
        Rec."Remaining Quantity Shipped" := Rec."Original Quantity" - SalesLine2."Qty to Split" - Rec."Qty to Split";
        REc.Modify();


        SalesLine3.ModifyAll("Remaining Quantity Shipped", Rec."Original Quantity" - SalesLine2."Qty to Split" - Rec."Qty to Split");

        CurrPage.Update();
    end;


    trigger OnOpenPage()
    var
    begin
        Clear(UserSetup);
        UserSetup.Get(UserId);
        visibleQTYSplit := UserSetup."Can Split SO";

    end;

    var
        visibleQTYSplit: Boolean;
        UserSetup: Record "User Setup";
}