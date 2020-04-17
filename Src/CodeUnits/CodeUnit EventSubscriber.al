codeunit 50100 EventSubscriber
{
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'GTIN', true, true)]
    local procedure CreateBook(rec: Record Item)
    var
        Boek: Record "LD Boek";
        Boekpage: Page "LD Boek";
    begin
        if rec."Item Category Code" = 'BOEK' then begin
            Boek.Reset();
            Boek.SetRange(ISBN, rec.GTIN);
            if Boek.FindFirst() then begin
                Boekpage.SetTableView(Boek);
                Boekpage.Run();
            end
            else begin
                Boek.Reset();
                Boek.Init();
                Boek.Validate(ISBN, rec.GTIN);
                Boek.Insert(true);
                Boek.SetRange(ISBN, rec.GTIN);
                Boek.FindFirst();
                Boekpage.SetTableView(Boek);
                Boekpage.Run();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure CheckAbbo(Rec: Record "Sales Invoice Line")
    var
        Abonnementen: Record "LD Abonnementen";
        index: Integer;
        Datum: Date;
    begin
        if (rec."Item Category Code" = 'ABBO') then begin
            Abonnementen.Reset();
            Abonnementen.SetRange(Customernr, rec."Sell-to Customer No.");
            Abonnementen.SetRange("Abonnements type", rec."No.");
            if Abonnementen.FindFirst() then begin
                if Abonnementen.einddatum >= rec."Posting Date" then begin
                    Datum := Abonnementen.einddatum;
                    for index := 1 to rec.Quantity do begin
                        Datum := CalcDate('1M', Datum);
                    end;
                end
                else begin
                    Datum := rec."Posting Date";
                    for index := 1 to rec.Quantity do begin
                        Datum := CalcDate('1m', Datum);
                    end;
                end;
            end
            else begin
                Abonnementen.Reset();
                Abonnementen.Init();
                Abonnementen.Validate(Customernr, Rec."Sell-to Customer No.");
                Abonnementen.Validate("Abonnements type", Rec."No.");
                Abonnementen.Insert(true);
                Datum := rec."Posting Date";
                for index := 1 to rec.Quantity do begin
                    Datum := CalcDate('1m', Datum);
                end;
                Abonnementen.Validate(startdatum, rec."Posting Date");
            end;
            Abonnementen.Validate(einddatum, Datum);
            Abonnementen.Modify(true);
        end
    end;


    /*
        Local procedure UpdateItem(WarehouseActivityLine: Record "Warehouse Activity Line")
        var
            Item: Record Item;
        begin
            Item.Reset();
            Item.SetRange("No.", WarehouseActivityLine."Item No.");
            Item.FindFirst();
            Item.CalcFields(Loaned);
            Item.CalcFields(Inventory);
            Message('Controle Available nieuw Item, Loand: ' + Format(Item.Loaned) + ' en Inventory' + Format(Item.Inventory));
            if item.Loaned < item.Inventory then
                Item.available := true else
                Item.available := false;
            Item.Modify();
        end;
    */
    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnAfterGetCurrRecordEvent', '', true, true)]
    local procedure CheckAvailable(var rec: Record Item)
    begin
        if rec.loaned < rec.Inventory then
            rec.available := true
        else
            rec.available := false;
        rec.Modify()
    end;


    [EventSubscriber(ObjectType::Table, Database::"LD Loan Lines", 'OnAfterModifyEvent', '', true, true)]
    local procedure CheckFinishedAndAvailable(rec: Record "LD Loan Lines")
    var
        LoanLines: Record "LD Loan Lines";
        Item: Record Item;
    begin
        Item.Reset();
        Item.SetRange("No.", rec.Itemnr);
        Item.FindFirst();
        item.CalcFields(Loaned);
        item.CalcFields(Inventory);
        if item.Inventory > Item.Loaned then
            Item.Validate(available, true)
        else
            item.Validate(available, false);
        Item.Modify();
        LoanLines.Reset();
        LoanLines.SetRange(Loannr, rec.Loannr);
        LoanLines.SetRange(serienummer, rec.serienummer);
        LoanLines.FindFirst();
        LoanLines.CheckReturned();
    end;

    [EventSubscriber(ObjectType::Table, Database::"LD Loan Lines", 'OnAfterInsertEvent', '', true, true)]
    local procedure CheckFinishedAndAvailableAfterInsert(rec: Record "LD Loan Lines")
    begin
        CheckFinishedAndAvailable(rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"LD Loan Lines", 'OnAfterDeleteEvent', '', true, true)]
    local procedure CheckFinishedAndAvailableAfterDelete(rec: Record "LD Loan Lines")
    var
        //LoanLines: Record "LD Loan Lines";
        LoanHeader: Record "LD Loan Header";
        Item: Record Item;
    begin
        LoanHeader.Reset();
        LoanHeader.SetRange(Loannr, rec.Loannr);
        LoanHeader.FindFirst();
        Item.Reset();
        Item.SetRange("No.", rec.Itemnr);
        Item.FindFirst();
        item.CalcFields(Loaned);
        item.CalcFields(Inventory);
        if item.Inventory > Item.Loaned then
            Item.Validate(available, true)
        else
            item.Validate(available, false);
        Item.Modify();
        rec.CheckReturned();
    end;
}