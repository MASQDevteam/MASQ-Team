pageextension 70123 ItemListExt extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            // field(Thumbnail; Rec."MASQ Thumbnail")
            // {
            //     ApplicationArea = All;
            // }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
            }
            // field(SystemCreatedBy; Rec.SystemCreatedBy)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
            // }
            field(UserName; UserName)
            { ApplicationArea = All; }
        }
        addafter("No.")
        {
            field(ApolloItemNo; Rec.ApolloItemNo)
            {
                ApplicationArea = All;
            }
        }
    }


    actions
    {
        addafter(ApplyTemplate)
        {
            action(UpdatePictureThumbnails)
            {
                Caption = 'Update Picture Thumbnails';
                Promoted = true;
                PromotedCategory = Process;
                Image = UpdateDescription;
                ApplicationArea = All;
                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                begin
                    if Rec.FindSet() then
                        repeat
                            if Rec.Picture.Count > 0 then begin
                                if TenantMedia.Get(Rec.Picture.Item(1)) then begin
                                    TenantMedia.CalcFields(Content);
                                    Rec."MASQ Thumbnail" := TenantMedia.Content;
                                    Rec.Modify(true);
                                end;
                            end else begin
                                if Rec."MASQ Thumbnail".HasValue then begin
                                    Rec.CalcFields("MASQ Thumbnail");
                                    Clear(Rec."MASQ Thumbnail");
                                    Rec.Modify(true);
                                end;
                            end;
                        until Rec.Next() = 0;
                    Rec.FindFirst();
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    var
    begin
        IF user.Get(Rec.SystemCreatedBy) then begin
            UserName := User."User Name";
        end;
    end;

    var
        User: Record User;
        UserName: Code[20];
}