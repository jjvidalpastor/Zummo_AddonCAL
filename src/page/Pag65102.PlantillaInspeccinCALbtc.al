page 65102 "Plantilla Inspección_CAL_btc"
{
    Caption = 'Template Inspection Quality Card', comment = 'ESP="Plantilla Inspección Calidad Ficha"';
    PageType = Card;
    SourceTable = "Plantilla de inseval_CAL_btc";
    SourceTableView = SORTING("No.", "No. revisión") ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = EditableOK;
                    ApplicationArea = All;
                }
                field("No. revisión"; "No. revisión")
                {
                    Editable = EditableOK;
                    ApplicationArea = All;
                }
                field(Descripcion; Descripcion)
                {
                    Editable = EditableOK;
                    ApplicationArea = All;
                }
                /*field(TablaOrigenEspecifico; TablaOrigenEspecifico)
                        {
                            ApplicationArea = All;
                            Editable = EditableOK;
                        }

                        field(CodEspecifico; CodEspecifico)
                        {
                            Editable = EditableOK;
                            ApplicationArea = All;
                        }*/
                group(Control1000000017)
                {
                    ShowCaption = false;

                    field("Version activa"; "Version activa")
                    {
                        ApplicationArea = All;
                    }
                    field(Estado; Estado)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if Estado = Estado::Lanzada then
                                EditableOK := false
                            else
                                EditableOK := true;
                        end;
                    }
                    field("Tipo de Requisitos Específicos"; "Tipo de Requisitos Específicos")
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(Bloqueado; Bloqueado)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1000000015)
                {
                    Editable = EditableOK;
                    ShowCaption = false;

                    /*field("Origen inspección"; "Origen inspección")
                              {
                                  ApplicationArea = All;
                              }*/
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
                    field("Criterio de muestreo"; "Criterio de muestreo")
                    {
                        ApplicationArea = All;
                        Visible = false;
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
                }
            }
            part(Control1000000021; "Grupos Inspec x Plant_CAL_btc")
            {
                Editable = EditableOK;
                ShowFilter = false;
                SubPageLink = "Cód. plantilla" = FIELD("No."), "No. revision plantilla" = FIELD("No. revisión");
                SubPageView = SORTING("Cód. plantilla", "No. revision plantilla", "No. orden");
                ApplicationArea = All;
            }
            group(Control)
            {
                Editable = false;

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
                field("Fecha activación"; "Fecha activación")
                {
                    ApplicationArea = All;
                }
                field("Activada por usuario"; "Activada por usuario")
                {
                    ApplicationArea = All;
                }
                field("Fecha lanzamiento"; "Fecha lanzamiento")
                {
                    ApplicationArea = All;
                }
                field("Lanzado por usuario"; "Lanzado por usuario")
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
                field("Fecha terminación"; "Fecha terminación")
                {
                    ApplicationArea = All;
                }
                field("Terminado por usuario"; "Terminado por usuario")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000018; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000019; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        if (Estado = Estado::Lanzada) or (Estado = Estado::Terminada) then
            EditableOK := false
        else
            EditableOK := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EditableOK := true;
    end;

    var
        EditableOK: Boolean;
}
