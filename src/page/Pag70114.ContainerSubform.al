page 70114 "Container Subform"
{
    AutoSplitKey = true;
    Caption = 'Container';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Container Details";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("SP ID"; Rec."SP ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SP ID field.', Comment = '%';
                    Enabled = false;
                }
                field("Container ID"; Rec."Container ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container ID field.', Comment = '%';


                    // trigger OnValidate()
                    // var
                    //     BLDetails: Record "BL Details";
                    // begin
                    //     Clear(BLDetails);
                    //     BLDetails.Get(Rec."BL ID");
                    //     BLDetails.Validate("Container ID", Rec."Container ID");
                    //     BLDetails.Modify();
                    //     //   CurrPage.Update(false);


                    // end;
                }
                field("BL ID"; Rec."BL ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BL Number field.', Comment = '%';
                    Enabled = false;
                }
                field("Seal Number"; Rec."Seal Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seal Number field.', Comment = '%';
                }
                field(Fitting; Rec.Fitting)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fitting field.', Comment = '%';
                }
                field("Loaded On Board"; Rec."Loaded On Board")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loaded On Board field.', Comment = '%';
                }
                field("Terminal Delivery Order Date"; Rec."Terminal Delivery Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Terminal Delivery Order Date field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field("Final ETR"; Rec."Final ETR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final ETR field.', Comment = '%';
                }
                field("Final ETD"; Rec."Final ETD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final ETD field.', Comment = '%';

                    trigger OnValidate()
                    var
                    begin
                        IF (Rec."Final ETA" <> 0D) AND (Rec."Final ETD" <> 0D) then
                            Rec."Transit Time" := FORMAT(Rec."Final ETA" - Rec."Final ETD");
                    end;
                }
                field("Final ETA"; Rec."Final ETA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final ETA field.', Comment = '%';
                    trigger OnValidate()
                    var
                    begin
                        IF (Rec."Final ETA" <> 0D) AND (Rec."Final ETD" <> 0D) then
                            Rec."Transit Time" := FORMAT(Rec."Final ETA" - Rec."Final ETD");
                    end;
                }
                field("Final ETAW"; Rec."Final ETAW")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final ETAW field.', Comment = '%';
                }
                field(ATA; Rec.ATA)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ATA field.', Comment = '%';
                }

                field("ROC Date"; Rec."ROC Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ROC Date field.', Comment = '%';
                }
                field("Transit Time"; Rec."Transit Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transit Time field.', Comment = '%';
                }
                field("Final Transit Time"; Rec."Final Transit Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final Transit Time field.', Comment = '%';
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {

        }
    }
    /* trigger OnAfterGetCurrRecord()
     var
         BLDetails: Record "BL Details";
         Container: Record "Container Details";
     begin
         Container.SetRange("BL ID", Rec."BL ID");
         Container.SetFilter("Container ID", '<> %1', rec."Container ID");
         Container.ModifyAll(Selected, false);
         Rec.Selected := true;
         rec.Modify();
         Clear(BLDetails);
         BLDetails.Get(Rec."BL ID");
         BLDetails."Container ID" := rec."Container ID";
         BLDetails.Modify(true);

     end;*/
}