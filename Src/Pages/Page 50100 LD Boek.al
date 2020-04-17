page 50100 "LD Boek"
{
    Caption = 'Boek';
    PageType = Card;
    SourceTable = "LD Boek";
    Editable = true;
    layout
    {
        area(Content)
        {
            field(ISBN; ISBN)
            {
                Caption = 'ISBN';
                ApplicationArea = all;
                Editable = true;
            }

            field("Language Code"; "Language Code")
            {
                Caption = 'Taal Code';
                ApplicationArea = all;
                Editable = true;
            }
            field(Auteur; Auteur)
            {
                Caption = 'Auteur';
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    SchrijversLIst: Page "LD Schrijvers List";
                    Schrijver: Record "LD Schrijvers";
                begin
                    SchrijversLIst.LookupMode(true);
                    if SchrijversList.RunModal() = Action::LookupOK then begin
                        SchrijversList.GetRecord(Schrijver);
                        rec.Auteurno := Schrijver.nummer;
                        rec.Modify();
                        rec.CalcFields(Auteur);
                        Auteur := Schrijver.Naam;
                    end;
                end;

            }
            field(Uitgever; Uitgever)
            {
                Caption = 'Uitgever';
                ApplicationArea = all;
                Editable = true;
            }
            field(Genre; Genre)
            {
                Caption = 'Genre';
                ApplicationArea = all;
                Editable = true;
            }
        }
    }

}