Page 50111 "LD Schrijvers List"
{
    Caption = 'Schrijvers';
    SourceTable = "LD Schrijvers";
    PageType = List;
    DelayedInsert = true;
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            repeater(Auteurs)
            {
                field(nummer; nummer)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Naam; Naam)
                {
                    ApplicationArea = all;
                }
                field(Land; Land)
                {
                    ApplicationArea = all;
                }
            }

        }
    }
}