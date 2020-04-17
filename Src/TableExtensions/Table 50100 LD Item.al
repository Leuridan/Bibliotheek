tableextension 50100 "LD Item" extends Item
{
    Caption = 'Item';
    fields
    {
        field(50000; vet; Boolean)
        {
            Caption = 'vet';
            DataClassification = SystemMetadata;
        }
        field(50001; available; Boolean)
        {
            Caption = 'Beschikbaar';
            DataClassification = SystemMetadata;
            InitValue = true;
        }
        field(50002; Loaned; Integer)
        {
            Caption = 'Uitgeleend';
            FieldClass = FlowField;
            CalcFormula = count ("LD Loan Lines" where(Itemnr = field("No."), Returned = const(false)));
        }
    }
}