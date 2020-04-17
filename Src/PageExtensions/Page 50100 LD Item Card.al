pageextension 50100 "LD Item Card" extends "Item Card"
{
    Caption = 'Item Card';
    layout
    {
        addafter(Item)
        {
            group(diverse)
            {
                Caption = 'Diverse';
                field(Loaned; Loaned)
                {
                    ApplicationArea = all;
                    Caption = 'Uitgeleend';
                }
                field(available; available)
                {
                    ApplicationArea = all;
                    Caption = 'Beschikbaar';
                }
            }
            part(Loanlines; "LD Loan Lines LP Item Card")
            {
                Caption = 'Uitgeleende artikelen';
                ApplicationArea = all;
                SubPageLink = Itemnr = field("No.");
                Editable = false;
            }
        }
    }
}