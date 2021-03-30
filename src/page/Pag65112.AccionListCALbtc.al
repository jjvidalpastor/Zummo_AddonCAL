page 65112 "Accion List_CAL_btc"
{
    Caption = 'Accion List', Comment = '"Acciión lista"';
    PageType = List;
    SourceTable = "Accion_CAL_btc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tipo; Tipo)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Descripción"; Descripción)
                {
                    ApplicationArea = All;
                }
                field("Descripción 2"; "Descripción 2")
                {
                    ApplicationArea = All;
                }
                field("Descripción 3"; "Descripción 3")
                {
                    ApplicationArea = All;
                }
                field("Acción inmediata"; "Acción inmediata")
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
            systempart(Control1000000014; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000015; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
