namespace MASQTeam.MASQTeam;
using System.IO;
using Microsoft.Foundation.Attachment;

page 70180 "Company Attachments Part"
{
    ApplicationArea = All;
    Caption = 'Attachments';
    PageType = ListPart;
    SourceTable = "Company Attachments";
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.', Comment = '%';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        FileMgt: Codeunit "File Management";
                        InStream: InStream;
                        OutStream: OutStream;
                        FileName: Text;
                        RecRef: RecordRef;
                    begin
                        Rec.CalcFields("File Content");
                        if Rec."File Content".HasValue then begin
                            Rec."File Content".CreateInStream(InStream);
                            DownloadFromStream(InStream, '', '', Rec."File Extension", Rec."File Name");
                        end else begin
                            if UploadIntoStream('Select File', '', '', FileName, InStream) then begin
                                Rec.Init();
                                Rec."File Name" := FileName;
                                Rec."Uploaded By" := UserId;
                                Rec."Uploaded DateTime" := CurrentDateTime;
                                Rec."File Extension" := FileMgt.GetExtension(FileName);

                                Clear(Rec."File Content");
                                Rec."File Content".CreateOutStream(OutStream);
                                CopyStream(OutStream, InStream);
                                Rec.Insert(true);
                            end;
                        end;
                    end;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ToolTip = 'Specifies the value of the File Extension field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ToolTip = 'Specifies the value of the Uploaded By field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Uploaded DateTime"; Rec."Uploaded DateTime")
                {
                    ToolTip = 'Specifies the value of the Uploaded DateTime field.', Comment = '%';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(UploadFile)
            {
                Caption = 'Upload File';
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                var
                    FileMgt: Codeunit "File Management";
                    InStream: InStream;
                    OutStream: OutStream;
                    FileName: Text;
                    RecRef: RecordRef;
                begin
                    if UploadIntoStream('Select File', '', '', FileName, InStream) then begin
                        Rec.Init();
                        Rec."File Name" := FileName;
                        Rec."Uploaded By" := UserId;
                        Rec."Uploaded DateTime" := CurrentDateTime;
                        Rec."File Extension" := FileMgt.GetExtension(FileName);

                        Clear(Rec."File Content");
                        Rec."File Content".CreateOutStream(OutStream);
                        CopyStream(OutStream, InStream);
                        Rec.Insert(true);
                    end;
                end;
            }

            action(DownloadFile)
            {
                Caption = 'Download File';
                Image = Export;
                ApplicationArea = All;
                trigger OnAction()
                var
                    FileMgt: Codeunit "File Management";
                    InStream: InStream;
                begin
                    Rec.CalcFields("File Content");
                    if Rec."File Content".HasValue then begin
                        Rec."File Content".CreateInStream(InStream);
                        DownloadFromStream(InStream, '', '', Rec."File Extension", Rec."File Name");
                    end else
                        Message('No file content found.');
                end;
            }

            action(DeleteFile)
            {
                Caption = 'Delete File';
                Image = Delete;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to delete this file?', false) then
                        Rec.Delete();
                end;
            }
        }
    }
}
