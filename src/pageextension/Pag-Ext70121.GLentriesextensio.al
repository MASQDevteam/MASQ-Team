pageextension 70121 "GL entries extensio" extends "General Ledger Entries"
{
    layout
    {
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
        // Add changes to page actions here
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


    var
        SourceName: Text[100];
}