page 70109 "Opex "
{
    ApplicationArea = All;
    Caption = 'Opex ';
    PageType = ListPart;
    SourceTable = Opex;
    SourceTableView = where(Amount = filter('<>0'));
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("GL Account Name"; Rec."GL Account Name")
                {
                    ToolTip = 'Specifies the value of the GL Account Name field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                    Editable = false;
                }
            }

        }


    }
}
