page 65111 "Causas de Defectos_CAL_btc"
{
    Caption = 'Causas de Defectos', comment = 'ESP="Causas de Defectos"';
    PageType = List;
    SourceTable = "Causa de defectos_CAL_btc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Descripción"; Descripción)
                {
                    ApplicationArea = All;
                }
                field("Descripcion 2"; "Descripcion 2")
                {
                    ApplicationArea = All;
                }
                field("Descripcion 3"; "Descripcion 3")
                {
                    ApplicationArea = All;
                }
                field("Cód. acción inmediata"; "Cód. acción inmediata")
                {
                    ApplicationArea = All;
                }
                field("Cód. acción correctiva"; "Cód. acción correctiva")
                {
                    ApplicationArea = All;
                }
                field("Cód. acción preventiva"; "Cód. acción preventiva")
                {
                    ApplicationArea = All;
                }
                field("Cód. defecto habitual"; "Cód. defecto habitual")
                {
                    ApplicationArea = All;
                }
                field("Cód. defecto secundario"; "Cód. defecto secundario")
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
                field("Fecha última modificación"; "Fecha última modificación")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Usuario última modificación"; "Usuario última modificación")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000017; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000018; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
