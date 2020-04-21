page 50109 "LD Finished Loan Lines List"
{
    Caption = 'Finished Loan Lines';
    SourceTable = "LD Finished Loan Lines";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(LoanLines)
            {
                field(Loannr; Loannr)
                {
                    Caption = 'Uitleen Document Nummer';
                    ApplicationArea = all;
                }
                field(Itemnr; Itemnr)
                {
                    Caption = 'Artikelnummer';
                    ApplicationArea = all;
                }
                field(Titel; rec.ReturnItemDescription(Itemnr))
                {
                    ApplicationArea = all;
                }
                field(serienummer; serienummer)
                {
                    Caption = 'Identificatienummer Bibliotheek';
                    ApplicationArea = all;
                }
                field(Customer; rec.FindCustomer(Loannr))
                {
                    Caption = 'Klantnaam';
                    ApplicationArea = all;
                }
                field(Loandate; rec.FindStartLoanDate(Loannr))
                {
                    Caption = 'Uitleendatum';
                    ApplicationArea = all;
                }
                field(Rturndate; rec.FindReturnDate(Loannr))
                {
                    Caption = 'Teruggavedatume';
                    ApplicationArea = all;
                }

            }
        }
    }
}