table 50105 "LD Finished Loan Lines"
{
    Caption = 'Finished Loan Line';
    //DrillDownPageId = 
    //LookupPageId = 
    fields
    {
        field(1; Loannr; Integer)
        {
            Caption = 'Uitleendocumentnummer';
            DataClassification = SystemMetadata;
        }
        field(2; Itemnr; Code[20])
        {
            Caption = 'Artikel nummer';
            DataClassification = SystemMetadata;
        }
        field(3; serienummer; Code[20])
        {
            Caption = 'serienummer';
            DataClassification = SystemMetadata;
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

    procedure FindCustomer(loannr: Integer): Text
    var
        FinishedLoanheader: Record "LD Finished Loan Header";
    begin
        FinishedLoanheader.Reset();
        FinishedLoanheader.SetRange(Loannr, loannr);
        if FinishedLoanheader.FindFirst() then
            FinishedLoanheader.CalcFields(CustomerName);
        exit(FinishedLoanheader.CustomerName);
    end;

    procedure FindReturnDate(loannr: Integer): Date
    var
        FinishedLoanheader: Record "LD Finished Loan Header";
    begin
        FinishedLoanheader.Reset();
        FinishedLoanheader.SetRange(Loannr, loannr);
        if FinishedLoanheader.FindFirst() then
            exit(FinishedLoanheader."Teruggave Datum");
    end;

    procedure FindStartLoanDate(loannr: Integer): Date
    var
        FinishedLoanheader: Record "LD Finished Loan Header";
    begin
        FinishedLoanheader.Reset();
        FinishedLoanheader.SetRange(Loannr, loannr);
        if FinishedLoanheader.FindFirst() then
            exit(FinishedLoanheader.UitleenDatum);
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