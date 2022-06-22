report 65101 "Informe No Conformidad_CAL_BTC"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Resources/Informe No Conformidad_CAL_BTC.rdl';
    PreviewMode = PrintLayout;
    Caption = 'Informe No Conformidad';

    dataset
    {
        dataitem("Cab. inspección/eval. calidad"; "Cab no conformidad_CAL_btc")
        {
            //BEGIN FJAB 311019 Cambio campos
            /*
                      DataItemTableView = SORTING ("Origen inspección", "No. inspección", "No. no conformidad");
                      RequestFilterFields = "Origen inspección", "No. inspección", "No. no conformidad";
                      */
            DataItemTableView = sorting("No. inspección", "No. no conformidad");
            RequestFilterFields = "Origen inspección", "No. inspección", "No. no conformidad";

            //END FJAB 311019
            column(Titulo;
            TituloLbl)
            {
            }
            column(EmpresaText;
            CompanyName())
            {
            }
            column(OrigenInspeccion;
            format("Cab. inspección/eval. calidad"."Origen inspección"))
            {
            }
            column(CodPlantillaInspeccion;
            "Cab. inspección/eval. calidad"."Cód. plantilla")
            {
            }
            column(NumInspeccion;
            "Cab. inspección/eval. calidad"."No. inspección")
            {
            }
            column(NumNoConformidad;
            "Cab. inspección/eval. calidad"."No. no conformidad")
            {
            }
            column(FechaCreacionInspeccion;
            Format("Cab. inspección/eval. calidad"."Fecha creación"))
            {
            }
            column(FechaAprobacionInspeccion;
            Format("Cab. inspección/eval. calidad"."Fecha certificación"))
            {
            }
            column(AprobadoPorInspeccion;
            "Cab. inspección/eval. calidad"."Certificado por usuario")
            {
            }
            column(NumNoConformidadInspeccion;
            "Cab. inspección/eval. calidad"."No. no conformidad")
            {
            }
            column(EstadoInspeccion;
            "Cab. inspección/eval. calidad"."Estado no conformidad")
            {
            }
            column(TipoInspeccion;
            "Cab. inspección/eval. calidad"."Tipo inspección")
            {
            }
            column(ObjetoInspeccion;
            "Cab. inspección/eval. calidad"."Objeto inspección")
            {
            }
            column(NumrevNoConformidadCaption;
            NumrevNoConformidadCaptionLbl)
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
            "Cab. inspección/eval. calidad"."No. producto")
            {
            }
            column(DescProducto;
            Recproducto.Description)
            {
            }
            column(NumLote;
            "Cab. inspección/eval. calidad"."No. lote inspeccionado")
            {
            }
            column(NumSerie;
            "Cab. inspección/eval. calidad"."No. serie inspeccionado")
            {
            }
            column(CdadInspeccionada;
            "Cab. inspección/eval. calidad"."Cantidad Lote")
            {
            }
            column(UM;
            "Cab. inspección/eval. calidad"."Unidad de medida")
            {
            }
            column(AlmacenCode;
            "Cab. inspección/eval. calidad"."Cód. almacén")
            {
            }
            column(NomAlmacen;
            Recalmacen.Name)
            {
            }
            column(CodTarea;
            "Cab. inspección/eval. calidad"."Cód. tarea")
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
            "Cab. inspección/eval. calidad"."No. cliente")
            {
            }
            column(NomCliente;
            RecCliente.Name)
            {
            }
            column(CodProveedor;
            "Cab. inspección/eval. calidad"."No. proveedor")
            {
            }
            column(NomProveedor;
            RecProveedor.Name)
            {
            }
            column(Veredicto;
            "Cab. inspección/eval. calidad"."Veredicto no conformidad")
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
            dataitem("Lín. inspección/eval. calidad";
            "Lin no conformidad_CAL_btc")
            {
                //BEGIN FJAB 311019 Cambio campos
                /*
                              DataItemLink = "Origen inspección" = FIELD("Origen inspección"), "No. inspección" = FIELD("No. inspección"), "No. no conformidad" = FIELD("No. no conformidad");
                              DataItemTableView = SORTING("Origen inspección", "No. inspección", "No. no conformidad", "No. línea");
                              */
                DataItemLink = "No. inspección" = FIELD("No. inspección"), "No. no conformidad" = FIELD("No. no conformidad");
                DataItemTableView = SORTING("No. inspección", "No. no conformidad", "No. línea");

                //END FJAB 311019
                column(numLin;
                "Lín. inspección/eval. calidad"."No. línea")
                {
                }
                column(CodGrupoInspeccion;
                "Lín. inspección/eval. calidad"."Cod. grupo inspección")
                {
                }
                column(GrupoInspeccionDesc;
                RecGrupoInsp.Descripción)
                {
                }
                column(CodRequisito;
                "Lín. inspección/eval. calidad"."Cód. requisito control")
                {
                }
                column(DescRequisito;
                "Lín. inspección/eval. calidad"."Descripción requisito")
                {
                }
                column(CodCausapreliminar;
                "Lín. inspección/eval. calidad"."Cód. causa preliminar")
                {
                }
                column(DescCausapreliminar;
                "Lín. inspección/eval. calidad"."Descripcion causa preliminar")
                {
                }
                column(CodCausaFinal;
                "Lín. inspección/eval. calidad"."Cód. causa final")
                {
                }
                column(DescCausaFinal;
                "Lín. inspección/eval. calidad"."Descripción causa final")
                {
                }
                column(CodAccionPreventiva;
                "Lín. inspección/eval. calidad"."Cód. acción correctiva")
                {
                }
                column(DescaccionPreventiva;
                Recaccion.Descripción)
                {
                }
                column(Requisitocaption;
                RequisitocaptionLbl)
                {
                }
                column(CausaPremCaption;
                CausaPremCaptionLbl)
                {
                }
                column(CausaFinalCaption;
                CausaFinalCaptionLbl)
                {
                }
                column(AccionPrevCaption;
                AccionPrevCaptionLbl)
                {
                }
                column(AccionInmeCaption;
                AccionInmeCaptionLbl)
                {
                }
                column(AccionCorrecCaption;
                AccionCorrecCaptionLbl)
                {
                }
                column(ObservacionesCaption;
                ObservacionesCaptionLbl)
                {
                }
                column(CodAccionInmediata;
                "Lín. inspección/eval. calidad"."Cód. acción inmediata")
                {
                }
                column(CodAccionCorrectiva;
                "Lín. inspección/eval. calidad"."Cód. acción preventiva")
                {
                }
                column(ObservacionesAcciones;
                "Lín. inspección/eval. calidad"."Observaciones acciones")
                {
                }
                column(DescAccionCorrectiva;
                RecaccionCorrec.Descripción)
                {
                }
                column(DescaccionInmediata;
                RecAccionInme.Descripción)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not RecGrupoInsp.Get("Cod. grupo inspección") then Clear(RecGrupoInsp);
                    if not Recaccion.Get(Recaccion.Tipo::Preventiva, "Cód. acción correctiva") then Clear(Recaccion);
                    if not RecaccionCorrec.Get(RecaccionCorrec.Tipo::Correctiva, "Cód. acción preventiva") then Clear(RecaccionCorrec);
                    if not RecAccionInme.Get(RecAccionInme.Tipo::Inmediata, "Cód. acción inmediata") then Clear(RecAccionInme);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if not Recproducto.Get("Cab. inspección/eval. calidad"."No. producto") then Clear(Recproducto);
                if not Recalmacen.Get("Cab. inspección/eval. calidad"."Cód. almacén") then Clear(Recalmacen);
                if not RecTarea.Get("Cab. inspección/eval. calidad"."Cód. tarea") then Clear(RecTarea);
                if not RecCliente.Get("Cab. inspección/eval. calidad"."No. cliente") then Clear(RecCliente);
                if not RecProveedor.Get("Cab. inspección/eval. calidad"."No. proveedor") then Clear(RecProveedor);
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
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        Recproducto: Record Item;
        Recalmacen: Record Location;
        RecTarea: Record "Standard Task";
        RecCliente: Record Customer;
        RecProveedor: Record Vendor;
        RecGrupoInsp: Record inspeccion_CAL_btc;
        Recaccion: Record "Accion_CAL_btc";
        RecaccionCorrec: Record "Accion_CAL_btc";
        RecAccionInme: Record "Accion_CAL_btc";
        EsProcesos: Boolean;
        EsEvaluacion: Boolean;
        EsEnvio: Boolean;
        EsDev: Boolean;
        EsRecep: Boolean;
        NumrevNoConformidadCaptionLbl: Label 'Nº Revisión:';
        RequisitocaptionLbl: Label 'Requisito:';
        CausaPremCaptionLbl: Label 'Causa Preliminar:';
        CausaFinalCaptionLbl: Label 'Causa Final:';
        AccionPrevCaptionLbl: Label 'Acción Preventiva:';
        AccionInmeCaptionLbl: Label 'Acción Inmediata:';
        AccionCorrecCaptionLbl: Label 'Acción Correctiva:';
        ObservacionesCaptionLbl: Label 'Observaciones:';
        OrigenInspeccionCaptionLbl: Label 'Origen:';
        CodPlantillaInspeccionCaptionLbl: Label 'Plantilla:';
        NumInspeccionCaptionLbl: Label 'Nº Inspección:';
        NumRevisionInspeccionCaptionLbl: Label 'Nº Revisión Inspección:';
        FechaCreacionInspeccionCaptionLbl: Label 'Fecha Creación:';
        FechaAprobacionInspeccionCaptionLbl: Label 'Fecha Aprobación:';
        AprobadoPorInspeccionCaptionLbl: Label 'Aprobado por:';
        ConformidadInspeccionCaptionLbl: Label 'Conformidad:';
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
        VeredictoCaptionLbl: Label 'Veredicto';
        TituloLbl: Label 'No Conformidad';
}
