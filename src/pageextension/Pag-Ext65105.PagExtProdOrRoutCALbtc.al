pageextension 65105 "PagExtProdOrRout_CAL_btc" extends "Prod. Order Routing"
{
    layout
    {
        addafter(Description)
        {
            field(InspeccionDeCalidadCAL_BTC; InspeccionDeCalidadCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(NoConformidadCAL_BTC; NoConformidadCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            group(Calidad)
            {
                action("Inspecciones de calidad")
                {
                    Image = TaskQualityMeasure;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Inspecciones de Calida_CAL_btc";
                    ApplicationArea = All;

                    //TODO: Revisar qué tipo de origen tiene que ser
                    /*
                              RunPageLink = "Origen inspección" = CONST(Procesos),
                                            "No. ruta produccion" = FIELD("Routing No."),
                                            "No. operación ruta fabricación" = FIELD("Operation No."),
                                            "No. orden produccion" = FIELD("Prod. Order No.");
                              */
                    trigger OnAction()
                    begin
                        if InspeccionDeCalidadCAL_BTC = false then Error('Atención: Inspección de Calidad no creada');
                    end;
                }
                action("No conformidad")
                {
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "No Conformidades_CAL_btc";
                    ApplicationArea = All;

                    //TODO: Revisar qué tipo de origen tiene que ser
                    /*
                              RunPageLink = "Origen inspección" = CONST (Procesos),
                                            "No. ruta produccion" = FIELD ("Routing No."),
                                            "No. operación ruta fabricación" = FIELD ("Operation No."),
                                            "No. orden produccion" = FIELD ("Prod. Order No.");
                              */
                    trigger OnAction()
                    begin
                        if NoConformidadCAL_BTC = false then Error('Atención: No conformidad no creada');
                    end;
                }
                action("Crear inspección de calidad")
                {
                    Image = CopyFromTask;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        funcCalidad: Codeunit "Calidad Mgt_CAL_BTC";
                    begin
                        funcCalidad.CrearInspeccionRutaOP(Rec);
                    end;
                }
            }
        }
    }
}
