pageextension 70121 "GL entries extensio" extends "General Ledger Entries"
{
    layout
    {
        addafter("Shortcut Dimension 7 Code")
        {
            field("Expense Category Description"; Rec."Expense Category Description")
            {
                Caption = 'Expense Category Description';
                ApplicationArea = All;
                ToolTip = 'Displays the description of the expense category based on the default dimension.';
                Editable = false;
            }
        }
        // Add changes to page layout here
        addafter("Source No.")
        {
            field("MASQ Source Name"; SourceName)
            {
                Caption = 'Source Name';
                ApplicationArea = All;
            }
            field("Travel Request Code"; Rec."Travel Request Code")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("&Navigate")
        {
            action(FillExpenseCatDesc)
            {
                ApplicationArea = All;
                Caption = 'Fill Expense Category Description';
                ToolTip = 'Fills the Expense Category Description based on the Default Dimension.';
                Image = Edit;
                trigger OnAction()
                begin
                    FillExpenseCatDesc();
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    var
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAccount: Record "Bank Account";
        Employee: Record Employee;
    begin
        SourceName := '';
        Case Rec."Source Type" of
            Rec."Source Type"::Customer:
                If Cust.GET(Rec."Source No.") then
                    SourceName := Cust.Name;
            Rec."Source Type"::Vendor:
                If Vend.GET(Rec."Source No.") then
                    SourceName := Vend.Name;
            Rec."Source Type"::"Fixed Asset":
                If FA.GET(Rec."Source No.") then
                    SourceName := FA.Description;
            Rec."Source Type"::"Bank Account":
                If BankAccount.GET(Rec."Source No.") then
                    SourceName := BankAccount.Name;
            Rec."Source Type"::Employee:
                If Employee.GET(Rec."Source No.") then
                    SourceName := Employee.FullName();
        end;
    end;

    local procedure FillExpenseCatDesc()
    var
        DimensionSetEntry: Record "Dimension Set Entry";
    begin
        repeat
            DimensionSetEntry.SetRange("Dimension Code", 'EXPENSE CATEGORY');
            DimensionSetEntry.SetRange("Dimension Value Code", Rec."Shortcut Dimension 7 Code");
            if DimensionSetEntry.FindFirst() then begin
                DimensionSetEntry.CalcFields("Dimension Value Name");
                Rec."Expense Category Description" := DimensionSetEntry."Dimension Value Name";
            end
            else
                Rec."Expense Category Description" := '';
            Rec.Modify(true);
        until Rec.Next() = 0;
    end;

    var
        SourceName: Text[100];
}