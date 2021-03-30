page 65109 "Requisitos Cont Espec_CAL_btc"
{
    Caption = 'Requisitos Control Específicos', comment = 'ESP="Requisitos Control Específicos"';
    CardPageID = "Req Control Especial_CAL_btc";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Req Control especifico_CAL_btc";
    SourceTableView = SORTING(Tipo, "Cód. requisito control", "No.", "Cod. variante") ORDER(Ascending);

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
                field("Tipo control"; "Tipo control")
                {
                    ApplicationArea = All;
                }
                field("Condición esperada"; "Condición esperada")
                {
                    ApplicationArea = All;
                }
                field("Valor mínimo"; "Valor mínimo")
                {
                    ApplicationArea = All;
                }
                field("Valor máximo"; "Valor máximo")
                {
                    ApplicationArea = All;
                }
                field("Texto especificación"; "Texto especificación")
                {
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
