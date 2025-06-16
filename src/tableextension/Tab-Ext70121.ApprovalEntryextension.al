tableextension 70121 "Approval Entry extension" extends "Approval Entry"
{

    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    // trigger OnModify()//to be removed
    // var
    //     ApprovalEntry: Record "Approval Entry";
    //     Firstapproved: Boolean;
    //     secondApproved: Boolean;
    //     thirdCreated: Boolean;
    // begin
    //     Clear(ApprovalEntry);
    //     ApprovalEntry.SetRange("Table ID", 70102);
    //     ApprovalEntry.SetRange("Document No.", Rec."Document No.");
    //     if ApprovalEntry.FindSet() then
    //         repeat
    //             IF ApprovalEntry."Sequence No." = 1 then
    //                 IF ApprovalEntry.Status = ApprovalEntry.Status::Approved then
    //                     Firstapproved := true;

    //             IF ApprovalEntry."Sequence No." = 2 then
    //                 IF ApprovalEntry.Status = ApprovalEntry.Status::Approved then
    //                     secondApproved := true;

    //             IF ApprovalEntry."Sequence No." = 3 then
    //                 IF ApprovalEntry.Status = ApprovalEntry.Status::Created then
    //                     thirdCreated := true;


    //             IF Firstapproved and secondApproved and thirdCreated then
    //                 IF (ApprovalEntry."Sequence No." = 3) and (ApprovalEntry.Status = ApprovalEntry.Status::Created) then begin
    //                     ApprovalEntry.Status := ApprovalEntry.Status::Open;
    //                     ApprovalEntry.Modify();
    //                 end;
    //         until ApprovalEntry.Next() = 0;
    // end;

    var
        myInt: Integer;
}