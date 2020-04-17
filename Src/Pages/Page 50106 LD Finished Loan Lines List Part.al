page 50106 "LD Finished LoanLines ListPart"
{
    Caption = 'Finished Loan Lines';
    SourceTable = "LD Finished Loan Lines";
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
            }
        }
    }
}