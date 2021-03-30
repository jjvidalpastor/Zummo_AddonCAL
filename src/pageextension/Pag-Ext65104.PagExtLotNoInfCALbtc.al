pageextension 65104 "PagExtLotNoInf_CAL_btc" extends "Lot No. Information Card"
{
    layout
    {
        modify("Test Quality")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        addafter(Description)
        {
            field(Blocked2; Blocked)
            {
                ApplicationArea = ItemTracking;
                ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
            }
            field(ControlVisualObligCAL_BTC; ControlVisualObligCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
        addafter("Test Quality")
        {
            field(TestQualityCAL_BTC; TestQualityCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(EstadoRevisionVisualCAL_BTC; EstadoRevisionVisualCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
        addafter("Certificate Number")
        {
            field(NoLoteExternoCAL_BTC; NoLoteExternoCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(ObservacionesCAL_BTC; ObservacionesCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(FotografiaAdjuntaCAL_BTC; FotografiaAdjuntaCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
        addafter("Expired Inventory")
        {
            group(Calidad)
            {
                field(InspeccionDeCalidadCAL_BTC; InspeccionDeCalidadCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(NoConformidadCAL_BTC; NoConformidadCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(FechaRecepcionCAL_BTC; FechaRecepcionCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(EstadoControlCalidadCAL_BTC; EstadoControlCalidadCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(FechaFabricacionCAL_BTC; FechaFabricacionCAL_BTC)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(FechaCaducidadCAL_BTC; FechaCaducidadCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(FechaCaducidadPreviaCAL_BTC; FechaCaducidadPreviaCAL_BTC)
                {
                    ApplicationArea = All;
                }
            }
            group("Control Visual")
            {
                field(MarcarTodoOKCAL_BTC; MarcarTodoOKCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(AlbaranProveedorSICAL_BTC; AlbaranProveedorSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(MercanciaConformeSICAL_BTC; MercanciaConformeSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(FichaSeguridadSICAL_BTC; FichaSeguridadSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(CertificadoAnalisisSICAL_BTC; CertificadoAnalisisSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(RecipientesConformesSICAL_BTC; RecipientesConformesSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                field("Cierr/PrecinConformesSICAL_BTC"; "Cierr/PrecinConformesSICAL_BTC")
                {
                    ApplicationArea = All;
                }
                field(PaletsLimpiosSICAL_BTC; PaletsLimpiosSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(EtiqProveedorVisibleSICAL_BTC; EtiqProveedorVisibleSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                field("AusenciaContam/ManipuSICAL_BTC"; "AusenciaContam/ManipuSICAL_BTC")
                {
                    ApplicationArea = All;
                }
                field(RecipientesLoteXPaletSICAL_BTC; RecipientesLoteXPaletSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(CertificadPlaguicidasSICAL_BTC; CertificadPlaguicidasSICAL_BTC)
                {
                    ApplicationArea = All;
                }
                group(Control1000000022)
                {
                    ShowCaption = false;

                    field(MarcarTodoNOOKCAL_BTC; MarcarTodoNOOKCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field(AlbaranProveedorNOCAL_BTC; AlbaranProveedorNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field(MercanciaConformeNOCAL_BTC; MercanciaConformeNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field(FichaSeguridadNOCAL_BTC; FichaSeguridadNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field(CertificadoAnalisisNOCAL_BTC; CertificadoAnalisisNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field(RecipientesConformesNOCAL_BTC; RecipientesConformesNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field("Cierr/PrecinConformesNOCAL_BTC"; "Cierr/PrecinConformesNOCAL_BTC")
                    {
                        ApplicationArea = All;
                    }
                    field(PaletsLimpiosNOCAL_BTC; PaletsLimpiosNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field(EtiqProveedorVisibleNOCAL_BTC; EtiqProveedorVisibleNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field("AusenciaContam/ManipuNOCAL_BTC"; "AusenciaContam/ManipuNOCAL_BTC")
                    {
                        ApplicationArea = All;
                    }
                    field(RecipientesLoteXPaletNOCAL_BTC; RecipientesLoteXPaletNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                    field(CertificadPlaguicidasNOCAL_BTC; CertificadPlaguicidasNOCAL_BTC)
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Control)
            {
                Caption = 'Control';

                field(VisadoXUsuarioCAL_BTC; VisadoXUsuarioCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(FechaVisadoCAL_BTC; FechaVisadoCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(RevisadoXusuarioCAL_BTC; RevisadoXusuarioCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(FechaRevisadoCAL_BTC; FechaRevisadoCAL_BTC)
                {
                    ApplicationArea = All;
                }
            }
            group(Origen)
            {
                Caption = 'Origen';

                field(ProcedenciaCreacionCAL_BTC; ProcedenciaCreacionCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(LoteOrigenReclasificaCAL_BTC; LoteOrigenReclasificaCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(ProdOrderNoCAL_BTC; ProdOrderNoCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(PrioridadCAL_BTC; PrioridadCAL_BTC)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
