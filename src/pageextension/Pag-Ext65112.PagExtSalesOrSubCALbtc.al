pageextension 65112 "PagExtSalesOrSub_CAL_btc" extends "Sales Order Subform"
{
    layout
    {
        addafter("Bin Code")
        {
            field(InspeccionDeCalidadCAL_BTC; InspeccionDeCalidadCAL_BTC)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(NoConformidadCAL_BTC; NoConformidadCAL_BTC)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    actions
    {
        addafter("O&rder")
        {
            group(Calidad)
            {
                Visible = false;

                action("Inspecciones de calidad")
                {
                    Image = TaskQualityMeasure;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Inspecciones de Calida_CAL_btc";
                    ApplicationArea = All;

                    //TODO: Revisar filtro
                    /*
                              RunPageLink = "Origen inspección" = FILTER ("Envío" | "Devolución"),
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
                              RunPageLink = "Origen inspección" = FILTER ("Envío" | "Devolución"),
                                            "No. pedido cliente" = FIELD ("Document No."),
                                            "No. línea pedido cliente" = FIELD ("Line No.");
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
                        funcCalidad.CrearInspeccionLinPedidoVenta(Rec);
                    end;
                }
            }
        }
    }
}
