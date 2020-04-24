table 50103 "LD Loan Lines"
{
    Caption = 'Loan Line';
    fields
    {
        field(1; Loannr; Integer)
        {
            Caption = 'Uitleendocumentnummer';
            DataClassification = SystemMetadata;
            TableRelation = "LD Loan Header".Loannr;
        }
        field(2; Itemnr; Code[20])
        {
            Caption = 'Artikel nummer';
            DataClassification = SystemMetadata;
            TableRelation = item."No." where(available = const(true));
        }
        field(3; serienummer; Code[20])
        {
            Caption = 'serienummer';
            DataClassification = SystemMetadata;
            TableRelation = "Serial No. Information"."Serial No." where("Item No." = field(Itemnr), NotAvailable = const(false));
            NotBlank = true;
        }
        field(4; Returned; Boolean)
        {
            Caption = 'Teruggebracht';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; Loannr, serienummer)
        { }
    }
    procedure CheckReturned()
    var
        LoanHeader: Record "LD Loan Header";
        LoanLines: Record "LD Loan Lines";
        Afgesloten: Boolean;
    begin
        Afgesloten := true;
        LoanLines.Reset();
        LoanLines.SetRange(Loannr, rec.Loannr);
        if LoanLines.FindSet() then begin
            repeat
                if LoanLines.Returned = false then
                    Afgesloten := false;
            until LoanLines.Next() = 0;
        end;
        LoanHeader.Reset();
        Loanheader.SetRange(loannr, rec.Loannr);
        LoanHeader.FindFirst();
        LoanHeader.Validate(completed, Afgesloten);
        LoanHeader.Modify();
    end;

    procedure MoveToFinishedLoanLines(var LoanLines: Record "LD Loan Lines")
    var
        FinishedLoanLines: Record "LD Finished Loan Lines";
    begin
        FinishedLoanLines.Reset();
        FinishedLoanLines.Init();
        FinishedLoanLines.TransferFields(Rec);
        FinishedLoanLines.Insert();
    end;

    procedure FindCustomer(loannr: Integer): Text
    var
        Loanheader: Record "LD Loan Header";
    begin
        LoanHeader.Reset();
        loanheader.SetRange(Loannr, loannr);
        if Loanheader.FindFirst() then
            Loanheader.CalcFields(CustomerName);
        exit(Loanheader.CustomerName);
    end;

    procedure FindReturnDate(loannr: Integer): Date
    var
        Loanheader: Record "LD Loan Header";
    begin
        Loanheader.Reset();
        Loanheader.SetRange(Loannr, loannr);
        if Loanheader.FindFirst() then
            exit(Loanheader."Teruggave Datum");
    end;

    Procedure ReturnItemDescription(Itemnr: Code[20]): Text
    var
        Item: Record Item;
    begin
        Item.Reset();
        Item.SetRange("No.", Itemnr);
        if Item.FindFirst() then
            exit(Item.Description);
    end;
}