pageextension 70160 "Posted purch inv extension" extends "Posted Purchase Invoice"
{
    layout
    {
        addbefore("Invoice Details")
        {
            // group("Additional Total Costs")
            // {
            //     field("Actual (Total Cost) Freight"; Rec."Actual (Total Cost) Freight")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the actual total cost for Freight.';
            //     }
            //     field("Actual (Total Cost) Custom"; Rec."Actual (Total Cost) Custom")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the actual total cost for Custom.';
            //     }
            //     field("Actual (Total Cost) Clearance"; Rec."Actual (Total Cost) Clearance")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the actual total cost for Clearance.';
            //     }
            //     field("Actual (Total Cost) Others"; Rec."Actual (Total Cost) Others")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the actual total cost for Others.';
            //     }
            //     field("Actual (Total Cost) Insurance"; Rec."Actual (Total Cost) Insurance")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the actual total cost for Insurance.';
            //     }
            // }
        }
        addafter("Meg SO No.")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Date field.', Comment = '%';
            }
        }
    }

}