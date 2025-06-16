pageextension 70151 "Pucrhase Credit memo Subform" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here

        modify("Job No.")
        {
            Editable = true;
            Visible = false;
        }
        modify("Job Task No.")
        { Editable = false; Visible = true; }
        modify("Job Planning Line No.")
        { Editable = false; Visible = true; }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}