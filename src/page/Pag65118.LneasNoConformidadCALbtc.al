page 65118 "Líneas No Conformidad_CAL_btc"
{
    AutoSplitKey = true;
    Caption = 'Líneas No Conformidad', Comment = '"Líneas No Conformidad"';
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Lin no conformidad_CAL_btc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Origen inspección"; "Origen inspección")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                //BEGIN FJAB 311019 Cambio campos
                /*
                        field("No. inspección"; "No. inspección")
                        {
                            Editable = false;
                            Visible = false;
                        }
                        */
                //END FJAB 311019
                field("No. no conformidad"; "No. no conformidad")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No. línea"; "No. línea")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Estado no conformidad"; "Estado no conformidad")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cod. grupo inspección"; "Cod. grupo inspección")
                {
                    ApplicationArea = All;
                }
                field("Descripción"; Descripción)
                {
                    ApplicationArea = All;
                }
                field("Cód. requisito control"; "Cód. requisito control")
                {
                    ApplicationArea = All;
                }
                field("Descripción requisito"; "Descripción requisito")
                {
                    ApplicationArea = All;
                }
                field("Requisito específico"; "Requisito específico")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tipo control"; "Tipo control")
                {
                    ApplicationArea = All;
                }
                field("No. línea inspección"; "No. línea inspección")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cód. defecto"; "Cód. defecto")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Descripción defecto"; "Descripción defecto")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Clase defecto"; "Clase defecto")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Observaciones defecto"; "Observaciones defecto")
                {
                    ApplicationArea = All;
                    Editable = TRUE;
                }
                field("Cód. causa preliminar"; "Cód. causa preliminar")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Descripcion causa preliminar"; "Descripcion causa preliminar")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cód. causa final"; "Cód. causa final")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Descripción causa final"; "Descripción causa final")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Observaciones causas"; "Observaciones causas")
                {
                    ApplicationArea = All;
                }
                field("Cód. acción inmediata"; "Cód. acción inmediata")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cód. acción correctiva"; "Cód. acción correctiva")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cód. acción preventiva"; "Cód. acción preventiva")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Observaciones acciones"; "Observaciones acciones")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Acción inmediata realizada"; "Acción inmediata realizada")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha accion inmediata"; "Fecha accion inmediata")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Acción correctiva realizada"; "Acción correctiva realizada")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha acción correctiva"; "Fecha acción correctiva")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Acción preventiva realizada"; "Acción preventiva realizada")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha acción preventiva"; "Fecha acción preventiva")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field("Aprobado por usuario"; "Aprobado por usuario")
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
