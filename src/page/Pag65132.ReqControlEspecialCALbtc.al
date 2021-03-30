page 65132 "Req Control Especial_CAL_btc"
{
    Caption = 'Requisito Control Específico', Comment = '"Requisito Control Específico"';
    PageType = Card;
    SourceTable = "Req Control especifico_CAL_btc";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tipo; Tipo)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Clear(Condición);
                        Clear(Valor);
                        Clear(Texto);
                        Clear(Puntaje);
                        if ("Tipo control" = "Tipo control"::"Condición") then Condición := true;
                        if ("Tipo control" = "Tipo control"::Valor) then Valor := true;
                        if ("Tipo control" = "Tipo control"::Texto) then Texto := true;
                        if ("Tipo control" = "Tipo control"::Puntaje) then Puntaje := true;
                    end;
                }
                field("Cód. requisito control"; "Cód. requisito control")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Cod. variante"; "Cod. variante")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Descripción requisito"; "Descripción requisito")
                {
                    ApplicationArea = All;
                }
                field("Descripción Tipo"; "Descripción Tipo")
                {
                    ApplicationArea = All;
                }
                field("Omitir impresión"; "Omitir impresión")
                {
                    ApplicationArea = All;
                }
                field("Requisito crítico"; "Requisito crítico")
                {
                    ApplicationArea = All;
                }
                field(Bloqueado; Bloqueado)
                {
                    ApplicationArea = All;
                }
                field("Cód. Procedimiento"; "Cód. Procedimiento")
                {
                    ApplicationArea = All;
                }
                field("Descripción Procedimiento"; "Descripción Procedimiento")
                {
                    ApplicationArea = All;
                }
                field(Norma; Norma)
                {
                    ApplicationArea = All;
                }
                field("Unidad de medida"; "Unidad de medida")
                {
                    ApplicationArea = All;
                }
                field("Cod. defecto si fallo"; "Cod. defecto si fallo")
                {
                    ApplicationArea = All;
                }
                field("Afecta conformidad"; "Afecta conformidad")
                {
                    ApplicationArea = All;
                }
            }
            group(Tipos)
            {
                field("Tipo control"; "Tipo control")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Clear(Condición);
                        Clear(Valor);
                        Clear(Texto);
                        Clear(Puntaje);
                        if ("Tipo control" = "Tipo control"::"Condición") then Condición := true;
                        if ("Tipo control" = "Tipo control"::Valor) then Valor := true;
                        if ("Tipo control" = "Tipo control"::Texto) then Texto := true;
                        if ("Tipo control" = "Tipo control"::Puntaje) then Puntaje := true;
                    end;
                }
                field("Condición esperada"; "Condición esperada")
                {
                    Editable = Condición;
                    ApplicationArea = All;
                }
                field("Valor mínimo"; "Valor mínimo")
                {
                    Editable = Valor;
                    ApplicationArea = All;
                }
                field("Valor máximo"; "Valor máximo")
                {
                    Editable = Valor;
                    ApplicationArea = All;
                }
                field("Texto especificación"; "Texto especificación")
                {
                    Editable = Texto;
                    ApplicationArea = All;
                }
                field("Valor medio"; "Valor medio")
                {
                    Editable = Valor;
                    ApplicationArea = All;
                }
                field("Tolerancia s/valor medio (%)"; "Tolerancia s/valor medio (%)")
                {
                    Editable = Valor;
                    ApplicationArea = All;
                }
                field("Peso del requisito"; "Peso del requisito")
                {
                    Editable = Puntaje;
                    ApplicationArea = All;
                }
            }
            group(Control)
            {
                field("Fecha creación"; "Fecha creación")
                {
                    ApplicationArea = All;
                }
                field("Usuario creación"; "Usuario creación")
                {
                    ApplicationArea = All;
                }
                field("Fecha ultima modificación"; "Fecha ultima modificación")
                {
                    ApplicationArea = All;
                }
                field("Usuario ultima modificación"; "Usuario ultima modificación")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000030; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000031; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    var
        "Condición": Boolean;
        Valor: Boolean;
        Texto: Boolean;
        Puntaje: Boolean;
}
