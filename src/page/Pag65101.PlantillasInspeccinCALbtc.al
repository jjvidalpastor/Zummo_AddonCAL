page 65101 "Plantillas Inspección_CAL_btc"
{
    Caption = 'Template Inspection Quality List', comment = 'ESP="Plantilla Inspección Calidad Lista"';
    CardPageID = "Plantilla Inspección_CAL_btc";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Plantilla de inseval_CAL_btc";
    SourceTableView = SORTING("No.", "No. revisión") ORDER(Ascending) WHERE(Estado = FILTER(<> Terminada));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /*field("Origen inspección"; "Origen inspección")
                        {
                            ApplicationArea = All;
                        }*/
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("No. revisión"; "No. revisión")
                {
                    ApplicationArea = All;
                }
                field("Version activa"; "Version activa")
                {
                    ApplicationArea = All;
                }
                field(Estado; Estado)
                {
                    ApplicationArea = All;
                }
                field("Tipo de Requisitos Específicos"; "Tipo de Requisitos Específicos")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tipo inspección"; "Tipo inspección")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Objeto inspección"; "Objeto inspección")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Bloqueado; Bloqueado)
                {
                    ApplicationArea = All;
                }
                field(Descripcion; Descripcion)
                {
                    ApplicationArea = All;
                }
                field("Tamaño muestra recomendado"; "Tamaño muestra recomendado")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("% muestra recomendado"; "% muestra recomendado")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
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
                field("Fecha certificación"; "Fecha certificación")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Certificado por usuario"; "Certificado por usuario")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha activación"; "Fecha activación")
                {
                    ApplicationArea = All;
                }
                field("Activada por usuario"; "Activada por usuario")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000016; Notes)
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
