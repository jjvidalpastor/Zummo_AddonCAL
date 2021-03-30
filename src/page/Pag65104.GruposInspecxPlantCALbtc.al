page 65104 "Grupos Inspec x Plant_CAL_btc"
{
    AutoSplitKey = true;
    Caption = 'Grupos Inspección x Plantilla', comment = 'ESP="Grupos Inspección x Plantilla"';
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Grupos inspec x planta_CAL_btc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cód. plantilla"; "Cód. plantilla")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No. revision plantilla"; "No. revision plantilla")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. orden"; "No. orden")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Cod. grupo inspección"; "Cod. grupo inspección")
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
