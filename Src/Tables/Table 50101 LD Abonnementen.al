table 50101 "LD Abonnementen"
{
    Caption = 'Abonnementen';
    DrillDownPageId = "LD Abonnementen List Page";
    LookupPageId = "LD Abonnementen List Page";
    fields
    {

        field(1; Customernr; Code[20])
        {
            Caption = 'Klantnummer';
            DataClassification = SystemMetadata;
            TableRelation = customer."No.";
        }
        field(2; "Abonnements type"; Code[20])
        {
            Caption = 'Abonnements Type';
            DataClassification = SystemMetadata;
            TableRelation = item."No." where("Item Category Code" = const('ABBO'));
        }
        field(3; startdatum; Date)
        {
            Caption = 'StartDatum';
            DataClassification = SystemMetadata;
        }
        field(4; einddatum; Date)
        {
            Caption = 'Eindatum';
            DataClassification = SystemMetadata;
        }

    }
    keys
    {
        key(PK; Customernr)
        { }
    }
    procedure FindCustomer(customernr: code[20]): Text
    var
        Customer: Record Customer;
    begin
        Customer.Reset();
        Customer.SetRange("No.", customernr);
        if Customer.FindFirst() then
            exit(Customer.Name);
    end;
}