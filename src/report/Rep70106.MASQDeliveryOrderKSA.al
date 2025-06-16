

report 70106 "MASQ Delivery Order KSA"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Delivery Order KSA';
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = 'MegDeliveryOrderKSA.rdl';
    Description = 'The Delivery Order report is used in: Posted Sales Shipment - Posted Sales Shipments';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Bill-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Delivery Order';

            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(Meg_Delivery_Order_No_; Meg_Delivery_Order_No_)
            {
            }
            column(Shipment_Date; "Shipment Date")
            {
            }
            column(Meg_OC_No_; "Meg OC No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(ProjectName; ProjectName)
            {
            }
            column(IssuedFor; IssuedFor)
            {
            }
            column(Meg_Purchase_Order_No_; "Meg Client PO #")
            {
            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                // DataItemTableView = sorting("Document No.", "Line No.") where(Quantity = filter(<> 0));
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");

                column(ExpandBreakdowns; ExpandBreakdowns)
                {

                }
                column(LineNo; LineNo)
                {
                }
                column(Meg_Item_Type; "Meg Item Type")
                {
                }
                column(Meg_Vendor_Item_Code; "Meg Vendor Item Code")
                {
                }
                column(Job_No_; "Job No.")
                {

                }
                column(Meg_Item_Note; "Meg Item Note")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }

                dataitem(Item; Item)
                {
                    DataItemTableView = sorting("No.");
                    DataItemLinkReference = "Sales Invoice Line";
                    DataItemLink = "No." = field("No.");

                    column(ItemPicAsText; ItemPicAsText)
                    {
                    }
                    column(Brand; "Meg Brand")
                    {
                    }
                    column(Model; "Meg Model")
                    {
                    }
                    column(Meg_Other_Details; "Meg Other Details")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        GetItemPic: Codeunit "MASQ Get Item Pic";
                    begin
                        ItemPicAsText := GetItemPic."Pic as JSON"(Item."No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    LineNo += 1;
                end;
            }

            column(Delivery_Order_No_Caption; Delivery_Order_No_Caption)
            {
            }
            column(DO_Date_Caption; DO_Date_Caption)
            {
            }
            column(OC_No_Caption; OC_No_Caption)
            {
            }
            column(Client_Caption; Client_Caption)
            {
            }
            column(Project_Caption; Project_Caption)
            {
            }
            column(Client_PO_No_Caption; Client_PO_No_Caption)
            {
            }
            column(Issued_for_Caption; Issued_for_Caption)
            {
            }
            column(No_Caption; No_Caption)
            {
            }
            column(Photo_Caption; Photo_Caption)
            {
            }
            column(Type_Caption; Type_Caption)
            {
            }
            column(Brand_Caption; Brand_Caption)
            {
            }
            column(Item_Caption; Item_Caption)
            {
            }
            column(Model_Caption; Model_Caption)
            {
            }
            column(Other_Details_Caption; Other_Details_Caption)
            {
            }
            column(Qty_Caption; Qty_Caption)
            {
            }
            column(tridonic_Caption; tridonic_Caption)
            {
            }
            column(RECEIPT_CONFIRMATION_Caption; RECEIPT_CONFIRMATION_Caption)
            {
            }
            column(Name_Caption; Name_Caption)
            {
            }
            column(Position_Caption; Position_Caption)
            {
            }
            column(Date_Caption; Date_Caption)
            {
            }
            column(Decalaration_Caption; Decalaration_Caption)
            {
            }
            column(Signature_Caption; Signature_Caption)
            {
            }
            column(Prepared_By_Caption; Prepared_By_Caption)
            {
            }
            column(ReportsSetup_PreparedBy; 'THANZEEL')
            {
            }
            column(Approved_By_Caption; Approved_By_Caption)
            {
            }
            column(ReportsSetup_ApprovedBy; 'JOE IGHNIADES')
            {
            }
            column(Receiver_Initials_Caption; Receiver_Initials_Caption)
            {
            }
            column(MASQ_Caption; MASQ_Caption)
            {
            }
            column(Note_Caption; Note_Caption)
            {
            }

            trigger OnAfterGetRecord()
            var
                DimensionSetEntry: Record "Dimension Set Entry";
                Dimensions: Record Dimension;
            begin
                IssuedFor := 'Invoiced';

                Dimensions.Reset();
                DimensionSetEntry.Reset();

                if (not DimensionSetEntry.Get("Sales Invoice Header"."Dimension Set ID", 'PROJECT')) then begin
                    if Dimensions.Get('PROJECT') then
                        ProjectName := Dimensions.Description;
                end else begin
                    DimensionSetEntry.CalcFields("Dimension Value Name");
                    ProjectName := DimensionSetEntry."Dimension Value Name";
                end;
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Meg_Delivery_Order_No_; Meg_Delivery_Order_No_)
                    {
                        ApplicationArea = All;
                    }
                    field(ExpandBreakdowns; ExpandBreakdowns)
                    {
                        ApplicationArea = All;
                        Caption = 'Expand Breakdowns';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        //  ReportsSetup.Get();

        LineNo := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        //  ReportsSetup: Record "Meg Reports Setup";
        ProjectName: Text[100];
        LineNo: Integer;
        ItemPicAsText: Text;
        IssuedFor: Text[100];

        Delivery_Order_No_Caption: Label 'DELIVERY ORDER #';
        DO_Date_Caption: Label 'DO Date';
        OC_No_Caption: Label 'OC No.';
        Client_Caption: Label 'Client';
        Project_Caption: Label 'Project';
        Client_PO_No_Caption: Label 'Client PO#';
        Issued_for_Caption: Label 'Issued for';
        No_Caption: Label 'No';
        Photo_Caption: Label 'Photo';
        Type_Caption: Label 'Type';
        Brand_Caption: Label 'Brand';
        Item_Caption: Label 'Vendor Item No.';
        Model_Caption: Label 'Model';
        Other_Details_Caption: Label 'Other Details';
        Qty_Caption: Label 'Qty';
        tridonic_Caption: Label 'come with tridonic power supply Art no 28003344';
        RECEIPT_CONFIRMATION_Caption: Label 'RECEIPT CONFIRMATION';
        Name_Caption: Label 'Name:';
        Position_Caption: Label 'Position:';
        Date_Caption: Label 'Date:';
        Decalaration_Caption: Label 'By signing this DO, we declare having received the above items in GOOD condition: free of breakage and in original packing.';
        Signature_Caption: Label 'Signature:';
        Prepared_By_Caption: Label 'Prepared By:';
        Approved_By_Caption: Label 'Approved By:';
        Receiver_Initials_Caption: Label 'Receiver Initials ______________';
        MASQ_Caption: Label 'MASQ ____________';
        Note_Caption: Label 'If DO more than one page, initials required on each page';
        Meg_Delivery_Order_No_: Code[50];
        ExpandBreakdowns: Boolean;
}