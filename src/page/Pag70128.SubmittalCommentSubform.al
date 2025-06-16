page 70128 "SubmittalComment Subform"
{
    AutoSplitKey = true;
    Caption = 'SubmittalComment';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = SubmittalComment;
    ApplicationArea = All;
    //  Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SubmittalCommentId"; Rec."SubmittalCommentId")
                {
                    ApplicationArea = All;
                }

                field("SubmittalId"; Rec."SubmittalId")
                {
                    ApplicationArea = All;
                }

                field("ProjectItemDetailOrItemAccessoryId"; Rec."ProjectItemDetailOrItemAccessoryId")
                {
                    ApplicationArea = All;
                }
                field("Dynamics Project Number"; Rec."Dynamics Project Number")
                {
                    ToolTip = 'Specifies the value of the Dynamics Project Number field.', Comment = '%';
                }
                field("Dynamics Item Number"; Rec."Dynamics Item Number")
                {
                    ToolTip = 'Specifies the value of the Dynamics Item Number field.', Comment = '%';
                    //  Editable = false;
                }
                field("Brand Name"; Rec."Brand Name")
                {
                    ToolTip = 'Specifies the value of the Brand Name field.', Comment = '%';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.', Comment = '%';
                }

                field("IsAccessory"; Rec."IsAccessory")
                {
                    ApplicationArea = All;
                }



                field("Reply"; Rec."Reply")
                {
                    ApplicationArea = All;
                }

                field("ReplyDocPath"; Rec."ReplyDocPath")
                {
                    ApplicationArea = All;
                }

                field("ItemDocPath"; Rec."ItemDocPath")
                {
                    ApplicationArea = All;
                }

                field("CommentStatus"; Rec."CommentStatus")
                {
                    ApplicationArea = All;
                }

                field("RevisionNumber"; Rec."RevisionNumber")
                {
                    ApplicationArea = All;
                }

                field("A"; Rec."A")
                {
                    ApplicationArea = All;
                }

                field("B"; Rec."B")
                {
                    ApplicationArea = All;
                }

                field("C"; Rec."C")
                {
                    ApplicationArea = All;
                }

                field("D"; Rec."D")
                {
                    ApplicationArea = All;
                }
                field(NC; Rec.NC)
                {
                    ToolTip = 'Specifies the value of the NC field.', Comment = '%';
                }
                field(ClearToOrder; Rec.ClearToOrder)
                {
                    ToolTip = 'Specifies the value of the ClearToOrder field.', Comment = '%';
                }
                field(ClearToOrderPMOApprove; Rec.ClearToOrderPMOApprove)
                {
                    ToolTip = 'Specifies the value of the ClearToOrderPMOApprove field.', Comment = '%';
                }
                field(CommentType; Rec.CommentType)
                {
                    ToolTip = 'Specifies the value of the CommentType field.', Comment = '%';
                }
                field(Tag; Rec.Tag)
                {
                    ToolTip = 'Specifies the value of the Tag field.', Comment = '%';
                }

                field("CreatedDate"; Rec."CreatedDate")
                {
                    ApplicationArea = All;
                    Editable = false;  // This is typically not editable
                }



                field("Deleted"; Rec."Deleted")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field(CommentAction; Rec.CommentAction)
                {
                    ToolTip = 'Specifies the value of the CommentAction field.', Comment = '%';
                }
                field(CommentActionStatus; Rec.CommentActionStatus)
                {
                    ToolTip = 'Specifies the value of the CommentActionStatus field.', Comment = '%';
                }
                field(CommentBy; Rec.CommentBy)
                {
                    ToolTip = 'Specifies the value of the CommentBy field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }


    trigger OnAfterGetRecord()
    var
        ItemRec: Record Item;
        VendorRec: Record Vendor;
    begin
        Clear(ItemRec);
        IF (Rec."Brand Name" = '') AND (Rec."Vendor Name" = '') then begin
            IF ItemRec.Get(Rec."Dynamics Item Number") then begin
                Rec."Brand Name" := ItemRec."Meg Brand";
                IF VendorRec.Get(ItemRec."Vendor No.") then
                    Rec."Vendor Name" := VendorRec.Name;
            end;

        end;
    end;
}
