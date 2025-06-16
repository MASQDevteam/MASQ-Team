page 70155 "Subjob Information Subform"
{
    PageType = ListPart;
    SourceTable = "Subjob Information";
    ApplicationArea = All;

    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Subjob ID"; Rec."Subjob ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }
                field("Job ID"; Rec."Job#")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }
                field(Phases; Rec.Phases)
                {
                    ToolTip = 'Specifies the value of the Phases field.', Comment = '%';
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Subjob Name"; Rec."Subjob Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("SubJob Value"; Rec."SubJob Value")
                {
                    ToolTip = 'Specifies the value of the SubJob Value field.', Comment = '%';
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()

                    begin
                        GetStyle();
                    end;
                }
                field("Subjob Expenses"; Rec."Subjob Expenses")
                {
                    ToolTip = 'Specifies the value of the Subjob Expenses field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Notes"; Rec.Notes)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    actions
    {
        // Add actions here if needede
        area(Processing)
        {
            action("Add Lines")
            {
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseOrderLinepage: page "Purchase Lines";
                    PurchaseOrderLine: Record "Purchase Line";
                    "AWB Card": Page "AWB Card";
                    BLAWBNumber: Code[20];
                    ContainerNumber: Code[50];
                    ContainerLineNumber: Integer;
                    ContainerDetails: Record "Container Details";
                    AWBDetails: Record "AWB Details";
                begin
                    rec.FilterGroup(4);


                    Clear(PurchaseOrderLine);
                    PurchaseOrderLine.SetRange("Document Type", PurchaseOrderLine."Document Type"::Order);
                    PurchaseOrderLine.SetRange("Quantity Received", 0);
                    PurchaseOrderLine.SetRange("Job#", '');
                    PurchaseOrderLine.SetRange("Job No.", '');

                    Clear(PurchaseOrderLinepage);
                    PurchaseOrderLinepage.SetTableView(PurchaseOrderLine);
                    PurchaseOrderLinepage.LookupMode(true);
                    IF PurchaseOrderLinepage.RunModal() = Action::LookupOK then begin

                        PurchaseOrderLinepage.SetSelectionFilter(PurchaseOrderLine);
                        if PurchaseOrderLine.FindSet() then
                            repeat
                                PurchaseOrderLine."Job#" := Rec."Job#";
                                PurchaseOrderLine."Subjob ID" := Rec."Subjob ID";
                                PurchaseOrderLine.Modify();
                            until PurchaseOrderLine.Next() = 0;
                    end;
                end;
            }

            action("Remove Lines")
            {
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseOrderLinepage: page "Purchase Lines";
                    PurchaseOrderLine: Record "Purchase Line";
                    "AWB Card": Page "AWB Card";
                    BLAWBNumber: Code[20];
                    ContainerNumber: Code[50];
                    ContainerLineNumber: Integer;
                    ContainerDetails: Record "Container Details";
                    AWBDetails: Record "AWB Details";
                begin
                    rec.FilterGroup(4);


                    Clear(PurchaseOrderLine);
                    PurchaseOrderLine.SetRange("Document Type", PurchaseOrderLine."Document Type"::Order);
                    PurchaseOrderLine.SetRange("Job#", Rec."Job#");
                    PurchaseOrderLine.SetRange("Subjob ID", Rec."Subjob ID");


                    Clear(PurchaseOrderLinepage);
                    PurchaseOrderLinepage.SetTableView(PurchaseOrderLine);
                    PurchaseOrderLinepage.LookupMode(true);
                    IF PurchaseOrderLinepage.RunModal() = Action::LookupOK then begin

                        PurchaseOrderLinepage.SetSelectionFilter(PurchaseOrderLine);
                        if PurchaseOrderLine.FindSet() then
                            repeat
                                PurchaseOrderLine."Job#" := '';
                                PurchaseOrderLine."Subjob ID" := 0;
                                PurchaseOrderLine.Modify();
                            until PurchaseOrderLine.Next() = 0;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin

        GetStyle();
    end;

    Local procedure GetStyle()
    var
    begin
        IF rec.Status = Rec.Status::Lose then
            StyleExprTxt := 'Unfavorable'
        else
            If rec.Status = Rec.Status::Win then
                StyleExprTxt := 'Favorable'
            else
                StyleExprTxt := 'None'
    end;

    // trigger OnInit()
    // var
    // begin
    //     IF Rec.GetFilter("Subjob ID") <> '' then begin
    //         SubjobID := Rec.GetFilter("Subjob ID");
    //         Evaluate(Rec."Subjob ID", SubjobID);
    //     end;
    // end;



    var
        StyleExprTxt: Text;
        SubjobID: Text;
}