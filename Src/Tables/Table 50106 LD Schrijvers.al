table 50106 "LD Schrijvers"
{
    Caption = 'schrijvers';
    DrillDownPageId = "LD Schrijvers List";
    LookupPageId = "LD Schrijvers List";

    fields
    {
        field(1; nummer; integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; Naam; Text[50])
        {
            Caption = 'Naam';
            DataClassification = SystemMetadata;
        }
        field(3; Land; Text[30])
        {
            Caption = 'Land';
            TableRelation = "Country/Region".Code;
        }
    }
    keys
    {
        key(PK; nummer)
        {

        }
        key(Key2; Naam)
        {

        }
    }
    var

}
