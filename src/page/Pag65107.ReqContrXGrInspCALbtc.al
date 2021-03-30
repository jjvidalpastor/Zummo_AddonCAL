page 65107 "ReqContrXGrInsp_CAL_btc"
{
    AutoSplitKey = true;
    Caption = 'Req. Control x Grupo Insp.', comment = 'ESP="Req. Control x Grupo Insp."';
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Req Contr x grupo insp_CAL_btc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cód. grupo inspección"; "Cód. grupo inspección")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No. orden"; "No. orden")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cod. requisito control"; "Cod. requisito control")
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
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Usuario creación"; "Usuario creación")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fecha ultima modificación"; "Fecha ultima modificación")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Usuario ultima modificación"; "Usuario ultima modificación")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
