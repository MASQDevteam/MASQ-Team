codeunit 70114 "Insert Opex to Project"
{
    trigger OnRun()
    var
        Job: Record Job;
    begin
        //Run InsertOpex for all Jobs
        If Job.FindSet() then
            repeat
                InsertOpex(Job."Global Dimension 1 Code");
            until Job.Next() = 0;
    end;
    //AN 07/25/2025
    procedure InsertOpex(ProjectCode: Code[20])
    var
        GLEntry: Record "G/L Entry";
        LineNo: Integer;
        Opex: Record Opex;
        CurrentGLAcc: Code[20];
    begin
        Clear(GLEntry);
        Clear(Opex);
        CurrentGLAcc := '';

        // Get the last Entry No. from Opex table
        if Opex.FindLast() then
            LineNo := Opex."Line No."
        else
            LineNo := 0;

        GLEntry.Reset();
        GLEntry.SetCurrentKey("G/L Account No.");
        GLEntry.SetFilter("G/L Account No.", '62..699');
        GLEntry.SetRange("Global Dimension 1 Code", ProjectCode);

        if GLEntry.FindSet() then
            repeat
                if GLEntry."G/L Account No." <> CurrentGLAcc then begin
                    CurrentGLAcc := GLEntry."G/L Account No.";

                    // Check if this G/L Account No. already exists in Opex
                    Opex.Reset();
                    Opex.SetRange("GL Account No", CurrentGLAcc);
                    Opex.SetRange("Shortcut Dimension 1", ProjectCode);
                    if not Opex.FindFirst() then begin
                        LineNo += 10000;
                        Opex.Init();
                        Opex."Line No." := LineNo;
                        Opex."GL Account No" := CurrentGLAcc;
                        Opex."Shortcut Dimension 1" := ProjectCode;
                        Opex.Insert();
                    end;
                end;
            until GLEntry.Next() = 0;
    end;

}
