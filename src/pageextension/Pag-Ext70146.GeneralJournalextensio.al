pageextension 70146 "General Journal extensio" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here

        addafter(IncomingDocAttachFactBox)
        {
            systempart(Control1905767508; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}