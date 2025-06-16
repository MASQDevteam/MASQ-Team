codeunit 70112 SendEmailofExportedProjects
{
    Permissions = tabledata "Job Planning Line" = m;
    trigger OnRun()
    begin
        ExportedProject();
    end;

    local procedure ExportedProject()
    var
        JobTask: Record "Job Task";
        JobPlanningLine: Record "Job Planning Line";
        MASQEmail: Codeunit "MASQ Email";
    begin
        Clear(JobTask);
        JobTask.CalcFields("Not All Email Sent");
        JobTask.SetRange("Not All Email Sent", true);
        IF JobTask.FindSet() then
            repeat
                MASQEmail.SendEmailProjectTask(JobTask);
            until JobTask.Next() = 0;

        JobPlanningLine.SetRange("Email Sent", false);
        if JobPlanningLine.FindFirst() then begin
            repeat
                if JobPlanningLine."Contract Line" = true then begin
                    Clear(JobTask);
                    JobTask.SetRange("Job No.", JobPlanningLine."Job No.");
                    JobTask.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
                    if JobTask.FindFirst() then begin
                        JobPlanningLine."Email Sent" := true;
                        JobPlanningLine.Modify();
                    end;
                end;
            until JobPlanningLine.Next() = 0;
        end;
    end;
}
