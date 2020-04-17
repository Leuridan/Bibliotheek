page 50108 "LD Loan Lines LP Item Card"
{
    Caption = 'Loan Lines List Part Item Card';
    SourceTable = "LD Loan Lines";
    PageType = ListPart;
    UsageCategory = None;
    layout
    {
        area(Content)
        {
            repeater(LoanLines)
            {
                field(Itemnr; Itemnr)
                {
                    ApplicationArea = all;
                }
                field(serienummer; serienummer)
                {
                    ApplicationArea = all;
                }
                field(Returned; Returned)
                {
                    ApplicationArea = all;
                }
                field(Customername; rec.FindCustomer(Loannr))
                {
                    ApplicationArea = all;
                }
                field(RetourDate; rec.FindReturnDate(Loannr))
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}