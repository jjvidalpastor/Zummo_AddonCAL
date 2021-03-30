page 65106 "Procedimientos_CAL_btc"
{
    Caption = 'Procedimientos', comment = 'ESP="Procedimientos"';
    PageType = List;
    SourceTable = "Procedimientos_CAL_btc";

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
                field(Norma; Norma)
                {
                    ApplicationArea = All;
                }
                field("Unidad medida preferente"; "Unidad medida preferente")
                {
                    ApplicationArea = All;
                }
                field("Tipo control preferente"; "Tipo control preferente")
                {
                    ApplicationArea = All;
                }
                field("No. suministrador"; "No. suministrador")
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
                field("Usuario ultima modificacón"; "Usuario ultima modificacón")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Aptitud del Procedimiento"; "Aptitud del Procedimiento")
                {
                    ApplicationArea = All;
                }
                field("Grupo inspección preferente"; "Grupo inspección preferente")
                {
                    ApplicationArea = All;
                }
                field("Requisito control preferente"; "Requisito control preferente")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000013; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000014; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
