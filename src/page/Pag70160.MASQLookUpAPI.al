page 70160 MASQLookupAPI
{

    Caption = 'MASQLookupAPI';
    APIGroup = 'MASQ';
    APIPublisher = 'MASQ';
    APIVersion = 'beta';
    DelayedInsert = true;
    EntityName = 'MASQLookupAPI';
    EntitySetName = 'MASQLookupAPI';
    PageType = API;
    SourceTable = "MASQ Lookup";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec."Type")
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }


            }
        }
    }

}