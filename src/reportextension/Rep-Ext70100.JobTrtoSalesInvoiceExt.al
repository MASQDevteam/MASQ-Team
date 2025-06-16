reportextension 70100 "Job Tr to Sales Invoice Ext" extends "Job Transfer to Sales Invoice"
{



    requestpage
    {

        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            Caption := 'Job Transfer to Sales Order';
        end;

    }

}