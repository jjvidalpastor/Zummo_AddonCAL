pageextension 65126 "PagExtPurchOrSub_CAL_btc" extends "Purchase Order Subform"
{
    layout
    {
        addafter("Bin Code")
        {
            field(InspeccionDeCalidadCAL_BTC; InspeccionDeCalidadCAL_BTC)
            {
                Visible = false;
            }
            field(NoConformidadCAL_BTC; NoConformidadCAL_BTC)
            {
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
                    Visible = false;

                    //FJAB 031119
                    /*
                              RunPageLink = "Origen inspección" = FILTER("Recepción" | "Devolución" | "Mat.Gráfico"),
                                            "No. pedido proveedor" = FIELD("Document No."),
                                            "No. línea pedido proveedor" = FIELD("Line No.");
                              */
                    /*RunPageLink = "Origen inspección" = const("Pedido Compra"),
                                  "Nº doc. Origen calidad" = field("Document No."),
                                  "Nº lín. doc. Origen calidad" = field("Line No.");*/
                    trigger OnAction()
                    begin
                        if not InspeccionDeCalidadCAL_BTC then Error('Atención: Inspección de Calidad no creada');
                    end;
                }
                action("No conformidad")
                {
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "No Conformidades_CAL_btc";
                    ApplicationArea = All;
                    Visible = false;

                    //FJAB 031119
                    /*
                              RunPageLink = "Origen inspección" = FILTER("Recepción" | "Devolución" | "Mat.Gráfico"),
                                            "No. pedido proveedor" = FIELD("Document No."),
                                            "No. línea pedido proveedor" = FIELD("Line No.");
                              */
                    /*RunPageLink = "Origen inspección" = const("Pedido Compra"),
                                  "Nº doc. Origen calidad" = field("Document No."),
                                  "Nº lín. doc. Origen calidad" = field("Line No.");*/
                    trigger OnAction()
                    begin
                        if not NoConformidadCAL_BTC then Error('Atención: No conformidad no creada');
                    end;
                }
                action("Crear inspección # control visual")
                {
                    Image = CopyFromTask;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    var
                        funcCalidad: Codeunit "Calidad Mgt_CAL_BTC";
                        cduPrueb: Codeunit Crear_CabInspecCalidad_CAL_BTC;
                        OrigenInspeccion: enum OrigenCalidad;
                    begin
                        //funcCalidad.CrearInspeccionLinPedidoCompra(Rec);
                        //cduPrueb.CrearInspeccionLinPedidoCompra(Rec, OrigenInspeccion::"Pedido Compra");
                    end;
                }
            }
        }
    }
}
