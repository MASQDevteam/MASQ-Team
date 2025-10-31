pageextension 70157 "Company Info Page Ext" extends "Company Information"
{
    layout
    {
        addafter("VAT Registration No.")
        {
            field("MOF #"; Rec."MOF #")
            {
                ApplicationArea = All;
            }
            //FQ MASQ **START
            field("SCC Module Enabled"; Rec."SCC Module Enabled")
            {
                ApplicationArea = All;
            }
            //FQ MASQ **END
        }
        addlast(Content)
        {
            group(Attachments)
            {
                Caption = 'Attachments';
                part(AttachmentPart; "Company Attachments Part")
                {
                    ApplicationArea = All;
                    SubPageLink = "Company Information ID" = field("Primary Key");
                }
            }
        }
    }
}
