codeunit 70106 "MASQ Email"
{
    procedure SendEmailTravelRequest(User: Record User; TravelRequest: Record "Travel Request"; ApprovalEntry: Record "Approval Entry")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        Recipients: text[100];
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
    // User: Record User;

    begin
        //  Clear(UserSetup);
        //   UserSetup.Get(UserId);

        //   Clear(User);
        //  User.SetRange("User Name", UserId);

        //IF User.FindFirst() then;

        //  if not SmtpMailSetup.Get() then
        //    exit;


        // // Find Gen Journ Line
        // GenJournLine.SetRange("Journal Template Name", JournTempName);
        // GenJournLine.SetRange("Journal Batch Name", JournBatchName);
        // GenJournLine.SetRange("Line No.", LineNo);
        // GenJournLine.SetRange("Account Type", GenJournLine."Account Type"::Vendor);
        // if not GenJournLine.FindFirst() then
        //     Error('Vendor Line was not found ');

        //    Vendor.get(GenJournLine."Account No.");
        GLSetup.get();
        //   ErrorMessage.SetRange("Register ID", JobQueueEntry."Error Message Register Id");
        //   IF ErrorMessage.FindFirst() then;


        // if not Confirm('Are you sure you want to send an email to ' + Vendor.Name) then exit;

        // Set Currency
        // Curr := GenJournLine."Currency Code";
        // if Curr = '' then
        //     Curr := GLSetup."LCY Code";

        // Write Body
        // JobQueueEntry.CalcFields("Object Caption to Run");
        //  Body := StrSubstNo('Dear Mr. %1,<br><br>', User."Full Name");
        Body := 'This is a system generated email to inform you about the new Travel Request with the below details: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Travel Request:  </td><td>%1</td></tr>', TravelRequest.Number);
        Body += StrSubstNo('<tr><td>SenderID : </td><td>%1</td></tr>', ApprovalEntry."Sender ID");
        Body += StrSubstNo('<tr><td>Amount :  </td><td>%1</td></tr>', TravelRequest."Travel Advance Required");
        // //     Body += StrSubstNo('<tr><td>Cheque:</td><td>%1</td></tr>', GenJournLine."Check No");
        Body += StrSubstNo('<tr><td>URL :  </td><td>%1</td></tr>', GetUrl(ClientTypeManagement.GetCurrentClientType(), CompanyName, OBJECTTYPE::Page, Page::"Requests to Approve"));

        Body += '</table></br><br>';



        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';

        // Set Subject
        Subject := 'Travel Request Approval entries';


        // Add Recipient
        UserSetup.Get(User."User Name");
        Recipients := UserSetup."E-Mail";// 'tech@thecohort.com';// UserSetup."E-Mail";

        //   Email.CreateMessage(Recipients, '', '', Subject, Body, true, true);//, User);


        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage);

    end;


    /*  procedure SendINTVendEmail(Recipient: Text; GenJournLine: Record "Gen. Journal Line")
      var
          GenJournLine2: Record "Gen. Journal Line";
          Curr: Code[10];
          GLSetup: Record "General Ledger Setup";
          Bank: Record "Bank Account";
          checkText: Text;
          checkText2: Text;
          SmtpMailSetup: Record "Email Account";
          Mail: Codeunit Mail;
          Subject: Text;
          Body: Text;
          Recipients: List of [Text];
          BCCList: List of [Text];
      begin
          if not SmtpMailSetup.Get() then
              exit;


          // Set Currency
          Curr := GenJournLine."Currency Code";
          if Curr = '' then
              Curr := GLSetup."LCY Code";

          // Write Body
          Body := 'Dear Valued Vendor,<br><br>';
          Body += 'This is a system generated email to inform you about the following payment:';
          Body += '<table style="margin-left:15px">';
          Body += StrSubstNo('<tr><td>Amount:</td><td>%1 %2</td></tr>', GenJournLine.Amount, Curr);

          GenJournLine2.SetRange("Journal Template Name", GenJournLine."Journal Template Name");
          GenJournLine2.SetRange("Journal Batch Name", GenJournLine."Journal Batch Name");
          GenJournLine2.SetRange("Line No.", GenJournLine."Line No.");
          GenJournLine2.SetRange("Account Type", GenJournLine."Account Type"::"Bank Account");
          // if GenJournLine2.FindFirst() then begin
          //     Bank.get(GenJournLine2."Account No.");
          //     if GenJournLine2."Check No" <> '' then
          //         Body += StrSubstNo('<tr><td>Bank:</td><td>%1</td></tr>', Bank.Name, GenJournLine2."Check No")
          //     else
          //         Body += StrSubstNo('<tr><td>Bank:</td><td>%1</td></tr>', Bank.Name)
          // end;

          Body += StrSubstNo('<tr><td>Date:</td><td>%1</td><tr>', GenJournLine."Posting Date");
          // Body += StrSubstNo('<tr><td>Description:</td><td>%1</td><tr>', GenJournLine."Description 2");
          Body += StrSubstNo('<tr><td>Collection:</td><td>LAT Headquarters - every Friday from 9am till 3pm</td><tr>');
          Body += '</table></br><br>';
          Body += 'Kindly bring the related receipt and an updated statement of account.<br><br>';
          Body += 'Thank you.<br><br>';
          Body += 'Regards,';//<br><br>Nathalie Dimassi';

          // Set Subject
          Subject := 'Payment Journal';

          // Add Recipeint
          if Recipient <> '' then
              Recipients.Add(Recipient);

          Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, true);//, User);

          // Add BCC
          // BCCList.Add('danielle.maamari@lat.com.lb');
          //  Mail.AddCC(BCCList);

          Mail.Send();
      end;*/
    // procedure SendEmailPaymentRequest(User: Record User; PaymentRequest: Record "Payment Line"; ApprovalEntry: Record "Approval Entry")
    // var
    //     GenJournLine: Record "Gen. Journal Line";
    //     GenJournLine2: Record "Gen. Journal Line";
    //     Vendor: Record Vendor;
    //     Curr: Code[10];
    //     GLSetup: Record "General Ledger Setup";
    //     Bank: Record "Bank Account";
    //     checkText: Text;
    //     checkText2: Text;
    //     SmtpMailSetup: Record "Email Account";
    //     Mail: Codeunit Mail;
    //     Email: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    //     Subject: Text;
    //     Body: Text;
    //     Recipients: text[100];
    //     BCCList: List of [Text];
    //     UserSetup: Record "User Setup";
    //     ErrorMessage: record "Error Message";
    //     ClientTypeManagement: Codeunit "Client Type Management";


    // // User: Record User;

    // begin
    //     //  Clear(UserSetup);
    //     //   UserSetup.Get(UserId);

    //     //   Clear(User);
    //     //  User.SetRange("User Name", UserId);

    //     //IF User.FindFirst() then;

    //     //  if not SmtpMailSetup.Get() then
    //     //    exit;


    //     // // Find Gen Journ Line
    //     // GenJournLine.SetRange("Journal Template Name", JournTempName);
    //     // GenJournLine.SetRange("Journal Batch Name", JournBatchName);
    //     // GenJournLine.SetRange("Line No.", LineNo);
    //     // GenJournLine.SetRange("Account Type", GenJournLine."Account Type"::Vendor);
    //     // if not GenJournLine.FindFirst() then
    //     //     Error('Vendor Line was not found ');

    //     //    Vendor.get(GenJournLine."Account No.");
    //     GLSetup.get();
    //     //   ErrorMessage.SetRange("Register ID", JobQueueEntry."Error Message Register Id");
    //     //   IF ErrorMessage.FindFirst() then;


    //     // if not Confirm('Are you sure you want to send an email to ' + Vendor.Name) then exit;

    //     // Set Currency
    //     // Curr := GenJournLine."Currency Code";
    //     // if Curr = '' then
    //     //     Curr := GLSetup."LCY Code";

    //     // Write Body
    //     // JobQueueEntry.CalcFields("Object Caption to Run");
    //     //  Body := StrSubstNo('Dear Mr. %1,<br><br>', User."Full Name");
    //     Body := 'This is a system generated email to inform you about the new Payment Request with the below details: <br><br>';
    //     Body += '<table  style="margin-left:15px">';
    //     Body += StrSubstNo('<tr><td>Payment Request:  </td><td>%1</td></tr>', PaymentRequest.Number);
    //     Body += StrSubstNo('<tr><td>SenderID : </td><td>%1</td></tr>', ApprovalEntry."Sender ID");
    //     Body += StrSubstNo('<tr><td>Amount :  </td><td>%1</td></tr>', FORMAT(PaymentRequest."PO Value") + ' ' + PaymentRequest.Currency);
    //     Body += StrSubstNo('<tr><td>URL :  </td><td>%1</td></tr>', GetUrl(ClientTypeManagement.GetCurrentClientType(), CompanyName, OBJECTTYPE::Page, Page::"Requests to Approve"));
    //     // //     Body += StrSubstNo('<tr><td>Cheque:</td><td>%1</td></tr>', GenJournLine."Check No");

    //     Body += '</table></br><br>';



    //     Body += 'Thank you.<br><br>';
    //     Body += 'Regards,';//<br><br>Nathalie Dimassi';

    //     // Set Subject
    //     IF PaymentRequest.Supplier <> '' then
    //         Vendor.get(PaymentRequest.Supplier);

    //     Subject := 'Payment Request PO# ' + PaymentRequest."PO#" + ' Vendor Name ' + Vendor.Name + ' Level of Urgency ' + Format(PaymentRequest."Level of Urgency");


    //     // Add Recipient
    //     UserSetup.Get(User."User Name");
    //     Recipients := UserSetup."E-Mail";// 'tech@thecohort.com';// UserSetup."E-Mail";

    //     //   Email.CreateMessage(Recipients, '', '', Subject, Body, true, true);//, User);


    //     EmailMessage.Create(Recipients, Subject, Body, true);
    //     Email.Send(EmailMessage);

    // end;
    procedure SendEmailPaymentRequest(User: Record User; PaymentRequest: Record "SUPPLIER PAYMENT REQUEST"; ApprovalEntry: Record "Approval Entry")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        Recipients: text[100];
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";


    // User: Record User;

    begin
        //  Clear(UserSetup);
        //   UserSetup.Get(UserId);

        //   Clear(User);
        //  User.SetRange("User Name", UserId);

        //IF User.FindFirst() then;

        //  if not SmtpMailSetup.Get() then
        //    exit;


        // // Find Gen Journ Line
        // GenJournLine.SetRange("Journal Template Name", JournTempName);
        // GenJournLine.SetRange("Journal Batch Name", JournBatchName);
        // GenJournLine.SetRange("Line No.", LineNo);
        // GenJournLine.SetRange("Account Type", GenJournLine."Account Type"::Vendor);
        // if not GenJournLine.FindFirst() then
        //     Error('Vendor Line was not found ');

        //    Vendor.get(GenJournLine."Account No.");
        GLSetup.get();
        //   ErrorMessage.SetRange("Register ID", JobQueueEntry."Error Message Register Id");
        //   IF ErrorMessage.FindFirst() then;


        // if not Confirm('Are you sure you want to send an email to ' + Vendor.Name) then exit;

        // Set Currency
        // Curr := GenJournLine."Currency Code";
        // if Curr = '' then
        //     Curr := GLSetup."LCY Code";

        // Write Body
        // JobQueueEntry.CalcFields("Object Caption to Run");
        //  Body := StrSubstNo('Dear Mr. %1,<br><br>', User."Full Name");
        Body := 'This is a system generated email to inform you about the new Payment Request with the below details: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Payment Request:  </td><td>%1</td></tr>', PaymentRequest.Number);
        Body += StrSubstNo('<tr><td>SenderID : </td><td>%1</td></tr>', ApprovalEntry."Sender ID");
        Body += StrSubstNo('<tr><td>Amount :  </td><td>%1</td></tr>', FORMAT(PaymentRequest."Total Requested Amount") + ' ' + PaymentRequest.Currency);
        Body += StrSubstNo('<tr><td>URL :  </td><td>%1</td></tr>', GetUrl(ClientTypeManagement.GetCurrentClientType(), CompanyName, OBJECTTYPE::Page, Page::"Requests to Approve"));
        // //     Body += StrSubstNo('<tr><td>Cheque:</td><td>%1</td></tr>', GenJournLine."Check No");

        Body += '</table></br><br>';



        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';

        // Set Subject
        IF PaymentRequest.Supplier <> '' then
            Vendor.get(PaymentRequest.Supplier);

        Subject := 'Payment Request PO# ' + PaymentRequest."PO#" + ' Vendor Name ' + Vendor.Name + ' Level of Urgency ' + Format(PaymentRequest."Level of Urgency");


        // Add Recipient
        UserSetup.Get(User."User Name");
        Recipients := UserSetup."E-Mail";// 'tech@thecohort.com';// UserSetup."E-Mail";

        //   Email.CreateMessage(Recipients, '', '', Subject, Body, true, true);//, User);


        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage);

    end;

    procedure SendEmailVariationOrder(VariationOrder: Record "Variation Order")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        Recipients: text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
        Job: Record Job;
        ProjName: Text[100];
        AppProjNumber: Code[50];
    // User: Record User;

    begin
        //  Clear(UserSetup);
        //   UserSetup.Get(UserId);

        //   Clear(User);
        //  User.SetRange("User Name", UserId);

        //IF User.FindFirst() then;

        //  if not SmtpMailSetup.Get() then
        //    exit;


        // // Find Gen Journ Line
        // GenJournLine.SetRange("Journal Template Name", JournTempName);
        // GenJournLine.SetRange("Journal Batch Name", JournBatchName);
        // GenJournLine.SetRange("Line No.", LineNo);
        // GenJournLine.SetRange("Account Type", GenJournLine."Account Type"::Vendor);
        // if not GenJournLine.FindFirst() then
        //     Error('Vendor Line was not found ');

        //    Vendor.get(GenJournLine."Account No.");
        GLSetup.get();
        //   ErrorMessage.SetRange("Register ID", JobQueueEntry."Error Message Register Id");
        //   IF ErrorMessage.FindFirst() then;


        // if not Confirm('Are you sure you want to send an email to ' + Vendor.Name) then exit;

        // Set Currency
        // Curr := GenJournLine."Currency Code";
        // if Curr = '' then
        //     Curr := GLSetup."LCY Code";

        // Write Body
        // JobQueueEntry.CalcFields("Object Caption to Run");
        //  Body := StrSubstNo('Dear Mr. %1,<br><br>', User."Full Name");
        Job.SetRange("No.", VariationOrder."Project Code");
        if Job.FindFirst() then begin
            ProjName := Job.Description;
            AppProjNumber := Job."Apollo Project Number";
        end;
        Body := 'This is a system generated email to inform you about the new Variation Order that requires your confirmation with the below details: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Variation Order:  </td><td>%1</td></tr>', VariationOrder.Number);
        Body += StrSubstNo('<tr><td>SO Number:  </td><td>%1</td></tr>', VariationOrder."Sales Order No.");
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', AppProjNumber);
        Body += StrSubstNo('<tr><td>Dynamics Project Number:  </td><td>%1</td></tr>', VariationOrder."Project Code");
        Body += StrSubstNo('<tr><td>Dynamics Project Name:  </td><td>%1</td></tr>', ProjName);
        Body += StrSubstNo('<tr><td>Item No:  </td><td>%1</td></tr>', VariationOrder."Item Number");
        IF VariationOrder."Variation Action(Change Price)" then
            Body += StrSubstNo('<tr><td>%1 </td><td>to %2</td></tr>', VariationOrder.FieldCaption("Variation Action(Change Price)"), FORMAT(VariationOrder."New Price", 0, '<Precision,2:2><Standard Format,2>'));

        IF VariationOrder."Variation Action(Change Qty)" then
            Body += StrSubstNo('<tr><td>%1 </td><td>to %2</td></tr>', VariationOrder.FieldCaption("Variation Action(Change Qty)"), VariationOrder."New Qty");


        IF VariationOrder."Variation Action(Change UOM)" then
            Body += StrSubstNo('<tr><td>%1 </td><td>to %2</td></tr>', VariationOrder.FieldCaption("Variation Action(Change UOM)"), VariationOrder."New UOM");

        IF VariationOrder."Variation Action(Change Cost)" then
            Body += StrSubstNo('<tr><td>%1 </td><td>: %2 - %3</td></tr>', VariationOrder.FieldCaption("Variation Action(Change Cost)"), FORMAT(VariationOrder."New Cost", 0, '<Precision,2:2><Standard Format,2>'), VariationOrder."Cost Status");

        IF VariationOrder."Variation Action(Add Item)" then
            Body += StrSubstNo('<tr><td>%1 </td><td>: %2</td></tr>', VariationOrder.FieldCaption("Variation Action(Add Item)"), VariationOrder."Item Number");

        IF VariationOrder."Variation Action(Replace Item)" then
            Body += StrSubstNo('<tr><td>%1 </td><td>%2 to %3</td></tr>', VariationOrder.FieldCaption("Variation Action(Replace Item)"), VariationOrder."Item Number", VariationOrder."New Item Number");
        Body += StrSubstNo('<tr><td>Remarks: %1</td></tr>', VariationOrder.Remarks);
        Body += '</table></br><br>';



        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';

        // Set Subject

        Subject := 'Variaion Order Project# ' + VariationOrder."Project Code" + 'Variation Order Number ' + VariationOrder.Number;


        // Add Recipient
        //Commented by AN 03/05/25
        // UserSetup.SetRange("Change Status of VO");
        // IF UserSetup.FindFirst() then;
        // Recipients := UserSetup."E-Mail";// 'tech@thecohort.com';// UserSetup."E-Mail";

        //   Email.CreateMessage(Recipients, '', '', Subject, Body, true, true);//, User);
        // AN 03/05/25
        UserSetup.SetRange("VO Reciever", true);
        IF UserSetup.FindFirst() then begin
            repeat
                Recipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            Recipients := DELCHR(Recipients, '>', ';');

            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;
    //AN 03/10/25
    procedure SendEmailSalesCrMemo(SalesHeader: Record "Sales Header")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
        ProjName: Text[100];
        Job: Record Job;
        SalesLine: Record "Sales Line";
        AppProjectManager: Code[50];
        AppProjNumber: Code[50];
    begin
        GLSetup.Get();

        Body := 'This is a system generated email to inform you about the new Sales Order: <br><br>';
        Body += '<table  style="margin-left:15px">';
        //AN 03/17/2025+
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindFirst() then begin
            //AN 03/17/2025+
            Job.SetRange("No.", SalesLine."Job No.");
            if Job.FindFirst() then begin
                ProjName := Job.Description;
                AppProjectManager := Job."Apollo Project Manager";
                AppProjNumber := Job."Apollo Project Number";
            end;
        end;
        Body += StrSubstNo('<tr><td>Sales Cr Memo:  </td><td>%1</td></tr>', SalesHeader."No.");
        //AN 03/17/2025+
        Body += StrSubstNo('<tr><td>User:  </td><td><b>%1 - %2</b></td></td></tr>', UserId, AppProjectManager);
        Body += StrSubstNo('<tr><td>Client Name:  </td><td>%1</td></tr>', SalesHeader."Sell-to Customer Name");
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', AppProjNumber);
        SalesHeader.CalcFields(Amount);
        Body += StrSubstNo('<tr><td>Amount:  </td><td>%1 %2</td></tr>', SalesHeader."Amount", GLSetup."LCY Code");

        //AN 03/17/2025-
        //AN 03/17/2025-
        Body += StrSubstNo('<tr><td>Project Code:  </td><td>%1</td></tr>', SalesLine."Job No.");
        Body += StrSubstNo('<tr><td>Project Name:  </td><td>%1</td></tr>', ProjName);
        // end;
        //AN 03/17/2025-
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
                           // Set Subject
        Subject := 'Sales Order ' + SalesHeader."No.";

        // Add Recipient
        UserSetup.SetRange(Reciever, true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;

        // IF UserSetup.FindFirst() then begin
        //     MultiRecipients := UserSetup."E-Mail";
        //     while UserSetup.Next() <> 0 do
        //         MultiRecipients += ';' + UserSetup."E-Mail";
        // end;

        // EmailMessage.Create(MultiRecipients, Subject, Body, true);
        // Email.Send(EmailMessage);
    end;

    //AN 03/05/25
    procedure SendEmailSalesOrder(SalesHeader: Record "Sales Header")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
        ProjName: Text[100];
        Job: Record Job;
        SalesLine: Record "Sales Line";
        AppProjectManager: Code[50];
        AppProjNumber: Code[50];
    begin
        GLSetup.Get();
        Body := 'This is a system generated email to inform you about the new Sales Order: <br><br>';
        Body += '<table  style="margin-left:15px">';
        //AN 03/17/2025+
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindFirst() then begin
            //AN 03/17/2025+
            Job.SetRange("No.", SalesLine."Job No.");
            if Job.FindFirst() then begin
                ProjName := Job.Description;
                AppProjectManager := Job."Apollo Project Manager";
                AppProjNumber := Job."Apollo Project Number";
            end;
        end;
        Body += StrSubstNo('<tr><td>Sales Order:  </td><td>%1</td></tr>', SalesHeader."No.");
        //AN 03/17/2025+
        Body += StrSubstNo('<tr><td>User:  </td><td><b>%1 - %2</b></td></td></tr>', UserId, AppProjectManager);
        Body += StrSubstNo('<tr><td>Client Name:  </td><td>%1</td></tr>', SalesHeader."Sell-to Customer Name");
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', AppProjNumber);
        SalesHeader.CalcFields(Amount);
        Body += StrSubstNo('<tr><td>Amount:  </td><td>%1 %2</td></tr>', SalesHeader."Amount", GLSetup."LCY Code");

        //AN 03/17/2025-
        //AN 03/17/2025-
        Body += StrSubstNo('<tr><td>Project Code:  </td><td>%1</td></tr>', SalesLine."Job No.");
        Body += StrSubstNo('<tr><td>Project Name:  </td><td>%1</td></tr>', ProjName);
        // end;
        //AN 03/17/2025-
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
                           // Set Subject
        Subject := 'Sales Order ' + SalesHeader."No.";

        // Add Recipient
        UserSetup.SetRange(Reciever, true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;

        // IF UserSetup.FindFirst() then begin
        //     MultiRecipients := UserSetup."E-Mail";
        //     while UserSetup.Next() <> 0 do
        //         MultiRecipients += ';' + UserSetup."E-Mail";
        // end;

        // EmailMessage.Create(MultiRecipients, Subject, Body, true);
        // Email.Send(EmailMessage);
    end;

    //AN 03/05/25
    procedure SendEmailSubmitalComments(SubmittalComment: Record SubmittalComment)
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
        ProjName: Text[100];
        Job: Record Job;
        AppProjectManager: Code[50];
        AppProjID: Code[50];
    begin
        Job.SetRange("No.", SubmittalComment."Dynamics Project Number");
        if Job.FindFirst() then begin
            AppProjID := Job."Apollo Project Number";
            ProjName := Job.Description;
            AppProjectManager := Job."Apollo Project Manager";
        end;

        Body := 'This is a system generated email to inform you about the new Submittal Comment: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Submital Comment ID:  </td><td>%1</td></tr>', Format(SubmittalComment.SubmittalCommentId));
        Body += StrSubstNo('<tr><td>User:  </td><td><b>%1 - %2</b></td></td></tr>', UserId, AppProjectManager);
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', AppProjID);
        Body += StrSubstNo('<tr><td>Dynamics Project Number:  </td><td>%1</td></tr>', SubmittalComment."Dynamics Project Number");
        Body += StrSubstNo('<tr><td>Dynamics Project Name:  </td><td>%1</td></tr>', ProjName);
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
        // Set Subject
        Subject := 'Submital Comment ID: ' + Format(SubmittalComment.SubmittalCommentId);

        // Add Recipient
        UserSetup.SetRange("Submittal Cmt Rec", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;

    //AN 03/05/25
    procedure SendEmailIntermediateItem(IntermediateItems: Record "Intermediate Items")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
    begin
        Body := 'This is a system generated email to inform you about the new Intermediate Item: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', IntermediateItems."Apollo Project Number");
        Body += StrSubstNo('<tr><td>Dynamics Project Number:  </td><td>%1</td></tr>', IntermediateItems."Project Number");
        Body += StrSubstNo('<tr><td>Apollo User Name:  </td><td><b>%1</b></td></tr>', IntermediateItems."Apollo User Name");
        Body += StrSubstNo('<tr><td>Intermediate Item:  </td><td>%1</td></tr>', IntermediateItems."No.");
        Body += StrSubstNo('<tr><td>Description:  </td><td>%1</td></tr>', IntermediateItems.Description);
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
        // Set Subject
        Subject := 'Intermediate Item: ' + IntermediateItems."No.";

        // Add Recipient
        UserSetup.SetRange("InterItem Reciever", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;

    //AN 03/05/25
    procedure SendEmailIntermediateCust(IntermediateCusts: Record "Intermediate Customers")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
    // AppProjNumber: Code[50];
    // Job: Record Job;
    begin
        Body := 'This is a system generated email to inform you about the new Intermediate Customer: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Description:  </td><td><b>%1</b></td></tr>', IntermediateCusts."Apollo User Name");
        Body += StrSubstNo('<tr><td>Intermediate Customer:  </td><td>%1</td></tr>', IntermediateCusts."No.");
        Body += StrSubstNo('<tr><td>Description:  </td><td>%1</td></tr>', IntermediateCusts.Name);
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
        // Set Subject
        Subject := 'Intermediate Customer: ' + IntermediateCusts."No.";

        // Add Recipient
        UserSetup.SetRange("InterCust Reciever", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;

    //AN 03/05/25
    procedure SendEmailIntermediateVend(IntermediateVends: Record "Intermediate Vendors")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
    begin
        Body := 'This is a system generated email to inform you about the new Intermediate Vendor: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Description:  </td><td><b>%1</b></td></tr>', IntermediateVends."Apollo User Name");
        Body += StrSubstNo('<tr><td>Intermediate Vendor:  </td><td>%1</td></tr>', IntermediateVends."No.");
        Body += StrSubstNo('<tr><td>Description:  </td><td>%1</td></tr>', IntermediateVends.Name);
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
        // Set Subject
        Subject := 'Intermediate Vendor: ' + IntermediateVends."No.";

        // Add Recipient

        UserSetup.SetRange("InterVend Reciever", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;

    //AN 03/06/25
    procedure SendEmailPurchOrder(PurchHeader: Record "Purchase Header")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
        ProjName: Text[100];
        Job: Record Job;
        PurchaseLine: Record "Purchase Line";
        AppProjNumber: Code[50];
    begin
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        if PurchaseLine.FindFirst() then begin
            Job.SetRange("No.", PurchaseLine."Job No.");
            if Job.FindFirst() then begin
                AppProjNumber := Job."Apollo Project Number";
            end;//aya 
        end;
        GLSetup.Get();
        Body := 'This is a system generated email to inform you about the new Purchase Order: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Purchase Order:  </td><td>%1</td></tr>', PurchHeader."No.");
        //AN 03/17/2025+
        Body += StrSubstNo('<tr><td>User:  </td><td><b>%1</b></td></tr>', UserId);
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', AppProjNumber);
        Body += StrSubstNo('<tr><td>Vendor Name:  </td><td>%1</td></tr>', PurchHeader."Buy-from Vendor Name");
        PurchHeader.CalcFields(Amount);
        if PurchHeader."Currency Code" <> '' then
            Body += StrSubstNo('<tr><td>Amount:  </td><td>%1 %2</td></tr>', PurchHeader."Amount", PurchHeader."Currency Code")
        else
            Body += StrSubstNo('<tr><td>Amount:  </td><td>%1 %2</td></tr>', PurchHeader."Amount", GLSetup."LCY Code");

        //Added by aya 07/15/2025
        PurchHeader.CalcFields("Invoice Discount Amount");
        if PurchHeader."Invoice Discount Amount" <> 0 then
            if PurchHeader."Currency Code" <> '' then
                Body += StrSubstNo('<tr><td>Amount After Discount:  </td><td>%1 %2</td></tr>', PurchHeader."Amount" - PurchHeader."Invoice Discount Amount", PurchHeader."Currency Code")
            else
                Body += StrSubstNo('<tr><td>Amount After Discount:  </td><td>%1 %2</td></tr>', PurchHeader."Amount" - PurchHeader."Invoice Discount Amount", GLSetup."LCY Code");
        //AN 03/17/2025+
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        if PurchaseLine.FindFirst() then begin
            //AN 03/17/2025+
            Job.SetRange("No.", PurchaseLine."Job No.");
            if Job.FindFirst() then begin
                ProjName := Job.Description;
            end;
            //AN 03/17/2025-
            //AN 03/17/2025-
            Body += StrSubstNo('<tr><td>Project Code:  </td><td>%1</td></tr>', PurchaseLine."Job No.");
            Body += StrSubstNo('<tr><td>Project Name:  </td><td>%1</td></tr>', ProjName);
        end;
        //AN 03/17/2025-
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
        // Set Subject
        Subject := 'Purchase Order ' + PurchHeader."No.";
        //an
        // Add Recipient
        UserSetup.SetRange("PO Reciever", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;

    //AN 03/10/25
    procedure SendEmailPurchCrMemo(PurchHeader: Record "Purchase Header")
    var
        GenJournLine: Record "Gen. Journal Line";
        GenJournLine2: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        Curr: Code[10];
        GLSetup: Record "General Ledger Setup";
        Bank: Record "Bank Account";
        checkText: Text;
        checkText2: Text;
        SmtpMailSetup: Record "Email Account";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        BCCList: List of [Text];
        UserSetup: Record "User Setup";
        ErrorMessage: record "Error Message";
        ClientTypeManagement: Codeunit "Client Type Management";
        ProjName: Text[100];
        Job: Record Job;
        PurchaseLine: Record "Purchase Line";
        AppProjNumber: Code[50];
    begin
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        if PurchaseLine.FindFirst() then begin
            Job.SetRange("No.", PurchaseLine."Job No.");
            if Job.FindFirst() then begin
                AppProjNumber := Job."Apollo Project Number";
            end;
        end;
        Body := 'This is a system generated email to inform you about the new Purchase Credit Memo: <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Purchase Credit Memo:  </td><td>%1</td></tr>', PurchHeader."No.");
        //AN 03/17/2025+
        Body += StrSubstNo('<tr><td>User:  </td><td><b>%1</b></td></tr>', UserId);
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', AppProjNumber);
        Body += StrSubstNo('<tr><td>Vendor Name:  </td><td>%1</td></tr>', PurchHeader."Buy-from Vendor Name");
        PurchHeader.CalcFields(Amount);
        if PurchHeader."Currency Code" <> '' then
            Body += StrSubstNo('<tr><td>Amount:  </td><td>%1 %2</td></tr>', PurchHeader."Amount", PurchHeader."Currency Code")
        else
            Body += StrSubstNo('<tr><td>Amount:  </td><td>%1 %2</td></tr>', PurchHeader."Amount", GLSetup."LCY Code");
        //AN 03/17/2025+
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        if PurchaseLine.FindFirst() then begin
            //AN 03/17/2025+
            Job.SetRange("No.", PurchaseLine."Job No.");
            if Job.FindFirst() then begin
                ProjName := Job.Description;
            end;
            //AN 03/17/2025-
            //AN 03/17/2025-
            Body += StrSubstNo('<tr><td>Project Code:  </td><td>%1</td></tr>', PurchaseLine."Job No.");
            Body += StrSubstNo('<tr><td>Project Name:  </td><td>%1</td></tr>', ProjName);
        end;
        //AN 03/17/2025-
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
        // Set Subject
        Subject := 'Purchase Credit Memo ' + PurchHeader."No.";

        // Add Recipient
        UserSetup.SetRange("PO Reciever", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;
    //AN 05/30/25
    procedure SendEmailProjectTask(JobTask: Record "Job Task")
    var
        GLSetup: Record "General Ledger Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        UserSetup: Record "User Setup";
        Job: Record Job;
    begin
        if Job.Get(JobTask."Job No.") then begin
            Body := 'This is a system generated email to inform you about the new project lines are exported: <br><br>';
            Body += '<table  style="margin-left:15px">';
            Body += StrSubstNo('<tr><td>Project No:  </td><td>%1</td></tr>', Job."No.");
            Body += StrSubstNo('<tr><td>Project Name:  </td><td>%1</td></tr>', Job.Description);
            //AN 03/17/2025+
            Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', Job."Apollo Project Number");
            Body += StrSubstNo('<tr><td>Total Apollo Value:  </td><td>%1</td></tr>', Job."Apollo Total Offer Value");
            JobTask.CalcFields("Contract (Total Price)");
            Body += StrSubstNo('<tr><td>Exported Amount:  </td><td>%1</td></tr>', JobTask."Contract (Total Price)");
        end;
        //AN 03/17/2025-
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
                           // Set Subject
        Subject := 'Project No: ' + JobTask."Job No.";

        // Add Recipient
        UserSetup.SetRange("Projects Reciever", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;
    //AN 08/04/2025
    procedure SendEmailAppSQ(ShippingQuotation: Record "Shipping Quotation")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        UserSetup: Record "User Setup";
    begin
        Body := 'This is a system generated email to inform you that the Shipping Quotation is approved. <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Shipping Quotation No. :  </td><td><b>%1</b></td></tr>', ShippingQuotation."Comparison ID");
        ShippingQuotation.CalcFields("Apollo Project No.");
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', ShippingQuotation."Apollo Project No.");
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
        // Set Subject
        Subject := 'Approved Shipping Quotation: ' + ShippingQuotation."Comparison ID";

        // Add Recipient

        UserSetup.SetRange("Sent Email Approved SQ", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;

    //AN 08/05/2025
    procedure SendEmailProjectCard(Job: Record Job)
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        MultiRecipients: Text;
        UserSetup: Record "User Setup";
    begin
        Body := 'This is a system generated email to inform you that new project is being exported. <br><br>';
        Body += '<table  style="margin-left:15px">';
        Body += StrSubstNo('<tr><td>Project No. :  </td><td><b>%1</b></td></tr>', Job."No.");
        Body += StrSubstNo('<tr><td>Project Name:  </td><td>%1</td></tr>', Job.Description);
        Body += StrSubstNo('<tr><td>Customer Name:  </td><td>%1</td></tr>', Job."Sell-to Customer Name");
        Body += StrSubstNo('<tr><td>Apollo Project Number:  </td><td>%1</td></tr>', Job."Apollo Project Number");
        Body += '</table></br><br>';
        Body += 'Thank you.<br><br>';
        Body += 'Regards,';//<br><br>Nathalie Dimassi';
        // Set Subject
        Subject := 'Project No: ' + Job."No.";

        // Add Recipient

        UserSetup.SetRange("Sent Email Project Card", true);
        IF UserSetup.FindFirst() then begin
            repeat
                MultiRecipients += UserSetup."E-Mail" + ';';
            until UserSetup.Next() = 0;
            MultiRecipients := DELCHR(MultiRecipients, '>', ';');
            EmailMessage.Create(MultiRecipients, Subject, Body, true);
            Email.Send(EmailMessage);
        end;
    end;

    var
        myInt: Integer;
}