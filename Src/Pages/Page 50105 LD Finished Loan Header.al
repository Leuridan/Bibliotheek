page 50105 "LD Finishded Loan Header"
{
    Caption = 'Finished Loan Header';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "LD Finished Loan Header";
    layout
    {
        area(Content)
        {
            field(Loannr; Loannr)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Customernr; Customernr)
            {
                ApplicationArea = all;
            }
            field(CustomerName; CustomerName)
            {
                ApplicationArea = all;
            }
            field(UitleenDatum; UitleenDatum)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Teruggave Datum"; "Teruggave Datum")
            {
                ApplicationArea = all;
            }

            group(Items)
            {
                part(Loanlines; "LD Finished LoanLines ListPart")
                {
                    Caption = 'Uitgeleende Artikelen';
                    SubPageLink = Loannr = field(Loannr);
                    ApplicationArea = all;
                }
            }
        }
    }
}