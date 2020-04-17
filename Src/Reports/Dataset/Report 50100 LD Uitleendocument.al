report 50100 "LD Uitleendocument"
{
    Caption = 'Uitleendocument';
    DefaultLayout = Word;
    WordLayout = 'Src/reports/Word/report 50100 LD Uitleendocument.docx';
    UsageCategory = None;
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Company_Name; Name)
            { }
            column(Company_Picture; Picture)
            { }
            column(Company_Address; Address)
            { }
            column(Company_PostCode; "Post Code")
            { }
            column(Company_City; City)
            { }
            column(Company_EnterpriseNo; "Enterprise No.")
            { }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Picture);
            end;
        }
        dataitem("LD Loan Header"; "LD Loan Header")
        {
            DataItemTableView = sorting("Loannr");
            column(Loannr; Loannr)
            { }
            column(CustomerName; CustomerName)
            { }
            column(UitleenDatum; UitleenDatum)
            { }
            column(Teruggave_Datum; "Teruggave Datum")
            { }
            dataitem("LD Loan Lines"; "LD Loan Lines")
            {
                DataItemLinkReference = "LD Loan Header";
                DataItemLink = Loannr = field(Loannr);
                DataItemTableView = sorting(Loannr, Serienummer);
                column(Itemnr; Itemnr)
                { }
                column(serienummer; serienummer)
                { }
            }

        }
    }

}