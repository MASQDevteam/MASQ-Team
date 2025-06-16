pageextension 70142 "job ledger entries extension" extends "Job Ledger Entries"
{

    layout
    {
        // Add changes to page layout here
        addafter("Total Cost (LCY)")
        {
            field("Actual (Total Cost) Freight"; Rec."Actual (Total Cost) Freight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Freight field.', Comment = '%';
            }
            field("Actual (Total Cost) Clearance"; Rec."Actual (Total Cost) Clearance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Clearance field.', Comment = '%';
            }
            field("Actual (Total Cost) Custom"; Rec."Actual (Total Cost) Custom")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Custom field.', Comment = '%';
            }
            field("Actual (Total Cost) Others"; Rec."Actual (Total Cost) Others")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Others field.', Comment = '%';
            }
            field("Actual (Total Cost) Insurance"; Rec."Actual (Total Cost) Insurance")//added on 10022025
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual (Total Cost) Insurance field.', Comment = '%';
            }
            field("Project Plannig Line No."; Rec."Project Plannig Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Project Plannig Line No. field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Transfer To Planning Lines")
        {
            action("update Charges")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    MASQSubscribers: Codeunit "MASQ Subs & Functions";
                begin
                    MASQSubscribers.UpdateChargesonJobLedgerEntry(Rec);
                end;
            }
            action("update Price")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    MASQSubscribers: Codeunit "MASQ Subs & Functions";
                begin
                    MASQSubscribers.updatepriceandAmount(Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}