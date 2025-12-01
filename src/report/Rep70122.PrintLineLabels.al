report 70122 PrintLineLabels
{
    ApplicationArea = All;
    Caption = 'PrintLineLabels';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    DefaultRenderingLayout = "PrintLineLabel-A4";
    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                    where("Document Type" = filter(Order), Type = filter(Item));
            RequestFilterFields = "Document No.";
            column(Meg_Item_Type; "Meg Item Type")
            {
            }
            column(Meg_Vendor_Item_Code; "Meg Vendor Item Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(ItemNo; "No.")
            {
            }
            column(Line_No_; "Line No.")
            {
            }
            column(Meg_Driver; ItemRec."Meg Driver") { }
            column(Picture; ItemRec.Picture) { }
            column(Meg_Brand; ItemRec."Meg Brand") { }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Order));
                DataItemLinkReference = "Sales Line";
                DataItemLink = "No." = field("Document No.");
                RequestFilterFields = "No.";
                column(MegOCNo; "Meg OC No.") { }
                column(LocationCode; "Location Code") { }
                column(No_; "No.") { }
                column(CompInfoPic; CompanyInformation.Picture) { }
                column(Sample; Sample) { }
                column("Area"; "Area") { }
                column(SampleText; SampleText) { }
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

                ItemRec.Get("No.");

                if Sample then
                    SampleText := 'SAMPLE';
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
        layout("PrintLineLabel-A4")
        {
            Type = RDLC;
            LayoutFile = 'src/report/Layouts/PrintLineLabel-A4.rdl';
        }
        layout("PrintLineLabel-A5")
        {
            Type = RDLC;
            LayoutFile = 'src/report/Layouts/PrintLineLabel-A5.rdl';
        }
    }
    var
        CompanyInformation: Record "Company Information";
        Sample: Boolean;
        SampleText: Text;
        ItemRec: Record Item;
}
