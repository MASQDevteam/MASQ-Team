page 70118 "Shipping Dates LOG Factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    //  UsageCategory = Lists;
    SourceTable = "Supply Chain LOG";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("BL/AWB ID"; Rec."BL/AWB ID")
                {
                    ToolTip = 'Specifies the value of the BL/AWB ID field.', Comment = '%';
                }
                field("Container Number"; Rec."Container Number")
                {
                    ToolTip = 'Specifies the value of the Container Number field.', Comment = '%';
                }
                field("PO Number"; Rec."PO Number")
                {
                    ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
                }
                field("PO Line Number"; Rec."PO Line Number")
                {
                    ToolTip = 'Specifies the value of the PO Line Number field.', Comment = '%';
                }
                field("Initial ETR"; Rec."Initial ETR")
                {
                    ToolTip = 'Specifies the value of the Initial ETR field.', Comment = '%';
                }
                field("Initial ETD"; Rec."Initial ETD")
                {
                    ToolTip = 'Specifies the value of the Initial ETD field.', Comment = '%';
                }
                field("Initial ETA"; Rec."Initial ETA")
                {
                    ToolTip = 'Specifies the value of the Initial ETA field.', Comment = '%';
                }
                field("Initial ETAW"; Rec."Initial ETAW")
                {
                    ToolTip = 'Specifies the value of the Initial ETAW field.', Comment = '%';
                }
                field("Final ETR"; Rec."Final ETR")
                {
                    ToolTip = 'Specifies the value of the Final ETR field.', Comment = '%';
                }
                field("Final ETD"; Rec."Final ETD")
                {
                    ToolTip = 'Specifies the value of the Final ETD field.', Comment = '%';
                }
                field("Final ETA"; Rec."Final ETA")
                {
                    ToolTip = 'Specifies the value of the Final ETA field.', Comment = '%';
                }
                field("Final ETAW"; Rec."Final ETAW")
                {
                    ToolTip = 'Specifies the value of the Final ETAW field.', Comment = '%';
                }
                field(ATA; Rec.ATA)
                {
                    ToolTip = 'Specifies the value of the ATA field.', Comment = '%';
                }
                field(UserName; UserName)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field("SO Number"; Rec."PO Number")
                {
                    ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
                }
                field("SO Line Number"; Rec."PO Line Number")
                {
                    ToolTip = 'Specifies the value of the PO Line Number field.', Comment = '%';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

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