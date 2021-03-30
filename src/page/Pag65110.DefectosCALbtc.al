page 65110 "Defectos_CAL_btc"
{
    Caption = 'Defectos', comment = 'ESP="Defectos"';
    PageType = List;
    SourceTable = "Defectos_CAL_btc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Código"; Código)
                {
                    ApplicationArea = All;
                }
                field("Descripción"; Descripción)
                {
                    ApplicationArea = All;
                }
                field("Origen inspección"; "Origen inspección")
                {
                    ApplicationArea = All;
                }
                field("Clase de defecto"; "Clase de defecto")
                {
                    ApplicationArea = All;
                }
                field("Afecta Conformidad"; "Afecta Conformidad")
                {
                    ApplicationArea = All;
                }
                field("Cód. requisito control"; "Cód. requisito control")
                {
                    ApplicationArea = All;
                }
                field("Cód. causa principal"; "Cód. causa principal")
                {
                    ApplicationArea = All;
                }
                field("Cód. causa alternativa"; "Cód. causa alternativa")
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
        area(factboxes)
        {
            systempart(Control1000000015; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000016; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
