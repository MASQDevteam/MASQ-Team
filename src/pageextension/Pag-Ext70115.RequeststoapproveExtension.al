pageextension 70115 "Requests to approve Extension" extends "Requests to Approve"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Supplier Number"; Rec."Supplier Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Number field.', Comment = '%';
            }
            field("Supplier Name"; Rec."Supplier Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Name field.', Comment = '%';
            }
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.';
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
            // field("RFP 1st Payment Date"; Rec."RFP 1st Payment Date") { ApplicationArea = All; }
            // field("RFP 2nd Payment Date"; Rec."RFP 2nd Payment Date") { ApplicationArea = All; }
            // field("RFP 3rd Payment Date"; Rec."RFP 3rd Payment Date") { ApplicationArea = All; }
            field(Payment; Rec.Payment)
            {
                ApplicationArea = All;
            }
            field("Payment %"; Rec."Payment %")
            {
                ApplicationArea = All;
            }
            field("Payment Date"; Rec."Payment Date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(OpenRequests)
        {
            action("Open RFP")
            {
                ApplicationArea = All;
                Image = Open;

                trigger OnAction()
                var
                    RFP: Record "SUPPLIER PAYMENT REQUEST";
                begin
                    Clear(RFP);
                    RFP.SetRange(Number, Rec."Document No.");
                    Page.Run(Page::"Request for Payment", RFP);
                end;
            }
        }
    }

    var
        myInt: Integer;
}