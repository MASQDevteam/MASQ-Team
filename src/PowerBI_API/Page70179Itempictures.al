//FQ MASQ **Start
page 70179 "ItemPictures API"
{
    PageType = API;
    APIPublisher = 'MASQ';
    APIGroup = 'MASQ';
    APIVersion = 'v2.0';
    EntityName = 'masqitemPicture';
    EntitySetName = 'masqitemPictures';
    ODataKeyFields = SystemId;
    ApplicationArea = all;
    SourceTable = Item;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId) { ApplicationArea = All; }
                field(no; Rec."No.") { ApplicationArea = All; }

                field(pictureBase64; GetPictureBase64()) { ApplicationArea = All; }
                field(hasPicture; GetHasPicture()) { ApplicationArea = All; }
            }
        }
    }

    local procedure GetPictureBase64(): Text
    var
        Base64: Codeunit "Base64 Convert";
        ItemTenantMedia: Record "Tenant Media";
        InS: InStream;
        Base64Txt: Text;
        MediaId: Guid;
    begin
        if Rec.Picture.Count = 0 then
            exit('');

        MediaId := Rec.Picture.Item(1);
        if not ItemTenantMedia.Get(MediaId) then
            exit('');

        ItemTenantMedia.CalcFields(Content);
        ItemTenantMedia.Content.CreateInStream(InS);
        Base64Txt := Base64.ToBase64(InS, false);
        exit(Base64Txt);
    end;

    local procedure GetHasPicture(): Boolean
    var
        ItemTenantMedia: Record "Tenant Media";
        MediaId: Guid;
    begin
        if Rec.Picture.Count = 0 then
            exit(false);

        MediaId := Rec.Picture.Item(1);
        exit(ItemTenantMedia.Get(MediaId));
    end;
}
//FQ MASQ **END