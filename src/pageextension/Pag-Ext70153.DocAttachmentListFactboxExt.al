pageextension 70153 "DocAttachmentListFactboxExt " extends "Doc. Attachment List Factbox"
{
    layout
    {
        //AN 03/07/25
        addafter("File Extension")
        {
            field(FileSizeTxt; Rec.FileSizeTxt)
            {
                ApplicationArea = All;
                Caption = 'File Size';
                Editable = false;
                ToolTip = 'The size of the file in KB or MB';
            }
        }
    }
}
