report 70120 "Print Shipment Label"
{
    ApplicationArea = All;
    Caption = 'Print Shipment Label';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    DefaultRenderingLayout = "PrintShipLabel-A4";
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.");
            column(MegOCNo; "Meg OC No.") { }
            column(LocationCode; "Location Code") { }
            column(No_; "No.") { }
            column(CompInfoPic; CompanyInformation.Picture) { }
            column(Sample; Sample) { }
            column("Area"; "Area") { }
            column(SampleText; SampleText) { }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.")
                                    where(Type = filter(Item), Quantity = filter(> 0));
                DataItemLinkReference = "Sales Shipment Header";
                DataItemLink = "Document No." = field("No.");
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
                    DataItemLinkReference = "Sales Shipment Line";
                    DataItemLink = "No." = field("No.");
                    column(Meg_Driver; "Meg Driver") { }
                    column(Picture; Picture) { }
                    column(Meg_Brand; "Meg Brand") { }
                }
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

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
        layout("PrintShipLabel-A4")
        {
            Type = RDLC;
            LayoutFile = 'src/report/Layouts/PrintShipLabel-A4.rdl';
        }
        layout("PrintShipLabel-A5")
        {
            Type = RDLC;
            LayoutFile = 'src/report/Layouts/PrintShipLabel-A5.rdl';
        }
    }
    var
        CompanyInformation: Record "Company Information";
        Sample: Boolean;
        SampleText: Text;
}
