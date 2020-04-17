table 50102 "LD Loan Header"
{
    Caption = 'Loan';
    //DrillDownPageId = 
    //LookupPageId = 
    fields
    {
        field(1; Loannr; Integer)
        {
            Caption = 'Uitleendocumentnummer';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; Customernr; Code[20])
        {
            Caption = 'Klantnummer';
            DataClassification = SystemMetadata;
            TableRelation = customer."No.";
            trigger OnValidate()
            begin
                CheckAbbo();
            end;
        }
        field(3; "CustomerName"; Text[100])
        {
            Caption = 'Klantnaam';
            FieldClass = FlowField;
            CalcFormula = lookup (Customer.Name where("No." = field(Customernr)));
        }
        field(4; UitleenDatum; Date)
        {
            Caption = 'Uitleen Datum';
            DataClassification = SystemMetadata;
        }
        field(5; "Teruggave Datum"; Date)
        {
            Caption = 'Teruggave Datum';
            DataClassification = SystemMetadata;
        }
        field(6; completed; Boolean)
        {
            Caption = 'Afgesloten';
            Editable = false;
            DataClassification = SystemMetadata;

        }
    }
    keys
    {
        key(PK; Loannr)
        { }
    }

    local procedure CheckAbbo()
    var
        Abonnement: Record "LD Abonnementen";
    begin
        Abonnement.Reset();
    end;

    procedure CreateNew()
    var
        LoanHeader: Record "LD Loan Header";
        LoanHeaderPage: Page "LD Loan Header";
        CustomerListPage: Page "Customer List";
        Customer: Record Customer;
        Abonnement: Record "LD Abonnementen";
        MessageText: Text;
    begin
        CustomerListPage.LookupMode(true);
        If CustomerListPage.RunModal() = Action::LookupOK then begin
            CustomerListPage.GetRecord(Customer);
            Abonnement.Reset();
            Abonnement.SetRange(Customernr, Customer."No.");
            if Abonnement.FindFirst() and (Abonnement.einddatum > CalcDate('14D', WorkDate())) then begin
                LoanHeader.Reset();
                LoanHeader.Init();
                LoanHeader.Insert();
                LoanHeader.Validate(UitleenDatum, WorkDate());
                LoanHeader.Validate("Teruggave Datum", CalcDate('14D', WorkDate()));
                LoanHeader.Validate(Customernr, Customer."No.");
                LoanHeader.Validate(completed, true);
                LoanHeader.Modify();
                LoanHeaderPage.SetRecord(LoanHeader);
                LoanHeaderPage.Run();
            end
            else begin
                Abonnement.Reset();
                Abonnement.SetRange(Customernr, Customer."No.");
                if Abonnement.FindFirst() then begin
                    if Abonnement.einddatum < WorkDate() then
                        MessageText := 'Klant: ' + Format(customer.Name) + ' abonnement is vervallen wile je een abonnement verlengen?'
                    else
                        MessageText := 'Klant: ' + Format(Customer.Name) + ' abonnement zal vervallen voor het einde van de huurtermijn, wil je abonnement verlengen?';
                end
                else
                    MessageText := 'Klant: ' + Format(customer.Name) + ' abonnement bestaat niet wil je abonnement aanmaken?';
                If Confirm(MessageText, true) then
                    CreateAbboOrder(Customer."No.");
            end;
        end
        else
            Message('Order niet aangemaakt');
    end;

    procedure MoveToFinishedLoanHeader(var Loanheader: Record "LD Loan Header")
    var
        FinishedLoanHeader: Record "LD Finished Loan Header";
        LoanLines: Record "LD Loan Lines";
    begin
        If Loanheader."Teruggave Datum" < WorkDate() then
            CreateBoete(Loanheader);
        LoanLines.Reset();
        loanlines.SetRange(Loannr, rec.Loannr);
        if loanlines.FindSet() then begin
            message('set gevonden');
            repeat
                LoanLines.MoveToFinishedLoanLines(LoanLines);
                LoanLines.Delete()
            until LoanLines.Next() = 0;
            FinishedLoanHeader.Reset();
            FinishedLoanHeader.Init();
            FinishedLoanHeader.TransferFields(Loanheader);
            FinishedLoanHeader.Insert();
            FinishedLoanHeader.Validate("Teruggave Datum", WorkDate());
            FinishedLoanHeader.Modify();
        end;
    end;

    local procedure FindItemBoete(): Code[20]
    var
        Item: Record Item;
    begin
        Item.reset();
        Item.SetRange("Item Category Code", 'BOETE');
        item.FindSet();
        exit(Item."No.");
    end;

    local procedure FindItemAbbo(): Code[20]
    var
        Item: Record Item;
    begin
        Item.reset();
        Item.SetRange("Item Category Code", 'ABBO');
        item.FindSet();
        exit(Item."No.");
    end;

    Local Procedure CreateBoete(LoanHeader: Record "LD Loan Header")
    var
        SalesAndRecievablesSetup: Record "Sales & Receivables Setup";
        Days: Integer;
        ItemNoBoete: Code[20];
        SalesHeader: Record "Sales Header";
        SalesLines: Record "Sales Line";
        NoSeriesCodeUnit: Codeunit NoSeriesManagement;
        LoanLines: Record "LD Loan Lines";
        SalesPage: page "Sales Order";
        Item: Record Item;
        LineNo: Integer;
    begin
        Message('Te late Teruggave, boete wordt aangemaakt');
        SalesAndRecievablesSetup.FindFirst();
        Days := WorkDate() - Loanheader."Teruggave Datum";
        ItemNoBoete := FindItemBoete();
        SalesHeader.Reset();
        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Validate("Sell-to Customer No.", Loanheader.Customernr);
        SalesHeader.Validate("No.", NoSeriesCodeUnit.GetNextNo(SalesAndRecievablesSetup."Order Nos.", WorkDate(), true));
        SalesHeader.Insert();
        SalesPage.SetRecord(SalesHeader);
        LoanLines.Reset();
        LoanLines.SetRange(Loannr, Loanheader.Loannr);
        LoanLines.FindSet();
        repeat
            Lineno += 10;
            Saleslines.Reset();
            Saleslines.Init();
            Saleslines.Validate("Document Type", SalesHeader."Document Type");
            Saleslines.Validate("Document No.", SalesHeader."No.");
            saleslines.validate("Line No.", Lineno);
            Saleslines.Validate(Type, Saleslines.Type::Item);
            saleslines.Insert();
            Saleslines.Validate("No.", ItemNoBoete);
            Item.Reset();
            Item.SetRange("No.", LoanLines.Itemnr);
            Item.FindFirst();
            SalesLines.validate(Description, 'Boete voor te laat inleveren ' + Item.Description);
            Saleslines.Validate(Quantity, Days);
            Saleslines.Modify();
        until LoanLines.Next() = 0;
        SalesPage.Run();
    end;

    Local Procedure CreateAbboOrder(customerno: Code[20])
    var
        SalesAndRecievablesSetup: Record "Sales & Receivables Setup";
        ItemNoAbbo: Code[20];
        SalesHeader: Record "Sales Header";
        SalesLines: Record "Sales Line";
        NoSeriesCodeUnit: Codeunit NoSeriesManagement;
        SalesPage: page "Sales Order";
    begin
        SalesAndRecievablesSetup.FindFirst();
        ItemNoAbbo := FindItemAbbo();
        SalesHeader.Reset();
        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Validate("Sell-to Customer No.", customerno);
        SalesHeader.Validate("No.", NoSeriesCodeUnit.GetNextNo(SalesAndRecievablesSetup."Order Nos.", WorkDate(), true));
        SalesHeader.Insert();
        SalesPage.SetRecord(SalesHeader);
        Saleslines.Reset();
        Saleslines.Init();
        Saleslines.Validate("Document Type", SalesHeader."Document Type");
        Saleslines.Validate("Document No.", SalesHeader."No.");
        saleslines.validate("Line No.", 1);
        Saleslines.Validate(Type, Saleslines.Type::Item);
        saleslines.Insert();
        Saleslines.Validate("No.", ItemNoAbbo);
        Saleslines.Modify();

        SalesPage.Run();
    end;
}