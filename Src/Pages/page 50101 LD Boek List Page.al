page 50101 "LD Boek List Page"
{
    Caption = 'Boekenlijst';
    PageType = List;
    SourceTable = "LD Boek";
    ApplicationArea = all;
    UsageCategory = Lists;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "LD Boek";
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
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        rec.CalcFields(Auteur);
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
            }
        }
    }
}