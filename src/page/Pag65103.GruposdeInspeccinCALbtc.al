page 65103 "Grupos de Inspección_CAL_btc"
{
    Caption = 'Grupos de Inspección', comment = 'ESP="Grupos de Inspección"';
    CardPageID = "Grupo de Inspeccion_CAL_btc";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = inspeccion_CAL_btc;
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
                field("Usuario ultima modificación"; "Usuario ultima modificación")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000011; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000012; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
