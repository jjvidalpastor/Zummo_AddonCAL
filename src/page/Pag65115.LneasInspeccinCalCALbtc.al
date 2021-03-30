page 65115 "Líneas Inspección Cal_CAL_btc"
{
    AutoSplitKey = true;
    Caption = 'Líneas Inspección Calidad', Comment = 'ESP="Líneas Inspección Calidad"';
    Editable = true;
    InsertAllowed = true;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Lin inspe eval_CAL_btc";

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
                //BEGIN FJAB 311019 Nuevos campos
                /*
                        field("No. inspección"; "No. inspección")
                        {
                            Editable = false;
                            Visible = false;
                        }
                        */
                //END FJAB 311019
                field("No. línea"; "No. línea")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Estado inspección"; "Estado inspección")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cód. grupo inspección"; "Cód. grupo inspección")
                {
                    Editable = Editable;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Descripción"; Descripción)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Omitir impresión"; "Omitir impresión")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cód. requisito control"; "Cód. requisito control")
                {
                    Editable = Editable;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if ("Tipo control" = "Tipo control"::"Condición") then Condicion := true;
                        if ("Tipo control" = "Tipo control"::Valor) then Valor := true;
                        if ("Tipo control" = "Tipo control"::Texto) then Texto := true;
                        if ("Tipo control" = "Tipo control"::Puntaje) then Valor := true;
                    end;
                }
                field("Descripción requisito"; "Descripción requisito")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requisito específico"; "Requisito específico")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requisito crítico"; "Requisito crítico")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unidad de medida"; "Unidad de medida")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cód. Procedimiento"; "Cód. Procedimiento")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tipo control"; "Tipo control")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Condición esperada"; "Condición esperada")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Valor mínimo"; "Valor mínimo")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Valor máximo"; "Valor máximo")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Texto especificación"; "Texto especificación")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Valor medio"; "Valor medio")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tolerancia s/valor medio (%)"; "Tolerancia s/valor medio (%)")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Peso del requisito"; "Peso del requisito")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cód. defecto si fallo"; "Cód. defecto si fallo")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Afecta conformidad"; "Afecta conformidad")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Requisito conforme"; "Requisito conforme")
                {
                    ApplicationArea = All;
                }
                field("Requisito no conforme"; "Requisito no conforme")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Resultado condición"; "Resultado condición")
                {
                    Editable = Condicion;
                    ApplicationArea = All;
                    StyleExpr = Condicion;
                    Style = StrongAccent;

                    trigger OnValidate()
                    var
                        RecCabIn: Record "Cab inspe eval_CAL_btc";
                    begin
                        //BTC 03.02.2020 Se cambia estado de la cabecera en campo veredicto inspeccion en funciona este campo
                        if "Resultado condición" = "Resultado condición"::"No Conforme" then begin
                            RecCabIn.Reset();
                            RecCabIn.SetRange("No.", Rec."No. inspección");
                            RecCabIn.FindFirst();
                            RecCabIn."Evaluación Inspección" := RecCabIn."Evaluación Inspección"::"No Conforme";
                            RecCabIn.Modify();
                            CurrPage.Update();
                        end;
                    end;
                }
                field("Resultado valor"; "Resultado valor")
                {
                    Editable = Valor;
                    ApplicationArea = All;
                    StyleExpr = Valor;
                    Style = StrongAccent;
                }
                field("Resultado texto"; "Resultado texto")
                {
                    Editable = Texto;
                    ApplicationArea = All;
                    StyleExpr = Texto;
                    Style = StrongAccent;
                }
                field(Puntos; Puntos)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Aptitud; Aptitud)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Decision DT"; "Decision DT")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Motivo DT"; "Motivo DT")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Defecto; Defecto)
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
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Clase defecto"; "Clase defecto")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Observaciones defecto"; "Observaciones defecto")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha creación"; "Fecha creación")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Usuario creación"; "Usuario creación")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha última modificación"; "Fecha última modificación")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Usuario última modificación"; "Usuario última modificación")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Certificado por usuario"; "Certificado por usuario")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Clear(Condicion);
        Clear(Valor);
        Clear(Texto);
        Clear(Editable);
        if ("Tipo control" = "Tipo control"::"Condición") then Condicion := true;
        if ("Tipo control" = "Tipo control"::Valor) then Valor := true;
        if ("Tipo control" = "Tipo control"::Texto) then Texto := true;
        if ("Tipo control" = "Tipo control"::Puntaje) then Valor := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Condicion);
        Clear(Valor);
        Clear(Texto);
        Clear(Editable);
        if ("Tipo control" = "Tipo control"::"Condición") then Condicion := true;
        if ("Tipo control" = "Tipo control"::Valor) then Valor := true;
        if ("Tipo control" = "Tipo control"::Texto) then Texto := true;
        if ("Tipo control" = "Tipo control"::Puntaje) then Valor := true;
        Editable := true;
    end;

    var
        Condicion: Boolean;
        Valor: Boolean;
        Texto: Boolean;
        Editable: Boolean;
}
