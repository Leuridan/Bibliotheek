page 50104 "LD Loan Lines List Part"
{
    Caption = 'Loan Lines';
    SourceTable = "LD Loan Lines";
    PageType = ListPart;
    DelayedInsert = true;
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
                field(Titel; rec.ReturnItemDescription(Itemnr))
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
            }
        }
    }
}
