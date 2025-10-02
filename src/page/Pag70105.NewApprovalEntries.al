page 70105 "New Approval Entries"
{
    // Editable = false;
    //  DeleteAllowed = false;
    //  ModifyAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Approval Entry";
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "Approval Entry" = md, tabledata "Workflow Event Queue" = d;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID";
                Rec."Table ID")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                }
                field("Approval Code"; Rec."Approval Code")
                {
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                }
                field("Approver ID"; Rec."Approver ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Approval Type"; Rec."Approval Type")
                {
                }
                field("Limit Type"; Rec."Limit Type")
                {
                }
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                }
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                }
                field("Record ID to Approve"; Rec."Record ID to Approve")
                {
                }
                field("Delegation Date Formula"; Rec."Delegation Date Formula")
                {
                }
                field("Number of Approved Requests"; Rec."Number of Approved Requests")
                {
                }
                field("Number of Rejected Requests"; Rec."Number of Rejected Requests")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Workflow Step Instance ID"; Rec."Workflow Step Instance ID")
                {
                }
                field("Related to Change"; Rec."Related to Change")
                {
                }
                field("PO Number"; Rec."PO Number")
                {
                    ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field.', Comment = '%';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ToolTip = 'Specifies the value of the Supplier Name field.', Comment = '%';
                }
                field("Supplier Number"; Rec."Supplier Number")
                {
                    ToolTip = 'Specifies the value of the Supplier Number field.', Comment = '%';
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ToolTip = 'Specifies the ID of the user who sent the approval request for the document to be approved.';
                }
                // field("Approval Field Number"; Rec."Approval Field Number")
                // {
                // }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Delete Entry")
            {
                ApplicationArea = All;
                Enabled = UserIdvar = 'ABDALLAH';

                trigger OnAction()
                begin
                    Rec.Delete();
                end;
            }
            action("Delete Workflow event queue Entry")
            {
                ApplicationArea = All;
                Enabled = UserIdvar = 'ABDALLAH';

                trigger OnAction()
                var
                    WorkfloweventQueue: Record "Workflow Event Queue";
                begin
                    WorkfloweventQueue.DeleteAll();
                end;
            }
            action("UpdateApproverto")
            {
                ApplicationArea = All;
                Enabled = UserIdvar = 'ABDALLAH';
                trigger OnAction()
                var
                    GLSetup: Record "General Ledger Setup";
                begin
                    Clear(GLSetup);
                    GLSetup.Get();
                    GLSetup.TestField("RFP Approver");
                    // IF Rec."Approver ID" = '' then begin
                    Rec.Validate("Approver ID", GLSetup."RFP Approver");
                    Rec.Modify();
                    //  end;
                end;
            }
            action("UpdateApprovertoABDULAZIZ")
            {
                ApplicationArea = All;
                Enabled = UserIdvar = 'ABDALLAH';
                trigger OnAction()
                begin
                    //  IF Rec."Approver ID" = '' then begin
                    Rec.Validate("Approver ID", 'ABDULAZIZ');
                    Rec.Modify();
                    //   end;
                end;
            }
            action("Update Approval Entries fields from RFP")
            {
                ApplicationArea = All;
                Enabled = UserIdvar = 'ABDALLAH';
                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    RFP: Record "SUPPLIER PAYMENT REQUEST";
                    Vendor: Record Vendor;
                begin
                    Clear(ApprovalEntry);
                    ApprovalEntry.SetRange("Table ID", Database::"SUPPLIER PAYMENT REQUEST");
                    if ApprovalEntry.FindSet() then
                        repeat
                            Clear(RFP);
                            RFP.Get(ApprovalEntry."Document No.");
                            ApprovalEntry."Supplier Number" := RFP.Supplier;
                            Clear(Vendor);
                            IF Vendor.Get(ApprovalEntry."Supplier Number") then
                                ApprovalEntry."Supplier Name" := Vendor.Name;

                            ApprovalEntry."PO Number" := RFP."PO#";
                            ApprovalEntry."Project Code" := RFP.Project; //NB MASQ
                            ApprovalEntry.Modify();
                        until ApprovalEntry.Next() = 0;
                end;
            }
        }

    }



    trigger OnModifyRecord(): Boolean
    var
    begin
        IF UserId <> 'ABDALLAH' then
            Error('no permission');
    end;

    trigger OnOpenPage()
    var
    begin

        UserIdvar := UserId;
    end;

    var

        UserIdvar: Text;
}

