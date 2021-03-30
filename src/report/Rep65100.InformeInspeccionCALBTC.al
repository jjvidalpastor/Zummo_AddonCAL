report 65100 "Informe Inspeccion_CAL_BTC"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Resources/Informe Inspeccion_CAL_BTC.rdl';
    Caption = 'Inspection Report', comment = 'ESP="Informe Inspección"';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Cab inspe eval_CAL_BTC";
        "Cab inspe eval_CAL_btc")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Origen inspección", "Nº doc. Origen calidad", "Nº lín. doc. Origen calidad";

            column(Titulo;
            TituloLbl)
            {
            }
            column(EmpresaText;
            CompanyName())
            {
            }
            column(OrigenInspeccion;
            format("Cab inspe eval_CAL_BTC"."Origen inspección"))
            {
            }
            column(CodPlantillaInspeccion;
            "Cab inspe eval_CAL_BTC"."Cód. plantilla")
            {
            }
            column(NumInspeccion;
            "Cab inspe eval_CAL_BTC"."No.")
            {
            }
            column(FechaCreacionInspeccion;
            Format("Cab inspe eval_CAL_BTC"."Fecha creación"))
            {
            }
            column(FechaAprobacionInspeccion;
            Format("Cab inspe eval_CAL_BTC"."Fecha certificación"))
            {
            }
            column(AprobadoPorInspeccion;
            "Cab inspe eval_CAL_BTC"."Certificado por usuario")
            {
            }
            column(ConformidadInspeccion;
            Format("Cab inspe eval_CAL_BTC".Conformidad))
            {
            }
            column(NoConformidadInspeccion;
            Format("Cab inspe eval_CAL_BTC"."No conformidad"))
            {
            }
            column(NumNoConformidadInspeccion;
            "Cab inspe eval_CAL_BTC"."No. No conformidad")
            {
            }
            column(EstadoInspeccion;
            "Cab inspe eval_CAL_BTC"."Estado inspección")
            {
            }
            column(TipoInspeccion;
            "Cab inspe eval_CAL_BTC"."Tipo inspección")
            {
            }
            column(ObjetoInspeccion;
            "Cab inspe eval_CAL_BTC"."Objeto inspección")
            {
            }
            column(OrigenInspeccionCaption;
            OrigenInspeccionCaptionLbl)
            {
            }
            column(CodPlantillaInspeccionCaption;
            CodPlantillaInspeccionCaptionLbl)
            {
            }
            column(NumInspeccionCaption;
            NumInspeccionCaptionLbl)
            {
            }
            column(NumRevisionInspeccionCaption;
            NumRevisionInspeccionCaptionLbl)
            {
            }
            column(FechaCreacionInspeccionCaption;
            FechaCreacionInspeccionCaptionLbl)
            {
            }
            column(FechaAprobacionInspeccionCaption;
            FechaAprobacionInspeccionCaptionLbl)
            {
            }
            column(AprobadoPorInspeccionCaption;
            AprobadoPorInspeccionCaptionLbl)
            {
            }
            column(ConformidadInspeccionCaption;
            ConformidadInspeccionCaptionLbl)
            {
            }
            column(NoConformidadInspeccionCaption;
            NoConformidadInspeccionCaptionLbl)
            {
            }
            column(NumNoConformidadInspeccionCaption;
            NumNoConformidadInspeccionCaptionLbl)
            {
            }
            column(EstadoInspeccionCaption;
            EstadoInspeccionCaptionLbl)
            {
            }
            column(TipoInspeccionCaption;
            TipoInspeccionCaptionLbl)
            {
            }
            column(ObjetoInspeccionCaption;
            ObjetoInspeccionCaptionLbl)
            {
            }
            column(CodProducto;
            "Cab inspe eval_CAL_BTC"."No. producto")
            {
            }
            column(DescProducto;
            Recproducto.Description)
            {
            }
            column(NumLote;
            "Cab inspe eval_CAL_BTC"."No. lote inspeccionado")
            {
            }
            column(NumSerie;
            "Cab inspe eval_CAL_BTC"."No. serie inspeccionado")
            {
            }
            column(CdadInspeccionada;
            "Cab inspe eval_CAL_BTC"."Cantidad Lote")
            {
            }
            column(UM;
            "Cab inspe eval_CAL_BTC"."Unidad de medida")
            {
            }
            column(AlmacenCode;
            "Cab inspe eval_CAL_BTC"."Cód. almacén")
            {
            }
            column(NomAlmacen;
            Recalmacen.Name)
            {
            }
            column(CodTarea;
            "Cab inspe eval_CAL_BTC"."Cód. tarea")
            {
            }
            column(DescTarea;
            RecTarea.Description)
            {
            }
            column(ProductoCaption;
            ProductoCaptionLbl)
            {
            }
            column(AlmacenCaption;
            AlmacenCaptionLbl)
            {
            }
            column(LoteCaption;
            LoteCaptionLbl)
            {
            }
            column(SerieCaption;
            SerieCaptionLbl)
            {
            }
            column(CantidadCaption;
            CantidadCaptionLbl)
            {
            }
            column(UMCaption;
            UMCaptionLbl)
            {
            }
            column(TareaCaption;
            TareaCaptionLbl)
            {
            }
            column(ClienteCaption;
            ClienteCaptionLbl)
            {
            }
            column(ProveedorCaption;
            ProveedorCaptionLbl)
            {
            }
            column(CodCliente;
            "Cab inspe eval_CAL_BTC"."No. cliente")
            {
            }
            column(NomCliente;
            RecCliente.Name)
            {
            }
            column(CodProveedor;
            "Cab inspe eval_CAL_BTC"."No. proveedor")
            {
            }
            column(NomProveedor;
            RecProveedor.Name)
            {
            }
            column(Veredicto;
            "Cab inspe eval_CAL_BTC"."Evaluación Inspección")
            {
            }
            column(VeredictoCaption;
            VeredictoCaptionLbl)
            {
            }
            column(EsProcesos;
            EsProcesos)
            {
            }
            column(EsEvaluacion;
            EsEvaluacion)
            {
            }
            column(EsEnvio;
            EsEnvio)
            {
            }
            column(EsDev;
            EsDev)
            {
            }
            column(EsRecep;
            EsRecep)
            {
            }
            column(EspecificacionLinea;
            EspecificacionCaptionLbl)
            {
            }
            column(ResultadoLinea;
            ResultadoCaptionLbl)
            {
            }
            column(MetodoLinea;
            MetodoCaptionLbl)
            {
            }
            column(AptitudLinea;
            AptitudCaptionLbl)
            {
            }
            dataitem("Lin inspe eval_CAL_BTC";
            "Lin inspe eval_CAL_btc")
            {
                //BEGIN FJAB 311019 Cambios campos
                /*
                              DataItemLink = "Origen inspección" = FIELD("Origen inspección"), "No. inspección" = FIELD("No.");
                              DataItemTableView = SORTING("Origen inspección", "No. inspección", "No. línea") WHERE("Omitir impresión" = CONST(false));
                              */
                DataItemLink = "No. inspección" = FIELD("No.");
                DataItemTableView = SORTING("No. inspección", "No. línea") WHERE("Omitir impresión" = CONST(false));

                //END FJAB 311019
                column(NumLin;
                "Lin inspe eval_CAL_BTC"."No. línea")
                {
                }
                column(CodGrupoInspeccion;
                "Lin inspe eval_CAL_BTC"."Cód. grupo inspección")
                {
                }
                column(GrupoInspeccionDesc;
                RecGrupoInsp.Descripción)
                {
                }
                column(CodRequisito;
                "Lin inspe eval_CAL_BTC"."Cód. requisito control")
                {
                }
                column(DescRequisito;
                "Lin inspe eval_CAL_BTC"."Descripción requisito")
                {
                }
                column(FlagResult;
                Format("Lin inspe eval_CAL_BTC"."Resultado condición"))
                {
                }
                column(ValorResult;
                "Lin inspe eval_CAL_BTC"."Resultado valor")
                {
                }
                column(ComentarioResult;
                "Lin inspe eval_CAL_BTC".Aptitud)
                {
                }
                column(ConformeReq;
                "Lin inspe eval_CAL_BTC"."Requisito conforme")
                {
                }
                column(NoConformeReq;
                "Lin inspe eval_CAL_BTC"."Requisito no conforme")
                {
                }
                column(Resultado;
                Resultado)
                {
                }
                column(CodUM;
                UMedida)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not RecGrupoInsp.Get("Cód. grupo inspección") then Clear(RecGrupoInsp);
                    Clear(UMedida);
                    if "Tipo control" in ["Tipo control"::"Condición"] then Resultado := Format("Resultado condición");
                    if "Tipo control" in ["Tipo control"::Texto] then Resultado := Format("Resultado texto");
                    if "Tipo control" in ["Tipo control"::Puntaje] then Resultado := Format("Resultado valor");
                    if "Tipo control" in ["Tipo control"::Valor] then Resultado := Format("Resultado valor");
                    UMedida := "Lin inspe eval_CAL_BTC"."Unidad de medida";
                    Resultado := Format(Aptitud);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if not Recproducto.Get("Cab inspe eval_CAL_BTC"."No. producto") then Clear(Recproducto);
                if not Recalmacen.Get("Cab inspe eval_CAL_BTC"."Cód. almacén") then Clear(Recalmacen);
                if not RecTarea.Get("Cab inspe eval_CAL_BTC"."Cód. tarea") then Clear(RecTarea);
                if not RecCliente.Get("Cab inspe eval_CAL_BTC"."No. cliente") then Clear(RecCliente);
                if not RecProveedor.Get("Cab inspe eval_CAL_BTC"."No. proveedor") then Clear(RecProveedor);
                //BEGIN FJAB 311019 Valores en base a origen inspección
                //TODO: Revisar asignación de valores de campos en base al Origen de la inspección
                /*
                              EsProcesos := "Origen inspección" = "Origen inspección"::Procesos;
                              EsEvaluacion := "Origen inspección" = "Origen inspección"::"Evaluación";
                              EsEnvio := "Origen inspección" = "Origen inspección"::"Envío";
                              EsDev := "Origen inspección" = "Origen inspección"::"Devolución";
                              EsRecep := "Origen inspección" = "Origen inspección"::"Recepción";
                              */
                //END FJAB 311019
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        Recproducto: Record Item;
        Recalmacen: Record Location;
        RecTarea: Record "Standard Task";
        RecCliente: Record Customer;
        RecProveedor: Record Vendor;
        RecGrupoInsp: Record inspeccion_CAL_btc;
        EsProcesos: Boolean;
        EsEvaluacion: Boolean;
        EsEnvio: Boolean;
        EsDev: Boolean;
        EsRecep: Boolean;
        Resultado: Text;
        UMedida: Code[20];
        OrigenInspeccionCaptionLbl: Label 'Origen:';
        CodPlantillaInspeccionCaptionLbl: Label 'Plantilla:';
        NumInspeccionCaptionLbl: Label 'Nº';
        NumRevisionInspeccionCaptionLbl: Label 'Nº Revisión:';
        FechaCreacionInspeccionCaptionLbl: Label 'Fecha Creación:';
        FechaAprobacionInspeccionCaptionLbl: Label 'Fecha Aprobación:';
        AprobadoPorInspeccionCaptionLbl: Label 'Aprobado por:';
        ConformidadInspeccionCaptionLbl: Label 'Conformidad:';
        NoConformidadInspeccionCaptionLbl: Label 'No Conformidad:';
        NumNoConformidadInspeccionCaptionLbl: Label 'Nº No Conformidad:';
        EstadoInspeccionCaptionLbl: Label 'Estado:';
        TipoInspeccionCaptionLbl: Label 'Tipo:';
        ObjetoInspeccionCaptionLbl: Label 'Objeto:';
        ProductoCaptionLbl: Label 'Producto:';
        AlmacenCaptionLbl: Label 'Almacén:';
        LoteCaptionLbl: Label 'Lote:';
        SerieCaptionLbl: Label 'Serie:';
        CantidadCaptionLbl: Label 'Cantidad:';
        UMCaptionLbl: Label 'Ud. Medida:';
        TareaCaptionLbl: Label 'Tarea:';
        ClienteCaptionLbl: Label 'Cliente:';
        ProveedorCaptionLbl: Label 'Proveedor:';
        VeredictoCaptionLbl: Label 'Evaluación inpección';
        TituloLbl: Label 'Inspección';
        EspecificacionCaptionLbl: Label 'ESPECIFICACIÓN';
        ResultadoCaptionLbl: Label 'RESULTADO';
        MetodoCaptionLbl: Label 'METODO';
        AptitudCaptionLbl: Label 'APTITUD';
}
