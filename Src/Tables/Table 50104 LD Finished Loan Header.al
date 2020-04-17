table 50104 "LD Finished Loan Header"
{
    Caption = 'Finished Loan';
    //DrillDownPageId = 
    //LookupPageId = 
    fields
    {
        field(1; Loannr; Integer)
        {
            Caption = 'Uitleendocumentnummer';
            DataClassification = SystemMetadata;
        }
        field(2; Customernr; Code[20])
        {
            Caption = 'Klantnummer';
            DataClassification = SystemMetadata;
        }
        field(3; "CustomerName"; Text[100])
        {
            Caption = 'Klantnaam';
            FieldClass = FlowField;
            CalcFormula = lookup (Customer.Name where("No." = field(Customernr)));
        }
        field(4; UitleenDatum; Date)
        {
            Caption = 'Uitleen Datum';
            DataClassification = SystemMetadata;
        }
        field(5; "Teruggave Datum"; Date)
        {
            Caption = 'Teruggave Datum';
            DataClassification = SystemMetadata;
        }

    }
    keys
    {
        key(PK; Loannr)
        { }
    }


}