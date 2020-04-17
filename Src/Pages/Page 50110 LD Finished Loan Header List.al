page 50110 "LD Finished Loan Header List"
{
    Caption = 'Finished Loan Headers';
    SourceTable = "LD Finished Loan Header";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(LoanHeaders)
            {
                field(Loannr; Loannr)
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
                }
                field("Teruggave Datum"; "Teruggave Datum")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}