pageextension 70111 "User Setup Extension" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(PhoneNo)
        {
            field("Travel request Position"; Rec."Travel request Position")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Travel request Position field.', Comment = '%';
            }
            field("Can edit RFP fields after post"; Rec."Can edit RFP fields after post")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can edit RFP fields after post field.', Comment = '%';
            }
            field("Remove PO lines from Container"; Rec."Remove PO lines from Container")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Remove PO lines from Container field.', Comment = '%';
            }
            field("Change Status of VO"; Rec."Change Status of VO")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Change Status of VO field.', Comment = '%';
            }
            field("Can Restore Sales Order"; Rec."Can Restore Sales Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Restore Sales Order field.', Comment = '%';
            }
            field("Can Remove Line in BL/AWB"; Rec."Can Remove Line in BL/AWB")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Remove Line in BL/AWB field.', Comment = '%';
            }
            field("Change Status of SQ"; Rec."Change Status of SQ")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Change Status of SQ field.', Comment = '%';
            }
            field("Can Edit Budget Control"; Rec."Can Edit Budget Control")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Edit Budget Control field.', Comment = '%';
            }
            field("Can Change Agent From Header"; Rec."Can Change Agent From Header")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Change Agent From Header field.', Comment = '%';
            }
            field("Can Submit Purchase Request"; Rec."Can Submit Purchase Request")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Submit Purchase Request field.', Comment = '%';
            }
            //AN 03/05/25
            field(Reciever; Rec.Reciever)
            {
                ApplicationArea = All;
            }
            //AN 03/06/25
            field("PO Reciever"; Rec."PO Reciever")
            {
                ApplicationArea = All;
            }
            //AN 03/05/25
            field("Submittal Cmt Rec"; Rec."Submittal Cmt Rec")
            {
                ApplicationArea = All;
            }
            //AN 03/05/25
            field("InterItem Reciever"; Rec."InterItem Reciever")
            {
                ApplicationArea = All;
            }
            //AN 03/05/25
            field("InterCust Reciever"; Rec."InterCust Reciever")
            {
                ApplicationArea = All;
            }
            //AN 03/05/25
            field("InterVend Reciever"; Rec."InterVend Reciever")
            {
                ApplicationArea = All;
            }
            //AN 03/05/25
            field("VO Reciever"; Rec."VO Reciever")
            {
                ApplicationArea = All;
            }
            //AN 08/04/2025
            field("Sent Email Approved SQ"; Rec."Sent Email Approved SQ")
            {
                ApplicationArea = All;
            }
            field("Input DynamicNum to Intermed."; Rec."Input DynamicNum to Intermed.")//added on 10/03/2025
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Input DynamicNum to Intermed. field.', Comment = '%';
            }
            field("Send Data to Other Companies"; Rec."Send Data to Other Companies")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Send Data to Other Companies field.', Comment = '%';
            }
            field("Can AttachFilesGreaterthan3MB"; Rec."Can AttachFilesGreaterthan3MB")
            {
                ApplicationArea = All;
            }
            field("Can Edit SO/PO Details"; Rec."Can Edit SO/PO Details")//added on 26/03/2025
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Edit SO/PO Details field.', Comment = '%';
            }
            field("Can Split SO"; Rec."Can Split SO")
            {
                ApplicationArea = All;
            }
            field("Can Edit Attachment ID"; Rec."Can Edit Attachment ID")
            {
                ApplicationArea = All;
            }
            field("Projects Reciever"; Rec."Projects Reciever")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Projects Reciever field.', Comment = '%';
            }
            field("Hide/Unhide Accounts in COA"; Rec."Hide/Unhide Accounts in COA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Hide/Unhide Accounts in COA field.', Comment = '%';
            }
            field("Sent Email Project Card"; Rec."Sent Email Project Card")
            {
                ApplicationArea = All;
            }

            //NB MASQ Start
            field("Edit Payment Line"; Rec."Edit Payment Line")
            {
                ApplicationArea = All;
            }
            field("Payment Journal Template"; Rec."Payment Journal Template")
            {
                ApplicationArea = All;
            }
            field("Payment Journal Batch"; Rec."Payment Journal Batch")
            {
                ApplicationArea = All;
            }
            field("Create Direct RFP"; Rec."Create Direct RFP")
            {
                ApplicationArea = All;
            }
            //NB MASQ End
            // FQ MASQ Start
            field(BypassCustOnProject; Rec.BypassCustOnProject)
            {
                ApplicationArea = All;
                Caption = 'Bypass customer check on Project Card';
            }
            field("Can View SO Customer Fields"; Rec."Can View SO Customer Fields")
            {
                ApplicationArea = All;
            }
            field("Skip Project Qty.trans Inv"; Rec."Skip Project Qty.trans Inv")
            {
                ApplicationArea = All;
            }
            field("Create Direct SCC"; Rec."Create Direct SCC")
            {
                ApplicationArea = All;
            }
            field(Procurement; Rec.Procurement)
            {
                ApplicationArea = All;
            }

            // FQ MASQ End

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}