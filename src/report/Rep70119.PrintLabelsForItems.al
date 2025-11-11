report 70119 "Print Labels For Items"
{
    ApplicationArea = All;
    Caption = 'Print Labels For Items';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    DefaultRenderingLayout = PrintLabel;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Order));
            RequestFilterFields = "No.", "Meg OC No.", "Location Code";
            column(MegOCNo; "Meg OC No.") { }
            column(LocationCode; "Location Code") { }
            column(No_; "No.") { }
            column(CompInfoPic; CompanyInformation.Picture) { }
            column(Sample; Sample) { }
            column("Area"; "Area") { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                    where("Document Type" = filter(Order), Type = filter(Item));
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                RequestFilterFields = "No.", "Meg Item Type", "Meg Vendor Item Code";
                column(Meg_Item_Type; "Meg Item Type") { }
                column(Meg_Vendor_Item_Code; "Meg Vendor Item Code") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Document_No_; "Document No.") { }
                column(ItemNo; "No.") { }
                column(Line_No_; "Line No.") { }
                dataitem(Item; Item)
                {
                    DataItemTableView = sorting("No.");
                    DataItemLinkReference = "Sales Line";
                    DataItemLink = "No." = field("No.");
                    RequestFilterFields = "No.", "Meg Driver";
                    column(Meg_Driver; "Meg Driver") { }
                    column(Picture; Picture) { }
                    column(Meg_Brand; "Meg Brand") { }
                }
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(Sample; Sample)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    rendering
    {
        layout(PrintLabel)
        {
            Type = RDLC;
            LayoutFile = 'src/report/Layouts/PrintLabel.rdl';
        }
    }
    var
        CompanyInformation: Record "Company Information";
        Sample: Boolean;
}