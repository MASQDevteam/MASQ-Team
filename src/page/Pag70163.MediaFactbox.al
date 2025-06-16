page 70163 "Media Factbox"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    Caption = 'Media Factbox';
    PageType = CardPart;
    SourceTable = "Intermediate Items";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(MASQ_Picture; Rec.MASQ_Picture)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
            }
        }

    }
    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';


                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                    ClientFileName: Text;
                    itemRec: Record "Intermediate Items";
                    count: Integer;

                begin
                    Rec.TestField("No.");

                    // if Rec.MASQ_Picture.Count > 0 then
                    //     if not Confirm(OverrideImageQst) then
                    //         exit;

                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        if FromFileName = '' then
                            exit;

                        Clear(Rec.MASQ_Picture);
                        Rec.MASQ_Picture.ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    ToFile: Text;
                    ExportPath: Text;
                    FileName: Text[100];
                    index: integer;
                    InStreamPic: InStream;
                    TenantMedia: Record "Tenant Media";
                begin
                    if Rec.MASQ_Picture.Count = 0 then
                        exit;

                    for index := 1 to Rec.MASQ_Picture.Count do begin
                        if TenantMedia.Get(Rec.MASQ_Picture.Item(index)) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue then begin
                                FileName := StrSubstNo('%1 Image %2.jpg', Rec.TableCaption, Index);
                                TenantMedia.Content.CreateInStream(InStreamPic);
                                DownloadFromStream(InStreamPic, '', '', '', FileName);
                            end;
                        end;
                    end;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }
    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.MASQ_Picture);
        Rec.Modify(true);
    end;

    procedure TakeNewPicture()
    begin
        Rec.Find();
        Rec.TestField("No.");
        Rec.TestField(Description);

        OnAfterTakeNewPicture(Rec, DoTakeNewPicture());
    end;

    local procedure DoTakeNewPicture(): Boolean
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        if Rec.MASQ_Picture.Count() > 0 then
            if not Confirm(OverrideImageQst) then
                exit(false);

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.MASQ_Picture);
            Rec.MASQ_Picture.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true);
            exit(true);
        end;

        exit(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTakeNewPicture(var IntermediateItems: Record "Intermediate Items"; IsPictureAdded: Boolean)
    begin
    end;

    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        MimeTypeTok: Label 'image/jpeg', Locked = true;
}
