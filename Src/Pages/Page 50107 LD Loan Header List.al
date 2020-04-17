page 50107 "LD Loan Header List"
{
    Caption = 'Loan Headers';
    SourceTable = "LD Loan Header";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "LD Loan Header";

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
    actions
    {
        area(Navigation)
        {
            action(OpenPage)
            {
                Caption = 'Open Uitleendocument';
                Image = Open;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    UitleenDocument: Page "LD Loan Header";
                begin
                    UitleenDocument.SetRecord(Rec);
                    UitleenDocument.Run();
                end;
            }
        }
        area(Creation)
        {
            action(CreateDocument)
            {
                Caption = 'Maak Uitleendocument aan';
                Image = Create;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    LoanHeader: Record "LD Loan Header";
                begin
                    LoanHeader.CreateNew();
                end;
            }
        }
    }
}