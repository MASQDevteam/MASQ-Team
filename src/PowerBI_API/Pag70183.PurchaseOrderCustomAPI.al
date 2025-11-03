//FQ MASQ **Start
// It exposes the Purchase Order as an A list page and then converts it to a Power BI API Webservice.
namespace MASQTeam.MASQTeam;
using Microsoft.Purchases.Document;
page 70183 PurchaseOrderCustomAPI
{
    ApplicationArea = All;
    Caption = 'Purchase Order List Custom API';
    PageType = List;
    SourceTable = "Purchase Header";
    //UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("A. Rcd. Not Inv. Ex. VAT (LCY)"; Rec."A. Rcd. Not Inv. Ex. VAT (LCY)")
                {
                    ToolTip = 'Specifies the amount excluding VAT for the items on the order that have been received but are not yet invoiced.';
                }
                field("Acknowledgement Date"; Rec."Acknowledgement Date")
                {
                    ToolTip = 'Specifies the value of the Acknowledgement Date field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the sum of amounts on all the lines in the document. This will include invoice discounts.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the sum of amounts, including VAT, on all the lines in the document. This will include invoice discounts.';
                }
                field("Amt. Rcd. Not Invoiced (LCY)"; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    ToolTip = 'Specifies the sum, in LCY, for items that have been received but have not yet been invoiced. The value in the Amt. Rcd. Not Invoiced (LCY) field is used for entries in the Purchase Line table of document type Order to calculate and update the contents of this field.';
                }
                field("Apollo Clearance Value"; Rec."Apollo Clearance Value")
                {
                    ToolTip = 'Specifies the value of the Apollo Clearance Value field.', Comment = '%';
                }
                field("Apollo Customs Value"; Rec."Apollo Customs Value")
                {
                    ToolTip = 'Specifies the value of the Apollo Customs Value field.', Comment = '%';
                }
                field("Apollo Freight Value"; Rec."Apollo Freight Value")
                {
                    ToolTip = 'Specifies the value of the Apollo Freight Value field.', Comment = '%';
                }
                field("Apollo Location Code"; Rec."Apollo Location Code")
                {
                    ToolTip = 'Specifies the value of the Apollo Location Code field.', Comment = '%';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the destination country or region for the purpose of Intrastat reporting.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Attachment ID"; Rec."Attachment ID")
                {
                    ToolTip = 'Specifies the value of the Attachment ID field.', Comment = '%';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the value of the Bal. Account No. field.', Comment = '%';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of the Bal. Account Type field.', Comment = '%';
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ToolTip = 'Specifies the address of the vendor who ships the items.';
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ToolTip = 'Specifies the city of the vendor who ships the items.';
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ToolTip = 'Specifies the number of your contact at the vendor.';
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                }
                field("Buy-from County"; Rec."Buy-from County")
                {
                    ToolTip = 'Specifies the state, province or county of the address.';
                }
                field("Buy-from IC Partner Code"; Rec."Buy-from IC Partner Code")
                {
                    ToolTip = 'Specifies the value of the Buy-from IC Partner Code field.', Comment = '%';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';
                }
                field("Buy-from Vendor Name 2"; Rec."Buy-from Vendor Name 2")
                {
                    ToolTip = 'Specifies the value of the Buy-from Vendor Name 2 field.', Comment = '%';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the campaign number the document is linked to.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Completely Received"; Rec."Completely Received")
                {
                    ToolTip = 'Specifies if all the items on the order have been shipped or, in the case of inbound items, completely received.';
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the entry as a corrective entry. You can use the field if you need to post a corrective entry to a vendor account. If you place a check mark in this field when posting a corrective entry, the system will post a negative debit instead of a credit or a negative credit instead of a debit. Correction flag does not affect how inventory reconciled with general ledger.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ToolTip = 'Specifies the vendor who sent the purchase invoice.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency that is used on the entry.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.', Comment = '%';
                }
                field("Custom Status"; Rec."Custom Status")
                {
                    ToolTip = 'Shows the custom status based on receiving and invoicing progress';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.', Comment = '%';
                }
                field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT")
                {
                    ToolTip = 'Specifies the value of the Doc. Amount Incl. VAT field.', Comment = '%';
                }
                field("Doc. Amount VAT"; Rec."Doc. Amount VAT")
                {
                    ToolTip = 'Specifies the value of the Doc. Amount VAT field.', Comment = '%';
                }
                field("Doc. No. Occurrence"; Rec."Doc. No. Occurrence")
                {
                    ToolTip = 'Specifies the value of the Doc. No. Occurrence field.', Comment = '%';
                }
                field("Document Attachment Doc. Type"; Rec."Document Attachment Doc. Type")
                {
                    ToolTip = 'Specifies the value of the Document Attachment Doc. Type field.', Comment = '%';
                }
                field("Document Attachment ID"; Rec."Document Attachment ID")
                {
                    ToolTip = 'Specifies the value of the Document Attachment ID field.', Comment = '%';
                }
                field("Document Attachment Line No."; Rec."Document Attachment Line No.")
                {
                    ToolTip = 'Specifies the value of the Document Attachment Line No. field.', Comment = '%';
                }
                field("Document Attachment No."; Rec."Document Attachment No.")
                {
                    ToolTip = 'Specifies the value of the Document Attachment No. field.', Comment = '%';
                }
                field("Document Attachment Table ID"; Rec."Document Attachment Table ID")
                {
                    ToolTip = 'Specifies the value of the Document Attachment Table ID field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("Documentation Charges"; Rec."Documentation Charges")
                {
                    ToolTip = 'Specifies the value of the Documentation Charges field.', Comment = '%';
                }
                field("Documentation Charges Value"; Rec."Documentation Charges Value")
                {
                    ToolTip = 'Specifies the value of the Documentation Charges Value field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the related sales invoice must be paid.';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region, for reporting to Intrastat.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                }
                field("Format Region"; Rec."Format Region")
                {
                    ToolTip = 'Specifies the format to be used on printouts for this document.';
                }
                field("Freight Charges"; Rec."Freight Charges")
                {
                    ToolTip = 'Specifies the value of the Freight Charges field.', Comment = '%';
                }
                field("Freight Charges Value"; Rec."Freight Charges Value")
                {
                    ToolTip = 'Specifies the value of the Freight Charges Value field.', Comment = '%';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.', Comment = '%';
                }
                field("IC Direction"; Rec."IC Direction")
                {
                    ToolTip = 'Specifies the value of the IC Direction field.', Comment = '%';
                }
                field("IC Reference Document No."; Rec."IC Reference Document No.")
                {
                    ToolTip = 'Specifies the value of the IC Reference Document No. field.', Comment = '%';
                }
                field("IC Status"; Rec."IC Status")
                {
                    ToolTip = 'Specifies the value of the IC Status field.', Comment = '%';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ToolTip = 'Specifies the number of the incoming document that this purchase document is created for.';
                }
                field("Initial ETA"; Rec."Initial ETA")
                {
                    ToolTip = 'Specifies the value of the Initial ETA field.', Comment = '%';
                }
                field("Initial ETAW"; Rec."Initial ETAW")
                {
                    ToolTip = 'Specifies the value of the Initial ETAW field.', Comment = '%';
                }
                field("Initial ETD"; Rec."Initial ETD")
                {
                    ToolTip = 'Specifies the value of the Initial ETD field.', Comment = '%';
                }
                field("Initial ETR"; Rec."Initial ETR")
                {
                    ToolTip = 'Specifies the value of the Initial ETR field.', Comment = '%';
                }
                field(Invoice; Rec.Invoice)
                {
                    ToolTip = 'Specifies the value of the Invoice field.', Comment = '%';
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.', Comment = '%';
                }
                field("Invoice Discount Amount"; Rec."Invoice Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Amount field.', Comment = '%';
                }
                field("Invoice Discount Calculation"; Rec."Invoice Discount Calculation")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Calculation field.', Comment = '%';
                }
                field("Invoice Discount Value"; Rec."Invoice Discount Value")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Value field.', Comment = '%';
                }
                field("Invoice Received Date"; Rec."Invoice Received Date")
                {
                    ToolTip = 'Specifies the date when the related document was received.';
                }
                field("Job Queue Entry ID"; Rec."Job Queue Entry ID")
                {
                    ToolTip = 'Specifies the value of the Job Queue Entry ID field.', Comment = '%';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase credit memos.';
                }
                field("Journal Templ. Name"; Rec."Journal Templ. Name")
                {
                    ToolTip = 'Specifies the name of the journal template in which the purchase header is to be posted.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the language to be used on printouts for this document.';
                }
                field("Last Posting No."; Rec."Last Posting No.")
                {
                    ToolTip = 'Specifies the value of the Last Posting No. field.', Comment = '%';
                }
                field("Last Prepayment No."; Rec."Last Prepayment No.")
                {
                    ToolTip = 'Specifies the value of the Last Prepayment No. field.', Comment = '%';
                }
                field("Last Prepmt. Cr. Memo No."; Rec."Last Prepmt. Cr. Memo No.")
                {
                    ToolTip = 'Specifies the value of the Last Prepmt. Cr. Memo No. field.', Comment = '%';
                }
                field("Last Receiving No."; Rec."Last Receiving No.")
                {
                    ToolTip = 'Specifies the value of the Last Receiving No. field.', Comment = '%';
                }
                field("Last Return Shipment No."; Rec."Last Return Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Last Return Shipment No. field.', Comment = '%';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location where the items are to be placed when they are received. This field acts as the default location for new lines. You can update the location code for individual lines as needed.';
                }
                field("Logistics Coordinator"; Rec."Logistics Coordinator")
                {
                    ToolTip = 'Specifies the value of the Logistics Coordinator field.', Comment = '%';
                }
                field("MASQ Sales Order No."; Rec."MASQ Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the MASQ Sales Order No. field.', Comment = '%';
                }
                field("Meg OC No."; Rec."Meg OC No.")
                {
                    ToolTip = 'Specifies the blanket purchase order''s OC No. Used in "Purchase Order" report in "Purchase Order" page.';
                }
                field("Meg SO No."; Rec."Meg SO No.")
                {
                    ToolTip = 'Specifies the sales order number corresponding to this purchase order';
                }
                field("Meg Warranty"; Rec."Meg Warranty")
                {
                    ToolTip = 'Specifies the warranty period granted to all items presented in this order';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ToolTip = 'Specifies the number of archived versions for this document.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                }
                field("Order Class"; Rec."Order Class")
                {
                    ToolTip = 'Specifies the value of the Order Class field.', Comment = '%';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field("Other Charges"; Rec."Other Charges")
                {
                    ToolTip = 'Specifies the value of the Other Charges field.', Comment = '%';
                }
                field("Other Charges Value"; Rec."Other Charges Value")
                {
                    ToolTip = 'Specifies the value of the Other Charges Value field.', Comment = '%';
                }
                field("PO Type"; Rec."PO Type")
                {
                    ToolTip = 'Specifies the value of the PO Type field.', Comment = '%';
                }
                field("Partially Invoiced"; Rec."Partially Invoiced")
                {
                    ToolTip = 'Specifies the value of the Partially Invoiced field.', Comment = '%';
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ToolTip = 'Specifies the address of the vendor sending the invoice.';
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ToolTip = 'Specifies the city of the vendor sending the invoice.';
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact who sends the invoice.';
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the vendor on the purchase document.';
                }
                field("Pay-to County"; Rec."Pay-to County")
                {
                    ToolTip = 'Specifies the state, province or county of the address.';
                }
                field("Pay-to IC Partner Code"; Rec."Pay-to IC Partner Code")
                {
                    ToolTip = 'Specifies the value of the Pay-to IC Partner Code field.', Comment = '%';
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor sending the invoice.';
                }
                field("Pay-to Name 2"; Rec."Pay-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Pay-to Name 2 field.', Comment = '%';
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percentage that is granted if you pay on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                    ToolTip = 'Specifies the value of the Pending Approvals field.', Comment = '%';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ToolTip = 'Specifies the value of the Posting No. field.', Comment = '%';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ToolTip = 'Specifies the value of the Posting No. Series field.', Comment = '%';
                }
                field("Posting from Whse. Ref."; Rec."Posting from Whse. Ref.")
                {
                    ToolTip = 'Specifies the value of the Posting from Whse. Ref. field.', Comment = '%';
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for purchase.';
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ToolTip = 'Specifies when the prepayment invoice for this purchase order is due.';
                }
                field("Prepayment No."; Rec."Prepayment No.")
                {
                    ToolTip = 'Specifies the value of the Prepayment No. field.', Comment = '%';
                }
                field("Prepayment No. Series"; Rec."Prepayment No. Series")
                {
                    ToolTip = 'Specifies the value of the Prepayment No. Series field.', Comment = '%';
                }
                field("Prepmt. Cr. Memo No."; Rec."Prepmt. Cr. Memo No.")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Cr. Memo No. field.', Comment = '%';
                }
                field("Prepmt. Cr. Memo No. Series"; Rec."Prepmt. Cr. Memo No. Series")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Cr. Memo No. Series field.', Comment = '%';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted on the prepayment if the vendor pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the last date the vendor can pay the prepayment invoice and still receive a payment discount on the prepayment amount.';
                }
                field("Prepmt. Posting Description"; Rec."Prepmt. Posting Description")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Posting Description field.', Comment = '%';
                }
                field("Price Calculation Method"; Rec."Price Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Price Calculation Method field.', Comment = '%';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
                }
                field("Print Posted Documents"; Rec."Print Posted Documents")
                {
                    ToolTip = 'Specifies the value of the Print Posted Documents field.', Comment = '%';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the quote number for the purchase order.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the document.';
                }
                field("Recalculate Invoice Disc."; Rec."Recalculate Invoice Disc.")
                {
                    ToolTip = 'Specifies the value of the Recalculate Invoice Disc. field.', Comment = '%';
                }
                field(Receive; Rec.Receive)
                {
                    ToolTip = 'Specifies the value of the Receive field.', Comment = '%';
                }
                field("Received Not Invoiced"; Rec."Received Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Received Not Invoiced field.', Comment = '%';
                }
                field("Receiving No."; Rec."Receiving No.")
                {
                    ToolTip = 'Specifies the value of the Receiving No. field.', Comment = '%';
                }
                field("Receiving No. Series"; Rec."Receiving No. Series")
                {
                    ToolTip = 'Specifies the value of the Receiving No. Series field.', Comment = '%';
                }
                field("Remit-to Code"; Rec."Remit-to Code")
                {
                    ToolTip = 'Specifies the code for the vendor''s remit address for this invoice.';
                }
                field("Request for Payments"; Rec."Request for Payments")
                {
                    ToolTip = 'Specifies the value of the Request for Payments field.', Comment = '%';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date that you want the vendor to deliver your order. The field is used to calculate the latest date you can order, as follows: requested receipt date - lead time calculation = order date. If you do not need delivery on a specific date, you can leave the field blank.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field("Return Shipment No."; Rec."Return Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Return Shipment No. field.', Comment = '%';
                }
                field("Return Shipment No. Series"; Rec."Return Shipment No. Series")
                {
                    ToolTip = 'Specifies the value of the Return Shipment No. Series field.', Comment = '%';
                }
                field("SCC Count"; Rec."SCC Count")
                {
                    ToolTip = 'Shows the total number of shipping conformity certificates for this purchase order.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.';
                }
                field("Send IC Document"; Rec."Send IC Document")
                {
                    ToolTip = 'Specifies the value of the Send IC Document field.', Comment = '%';
                }
                field(Ship; Rec.Ship)
                {
                    ToolTip = 'Specifies the value of the Ship field.', Comment = '%';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address that you want the items on the purchase document to be shipped to.';
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ToolTip = 'Specifies the state, province or county of the address.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies an additional part of the name of the company at the address to which you want the items in the purchase order to be shipped.';
                }
                field("Ship-to Phone No."; Rec."Ship-to Phone No.")
                {
                    ToolTip = 'Specifies the telephone number of the company''s shipping address.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field("Shipment Mode"; Rec."Shipment Mode")
                {
                    ToolTip = 'Specifies the value of the Shipment Mode field.', Comment = '%';
                }
                field("Shipping Quotation No."; Rec."Shipping Quotation No.")
                {
                    ToolTip = 'Specifies the value of the Shipping Quotation No. field.', Comment = '%';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the tax area code used for this purchase to calculate and post sales tax.';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies if this vendor charges you sales tax for purchases.';
                }
                field(TotalWithCharges; Rec.TotalWithCharges)
                {
                    ToolTip = 'Specifies the value of the TotalWithCharges field.', Comment = '%';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies a specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ToolTip = 'Specifies the value of the VAT Base Discount % field.', Comment = '%';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("VAT Country/Region Code"; Rec."VAT Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the VAT Country/Region Code field.', Comment = '%';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the value of the VAT Registration No. field.', Comment = '%';
                }
                field("VAT Reporting Date"; Rec."VAT Reporting Date")
                {
                    ToolTip = 'Specifies the date used to include entries on VAT reports in a VAT period. This is either the date that the document was created or posted, depending on your setting on the General Ledger Setup page.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).';
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ToolTip = 'Specifies the vendor''s order number.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the vendor''s reference.';
                }
            }
        }
    }
}
//FQ MASQ **End