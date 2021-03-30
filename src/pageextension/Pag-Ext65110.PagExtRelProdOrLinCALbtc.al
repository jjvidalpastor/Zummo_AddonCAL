pageextension 65110 "PagExtRelProdOrLin_CAL_btc" extends "Released Prod. Order Lines"
{
    layout
    {
        addafter("Description 2")
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
        addafter("&Line")
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
                              RunPageLink = "Origen inspección" = CONST ("Fabricación"),
                                            "No. orden produccion" = FIELD ("Prod. Order No."),
                                            "No. línea orden producción" = FIELD ("Line No.");
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
                              RunPageLink = "Origen inspección" = CONST("Fabricación"),
                                            "No. orden produccion" = FIELD("Prod. Order No."),
                                            "No. línea orden producción" = FIELD("Line No.");
                              */
                    trigger OnAction()
                    begin
                        if NoConformidadCAL_BTC = false then Error('Atención: No conformidad no creada');
                    end;
                }
                action("Crear inspección # control visual")
                {
                    Image = CopyFromTask;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        funcCalidad: Codeunit "Calidad Mgt_CAL_BTC";
                    begin
                        funcCalidad.CrearInspeccionLinOP(Rec);
                    end;
                }
            }
        }
    }
}
