table 50107 "Ld Reservaties"
{
    Caption = 'Reservaties';
    fields
    {
        field(2; KlantNummer; code[20])
        {
            Caption = 'Klantnummer';
            DataClassification = SystemMetadata;
            TableRelation = customer."No.";
        }
        field(3; Boeknummer; Code[20])
        {
            Caption = 'Boek';
            DataClassification = SystemMetadata;
            TableRelation = Item."No.";
        }
    }
}