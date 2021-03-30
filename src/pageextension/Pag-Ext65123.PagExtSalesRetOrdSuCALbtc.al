pageextension 65123 "PagExtSalesRetOrdSu_CAL_btc" extends "Sales Return Order Subform"
{
    layout
    {
        addafter("Bin Code")
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

                    //TODO: Revisar filtro
                    /*
                              RunPageLink = "Origen inspección" = CONST ("Devolución"),
                                            "No. pedido cliente" = FIELD ("Document No."),
                                            "No. línea pedido cliente" = FIELD ("Line No.");
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

                    //TODO: Revisar filtro
                    /*
                              RunPageLink = "Origen inspección" = CONST ("Devolución"),
                                            "No. pedido cliente" = FIELD ("Document No."),
                                            "No. línea pedido cliente" = FIELD ("Line No.");
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
                        funcCalidad.CrearInspeccionLinPedidoVenta(Rec);
                    end;
                }
            }
        }
    }
}
