codeunit 70113 "Post Inventory to Apollo"
{
    trigger OnRun()
    var
        myInt: Integer;
    begin
        InserttoItemInventory();
        PostInventorytoApollo();
    end;

    local procedure PostInventorytoApollo()
    var
        Item: Record Item;
        IteminInventory: Record "Item in Inventory";
    begin
        Clear(IteminInventory);
        IteminInventory.SetRange(PostAPI, false);
        if IteminInventory.FindFirst() then
            repeat
                if Item.Get(IteminInventory."Item No.") then
                    if Item.ApolloItemNo <> 0 then
                        if Postinventory(Format(Item.ApolloItemNo), Format(IteminInventory.Quantity), IteminInventory.Location) = true then begin
                            IteminInventory.PostAPI := true;
                            IteminInventory.Modify();
                        end;
            until IteminInventory.Next() = 0;
    end;

    local procedure InserttoItemInventory()
    var
        ItemLedgQuery: Query "Item Ledg Query";
        IteminInventory: Record "Item in Inventory";
        IteminInventory2: Record "Item in Inventory";
    begin
        Clear(IteminInventory);
        ItemLedgQuery.SetFilter(ItemLedgQuery.quantity, '<>%1', 0);
        ItemLedgQuery.SetFilter(ItemLedgQuery.Location_Code, '<>%1', '');
        if ItemLedgQuery.Open() then
            while ItemLedgQuery.Read() do begin
                IteminInventory.SetRange("Item No.", ItemLedgQuery.itemNo);
                IteminInventory.SetRange("Location", ItemLedgQuery.Location_Code);
                IteminInventory.SetFilter(Quantity, '<>%1', ItemLedgQuery.quantity);
                if IteminInventory.FindSet() then begin
                    repeat
                        IteminInventory.Quantity := ItemLedgQuery.quantity;
                        IteminInventory.PostAPI := false;
                        IteminInventory.Modify();
                    until IteminInventory.Next() = 0;
                end;
                Clear(IteminInventory);
                IteminInventory.SetRange("Item No.", ItemLedgQuery.itemNo);
                IteminInventory.SetRange("Location", ItemLedgQuery.Location_Code);
                if not IteminInventory.FindFirst() then begin
                    Clear(IteminInventory2);
                    IteminInventory2.Init();
                    IteminInventory2."Item No." := ItemLedgQuery.itemNo;
                    IteminInventory2.Quantity := ItemLedgQuery.quantity;
                    IteminInventory2.Location := ItemLedgQuery.Location_Code;
                    IteminInventory2.PostAPI := false;
                    IteminInventory2.Insert();
                end;
            end;
    end;

    procedure Postinventory(ApolloItemNo: Text; DynamicsStock: Text; DynamicsWarehouse: Text): Boolean
    var
        Client: HttpClient;
        OutputString: Text;
        Content: HttpContent;
        postData: Text;
        RequestHeaders: HttpHeaders;
        ResponseHeader: HttpResponseMessage;
        HttpHeadersContent: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        Item: Record Item;
        IteminInventory: Record "Item in Inventory";
        sentAPI: Boolean;
    begin
        sentAPI := false;
        postData := '{"ApolloId": "' + ApolloItemNo + '","DynamicsStock": "' + DynamicsStock + '","DynamicsWarehouse": "' + DynamicsWarehouse + '"}';
        //Message('Sending Item: %1, Qty: %2, Location: %3', ApolloItemNo, DynamicsStock, DynamicsWarehouse);

        //postData := '{"ApolloId": ' + ApolloItemNo + ',"DynamicsStock": ' + DynamicsStock + ',"DynamicsWarehouse": ' + DynamicsWarehouse + ' "}';
        // Message(postData);
        RequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Clear();
        RequestHeaders.Add('Authorization', 'No Auth');
        RequestHeaders.Add('Accept', 'application/json');
        Content.WriteFrom(postData);

        //GET HEADERS
        Content.GetHeaders(HttpHeadersContent);
        HttpHeadersContent.Clear();
        HttpHeadersContent.Remove('Content-Type');
        HttpHeadersContent.Add('Content-Type', 'application/json; charset=UTF-8');


        //POST METHOD
        RequestMessage.Content := Content;
        RequestMessage.SetRequestUri('https://apollolightingapp.com/api/v1/Item/UpdateItemStockByItemId');
        RequestMessage.Method := 'POST';

        IF Client.Send(RequestMessage, ResponseMessage) then begin
            IF ResponseMessage.IsSuccessStatusCode then begin
                ResponseMessage.Content.ReadAs(OutputString);
                Message('%1', OutputString + ' :  Quantity is updated in Apollo');
                sentAPI := true;
            end else begin
                Error('Error: %1', ResponseMessage.ReasonPhrase);
                sentAPI := false
            end
        end else begin
            Error('Error: %1', ResponseMessage.ReasonPhrase);
            sentAPI := false;
        end;
        exit(sentAPI);
    end;
}
