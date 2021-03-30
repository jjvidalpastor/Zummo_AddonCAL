page 65108 "Grupo de Inspeccion_CAL_btc"
{
    Caption = 'Grupo de Inspeccion', comment = 'ESP="Grupo de Inspección"';
    PageType = Card;
    SourceTable = inspeccion_CAL_btc;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Descripción"; Descripción)
                {
                    ApplicationArea = All;
                }
                field("Omitir impresión"; "Omitir impresión")
                {
                    ApplicationArea = All;
                }
                field(Bloqueado; Bloqueado)
                {
                    ApplicationArea = All;
                }
                field("Fecha creación"; "Fecha creación")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Usuario creación"; "Usuario creación")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fecha ultima modificación"; "Fecha ultima modificación")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Usuario ultima modificación"; "Usuario ultima modificación")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            part(Control1000000006; ReqContrXGrInsp_CAL_btc)
            {
                ShowFilter = false;
                SubPageLink = "Cód. grupo inspección" = FIELD("No.");
                SubPageView = SORTING("Cód. grupo inspección", "No. orden");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            systempart(Control1000000011; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000012; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
