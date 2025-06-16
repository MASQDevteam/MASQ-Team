table 70136 "Item in Inventory"
{
    Caption = 'Item in Inventory';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            Editable = false;
        }
        field(2; Quantity; Decimal)
        {
            Caption = 'Quantity';
            Editable = false;
        }
        field(3; Location; Code[10])
        {
            Caption = 'Location';
            TableRelation = Location;
            Editable = false;
        }
        field(4; "PostAPI"; Boolean)
        {
            Caption = 'Modified';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Item No.", Location)
        {
            Clustered = true;
        }
    }
}
