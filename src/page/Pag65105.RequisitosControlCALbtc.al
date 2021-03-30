page 65105 "Requisitos Control_CAL_btc"
{
    Caption = 'Requisitos Control de Calidad', comment = 'ESP="Requisitos Control de Calidad"';
    CardPageID = "Requisito Control de_CAL_btc";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = calidad_CAL_btc;
    UsageCategory = Lists;

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
