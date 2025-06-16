table 70119 "SubmittalComment"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "SubmittalCommentId"; Integer) { }
        field(2; "SubmittalId"; Integer) { }
        field(3; "IsAccessory"; Boolean) { }
        field(4; "ProjectItemDetailOrItemAccessoryId"; Integer) { }
        field(5; "Reply"; Text[250]) { }
        field(6; "ReplyDocPath"; Text[250]) { }
        field(7; "ItemDocPath"; Text[250]) { }
        field(8; "CommentStatus"; Text[250]) { }
        field(9; "RevisionNumber"; Integer) { }
        field(10; "A"; Boolean) { }
        field(11; "B"; Boolean) { }
        field(12; "C"; Boolean) { }
        field(13; "D"; Boolean) { }
        field(14; "CreatedDate"; DateTime) { }
        field(15; "Deleted"; Boolean) { }
        field(16; "NC"; Boolean) { }
        field(17; "ClearToOrder"; Boolean) { }
        field(18; "ClearToOrderPMOApprove"; Boolean) { }
        field(19; "CommentType"; Text[250]) { }
        field(20; "Tag"; Boolean) { }
        field(21; "Comment"; Text[250]) { }
        field(22; "CommentAction"; Text[250]) { }
        field(23; "CommentActionStatus"; Text[250]) { }
        field(24; "CommentBy"; Text[250]) { }

        field(25; "Dynamics Item Number"; Code[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(26; "Dynamics Project Number"; Code[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
        }
        field(27; "Brand Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Vendor Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "SubmittalCommentId")
        {
            Clustered = true;
        }

        key(IdxSubmittalId; "SubmittalId")
        {
            // A non-clustered index to improve search performance based on SubmittalId
        }
    }

    trigger OnInsert()
    var
        Submittals: Record Submittal;
    begin
        Clear(Submittals);
        Submittals.Get(SubmittalId);
        Rec."Dynamics Project Number" := Submittals."Dynamics Project Number";
        //AN 03/05/25
        MASQEmail.SendEmailSubmitalComments(Rec);
    end;

    //AN 03/05/25
    trigger OnModify()
    begin
        MASQEmail.SendEmailSubmitalComments(Rec);
    end;

    var
        MASQEmail: Codeunit "MASQ Email";
}
