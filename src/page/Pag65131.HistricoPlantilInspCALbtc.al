page 65131 "Histórico Plantil Insp_CAL_btc"
{
    Caption = 'Histórico Plantillas Insp.', Comment = 'ESP="Histórico Plantillas Insp."';
    CardPageID = "Plantilla Inspección_CAL_btc";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Plantilla de inseval_CAL_btc";
    SourceTableView = SORTING("No.", "No. revisión") ORDER(Ascending) WHERE(Estado = FILTER(= Terminada));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

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
                field("Tipo inspección"; "Tipo inspección")
                {
                    ApplicationArea = All;
                }
                field("Objeto inspección"; "Objeto inspección")
                {
                    ApplicationArea = All;
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
                }
                field("% muestra recomendado"; "% muestra recomendado")
                {
                    ApplicationArea = All;
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
                }
                field("Certificado por usuario"; "Certificado por usuario")
                {
                    ApplicationArea = All;
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
