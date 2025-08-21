//Start NB MASQ
codeunit 70102 "WIP Details"
{
    procedure InsertWIPDetails(Rec: Record Job)
    var
        WIPProjectDetail: Record "WIP Project Detail";
    begin
        WIPProjectDetail.Reset();
        WIPProjectDetail.SetRange("Project No.", Rec."No.");
        WIPProjectDetail.SetRange(Name, WIPProjectDetail.Name::Project);
        if not WIPProjectDetail.FindFirst() then begin
            WIPProjectDetail.Init();
            WIPProjectDetail.Validate("Project No.", Rec."No.");
            WIPProjectDetail.Validate(Name, WIPProjectDetail.Name::Project);
            WIPProjectDetail.Insert(true);
        end;

        WIPProjectDetail.Reset();
        WIPProjectDetail.SetRange("Project No.", Rec."No.");
        WIPProjectDetail.SetRange(Name, WIPProjectDetail.Name::"Delivered Not Invoiced");
        if not WIPProjectDetail.FindFirst() then begin
            WIPProjectDetail.Init();
            WIPProjectDetail.Validate("Project No.", Rec."No.");
            WIPProjectDetail.Validate(Name, WIPProjectDetail.Name::"Delivered Not Invoiced");
            WIPProjectDetail.Insert(true);
        end;

        WIPProjectDetail.Reset();
        WIPProjectDetail.SetRange("Project No.", Rec."No.");
        WIPProjectDetail.SetRange(Name, WIPProjectDetail.Name::"Invoiced Not Delivered");
        if not WIPProjectDetail.FindFirst() then begin
            WIPProjectDetail.Init();
            WIPProjectDetail.Validate("Project No.", Rec."No.");
            WIPProjectDetail.Validate(Name, WIPProjectDetail.Name::"Invoiced Not Delivered");
            WIPProjectDetail.Insert(true);
        end;

        WIPProjectDetail.Reset();
        WIPProjectDetail.SetRange("Project No.", Rec."No.");
        WIPProjectDetail.SetRange(Name, WIPProjectDetail.Name::"Not Invoiced Not Delivered");
        if not WIPProjectDetail.FindFirst() then begin
            WIPProjectDetail.Init();
            WIPProjectDetail.Validate("Project No.", Rec."No.");
            WIPProjectDetail.Validate(Name, WIPProjectDetail.Name::"Not Invoiced Not Delivered");
            WIPProjectDetail.Insert(true);
        end;

        WIPProjectDetail.Reset();
        WIPProjectDetail.SetRange("Project No.", Rec."No.");
        WIPProjectDetail.SetRange(Name, WIPProjectDetail.Name::"Invoiced and Delivered");
        if not WIPProjectDetail.FindFirst() then begin
            WIPProjectDetail.Init();
            WIPProjectDetail.Validate("Project No.", Rec."No.");
            WIPProjectDetail.Validate(Name, WIPProjectDetail.Name::"Invoiced and Delivered");
            WIPProjectDetail.Insert(true);
        end;
    end;
}
//End NB MASQ