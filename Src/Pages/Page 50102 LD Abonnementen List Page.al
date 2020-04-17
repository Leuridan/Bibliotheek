page 50102 "LD Abonnementen List Page"
{
    Caption = 'Abonnementen Lijst';
    PageType = List;
    SourceTable = "LD Abonnementen";
    ApplicationArea = all;
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Abbonementen)
            {
                field(Customernr; Customernr)
                {
                    Caption = 'Klantnummer';
                    ApplicationArea = all;
                }
                field(customerName; rec.FindCustomer(Customernr))
                {
                    Caption = 'Klantnaam';
                    ApplicationArea = all;
                }
                field("Abonnements type"; "Abonnements type")
                {
                    Caption = 'Abonnementstype';
                    ApplicationArea = all;
                }
                field(startdatum; startdatum)
                {
                    Caption = 'Start Datum';
                    ApplicationArea = all;
                }
                field(einddatum; einddatum)
                {
                    Caption = 'Eind Datum';
                    ApplicationArea = all;
                }

            }
        }
    }
}