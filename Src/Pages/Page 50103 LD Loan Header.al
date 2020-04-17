page 50103 "LD Loan Header"
{
    Caption = 'Loan Header';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "LD Loan Header";
    InsertAllowed = false;
    DeleteAllowed = false;
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
                Editable = false;
            }
            field(CustomerName; CustomerName)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(UitleenDatum; UitleenDatum)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Teruggave Datum"; "Teruggave Datum")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(completed; completed)
            {
                ApplicationArea = all;
                Editable = false;
            }

            group(Items)
            {
                part(Loanlines; "LD Loan Lines List Part")
                {
                    Caption = 'Uitgeleende Artikelen';
                    SubPageLink = Loannr = field(Loannr);
                    ApplicationArea = all;
                    Editable = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PrintReport)
            {
                Caption = 'Druk uitleendocument af';
                Image = Print;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    Printdocument();
                end;
            }

            action(ProcessDocument)
            {
                Caption = 'Sluit Uitleendocument af';
                Image = Close;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    if rec.completed then begin
                        rec.MoveToFinishedLoanHeader(Rec);
                        rec.Delete();
                    end

                    else
                        Message('Niet alle items zijn terug');
                end;
            }
        }

    }
    local procedure PrintDocument()
    var
        Uitleendocument: Report "LD Uitleendocument";
    begin
        Uitleendocument.SetTableView(rec);
        Uitleendocument.Run();
    end;
}