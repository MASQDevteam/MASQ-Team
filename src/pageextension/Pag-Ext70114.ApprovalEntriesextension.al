pageextension 70114 "Approval Entries extension" extends "Approval Entries"
{
    layout
    {
        // Add changes to page layout here

        modify("Document No.")
        {
            Visible = true;

        }
        modify("Amount (LCY)")
        {
            Visible = true;
        }
        addafter("Amount (LCY)")
        {
            field("Supplier Name"; Rec."Supplier Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Name field.', Comment = '%';
            }
            field("Supplier Number"; Rec."Supplier Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Number field.', Comment = '%';


                trigger OnDrillDown()

                var
                    Vendor: Record Vendor;
                begin
                    Clear(Vendor);
                    Vendor.Get(Rec."Supplier Number");
                    Page.Run(page::"Vendor Card", Vendor);

                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Vendor: Record Vendor;
                begin
                    Clear(Vendor);
                    Vendor.Get(Rec."Supplier Number");
                    Page.Run(page::"Vendor Card", Vendor);

                end;
            }
            field("PO Number"; Rec."PO Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
            }
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval.';
            }
            field("RFP 1st Payment Date"; Rec."RFP 1st Payment Date") { ApplicationArea = All; }
            field("RFP 2nd Payment Date"; Rec."RFP 2nd Payment Date") { ApplicationArea = All; }
            field("RFP 3rd Payment Date"; Rec."RFP 3rd Payment Date") { ApplicationArea = All; }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}