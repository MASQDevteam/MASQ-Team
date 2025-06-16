report 70107 "Purchase Request Order"
{

    RDLCLayout = 'Purchase Request Order.rdl';
    Permissions = TableData "Purchase Request Header" = rimd, TableData "Purchase Request Line" = rimd;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Request Header";
        "Purchase Request Header")
        {
            RequestFilterFields = "No.";
            column(No;
            "Purch. Request Header"."No.")
            {
            }
            column(Status;
            "Purch. Request Header".Status)
            {
            }
            column(Request;
            "Purch. Request Header".Requester)
            {
            }
            column(Req_status;
            "Purch. Request Header"."Status")
            {
            }
            column(LocationCode;
            "Purch. Request Header"."Location Code")
            {
            }
            column(CurrencyCode;
            "Purch. Request Header"."Currency Code")
            {
            }
            column(Department;
            "Purch. Request Header"."Global Dimension 1 Code")
            {
            }
            column(ApprovedBy;
            "Purch. Request Header"."Approved By")
            {
            }
            column(Date;
            "Purch. Request Header".Date)
            {
            }
            column(ShowCost; ShowCost)
            {

            }
            column(Total_Line_Amount; "Total Line Amount")
            {

            }
            dataitem("Purch. Request Line";
            "Purchase Request Line")
            {
                DataItemLink = "Document No." = FIELD("No.");

                column(Item;
                "Purch. Request Line"."Item No.")
                {
                }
                column(VendItemNo; VendItemNo)
                {

                }


                column(Item_Desc;
                "Purch. Request Line"."Item Description")
                {
                }
                column(Qty;
                "Purch. Request Line".Quantity)
                {
                }
                column(UOM;
                "Purch. Request Line"."Unit of Measure Code")
                {
                }
                column(Description;
                "Purch. Request Line".Description)
                {
                }
                column(Vendor;
                "Purch. Request Line"."Document Reference")
                {
                }
                column(Unit_Cost;
                "Purch. Request Line"."Unit Cost")
                {
                }
                column(Line_Amount; "Line Amount")
                {

                }

                column(Total_Cost;
                "Purch. Request Line"."Total Cost")
                {
                }
                column(Vendor_Name;
                "Purch. Request Line"."Reference Name")
                {
                }
                column(Cost_Center;
                "Purch. Request Line".Remark)
                {
                }
                column(Picture;
                CompanyInfo.Picture)
                {
                }

                //AN 04/14/2025
                trigger OnAfterGetRecord()
                begin
                    Clear(Item);
                    VendItemNo := '';
                    Item.SetRange("No.", "Purch. Request Line"."Item No.");
                    if Item.FindFirst() then begin
                        VendItemNo := Item."Meg Vendor Item Code";
                    end;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(ShowCost; ShowCost)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Cost';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        VendItemNo: Code[200];
        ShowCost: Boolean;
}
