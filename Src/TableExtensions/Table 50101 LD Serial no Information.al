tableextension 50101 "LD Serial No. Information" extends "Serial No. Information"
{
    Caption = 'Serial No.';
    fields
    {
        field(50001; NotAvailable; Boolean)
        {
            Caption = 'Not available';
            FieldClass = FlowField;
            CalcFormula = exist ("LD Loan Lines" where(Itemnr = field("Item No."), serienummer = field("Serial No."), Returned = const(false)));
        }
    }
    trigger OnAfterInsert()
    var
        item: Record Item;
    begin
        item.Reset();
        item.SetRange("No.", rec."Item No.");
        item.FindFirst();
        Message('Item no: ' + Format(item."No."));
        item.available := true;
        item.Modify();
    end;
}