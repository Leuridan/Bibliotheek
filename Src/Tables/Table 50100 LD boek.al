table 50100 "LD Boek"
{
    Caption = 'Boek';
    LookupPageId = "LD Boek List Page";
    DrillDownPageId = "LD Boek List Page";
    fields
    {
        field(1; ISBN; Code[20])
        {
            Caption = 'ISBN';
            DataClassification = SystemMetadata;
        }
        field(2; Auteur; Text[50])
        {
            Caption = 'Auteur';
            FieldClass = FlowField;
            CalcFormula = lookup ("LD Schrijvers".Naam where(nummer = field(Auteurno)));
        }
        field(3; Uitgever; Text[50])
        {
            Caption = 'Uitgever';
            DataClassification = SystemMetadata;
        }
        field(4; "Language Code"; Code[10])
        {
            Caption = 'Taalcode';
            DataClassification = SystemMetadata;
            TableRelation = Language.Code;
        }
        field(5; Genre; Option)
        {
            Caption = 'Genre';
            DataClassification = SystemMetadata;
            OptionMembers = fiction,"non-fiction";
            OptionCaption = 'Fiction,Non-fiction';
        }
        field(6; Auteurno; Integer)
        {
            Caption = 'Auteur nummer';
            DataClassification = SystemMetadata;
            TableRelation = "LD Schrijvers".nummer;
        }
    }
    keys
    {
        key(PrimaryKey; ISBN)
        { }

    }
    procedure GetTitle(ISBN: Code[20]): Text
    var
        Item: Record Item;
    begin
        Item.Reset();
        Item.SetRange(GTIN, ISBN);
        if Item.FindFirst() then
            exit(Item.Description);
    end;
}