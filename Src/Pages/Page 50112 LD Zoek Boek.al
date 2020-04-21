page 50112 "LD Zoek Boek"
{
    Caption = 'Boek Opzoeken';
    PageType = List;
    SourceTable = "LD Boek";
    ApplicationArea = all;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ShowFilter = true;
    LinksAllowed = false;
    layout
    {

        area(Content)
        {
            repeater(Boeken)
            {
                field(ISBN; ISBN)
                {
                    Caption = 'ISBN';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Title; rec.GetTitle(ISBN))
                {
                    Caption = 'Titel';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Language Code"; "Language Code")
                {
                    Caption = 'Taal Code';
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Auteur; Auteur)
                {
                    Caption = 'Auteur';
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        Boek: Record "LD Boek";
                        Boekzoeken: Page "LD Zoek Boek";
                    begin
                        Boek.Reset();
                        Boek.SetRange(Auteurno, Rec.Auteurno);
                        boek.FindSet();
                        Boekzoeken.SetTableView(boek);
                        CurrPage.Close();
                        Boekzoeken.Run();
                    end;
                }
                field(Uitgever; Uitgever)
                {
                    Caption = 'Uitgever';
                    ApplicationArea = all;
                }
                field(Genre; Genre)
                {
                    Caption = 'Genre';
                    ApplicationArea = all;
                }
                field(Beschikbaar; rec.Beschikbaar())
                {
                    Caption = 'Beschikbaar';
                    ApplicationArea = all;
                }
                field(Locatie; rec.Locatie())
                {
                    Caption = 'Locatie';
                    ApplicationArea = all;
                }
            }
        }
    }
}