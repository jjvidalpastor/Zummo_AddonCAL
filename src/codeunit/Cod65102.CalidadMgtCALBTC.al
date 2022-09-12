codeunit 65102 "Calidad Mgt_CAL_BTC"
{

    Permissions = tabledata "Item Ledger Entry" = rmid;

    var
        SMTPMailSetup: Record "SMTP Mail Setup";
        cduSMTP: Codeunit "SMTP Mail";
        InspRecMsg: Label 'Inspección de Calidad de Producto en Recepción %1 creada';
        InspAlmMsg: Label 'Inspección de Calidad de Producto en Amacén %1 creada.';
        InspAlmMsg2: Label '\¿Desea abrir la inspección?';
        InspFabMsg: Label 'Inspección de Calidad de Producto en Fabricación %1 creada';
        InspEnvMsg: Label 'Inspección de Calidad de Producto en Envío a Cliente %1 creada';
        InspDevMsg: Label 'Inspección de Calidad de Producto de Devolución de Cliente %1 creada';
        InspProMsg: Label 'Inspección de Calidad de Proceso de Producción %1 creada';
        InspEvaMsg: Label 'Inspección de Calidad de Evaluación de Proveedor %1 creada';
        InspRcmMsg: Label 'Inspección de Calidad de Reclamación de Cliente %1 creada';
        InspRpmMsg: Label 'Inspección de Calidad de Reclamación de Proveedor %1 creada.';
        NconForMsg: Label 'No Conformidad %1 creada';
        PlanNDisMsg: Label 'Plantilla %1 No Disponible. Revise Versiones Activas y/o Certificadas.';
        GrupReqMsg: Label 'Grupo de Requisitos Plantilla %1 No Disponible. Revise Grupos de Requisitos Bloqueados.';
        InspSinLineasMsg: Label 'Inspección de Calidad %1 sin Requisito No Conforme y Afectación a Conformidad para Crear No Conformidad. Revise líneas de Inspección.';
        MailEmisor: Text[50];
        MailReceptores: Text[150];
        MailAsunto: Text[300];
        MailCuerpo: Text[600];
        DCActiva: Boolean;
        CR: Char;
        LF: Char;
        PopUp: Boolean;
        OnlyVisualControl: Boolean;
        NoInsertar: Boolean;

        lblConfirmReposicion: Label 'Se va a crear un pedido de compra de Reposición. ¿Desea Continuar?', comment = 'ESP="Se va a crear un pedido de compra de Reposición. ¿Desea Continuar?"';

    //TODO: Se ha comentado todo el código de las funciones que generan inspecciones por cada tipo de origen:
    //CrearInspeccionLinPedidoCompra
    //CrearInspeccionMovProducto
    //CrearInspeccionLinOP
    //CrearInspeccionLinPedidoVenta
    //CrearInspeccionRutaOP
    //CrearInspeccionProveedor
    //CrearInspeccionProveedorR
    //CrearInspeccionCliente
    //CrearInspeccionMuestras        
    procedure CrearInspeccionLinPedidoCompra(var pPurchLine: Record "Purchase Line")
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Item: Record Item;
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        MovReserva: Record "Reservation Entry";
        Requisitos: Record calidad_CAL_btc;
        TrackingSpecification: Record "Tracking Specification";
        InfoLote: Record "Lot No. Information";
        Vendor: Record Vendor;
        CabInspCalidad: Record "Cab inspe eval_CAL_btc";
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        numSerie: Code[20];
        codPlantilla: Code[20];
        bMatAcond: Boolean;
        TabLotes: array[20] of Code[20];
        TabSeries: array[20] of Code[20];
        TabFechaCad: array[20] of Date;
        TabFechaFab: array[20] of Date;
        TabCanLote: array[20] of Decimal;
        TopIndex: Integer;
        Index: Integer;
        NumLin: Integer;
    begin
        /*pPurchLine.TestField(Type, pPurchLine.Type::Item);
              pPurchLine.TestField("No.");

              Item.Get(pPurchLine."No.");
              if (Item.ActivarGestionCalidadCAL_BTC = false) and
                (Item.ControlVisuObligatorioCAL_BTC = false) then
                  Error('Atención: Producto sin gestión de calidad ni control visual configurado');

              Clear(OnlyVisualControl);
              if (Item.ActivarGestionCalidadCAL_BTC = false) and
                (Item.ControlVisuObligatorioCAL_BTC = true) then begin
                  OnlyVisualControl := true;
                  Message('Aviso: Producto con sólo control visual');
              end;

              GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. recepcion");
              GestionCalidadSetup.TestField("Cód. plantilla recepción pred");
              GestionCalidadSetup.TestField("No. serie insp. devolución");
              GestionCalidadSetup.TestField("Cód. plantilla devolución pred");
              GestionCalidadSetup.TestField("No. serie insp. mat. graph");
              GestionCalidadSetup.TestField("Cód. plantilla mat. graph pred");

              Clear(bMatAcond);
              Clear(numSerie);

              if Item."Item Category Code" = GestionCalidadSetup."Item Category Code Graph" then
                  bMatAcond := true;

              case pPurchLine."Document Type" of
                  pPurchLine."Document Type"::Order:
                      begin
                          numSerie := GestionCalidadSetup."No. serie insp. recepcion";
                          if bMatAcond then
                              numSerie := GestionCalidadSetup."No. serie insp. mat. graph";

                          if Item.CodPlantillaRecepCAL_BTC <> '' then
                              codPlantilla := Item.CodPlantillaRecepCAL_BTC
                          else begin
                              codPlantilla := GestionCalidadSetup."Cód. plantilla recepción pred";
                              if bMatAcond then
                                  codPlantilla := GestionCalidadSetup."Cód. plantilla mat. graph pred";
                          end;
                      end;
                  pPurchLine."Document Type"::"Return Order":
                      begin
                          numSerie := GestionCalidadSetup."No. serie insp. devolución";
                          if Item.CodPlantillaDevoCAL_BTC <> '' then
                              codPlantilla := Item.CodPlantillaDevoCAL_BTC
                          else
                              codPlantilla := GestionCalidadSetup."Cód. plantilla devolución pred";
                      end;
                  else
                      Error('Tipo no esperado');
              end;

              Plantilla.Reset();
              Plantilla.SetRange("No.", codPlantilla);
              Plantilla.SetRange(Bloqueado, false);
              Plantilla.SetRange("Version activa", true);
              Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
              if Plantilla.FindLast() = false then
                  Error(PlanNDisMsg, codPlantilla);

              Clear(TabLotes);
              Clear(TabSeries);
              Clear(TabFechaCad);
              Clear(TabFechaFab);
              Clear(TabCanLote);
              Clear(Index);
              Clear(TopIndex);


              MovReserva.Reset();
              MovReserva.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name",
                                                  "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
              MovReserva.SetRange("Source Type", 39);
              MovReserva.SetFilter("Source Subtype", '%1|%2', 1, 5);
              MovReserva.SetRange("Source ID", pPurchLine."Document No.");
              MovReserva.SetRange("Source Ref. No.", pPurchLine."Line No.");
              if MovReserva.FindSet() then
                  repeat
                      Index := Index + 1;
                      if Index < 20 then begin
                          TabLotes[Index] := MovReserva."Lot No.";
                          TabSeries[Index] := MovReserva."Serial No.";
                          TabFechaCad[Index] := MovReserva."Expiration Date";
                          TabFechaFab[Index] := MovReserva."Warranty Date";
                          TabCanLote[Index] := MovReserva."Quantity (Base)";
                          TopIndex := Index;
                      end;
                  until MovReserva.Next() = 0
              else begin
                  TrackingSpecification.Reset();
                  TrackingSpecification.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                                                  "Source Prod. Order Line", "Source Ref. No.");
                  TrackingSpecification.SetRange("Source Type", 39);
                  TrackingSpecification.SetFilter("Source Subtype", '%1|%2', 1, 5);
                  TrackingSpecification.SetRange("Source ID", pPurchLine."Document No.");
                  TrackingSpecification.SetRange("Source Ref. No.", pPurchLine."Line No.");
                  if TrackingSpecification.FindSet() then
                      repeat
                          Index := Index + 1;
                          if Index < 20 then begin
                              TabLotes[Index] := TrackingSpecification."Lot No.";
                              TabSeries[Index] := TrackingSpecification."Serial No.";
                              TabFechaCad[Index] := TrackingSpecification."Expiration Date";
                              TabFechaFab[Index] := TrackingSpecification."Warranty Date";
                              TabCanLote[Index] := TrackingSpecification."Quantity (Base)";
                              TopIndex := Index;
                          end;
                      until TrackingSpecification.Next() = 0
                  else
                      Error('Aviso: se requiere asignar nº de lote a la línea de compra');
              end;

              Clear(Index);
              while TopIndex > Index do begin
                  Index := Index + 1;

                  Inspeccion.Init();
                  Clear(Inspeccion."No.");
                  Clear(Inspeccion."Origen inspección");

                  Inspeccion.Validate("No. lote inspeccionado", TabLotes[Index]);
                  Inspeccion.Validate("No. serie inspeccionado", TabSeries[Index]);
                  Inspeccion.Validate("Fecha caducidad", TabFechaCad[Index]);
                  Inspeccion.Validate("Fecha fabricación", TabFechaFab[Index]);
                  Inspeccion.Validate("Cantidad Lote", TabCanLote[Index]);

                  case pPurchLine."Document Type" of
                      pPurchLine."Document Type"::Order:
                          begin
                              if bMatAcond = false then Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Recepción");
                              if bMatAcond = true then Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Mat.Gráfico");
                              Inspeccion.Validate("No. de serie", numSerie);
                          end;
                      pPurchLine."Document Type"::"Return Order":
                          begin
                              Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Devolución");
                              Inspeccion.Validate("No. de serie", numSerie);
                          end;
                      else
                          Error('Tipo no esperado');
                  end;

                  Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
                  Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
                  Inspeccion.Validate(Descripción, Plantilla.Descripcion);
                  Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
                  Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
                  Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
                  Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
                  Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
                  Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

                  case pPurchLine."Document Type" of
                      pPurchLine."Document Type"::Order:
                          begin
                              Inspeccion.Validate("No. pedido proveedor", pPurchLine."Document No.");
                              Inspeccion.Validate("No. línea pedido proveedor", pPurchLine."Line No.");
                          end;
                      pPurchLine."Document Type"::"Return Order":
                          begin
                              Inspeccion.Validate("No. pedido proveedor", pPurchLine."Document No.");
                              Inspeccion.Validate("No. línea pedido proveedor", pPurchLine."Line No.");
                          end;
                      else
                          Error('Tipo no esperado');
                  end;

                  Inspeccion.Validate("No. producto", pPurchLine."No.");
                  Inspeccion.Validate("Cód. variante", pPurchLine."Variant Code");
                  Inspeccion.Validate("Cód. almacén", pPurchLine."Location Code");
                  Inspeccion.Validate("Cód. ubicación", pPurchLine."Bin Code");
                  Inspeccion.Validate("No. proveedor", pPurchLine."Buy-from Vendor No.");
                  Inspeccion.Validate("Unidad de medida", pPurchLine."Unit of Measure Code");

                  if Inspeccion."Origen inspección" = Inspeccion."Origen inspección"::"Mat.Gráfico" then
                      Inspeccion.Validate("Cantidad Inspeccionada", Inspeccion."Cantidad Lote");

                  if Inspeccion."Cód. almacén" = '' then Error('Aviso: se requiere asignar código almacén a la línea de compra');

                  InfoLote.Init();
                  if Inspeccion."No. lote inspeccionado" <> '' then
                      if InfoLote.Get(Inspeccion."No. producto", Inspeccion."Cód. variante", Inspeccion."No. lote inspeccionado") then begin
                          InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                          InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                          InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                          InfoLote.Validate(ProcedenciaCreacionCAL_BTC, InfoLote.ProcedenciaCreacionCAL_BTC::"Recepción");
                          InfoLote.Modify(true);
                      end
                      else begin
                          InfoLote.Init();
                          InfoLote.Validate("Item No.", Inspeccion."No. producto");
                          InfoLote.Validate("Variant Code", Inspeccion."Cód. variante");
                          InfoLote.Validate("Lot No.", Inspeccion."No. lote inspeccionado");
                          InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                          InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                          InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                          InfoLote.Validate(ProcedenciaCreacionCAL_BTC, InfoLote.ProcedenciaCreacionCAL_BTC::"Recepción");
                          InfoLote.Insert(true);
                      end;

                  Clear(NoInsertar);
                  if OnlyVisualControl = true then NoInsertar := true;

                  Clear(CabInspCalidad);
                  CabInspCalidad.SetCurrentKey("Origen inspección", "No.");
                  CabInspCalidad.SetRange("Origen inspección", Inspeccion."Origen inspección");
                  CabInspCalidad.SetRange("No. producto", Inspeccion."No. producto");
                  CabInspCalidad.SetRange("No. lote inspeccionado", Inspeccion."No. lote inspeccionado");
                  CabInspCalidad.SetRange("No. proveedor", pPurchLine."Buy-from Vendor No.");
                  CabInspCalidad.SetRange("No. pedido proveedor", pPurchLine."Document No.");
                  CabInspCalidad.SetRange("No. línea pedido proveedor", pPurchLine."Line No.");
                  if CabInspCalidad.FindFirst() then
                      NoInsertar := true;

                  Inspeccion.CalcCantidadSugerida();

                  if NoInsertar = false then Inspeccion.Insert(true);

                  if NoInsertar = false then begin
                      Clear(NumLin);
                      RecDetallePlantilla.Reset();
                      RecDetallePlantilla.SetRange(Bloqueado, false);
                      RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
                      RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
                      if RecDetallePlantilla.FindSet() then begin
                          repeat
                              RecDetalleGrupo.Reset();
                              RecDetalleGrupo.SetRange(Bloqueado, false);
                              RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                              if RecDetalleGrupo.FindSet() then
                                  repeat
                                      RecLinIns.Init();
                                      RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                                      RecLinIns.Validate("No. inspección", Inspeccion."No.");
                                      RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                                      if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                          if Requisitos.Bloqueado = false then begin
                                              if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                                  ReqEspecificos.Init();
                                                  if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                                      if ReqEspecificos.Bloqueado = false then begin
                                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                          NumLin += 10000;
                                                          RecLinIns.Validate("No. línea", NumLin);
                                                          RecLinIns.Insert(true);
                                                      end;
                                              end;
                                              if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                          end;
                                  until RecDetalleGrupo.Next() = 0
                              else
                                  Message(GrupReqMsg, codPlantilla);
                          until RecDetallePlantilla.Next() = 0;
                          Message(InspRecMsg, Inspeccion."No.");
                      end
                      else
                          Message(GrupReqMsg, codPlantilla);

                      GestionCalidadSetup.Init();
                      GestionCalidadSetup.Get();
                      if bMatAcond = false then DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
                      if bMatAcond = true then DCActiva := GestionCalidadSetup."Activar aviso apert insp graph";
                      if DCActiva then begin
                          SMTPMailSetup.Init();
                          SMTPMailSetup.Get();
                          SMTPMailSetup.TestField("SMTP Server");
                          MailEmisor := SMTPMailSetup."User ID";
                          if bMatAcond = false then MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
                          if bMatAcond = true then MailReceptores := GestionCalidadSetup."Receptores Apertura Insp Graph";
                          PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                          Clear(MailAsunto);
                          Clear(MailCuerpo);
                          CR := 13;
                          LF := 10;
                      end;

                      if DCActiva then begin
                          if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                          if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
                          MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección");
                          MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
                          Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                          'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                          'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                          Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                          Clear(cduSMTP);
                          cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                          cduSMTP.Send();
                          if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
                      end;

                      Clear(GestionCalidadSetup);
                      GestionCalidadSetup.Get();
                      if bMatAcond = false then DCActiva := GestionCalidadSetup."Activar aviso recepcion produc";
                      if bMatAcond = true then DCActiva := GestionCalidadSetup."Activar aviso recepcion graph";
                      if DCActiva then begin
                          Clear(SMTPMailSetup);
                          SMTPMailSetup.Get();
                          SMTPMailSetup.TestField("SMTP Server");
                          MailEmisor := SMTPMailSetup."User ID";
                          if bMatAcond = false then MailReceptores := GestionCalidadSetup."Receptores Recepcion Producto";
                          if bMatAcond = true then MailReceptores := GestionCalidadSetup."Receptores Recep Mat.Graph";
                          PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                          Clear(MailAsunto);
                          Clear(MailCuerpo);
                          CR := 13;
                          LF := 10;
                      end;

                      if DCActiva then begin
                          if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                          if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la recepción de productos');
                          MailAsunto := 'Aviso Automático. Recepción de Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto";
                          MailCuerpo := 'Recepción Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') +
                          Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Origen: ' + Format(Inspeccion."Origen inspección") + ' - Proveedor: ' +
                          Inspeccion."Descripción proveedor" + ' - Nº Pedido: ' + Format(Inspeccion."No. pedido proveedor") + ' por: ' + Format(UserId()) +
                          Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                          'Lote: ' + Format(Inspeccion."No. lote inspeccionado") + ' - Cantidad: ' + Format(Inspeccion."Cantidad Lote") + ' ' + Format(Inspeccion."Unidad de medida") +
                          ' - Fecha caducidad: ' + Format(Inspeccion."Fecha caducidad") + ' - Fecha fabricación: ' + Format(Inspeccion."Fecha fabricación") +
                          Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';

                          Clear(cduSMTP);
                          cduSMTP.CreateMessage('Aviso de Recepción de Producto', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                          cduSMTP.Send();
                          if PopUp then Message('Correo enviado a los Receptores de Recepción de Productos');
                      end;

                  end;
              end;

              if Inspeccion."No. proveedor" <> '' then
                  if Vendor.Get(Inspeccion."No. proveedor") then
                      if Vendor.InspeccionCalidadAGR_BTC = false then begin
                          Vendor.Validate(InspeccionCalidadAGR_BTC, true);
                          Vendor.Modify(true);
                      end;

              pPurchLine.Validate(InspeccionDeCalidadCAL_BTC, true);
              pPurchLine.Modify(true);
              */
    end;

    procedure CrearInspeccionMovProducto(var pItemLedgerEntry: Record "Item Ledger Entry")
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Item: Record Item;
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        InfoLote: Record "Lot No. Information";
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        numSerie: Code[20];
        codPlantilla: Code[20];
        NumLin: Integer;
    begin
        /*Item.Get(pItemLedgerEntry."Item No.");
              if (Item.ActivarGestionCalidadCAL_BTC = false) and
                (Item.ControlVisuObligatorioCAL_BTC = false) then
                  Error('Atención: Producto sin gestión de calidad ni control visual configurado');

              Clear(OnlyVisualControl);
              if (Item.ActivarGestionCalidadCAL_BTC = false) and
                (Item.ControlVisuObligatorioCAL_BTC = true) then begin
                  OnlyVisualControl := true;
                  Message('Aviso: Producto con sólo control visual');
              end;

              GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. almacén");
              GestionCalidadSetup.TestField("Cód. plantilla almacén pred");

              Clear(numSerie);
              Inspeccion.Init();

              if Item.CodPlantillaAlmacenCAL_BTC <> '' then
                  codPlantilla := Item.CodPlantillaAlmacenCAL_BTC
              else
                  codPlantilla := GestionCalidadSetup."Cód. plantilla almacén pred";

              numSerie := GestionCalidadSetup."No. serie insp. almacén";

              Plantilla.Reset();
              Plantilla.SetRange("No.", codPlantilla);
              Plantilla.SetRange(Bloqueado, false);
              Plantilla.SetRange("Version activa", true);
              Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
              if Plantilla.FindLast() = false then Error(PlanNDisMsg, codPlantilla);

              Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Almacén");
              Inspeccion.Validate("No. de serie", numSerie);

              Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
              Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

              Inspeccion.Validate("No. producto", pItemLedgerEntry."Item No.");
              Inspeccion.Validate("Cód. variante", pItemLedgerEntry."Variant Code");
              Inspeccion.Validate("Cód. almacén", pItemLedgerEntry."Location Code");
              Inspeccion.Validate("Unidad de medida", pItemLedgerEntry."Unit of Measure Code");

              Inspeccion.Validate("No. lote inspeccionado", pItemLedgerEntry."Lot No.");
              Inspeccion.Validate("No. serie inspeccionado", pItemLedgerEntry."Serial No.");
              Inspeccion.Validate("Fecha caducidad", pItemLedgerEntry."Expiration Date");
              Inspeccion.Validate("Fecha fabricación", pItemLedgerEntry."Warranty Date");
              Inspeccion.Validate("Cantidad Lote", pItemLedgerEntry."Remaining Quantity");

              InfoLote.Init();
              if Inspeccion."No. lote inspeccionado" <> '' then
                  if InfoLote.Get(Inspeccion."No. producto", Inspeccion."Cód. variante", Inspeccion."No. lote inspeccionado") then begin
                      InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                      InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                      InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                      if InfoLote.EstadoAprobadoPrevioCAL_BTC = true then Inspeccion.Validate(Recontrol, true);
                      InfoLote.Modify(true);
                  end
                  else begin
                      InfoLote.Init();
                      InfoLote.Validate("Item No.", Inspeccion."No. producto");
                      InfoLote.Validate("Variant Code", Inspeccion."Cód. variante");
                      InfoLote.Validate("Lot No.", Inspeccion."No. lote inspeccionado");
                      InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                      InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                      InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                      InfoLote.Insert(true);
                  end;

              if OnlyVisualControl = true then exit;

              Inspeccion.CalcCantidadSugerida();

              Inspeccion.Insert(true);


              Clear(NumLin);
              RecDetallePlantilla.Reset();
              RecDetallePlantilla.SetRange(Bloqueado, false);
              RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
              RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
              if RecDetallePlantilla.FindSet() then begin
                  repeat
                      RecDetalleGrupo.Reset();
                      RecDetalleGrupo.SetRange(Bloqueado, false);
                      RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                      if RecDetalleGrupo.FindSet() then
                          repeat
                              RecLinIns.Init();
                              RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                              RecLinIns.Validate("No. inspección", Inspeccion."No.");
                              RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                              if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                  if Requisitos.Bloqueado = false then begin
                                      if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          ReqEspecificos.Init();
                                          if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                              if ReqEspecificos.Bloqueado = false then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                      end;
                                      if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                          NumLin += 10000;
                                          RecLinIns.Validate("No. línea", NumLin);
                                          RecLinIns.Insert(true);
                                      end;
                                  end;
                          until RecDetalleGrupo.Next() = 0
                      else
                          Message(GrupReqMsg, codPlantilla);
                  until RecDetallePlantilla.Next() = 0;
                  Message(InspAlmMsg, Inspeccion."No.");
              end
              else
                  Message(GrupReqMsg, codPlantilla);

              Clear(GestionCalidadSetup);
              GestionCalidadSetup.Get();
              DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
              if DCActiva then begin
                  SMTPMailSetup.Init();
                  SMTPMailSetup.Get();
                  SMTPMailSetup.TestField("SMTP Server");
                  MailEmisor := SMTPMailSetup."User ID";
                  MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
                  PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                  Clear(MailAsunto);
                  Clear(MailCuerpo);
                  CR := 13;
                  LF := 10;
              end;

              if DCActiva then begin
                  if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                  if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
                  MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección");
                  MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
                  Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                  Clear(cduSMTP);
                  cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                  cduSMTP.Send();
                  if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
              end;
              */
    end;

    procedure CrearInspeccionLinOP(var pProdOrderLine: Record "Prod. Order Line")
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Item: Record Item;
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        InfoLote: Record "Lot No. Information";
        MovReserva: Record "Reservation Entry";
        MovProducto: Record "Item Ledger Entry";
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        OrdProd: Record "Production Order";
        codPlantilla: Code[20];
        numSerie: Code[20];
        NumLin: Integer;
    begin
        /*
              if pProdOrderLine.InspeccionDeCalidadCAL_BTC = true then
                  Error('Inspección creada con anterioridad');

              Item.Get(pProdOrderLine."Item No.");
              if (Item.ActivarGestionCalidadCAL_BTC = false) and
                (Item.ControlVisuObligatorioCAL_BTC = false) then
                  Error('Atención: Producto sin gestión de calidad ni control visual configurado');

              Clear(OnlyVisualControl);
              if (Item.ActivarGestionCalidadCAL_BTC = false) and
                (Item.ControlVisuObligatorioCAL_BTC = true) then begin
                  OnlyVisualControl := true;
                  Message('Aviso: Producto con sólo control visual');
              end;

              OrdProd.Get(pProdOrderLine.Status, pProdOrderLine."Prod. Order No.");

              GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. fabricación");
              GestionCalidadSetup.TestField("Cód. plantilla fabricación pre");

              Clear(numSerie);
              Inspeccion.Init();

              if Item.CodPlantillaFabricacCAL_BTC <> '' then
                  codPlantilla := Item.CodPlantillaFabricacCAL_BTC
              else
                  codPlantilla := GestionCalidadSetup."Cód. plantilla fabricación pre";

              Plantilla.Reset();
              Plantilla.SetRange("No.", codPlantilla);
              Plantilla.SetRange(Bloqueado, false);
              Plantilla.SetRange("Version activa", true);
              Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
              if Plantilla.FindLast() = false then Error(PlanNDisMsg, codPlantilla);

              numSerie := GestionCalidadSetup."No. serie insp. fabricación";

              Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Fabricación");
              Inspeccion.Validate("No. de serie", numSerie);

              Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
              Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

              Inspeccion.Validate("No. producto", pProdOrderLine."Item No.");
              Inspeccion.Validate("Cód. variante", pProdOrderLine."Variant Code");
              Inspeccion.Validate("Unidad de medida", pProdOrderLine."Unit of Measure Code");

              Inspeccion.Validate("Cód. almacén", pProdOrderLine."Location Code");
              Inspeccion.Validate("Cód. ubicación", pProdOrderLine."Bin Code");

              Inspeccion.Validate("No. orden produccion", pProdOrderLine."Prod. Order No.");
              Inspeccion.Validate("No. línea orden producción", pProdOrderLine."Line No.");
              Inspeccion.Validate(Prioridad, OrdProd.PrioridadCAL_BTC);

              Clear(Inspeccion."No. lote inspeccionado");
              Clear(Inspeccion."No. serie inspeccionado");

              MovReserva.Reset();
              MovReserva.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name",
                                                  "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
              MovReserva.SetRange("Source Type", 5406);
              MovReserva.SetRange("Source Subtype", 3);
              MovReserva.SetRange("Source ID", pProdOrderLine."Prod. Order No.");
              MovReserva.SetRange("Source Prod. Order Line", pProdOrderLine."Line No.");
              if MovReserva.FindFirst() then begin
                  Inspeccion.Validate("No. lote inspeccionado", MovReserva."Lot No.");
                  Inspeccion.Validate("No. serie inspeccionado", MovReserva."Serial No.");
                  Inspeccion.Validate("Fecha caducidad", MovReserva."Expiration Date");
                  Inspeccion.Validate("Fecha fabricación", MovReserva."Warranty Date");
                  Inspeccion.Validate("Cantidad Lote", MovReserva."Quantity (Base)");
              end
              else begin
                  MovProducto.Reset();
                  MovProducto.SetCurrentKey("Entry Type", "Order No.", "Order Line No.");
                  MovProducto.SetRange("Entry Type", MovProducto."Entry Type"::Output);
                  MovProducto.SetRange("Order No.", pProdOrderLine."Prod. Order No.");
                  MovProducto.SetRange("Order Line No.", pProdOrderLine."Line No.");
                  if MovProducto.FindFirst() then begin
                      Inspeccion.Validate("No. lote inspeccionado", MovProducto."Lot No.");
                      Inspeccion.Validate("No. serie inspeccionado", MovProducto."Serial No.");
                      Inspeccion.Validate("Fecha caducidad", MovProducto."Expiration Date");
                      Inspeccion.Validate("Fecha fabricación", MovProducto."Warranty Date");
                      Inspeccion.Validate("Cantidad Lote", MovProducto."Remaining Quantity");
                  end
                  else
                      Error('Aviso: se requiere asignar nº de lote a la línea de orden de fabricación');
              end;

              if Inspeccion."Cód. almacén" = '' then Error('Aviso: se requiere asignar código almacén a la línea de orden de fabricación');
              if Inspeccion."No. lote inspeccionado" = '' then Error('Aviso: se requiere asignar nº de lote a la línea de orden de fabricación');
              if Inspeccion."Fecha fabricación" = 0D then Error('Aviso: se requiere asignar fecha fabricación al nº de lote de fabricación');
              if Item."Item Tracking Code" <> 'SEGLOTNCAD' then
                  if Inspeccion."Fecha caducidad" = 0D then Error('Aviso: se requiere asignar fecha caducidad al nº de lote de fabricación');

              InfoLote.Init();
              if Inspeccion."No. lote inspeccionado" <> '' then
                  if InfoLote.Get(Inspeccion."No. producto", Inspeccion."Cód. variante", Inspeccion."No. lote inspeccionado") then begin
                      InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                      InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                      InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                      InfoLote.Validate(ProcedenciaCreacionCAL_BTC, InfoLote.ProcedenciaCreacionCAL_BTC::"Fabricación");
                      InfoLote.Validate(PrioridadCAL_BTC, Inspeccion.Prioridad);
                      InfoLote.Validate(ProdOrderNoCAL_BTC, Inspeccion."No. orden produccion");
                      InfoLote.Modify(true);
                  end
                  else begin
                      InfoLote.Init();
                      InfoLote.Validate("Item No.", Inspeccion."No. producto");
                      InfoLote.Validate("Variant Code", Inspeccion."Cód. variante");
                      InfoLote.Validate("Lot No.", Inspeccion."No. lote inspeccionado");
                      InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                      InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                      InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                      InfoLote.Validate(ProcedenciaCreacionCAL_BTC, InfoLote.ProcedenciaCreacionCAL_BTC::"Fabricación");
                      InfoLote.Validate(PrioridadCAL_BTC, Inspeccion.Prioridad);
                      InfoLote.Validate(ProdOrderNoCAL_BTC, Inspeccion."No. orden produccion");
                      InfoLote.Insert(true);
                  end;

              if OnlyVisualControl = true then exit;

              Inspeccion.CalcCantidadSugerida();

              Inspeccion.Insert(true);


              Clear(NumLin);
              RecDetallePlantilla.Reset();
              RecDetallePlantilla.SetRange(Bloqueado, false);
              RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
              RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
              if RecDetallePlantilla.FindSet() then begin
                  repeat
                      RecDetalleGrupo.Reset();
                      RecDetalleGrupo.SetRange(Bloqueado, false);
                      RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                      if RecDetalleGrupo.FindSet() then
                          repeat
                              RecLinIns.Init();
                              RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                              RecLinIns.Validate("No. inspección", Inspeccion."No.");
                              RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                              if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                  if Requisitos.Bloqueado = false then begin
                                      if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          ReqEspecificos.Init();
                                          if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                              if ReqEspecificos.Bloqueado = false then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                      end;
                                      if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                          NumLin += 10000;
                                          RecLinIns.Validate("No. línea", NumLin);
                                          RecLinIns.Insert(true);
                                      end;
                                  end;
                          until RecDetalleGrupo.Next() = 0
                      else
                          Message(GrupReqMsg, codPlantilla);
                  until RecDetallePlantilla.Next() = 0;
                  Message(InspFabMsg, Inspeccion."No.");
              end
              else
                  Message(GrupReqMsg, codPlantilla);

              pProdOrderLine.Validate(InspeccionDeCalidadCAL_BTC, true);
              pProdOrderLine.Modify(true);

              GestionCalidadSetup.Init();
              GestionCalidadSetup.Get();
              DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
              if DCActiva then begin
                  SMTPMailSetup.Init();
                  SMTPMailSetup.Get();
                  SMTPMailSetup.TestField("SMTP Server");
                  MailEmisor := SMTPMailSetup."User ID";
                  MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
                  PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                  Clear(MailAsunto);
                  Clear(MailCuerpo);
                  CR := 13;
                  LF := 10;
              end;

              if DCActiva then begin
                  if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                  if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
                  MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' Prioridad: ' + Format(Inspeccion.Prioridad);
                  MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
                  Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                  Clear(cduSMTP);
                  cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                  cduSMTP.Send();
                  if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
              end;

              GestionCalidadSetup.Init();
              GestionCalidadSetup.Get();
              DCActiva := GestionCalidadSetup."Activar aviso fabricacion prod";
              if DCActiva then begin
                  SMTPMailSetup.Init();
                  SMTPMailSetup.Get();
                  SMTPMailSetup.TestField("SMTP Server");
                  MailEmisor := SMTPMailSetup."User ID";
                  MailReceptores := GestionCalidadSetup."Receptores Fabricacion Produc";
                  PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                  Clear(MailAsunto);
                  Clear(MailCuerpo);
                  CR := 13;
                  LF := 10;
              end;

              if DCActiva then begin
                  if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                  if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la recepción de productos');
                  MailAsunto := 'Aviso Automático. Fabricación de Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto";
                  MailCuerpo := 'Fabricación de Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') +
                  Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Origen: ' + Format(Inspeccion."Origen inspección") +
                  ' - Nº Orden Producción: ' + Format(Inspeccion."No. orden produccion") + ' Prioridad: ' + Format(Inspeccion.Prioridad) + ' por: ' + Format(UserId()) +
                  Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Lote: ' + Format(Inspeccion."No. lote inspeccionado") + ' - Cantidad: ' + Format(Inspeccion."Cantidad Lote") + ' ' + Format(Inspeccion."Unidad de medida") +
                  ' - Fecha caducidad: ' + Format(Inspeccion."Fecha caducidad") + ' - Fecha fabricación: ' + Format(Inspeccion."Fecha fabricación") +
                  Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                  Clear(cduSMTP);
                  cduSMTP.CreateMessage('Aviso de Fabricación Producto', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                  cduSMTP.Send();
                  if PopUp then Message('Correo enviado a los Receptores de Fabricación de Productos');
              end;
              */
    end;

    procedure CrearInspeccionLinPedidoVenta(var pSalesLine: Record "Sales Line")
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Item: Record Item;
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        TrackingSpecification: Record "Tracking Specification";
        InfoLote: Record "Lot No. Information";
        Customer: Record Customer;
        MovReserva: Record "Reservation Entry";
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        codPlantilla: Code[20];
        numSerie: Code[20];
        NumLin: Integer;
    begin
        /*
              if pSalesLine.InspeccionDeCalidadCAL_BTC = true then
                  Error('Inspección creada con anterioridad');

              pSalesLine.TestField(Type, pSalesLine.Type::Item);
              pSalesLine.TestField("No.");

              Item.Get(pSalesLine."No.");
              if (Item.ActivarGestionCalidadCAL_BTC = false) and
                (Item.ControlVisuObligatorioCAL_BTC = false) then
                  Error('Atención: Producto sin gestión de calidad ni control visual configurado');

              Clear(OnlyVisualControl);
              if (Item.ActivarGestionCalidadCAL_BTC = false) and
                (Item.ControlVisuObligatorioCAL_BTC = true) then begin
                  OnlyVisualControl := true;
                  Message('Aviso: Producto con sólo control visual');
              end;

              GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. envío");
              GestionCalidadSetup.TestField("Cód. plantilla envio predeter");
              GestionCalidadSetup.TestField("No. serie insp. devolución");
              GestionCalidadSetup.TestField("Cód. plantilla devolución pred");

              Clear(numSerie);
              Inspeccion.Init();

              case pSalesLine."Document Type" of
                  pSalesLine."Document Type"::Order:
                      begin

                          numSerie := GestionCalidadSetup."No. serie insp. envío";

                          if Item.CodPlantillaEnvioCAL_BTC <> '' then
                              codPlantilla := Item.CodPlantillaEnvioCAL_BTC
                          else
                              codPlantilla := GestionCalidadSetup."Cód. plantilla envio predeter";

                      end;
                  pSalesLine."Document Type"::"Return Order":
                      begin

                          numSerie := GestionCalidadSetup."No. serie insp. devolución";

                          if Item.CodPlantillaDevoCAL_BTC <> '' then
                              codPlantilla := Item.CodPlantillaDevoCAL_BTC
                          else
                              codPlantilla := GestionCalidadSetup."Cód. plantilla devolución pred";
                      end;
                  else
                      Error('Tipo no esperado');
              end;

              Plantilla.Reset();
              Plantilla.SetRange("No.", codPlantilla);
              Plantilla.SetRange(Bloqueado, false);
              Plantilla.SetRange("Version activa", true);
              Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
              if Plantilla.FindLast() = false then Error(PlanNDisMsg, codPlantilla);

              case pSalesLine."Document Type" of
                  pSalesLine."Document Type"::Order:
                      begin
                          Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Envío");
                          Inspeccion.Validate("No. de serie", numSerie);
                      end;
                  pSalesLine."Document Type"::"Return Order":
                      begin
                          Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Devolución");
                          Inspeccion.Validate("No. de serie", numSerie);
                      end;
                  else
                      Error('Tipo no esperado');
              end;

              Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
              Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

              case pSalesLine."Document Type" of
                  pSalesLine."Document Type"::Order:
                      begin
                          Inspeccion.Validate("No. pedido cliente", pSalesLine."Document No.");
                          Inspeccion.Validate("No. línea pedido cliente", pSalesLine."Line No.");
                      end;
                  pSalesLine."Document Type"::"Return Order":
                      begin
                          Inspeccion.Validate("No. pedido cliente", pSalesLine."Document No.");
                          Inspeccion.Validate("No. línea pedido cliente", pSalesLine."Line No.");
                      end;
                  else
                      Error('Tipo no esperado');
              end;

              Inspeccion.Validate("No. producto", pSalesLine."No.");
              Inspeccion.Validate("Cód. variante", pSalesLine."Variant Code");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

              Inspeccion.Validate("Cód. almacén", pSalesLine."Location Code");
              Inspeccion.Validate("Cód. ubicación", pSalesLine."Bin Code");
              Inspeccion.Validate("No. cliente", pSalesLine."Sell-to Customer No.");
              Inspeccion.Validate("Unidad de medida", pSalesLine."Unit of Measure Code");

              if Inspeccion."No. cliente" <> '' then
                  if Customer.Get(Inspeccion."No. cliente") then
                      if Customer.InspeccionCalidadAGR_BTC = false then begin
                          Customer.Validate(InspeccionCalidadAGR_BTC, true);
                          Customer.Modify(true);
                      end;

              Clear(Inspeccion."No. lote inspeccionado");
              Clear(Inspeccion."No. serie inspeccionado");

              MovReserva.Reset();
              MovReserva.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name",
                                                  "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
              MovReserva.SetRange("Source Type", 37);
              MovReserva.SetFilter("Source Subtype", '%1|%2', 1, 5);
              MovReserva.SetRange("Source ID", pSalesLine."Document No.");
              MovReserva.SetRange("Source Ref. No.", pSalesLine."Line No.");
              if MovReserva.FindFirst() then begin
                  Inspeccion.Validate("No. lote inspeccionado", MovReserva."Lot No.");
                  Inspeccion.Validate("No. serie inspeccionado", MovReserva."Serial No.");
                  Inspeccion.Validate("Fecha caducidad", MovReserva."Expiration Date");
                  Inspeccion.Validate("Fecha fabricación", MovReserva."Warranty Date");
                  Inspeccion.Validate("Cantidad Lote", MovReserva."Quantity (Base)");
              end
              else begin
                  TrackingSpecification.Reset();
                  TrackingSpecification.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                                                  "Source Prod. Order Line", "Source Ref. No.");
                  TrackingSpecification.SetRange("Source Type", 37);
                  TrackingSpecification.SetFilter("Source Subtype", '%1|%2', 1, 5);
                  TrackingSpecification.SetRange("Source ID", pSalesLine."Document No.");
                  TrackingSpecification.SetRange("Source Ref. No.", pSalesLine."Line No.");
                  if TrackingSpecification.FindFirst() then begin
                      Inspeccion.Validate("No. lote inspeccionado", TrackingSpecification."Lot No.");
                      Inspeccion.Validate("No. serie inspeccionado", TrackingSpecification."Serial No.");
                      Inspeccion.Validate("Fecha caducidad", TrackingSpecification."Expiration Date");
                      Inspeccion.Validate("Fecha fabricación", TrackingSpecification."Warranty Date");
                      Inspeccion.Validate("Cantidad Lote", TrackingSpecification."Quantity (Base)");
                  end
                  else
                      Error('Aviso: se requiere asignar nº de lote a la línea de venta');
              end;

              if Inspeccion."Cód. almacén" = '' then Error('Aviso: se requiere asignar código almacén a la línea de venta');
              if Inspeccion."No. lote inspeccionado" = '' then Error('Aviso: se requiere asignar nº de lote a la línea de venta');
              if Item."Item Tracking Code" <> 'SEGLOTNCAD' then
                  if Inspeccion."Fecha caducidad" = 0D then Error('Aviso: se requiere asignar fecha caducidad al nº de lote de venta');


              InfoLote.Init();
              if Inspeccion."No. lote inspeccionado" <> '' then
                  if InfoLote.Get(Inspeccion."No. producto", Inspeccion."Cód. variante", Inspeccion."No. lote inspeccionado") then begin
                      InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                      InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                      InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                      InfoLote.Modify(true);
                  end
                  else begin
                      InfoLote.Init();
                      InfoLote.Validate("Item No.", Inspeccion."No. producto");
                      InfoLote.Validate("Variant Code", Inspeccion."Cód. variante");
                      InfoLote.Validate("Lot No.", Inspeccion."No. lote inspeccionado");
                      InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                      InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                      InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                      InfoLote.Insert(true);
                  end;

              if OnlyVisualControl = true then exit;

              Inspeccion.CalcCantidadSugerida();

              Inspeccion.Insert(true);

              Clear(NumLin);
              RecDetallePlantilla.Reset();
              RecDetallePlantilla.SetRange(Bloqueado, false);
              RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
              RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");

              if RecDetallePlantilla.FindSet() then begin
                  repeat
                      RecDetalleGrupo.Reset();
                      RecDetalleGrupo.SetRange(Bloqueado, false);
                      RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                      if RecDetalleGrupo.FindSet() then
                          repeat
                              RecLinIns.Init();
                              RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                              RecLinIns.Validate("No. inspección", Inspeccion."No.");
                              RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                              if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                  if Requisitos.Bloqueado = false then begin
                                      if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          ReqEspecificos.Init();
                                          if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                              if ReqEspecificos.Bloqueado = false then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                      end;
                                      if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                          NumLin += 10000;
                                          RecLinIns.Validate("No. línea", NumLin);
                                          RecLinIns.Insert(true);
                                      end;
                                  end;
                          until RecDetalleGrupo.Next() = 0
                      else
                          Message(GrupReqMsg, codPlantilla);
                  until RecDetallePlantilla.Next() = 0;
                  if pSalesLine."Document Type" = pSalesLine."Document Type"::Order
                     then
                      Message(InspEnvMsg, Inspeccion."No.");
                  if pSalesLine."Document Type" = pSalesLine."Document Type"::"Return Order"
                     then
                      Message(InspDevMsg, Inspeccion."No.");
              end
              else
                  Message(GrupReqMsg, codPlantilla);

              pSalesLine.Validate(InspeccionDeCalidadCAL_BTC, true);
              pSalesLine.Modify(true);

              Clear(GestionCalidadSetup);
              GestionCalidadSetup.Get();
              DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
              if DCActiva then begin
                  CLEAR(SMTPMailSetup);
                  SMTPMailSetup.Get();
                  SMTPMailSetup.TestField("SMTP Server");
                  MailEmisor := SMTPMailSetup."User ID";
                  MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
                  PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                  Clear(MailAsunto);
                  Clear(MailCuerpo);
                  CR := 13;
                  LF := 10;
              end;

              if DCActiva then begin
                  if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                  if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
                  MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección");
                  MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
                  Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                  Clear(cduSMTP);
                  cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                  cduSMTP.Send();
                  if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
              end;
              */
    end;

    procedure CrearInspeccionRutaOP(var pProdOrderRoutingLine: Record "Prod. Order Routing Line")
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        codPlantilla: Code[20];
        numSerie: Code[20];
        NumLin: Integer;
    begin
        /*if pProdOrderRoutingLine.InspeccionDeCalidadCAL_BTC = true then
                  Error('Inspección creada con anterioridad');

              GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. procesos");
              GestionCalidadSetup.TestField("Cód. plantilla procesos pred");

              codPlantilla := GestionCalidadSetup."Cód. plantilla procesos pred";

              Plantilla.Reset();
              Plantilla.SetRange("No.", codPlantilla);
              Plantilla.SetRange(Bloqueado, false);
              Plantilla.SetRange("Version activa", true);
              Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
              if Plantilla.FindLast() = false then Error(PlanNDisMsg, codPlantilla);

              Clear(numSerie);
              Inspeccion.Init();

              numSerie := GestionCalidadSetup."No. serie insp. procesos";

              Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::Procesos);
              Inspeccion.Validate("No. de serie", numSerie);
              Inspeccion.Insert(true);

              Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
              Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

              Inspeccion.Validate("Cód. almacén", pProdOrderRoutingLine."Location Code");

              Inspeccion.Validate("No. orden produccion", pProdOrderRoutingLine."Prod. Order No.");
              Inspeccion.Validate("No. ruta produccion", pProdOrderRoutingLine."Routing No.");
              Inspeccion.Validate("No. operación ruta fabricación", pProdOrderRoutingLine."Operation No.");
              Inspeccion.Modify(true);

              Clear(NumLin);
              RecDetallePlantilla.Reset();
              RecDetallePlantilla.SetRange(Bloqueado, false);
              RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
              RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
              if RecDetallePlantilla.FindSet() then begin
                  repeat
                      RecDetalleGrupo.Reset();
                      RecDetalleGrupo.SetRange(Bloqueado, false);
                      RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                      if RecDetalleGrupo.FindSet() then
                          repeat
                              RecLinIns.Init();
                              RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                              RecLinIns.Validate("No. inspección", Inspeccion."No.");
                              RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                              if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                  if Requisitos.Bloqueado = false then begin
                                      if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          ReqEspecificos.Init();
                                          if ReqEspecificos.Get(ReqEspecificos.Tipo::"Proceso Fabricación", RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                              if ReqEspecificos.Bloqueado = false then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                      end;
                                      if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                          NumLin += 10000;
                                          RecLinIns.Validate("No. línea", NumLin);
                                          RecLinIns.Insert(true);
                                      end;
                                  end;
                          until RecDetalleGrupo.Next() = 0
                      else
                          Message(GrupReqMsg, codPlantilla);
                  until RecDetallePlantilla.Next() = 0;
                  Message(InspProMsg, Inspeccion."No.");
              end
              else
                  Message(GrupReqMsg, codPlantilla);

              pProdOrderRoutingLine.Validate(InspeccionDeCalidadCAL_BTC, true);
              pProdOrderRoutingLine.Modify(true);

              GestionCalidadSetup.Init();
              GestionCalidadSetup.Get();
              DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
              if DCActiva then begin
                  Clear(SMTPMailSetup);
                  SMTPMailSetup.Get();
                  SMTPMailSetup.TestField("SMTP Server");
                  MailEmisor := SMTPMailSetup."User ID";
                  MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
                  PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                  Clear(MailAsunto);
                  Clear(MailCuerpo);
                  CR := 13;
                  LF := 10;
              end;

              if DCActiva then begin
                  if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                  if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
                  MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección");
                  MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
                  Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                  Clear(cduSMTP);
                  cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                  cduSMTP.Send();
                  if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
              end;
              */
    end;

    procedure CrearInspeccionProveedor(var pVendor: Record Vendor)
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        numSerie: Code[20];
        codPlantilla: Code[20];
        NumLin: Integer;
    begin
        /*GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. evaluación");
              GestionCalidadSetup.TestField("Cód. plantilla evaluación pred");

              codPlantilla := GestionCalidadSetup."Cód. plantilla evaluación pred";

              Plantilla.Reset();
              Plantilla.SetRange("No.", codPlantilla);
              Plantilla.SetRange(Bloqueado, false);
              Plantilla.SetRange("Version activa", true);
              Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
              if Plantilla.FindLast() = false then Error(PlanNDisMsg, codPlantilla);

              Clear(numSerie);
              Inspeccion.Init();

              numSerie := GestionCalidadSetup."No. serie insp. evaluación";

              Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Evaluación");
              Inspeccion.Validate("No. de serie", numSerie);
              Inspeccion.Insert(true);

              Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
              Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

              Inspeccion.Validate("No. proveedor", pVendor."No.");

              Inspeccion.Modify(true);

              Clear(NumLin);
              RecDetallePlantilla.Reset();
              RecDetallePlantilla.SetRange(Bloqueado, false);
              RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
              RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
              if RecDetallePlantilla.FindSet() then begin
                  repeat
                      RecDetalleGrupo.Reset();
                      RecDetalleGrupo.SetRange(Bloqueado, false);
                      RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                      if RecDetalleGrupo.FindSet() then
                          repeat
                              RecLinIns.Init();
                              RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                              RecLinIns.Validate("No. inspección", Inspeccion."No.");
                              RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                              if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                  if Requisitos.Bloqueado = false then begin
                                      if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          ReqEspecificos.Init();
                                          if ReqEspecificos.Get(ReqEspecificos.Tipo::"Evaluación Proveedor", RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                              if ReqEspecificos.Bloqueado = false then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                      end;
                                      if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                          NumLin += 10000;
                                          RecLinIns.Validate("No. línea", NumLin);
                                          RecLinIns.Insert(true);
                                      end;
                                  end;
                          until RecDetalleGrupo.Next() = 0
                      else
                          Message(GrupReqMsg, codPlantilla);
                  until RecDetallePlantilla.Next() = 0;
                  Message(InspEvaMsg, Inspeccion."No.");
              end
              else
                  Message(GrupReqMsg, codPlantilla);

              pVendor.Validate(InspeccionCalidadAGR_BTC, true);
              pVendor.Validate(FechaUltEvaluAGR_BTC, WorkDate());
              pVendor.Modify(true);

              GestionCalidadSetup.Init();
              GestionCalidadSetup.Get();
              DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
              if DCActiva then begin
                  Clear(SMTPMailSetup);
                  SMTPMailSetup.Get();
                  SMTPMailSetup.TestField("SMTP Server");
                  MailEmisor := SMTPMailSetup."User ID";
                  MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
                  PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                  Clear(MailAsunto);
                  Clear(MailCuerpo);
                  CR := 13;
                  LF := 10;
              end;

              if DCActiva then begin
                  if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                  if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
                  MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección");
                  MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
                  Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                  Clear(cduSMTP);
                  cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                  cduSMTP.Send();
                  if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
              end;
              */
    end;

    procedure CrearInspeccionProveedorR(pVendor: Record Vendor)
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        numSerie: Code[20];
        codPlantilla: Code[20];
        NumLin: Integer;
    begin
        /*GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. reclamación");
              GestionCalidadSetup.TestField("Cód. plantilla reclamación pre");

              codPlantilla := GestionCalidadSetup."Cód. plantilla reclamación pre";

              Plantilla.Reset();
              Plantilla.SetRange("No.", codPlantilla);
              Plantilla.SetRange(Bloqueado, false);
              Plantilla.SetRange("Version activa", true);
              Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
              if Plantilla.FindLast() = false then Error(PlanNDisMsg, codPlantilla);

              Clear(numSerie);
              Inspeccion.Init();

              numSerie := GestionCalidadSetup."No. serie insp. reclamación";
              Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Reclamación");
              Inspeccion.Validate("No. de serie", numSerie);
              Inspeccion.Insert(true);

              Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
              Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");
              Inspeccion.Validate("No. proveedor", pVendor."No.");
              Inspeccion.Modify(true);

              Clear(NumLin);
              RecDetallePlantilla.Reset();
              RecDetallePlantilla.SetRange(Bloqueado, false);
              RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
              RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
              if RecDetallePlantilla.FindSet() then begin
                  repeat
                      RecDetalleGrupo.Reset();
                      RecDetalleGrupo.SetRange(Bloqueado, false);
                      RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                      if RecDetalleGrupo.FindSet() then
                          repeat
                              RecLinIns.Init();
                              RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                              RecLinIns.Validate("No. inspección", Inspeccion."No.");
                              RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                              if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                  if Requisitos.Bloqueado = false then begin
                                      if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          ReqEspecificos.Init();
                                          if ReqEspecificos.Get(ReqEspecificos.Tipo::"Reclamación Proveedor", RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                              if ReqEspecificos.Bloqueado = false then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                      end;
                                      if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                          NumLin += 10000;
                                          RecLinIns.Validate("No. línea", NumLin);
                                          RecLinIns.Insert(true);
                                      end;
                                  end;
                          until RecDetalleGrupo.Next() = 0
                      else
                          Message(GrupReqMsg, codPlantilla);
                  until RecDetallePlantilla.Next() = 0;
                  Message(InspRpmMsg, Inspeccion."No.");
              end
              else
                  Message(GrupReqMsg, codPlantilla);

              pVendor.Validate(InspeccionCalidadAGR_BTC, true);
              pVendor.Validate(FechaUltimaReclamacionAGR_BTC, WorkDate());
              pVendor.Modify(true);

              Clear(GestionCalidadSetup);
              GestionCalidadSetup.Get();
              DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
              if DCActiva then begin
                  Clear(SMTPMailSetup);
                  SMTPMailSetup.Get();
                  SMTPMailSetup.TestField("SMTP Server");
                  MailEmisor := SMTPMailSetup."User ID";
                  MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
                  PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                  Clear(MailAsunto);
                  Clear(MailCuerpo);
                  CR := 13;
                  LF := 10;
              end;

              if DCActiva then begin
                  if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                  if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
                  MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección");
                  MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
                  Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                  Clear(cduSMTP);
                  cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                  cduSMTP.Send();
                  if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
              end;
              */
    end;

    procedure CrearInspeccionCliente(var pCustomer: Record Customer)
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        numSerie: Code[20];
        codPlantilla: Code[20];
        NumLin: Integer;
    begin
        /*GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. reclamación");
              GestionCalidadSetup.TestField("Cód. plantilla reclamación pre");

              codPlantilla := GestionCalidadSetup."Cód. plantilla reclamación pre";

              Plantilla.Reset();
              Plantilla.SetRange("No.", codPlantilla);
              Plantilla.SetRange(Bloqueado, false);
              Plantilla.SetRange("Version activa", true);
              Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
              if Plantilla.FindLast() = false then Error(PlanNDisMsg, codPlantilla);

              Clear(numSerie);
              Inspeccion.Init();
              numSerie := GestionCalidadSetup."No. serie insp. reclamación";
              Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::"Reclamación");
              Inspeccion.Validate("No. de serie", numSerie);
              Inspeccion.Insert(true);

              Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
              Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

              Inspeccion.Validate("No. cliente", pCustomer."No.");
              Inspeccion.Modify(true);

              Clear(NumLin);
              RecDetallePlantilla.Reset();
              RecDetallePlantilla.SetRange(Bloqueado, false);
              RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
              RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
              if RecDetallePlantilla.FindSet() then begin
                  repeat
                      RecDetalleGrupo.Reset();
                      RecDetalleGrupo.SetRange(Bloqueado, false);
                      RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                      if RecDetalleGrupo.FindSet() then
                          repeat
                              RecLinIns.Init();
                              RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                              RecLinIns.Validate("No. inspección", Inspeccion."No.");
                              RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                              if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                  if Requisitos.Bloqueado = false then begin
                                      if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          ReqEspecificos.Init();
                                          if ReqEspecificos.Get(ReqEspecificos.Tipo::"Reclamación Proveedor", RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                              if ReqEspecificos.Bloqueado = false then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                      end;
                                      if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                          NumLin += 10000;
                                          RecLinIns.Validate("No. línea", NumLin);
                                          RecLinIns.Insert(true);
                                      end;
                                  end;
                          until RecDetalleGrupo.Next() = 0
                      else
                          Message(GrupReqMsg, codPlantilla);
                  until RecDetallePlantilla.Next() = 0;
                  Message(InspRcmMsg, Inspeccion."No.");
              end
              else
                  Message(GrupReqMsg, codPlantilla);

              pCustomer.Validate(InspeccionCalidadAGR_BTC, true);
              pCustomer.Validate(FechaUltimaReclamacionAGR_BTC, WorkDate());
              pCustomer.Modify(true);

              Clear(GestionCalidadSetup);
              GestionCalidadSetup.Get();
              DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
              if DCActiva then begin
                  Clear(SMTPMailSetup);
                  SMTPMailSetup.Get();
                  SMTPMailSetup.TestField("SMTP Server");
                  MailEmisor := SMTPMailSetup."User ID";
                  MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
                  PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                  Clear(MailAsunto);
                  Clear(MailCuerpo);
                  CR := 13;
                  LF := 10;
              end;

              if DCActiva then begin
                  if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                  if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
                  MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección");
                  MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
                  Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                  Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                  Clear(cduSMTP);
                  cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                  cduSMTP.Send();
                  if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
              end;
              */
    end;

    local procedure CrearInspeccionMuestras(var pInspMuestra: Record "Cab inspe eval_CAL_btc")
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        numSerie: Code[20];
        codPlantilla: Code[20];
        NumLin: Integer;
    begin
        /*pInspMuestra.TestField("No. producto");
              pInspMuestra.TestField("No. proveedor");

              GestionCalidadSetup.Get();
              GestionCalidadSetup.TestField("Activar gestión de la calidad");
              GestionCalidadSetup.TestField("No. serie insp. muestras");
              GestionCalidadSetup.TestField("Cód. plantilla muestras predet");

              pInspMuestra.TestField("Cód. plantilla");
              pInspMuestra.TestField("No. revision plantilla");

              Clear(numSerie);
              Inspeccion.Init();
              numSerie := GestionCalidadSetup."No. serie insp. muestras";
              Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::Muestras);
              Inspeccion.Validate("No. de serie", numSerie);
              Inspeccion.Insert(true);

              Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
              Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
              Inspeccion.Validate(Descripción, Plantilla.Descripcion);
              Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
              Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
              Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
              Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
              Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
              Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");
              Inspeccion.CalcCantidadSugerida();
              Inspeccion.Modify(true);

              Clear(NumLin);
              RecDetallePlantilla.Reset();
              RecDetallePlantilla.SetRange(Bloqueado, false);
              RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
              RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
              if RecDetallePlantilla.FindSet() then begin
                  repeat
                      RecDetalleGrupo.Reset();
                      RecDetalleGrupo.SetRange(Bloqueado, false);
                      RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                      if RecDetalleGrupo.FindSet() then
                          repeat
                              RecLinIns.Init();
                              RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                              RecLinIns.Validate("No. inspección", Inspeccion."No.");
                              RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                              if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                                  if Requisitos.Bloqueado = false then begin
                                      if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          ReqEspecificos.Init();
                                          if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                              if ReqEspecificos.Bloqueado = false then begin
                                                  RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                                  RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                                  RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                                  RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                                  RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                                  RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                                  RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                                  NumLin += 10000;
                                                  RecLinIns.Validate("No. línea", NumLin);
                                                  RecLinIns.Insert(true);
                                              end;
                                      end;
                                      if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                          RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                          RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                          RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                          RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                          RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                          RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                          RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                          NumLin += 10000;
                                          RecLinIns.Validate("No. línea", NumLin);
                                          RecLinIns.Insert(true);
                                      end;
                                  end;
                          until RecDetalleGrupo.Next() = 0
                      else
                          Message(GrupReqMsg, codPlantilla);
                  until RecDetallePlantilla.Next() = 0;
                  Message(InspRecMsg, Inspeccion."No.");
              end
              else
                  Message(GrupReqMsg, codPlantilla);
              */
    end;
    //TODO: Esta función se traspasa a la nueva codeunit 65105
    /*
      procedure CrearNoConformidad(var pInspeccion: Record "Cab inspe eval_CAL_btc")
      var
          LinInspeccion: Record "Lin inspe eval_CAL_btc";
          TmpLinInspeccion: Record "Lin inspe eval_CAL_btc" temporary;
          CabNoConf: Record "Cab no conformidad_CAL_btc";
          LinNoConf: Record "Lin no conformidad_CAL_btc";
          GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
          Vendor: Record Vendor;
          Customer: Record Customer;
          PurchLine: Record "Purchase Line";
          SalesLine: Record "Sales Line";
          ProdRutLine: Record "Prod. Order Routing Line";
          ProdOrdLine: Record "Prod. Order Line";
          InfoLote: Record "Lot No. Information";
          numSerie: Code[20];
          boolCrearNoConf: Boolean;
          numLinea: Integer;
      begin

          if pInspeccion."Estado inspección" = pInspeccion."Estado inspección"::Abierta then
              Error('En Estado Abierta no puede crear una No Conformidad. Se requiere que la Inspección esté Lanzada o Certificada');

          if pInspeccion."Estado inspección" = pInspeccion."Estado inspección"::Terminada then
              Error('En Estado Terminada no puede crear una No Conformidad. Se requiere que la Inspección esté Lanzada o Certificada');

          if pInspeccion."Evaluación Inspección" <> pInspeccion."Evaluación Inspección"::"No Conforme" then
              Error('Inspección con Evaluación Conforme. Se requiere que la Inspección esté Evaluada No Conforme');

          if pInspeccion."No conformidad" = false then begin
              boolCrearNoConf := false;
              Clear(LinInspeccion);
              LinInspeccion.Reset();
              LinInspeccion.SetRange("Origen inspección", pInspeccion."Origen inspección");

              //BEGIN FJAB 3110109 Cambio campos
              //LinInspeccion.SetRange("No. inspección", pInspeccion."No.");

              LinInspeccion.SetRange("Nº doc. Origen calidad", pInspeccion."Nº doc. Origen calidad");
              LinInspeccion.SetRange("Nº lín. doc. Origen calidad", pInspeccion."Nº lín. doc. Origen calidad");
              //END FJAB 311019

              if LinInspeccion.FindSet() then
                  repeat
                      LinInspeccion.Validate(Conformidad, true);
                      if LinInspeccion."Requisito no conforme" = true then
                          if LinInspeccion."Afecta conformidad" = true then LinInspeccion.Validate("No conformidad", true);
                      if LinInspeccion."No conformidad" = true then begin
                          boolCrearNoConf := true;
                          TmpLinInspeccion.Init();
                          TmpLinInspeccion.TransferFields(LinInspeccion);
                          TmpLinInspeccion.Insert(false);
                      end;
                      LinInspeccion.Modify();
                  until LinInspeccion.Next() = 0;
              if boolCrearNoConf = false then Error(InspSinLineasMsg, pInspeccion."No.");
          end;

          pInspeccion.Validate("No conformidad", true);
          if pInspeccion."Estado inspección" = pInspeccion."Estado inspección"::Certificada then
              pInspeccion.Validate("SubEstado inspección", pInspeccion."SubEstado inspección"::Rechazado) else
              pInspeccion.Validate("SubEstado inspección", pInspeccion."SubEstado inspección"::Cuarentena);
          pInspeccion.Modify(true);

          Clear(LinInspeccion);
          LinInspeccion.Reset();
          LinInspeccion.SetRange("Origen inspección", pInspeccion."Origen inspección");

          //BEGIN FJAB 3110109 Cambio campos
          //LinInspeccion.SetRange("No. inspección", pInspeccion."No.");

          LinInspeccion.SetRange("Nº doc. Origen calidad", pInspeccion."Nº doc. Origen calidad");
          LinInspeccion.SetRange("Nº lín. doc. Origen calidad", pInspeccion."Nº lín. doc. Origen calidad");
          //END FJAB 311019

          if LinInspeccion.FindSet() then
              repeat
              until LinInspeccion.Next() = 0
          else
              Message('Atención: Inspección de Calidad sin líneas');

          if pInspeccion."No. No conformidad" <> '' then
              Error('No Conformidad creada con anterioridad');

          Vendor.Init();
          if pInspeccion."No. proveedor" <> '' then
              if Vendor.Get(pInspeccion."No. proveedor") then begin
                  Vendor.Validate(NoConformidadAGR_BTC, true);
                  Vendor.Modify(true);
              end;

          Customer.Init();
          if pInspeccion."No. cliente" <> '' then
              if Customer.Get(pInspeccion."No. cliente") then begin
                  Customer.Validate(NoConformidadAGR_BTC, true);
                  Customer.Modify(true);
              end;

          PurchLine.Init();
          if pInspeccion."Origen inspección" = pInspeccion."Origen inspección"::"Recepción" then
              PurchLine."Document Type" := PurchLine."Document Type"::Order;
          if pInspeccion."Origen inspección" = pInspeccion."Origen inspección"::"Devolución" then
              PurchLine."Document Type" := PurchLine."Document Type"::"Return Order";

          if (pInspeccion."No. pedido proveedor" <> '') and (pInspeccion."No. línea pedido proveedor" <> 0) then
              if PurchLine.Get(PurchLine."Document Type", pInspeccion."No. pedido proveedor", pInspeccion."No. línea pedido proveedor") then begin
                  PurchLine.Validate(NoConformidadCAL_BTC, true);
                  PurchLine.Modify(true);
              end;

          SalesLine.Init();
          if pInspeccion."Origen inspección" = pInspeccion."Origen inspección"::"Envío" then
              PurchLine."Document Type" := PurchLine."Document Type"::Order;
          if pInspeccion."Origen inspección" = pInspeccion."Origen inspección"::"Devolución" then
              PurchLine."Document Type" := PurchLine."Document Type"::"Return Order";

          if (pInspeccion."No. pedido cliente" <> '') and (pInspeccion."No. línea pedido cliente" <> 0) then
              if SalesLine.Get(SalesLine."Document Type", pInspeccion."No. pedido cliente", pInspeccion."No. línea pedido cliente") then begin
                  SalesLine.Validate(NoConformidadCAL_BTC, true);
                  SalesLine.Modify(true);
              end;

          ProdOrdLine.Init();
          if (pInspeccion."No. orden produccion" <> '') and (pInspeccion."No. línea orden producción" <> 0) then
              if ProdOrdLine.Get(ProdOrdLine.Status::Released, pInspeccion."No. orden produccion", pInspeccion."No. línea orden producción") then begin
                  ProdOrdLine.Validate(NoConformidadCAL_BTC, true);
                  ProdOrdLine.Modify(true);
              end;

          ProdRutLine.Init();
          if (pInspeccion."No. orden produccion" <> '') and (pInspeccion."No. línea orden producción" <> 0) then begin
              ProdRutLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
              ProdRutLine.SetRange(Status, ProdRutLine.Status::Released);
              ProdRutLine.SetRange("Prod. Order No.", pInspeccion."No. orden produccion");
              ProdRutLine.SetRange("Routing No.", pInspeccion."No. ruta produccion");
              ProdRutLine.SetRange("Operation No.", pInspeccion."No. operación ruta fabricación");
              if ProdRutLine.FindFirst() then begin
                  ProdOrdLine.Validate(NoConformidadCAL_BTC, true);
                  ProdOrdLine.Modify(true);
              end;
          end;

          InfoLote.Init();
          if pInspeccion."No. lote inspeccionado" <> '' then
              if InfoLote.Get(pInspeccion."No. producto", pInspeccion."Cód. variante", pInspeccion."No. lote inspeccionado") then begin
                  InfoLote.Validate(NoConformidadCAL_BTC, true);
                  if pInspeccion."Estado inspección" = pInspeccion."Estado inspección"::Certificada then
                      InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Rechazado) else
                      InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                  InfoLote.Modify(true);
              end;

          GestionCalidadSetup.Get();
          GestionCalidadSetup.TestField("No. serie no conformidades");

          if pInspeccion."No. No conformidad" = '' then begin
              Clear(numSerie);
              CabNoConf.Init();
              numSerie := GestionCalidadSetup."No. serie no conformidades";
              CabNoConf.TransferFields(pInspeccion);
              CabNoConf.Validate(CabNoConf."No. de serie", numSerie);
              CabNoConf.Insert(true);
              Message(NconForMsg, CabNoConf."No. no conformidad");
          end;

          Clear(numLinea);
          TmpLinInspeccion.Reset();
          if TmpLinInspeccion.FindSet() then
              repeat
                  numLinea += 10000;
                  LinNoConf.Init();
                  LinNoConf."Origen inspección" := CabNoConf."Origen inspección";
                  LinNoConf."No. inspección" := CabNoConf."No. inspección";
                  LinNoConf."No. no conformidad" := CabNoConf."No. no conformidad";
                  LinNoConf."No. línea" := numLinea;

                  LinNoConf."Cod. grupo inspección" := TmpLinInspeccion."Cód. grupo inspección";
                  LinNoConf.Descripción := TmpLinInspeccion.Descripción;
                  LinNoConf."Cód. requisito control" := TmpLinInspeccion."Cód. requisito control";
                  LinNoConf."Descripción requisito" := TmpLinInspeccion."Descripción requisito";
                  LinNoConf."No. línea inspección" := TmpLinInspeccion."No. línea";
                  LinNoConf."Cód. defecto" := TmpLinInspeccion."Cód. defecto";
                  LinNoConf."Descripción defecto" := TmpLinInspeccion."Descripción defecto";
                  LinNoConf."Clase defecto" := TmpLinInspeccion."Clase defecto";
                  LinNoConf."Observaciones defecto" := TmpLinInspeccion."Observaciones defecto";
                  LinNoConf.Insert(true);
              until TmpLinInspeccion.Next() = 0;

          GestionCalidadSetup.Init();
          GestionCalidadSetup.Get();
          DCActiva := GestionCalidadSetup."Activar aviso apertura noconf";
          if DCActiva then begin
              SMTPMailSetup.Init();
              SMTPMailSetup.Get();
              SMTPMailSetup.TestField("SMTP Server");
              MailEmisor := SMTPMailSetup."User ID";
              MailReceptores := GestionCalidadSetup."Receptores Apertura No Confor";
              PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
              Clear(MailAsunto);
              Clear(MailCuerpo);
              CR := 13;
              LF := 10;
          end;

          if DCActiva then begin
              if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
              if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
              Clear(MailAsunto);
              Clear(MailCuerpo);
              MailAsunto := 'Aviso Automático. No Conformidad: ' + Format(CabNoConf."No. no conformidad") + ' Abierta por: ' + Format(UserId()) +
              ' Pendiente de Resolver';
              MailCuerpo := 'No Conformidad: ' + Format(CabNoConf."No. no conformidad") + ' Origen: ' + Format(CabNoConf."Origen inspección") + ' de la Inspección: ' +
              Format(CabNoConf."No. inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
              'Producto: ' + Format(CabNoConf."No. producto") + ' - ' + CabNoConf."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
              'Pendiente de Resolver en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
              Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
              Clear(cduSMTP);
              cduSMTP.CreateMessage('Aviso de Apertura No Conformidad', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
              cduSMTP.Send();
              if PopUp then Message('Correo enviado a los Receptores de Apertura No Conformidad');
          end;
      end;
      */
    procedure CrearInfoLote(var TrackingSpecification: Record "Tracking Specification")
    var
        LotNoInformation: Record "Lot No. Information";
        Item: Record Item;
    begin
        with TrackingSpecification do if not LotNoInformation.Get("Item No.", "Variant Code", "Lot No.") then
                if Item.Get("Item No.") then begin
                    LotNoInformation.Init();
                    LotNoInformation.Validate("Item No.", "Item No.");
                    LotNoInformation.Validate("Variant Code", "Variant Code");
                    LotNoInformation.Validate("Lot No.", "Lot No.");
                    LotNoInformation.Validate(Description, Item.Description);
                    LotNoInformation.Insert(true);
                end;
    end;

    procedure CrearReposicionDevCompra(var Rec: record "Purchase Header")
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if not Confirm(lblConfirmReposicion) then
            exit;

        // vamos a crear la cabecera del pedido de compra en base a la cabecera de dev. compra
        Rec.TestField(No_inspection);
        Rec.TestField(No_no_conformidad);

        PurchaseHeader.Init();
        PurchaseHeader.TransferFields(Rec);
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Order";
        PurchaseHeader.ReturnOrderReposicion := Rec."No.";
        PurchaseHeader.Insert();

        CrearLineasReposicionDevCompra(Rec, PurchaseHeader);

    end;

    procedure CrearLineasReposicionDevCompra(ReturnOrder: record "Purchase Header"; PurchOrder: record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document Type", ReturnOrder."Document Type");
        PurchaseLine.SetRange("Document No.", ReturnOrder."No.");
        if PurchaseLine.findset() then
            repeat
                PurchaseLine2.Init();
                PurchaseLine2."Document Type" := PurchOrder."Document Type";
                PurchaseLine2."Document No." := PurchOrder."No.";
                PurchaseLine2."Line No." := PurchaseLine."Line No.";
                case PurchaseLine.Type of
                    PurchaseLine2.Type::" ":
                        begin
                            PurchaseLine2.Type := PurchaseLine.Type::" ";
                            PurchaseLine2.Description := PurchaseLine.Description;
                        end;
                    else begin
                        PurchaseLine2.Type := PurchaseLine.Type;
                        PurchaseLine2.Validate("No.", PurchaseLine."No.");
                        PurchaseLine2."Location Code" := 'MMPP';
                        PurchaseLine2.Validate(Quantity, PurchaseLine.Quantity);
                    end;
                end;

                PurchaseLine2.Insert();

            Until PurchaseLine.next() = 0;
    end;

    procedure CreateJnlLineAdjustNeg(var ItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemJnlLine: record "Item Journal Line";
    begin
        // Función que a todos los registros seleccionados 
        // Creara el diario de productos con ajuste negativo, con misma cantidad pendiente y coste por unidad.        
        InitItemJnl;
        if ItemLedgerEntry.findset() then
            repeat
                ItemJnlLine.Init();
                InitItemJnlLine(ItemJnlLine);
                ItemJnlLine.validate("Item No.", ItemLedgerEntry."Item No.");
                ItemJnlLine.validate("Variant Code", ItemLedgerEntry."Variant Code");
                ItemJnlLine.validate("Location Code", ItemLedgerEntry."Location Code");
                ItemJnlLine.validate(Quantity, ItemLedgerEntry."Remaining Quantity");
                ItemJnlLine.validate("Applies-to Entry", ItemLedgerEntry."Entry No.");
                ItemJnlLine.Modify();
            Until ItemLedgerEntry.next() = 0;

        if ItemJnlLine.Count > 0 then begin
            Commit();
            ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
            ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
            Page.RunModal(PAGE::"Item Journal", ItemJnlLine);
        end;

    end;

    procedure CreateJnlLineReclasificacion(var ItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemJnlLine: record "Item Journal Line";
        CALSetup: record "Setup Calidad_CAL_btc";
    begin
        // Función que a todos los registros seleccionados 
        // Creara el diario de productos con ajuste negativo, con misma cantidad pendiente y coste por unidad.   
        CALSetup.Get();
        InitItemJnlReclas();
        if ItemLedgerEntry.findset() then
            repeat
                ItemJnlLine.Init();
                InitItemJnlLineReclas(ItemJnlLine);
                ItemJnlLine.validate("Item No.", ItemLedgerEntry."Item No.");
                ItemJnlLine.validate("Variant Code", ItemLedgerEntry."Variant Code");
                ItemJnlLine.validate("Location Code", ItemLedgerEntry."Location Code");
                ItemJnlLine.validate("New Location Code", CALSetup."Location Code Raw");
                ItemJnlLine.validate(Quantity, ItemLedgerEntry."Remaining Quantity");

                ItemJnlLine.validate("Applies-to Entry", ItemLedgerEntry."Entry No.");
                ItemJnlLine.Modify();
            Until ItemLedgerEntry.next() = 0;

        if ItemJnlLine.Count > 0 then begin
            Commit();
            ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
            ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
            Page.RunModal(PAGE::"Item Reclass. Journal", ItemJnlLine);
        end;

    end;

    local procedure InitItemJnl()
    var
        CALSetup: record "Setup Calidad_CAL_btc";
        ItemJnlLine2: record "Item Journal Line";
    begin
        CALSetup.Get();
        CALSetup.TestField("Journal Template No conforme");
        CALSetup.TestField("Journal Batch No conforme");
        ItemJnlLine2.SetRange("Journal Template Name", CALSetup."Journal Template No conforme");
        ItemJnlLine2.SetRange("Journal Batch Name", CALSetup."Journal Batch No conforme");
        ItemJnlLine2.DeleteAll();

    end;

    local procedure InitItemJnlReclas()
    var
        CALSetup: record "Setup Calidad_CAL_btc";
        ItemJnlLine2: record "Item Journal Line";
    begin
        CALSetup.Get();
        CALSetup.TestField("Journal Template Reclas");
        CALSetup.TestField("Journal Batch Reclas");
        ItemJnlLine2.SetRange("Journal Template Name", CALSetup."Journal Template Reclas");
        ItemJnlLine2.SetRange("Journal Batch Name", CALSetup."Journal Batch Reclas");
        ItemJnlLine2.DeleteAll();

    end;

    local procedure InitItemJnlLine(var ItemJnlLine: record "Item Journal Line")
    var
        CALSetup: record "Setup Calidad_CAL_btc";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine2: record "Item Journal Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        CALSetup.Get();
        CALSetup.TestField("Journal Template No conforme");
        CALSetup.TestField("Journal Batch No conforme");

        ItemJnlLine."Journal Template Name" := CALSetup."Journal Template No conforme";
        ItemJnlLine."Journal Batch Name" := CALSetup."Journal Batch No conforme";
        ItemJnlLine2.SetRange("Journal Template Name", CALSetup."Journal Template No conforme");
        ItemJnlLine2.SetRange("Journal Batch Name", CALSetup."Journal Batch No conforme");
        if ItemJnlLine2.FindLast() then
            ItemJnlLine."Line No." := ItemJnlLine2."Line No." + 10000
        else
            ItemJnlLine."Line No." := 10000;
        ItemJnlLine.validate("Posting Date", WorkDate());
        ItemJnlBatch.Get(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
        CLEAR(NoSeriesMgt);
        ItemJnlLine."Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", ItemJnlLine."Posting Date", FALSE);
        ItemJnlLine.validate("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");

        ItemJnlLine.Insert(true);

    end;

    local procedure InitItemJnlLineReclas(var ItemJnlLine: record "Item Journal Line")
    var
        CALSetup: record "Setup Calidad_CAL_btc";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine2: record "Item Journal Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        CALSetup.Get();
        CALSetup.TestField("Journal Template Reclas");
        CALSetup.TestField("Journal Batch Reclas");

        ItemJnlLine."Journal Template Name" := CALSetup."Journal Template Reclas";
        ItemJnlLine."Journal Batch Name" := CALSetup."Journal Batch Reclas";
        ItemJnlLine2.SetRange("Journal Template Name", CALSetup."Journal Template Reclas");
        ItemJnlLine2.SetRange("Journal Batch Name", CALSetup."Journal Batch Reclas");
        if ItemJnlLine2.FindLast() then
            ItemJnlLine."Line No." := ItemJnlLine2."Line No." + 10000
        else
            ItemJnlLine."Line No." := 10000;
        ItemJnlLine.validate("Posting Date", WorkDate());
        ItemJnlBatch.Get(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
        CLEAR(NoSeriesMgt);
        ItemJnlLine."Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", ItemJnlLine."Posting Date", FALSE);
        ItemJnlLine.validate("Entry Type", ItemJnlLine."Entry Type"::Transfer);

        ItemJnlLine.Insert(true);

    end;

    procedure CrearInspeccionProducto(var pItemLedgerEntry: Record "Item Ledger Entry")
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Item: Record Item;
        ConfPlantilla: record "Conf_Plantillas_Calidad";
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        InfoLote: Record "Lot No. Information";
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        InspecciónCalidad_CAL_btc: page "Inspección de Calidad_CAL_btc";
        numSerie: Code[20];
        codPlantilla: Code[20];
        NumLin: Integer;
        Quantity: Decimal;
    begin
        pItemLedgerEntry.FindFirst();
        Quantity := TestItemLedgerEntry(pItemLedgerEntry);
        Item.Get(pItemLedgerEntry."Item No.");
        // if (Item.ActivarGestionCalidadCAL_BTC = false) then
        //     Error('Atención: Producto sin gestión de calidad.');

        GestionCalidadSetup.Get();
        GestionCalidadSetup.TestField("Activar gestión de la calidad");
        GestionCalidadSetup.TestField("No. serie Cab. Inspección");
        ConfPlantilla.Reset();
        ConfPlantilla.SetRange("Origen inspección", ConfPlantilla."Origen inspección"::Producto);
        ConfPlantilla.FindFirst();
        ConfPlantilla.TestField(CodPlantillaInspeccion);

        Clear(numSerie);
        Inspeccion.Init();

        if Item.CodPlantillaAlmacenCAL_BTC <> '' then
            codPlantilla := Item.CodPlantillaAlmacenCAL_BTC
        else
            codPlantilla := ConfPlantilla.CodPlantillaInspeccion;

        numSerie := GestionCalidadSetup."No. serie insp. almacén";

        Plantilla.Reset();
        Plantilla.SetRange("No.", codPlantilla);
        Plantilla.SetRange(Bloqueado, false);
        Plantilla.SetRange("Version activa", true);
        Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
        if Plantilla.FindLast() = false then Error(PlanNDisMsg, codPlantilla);

        Inspeccion.Validate("Origen inspección", Inspeccion."Origen inspección"::Producto);
        Inspeccion.Validate("No. de serie", numSerie);

        Inspeccion.Validate("Cód. plantilla", Plantilla."No.");
        Inspeccion.Validate("No. revision plantilla", Plantilla."No. revisión");
        Inspeccion.Validate(Descripción, Plantilla.Descripcion);
        Inspeccion.Validate("Tipo inspección", Plantilla."Tipo inspección");
        Inspeccion.Validate("Objeto inspección", Plantilla."Objeto inspección");
        Inspeccion.Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
        Inspeccion.Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
        Inspeccion.Validate("% muestra recomendado", Plantilla."% muestra recomendado");
        Inspeccion.Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");

        Inspeccion.Validate("No. producto", pItemLedgerEntry."Item No.");
        Inspeccion.Validate("Cód. variante", pItemLedgerEntry."Variant Code");
        Inspeccion.Validate("Cód. almacén", pItemLedgerEntry."Location Code");
        Inspeccion.Validate("Unidad de medida", pItemLedgerEntry."Unit of Measure Code");

        Inspeccion.Validate("No. lote inspeccionado", pItemLedgerEntry."Lot No.");
        Inspeccion.Validate("No. serie inspeccionado", pItemLedgerEntry."Serial No.");
        Inspeccion.Validate("Fecha caducidad", pItemLedgerEntry."Expiration Date");
        Inspeccion.Validate("Fecha fabricación", pItemLedgerEntry."Warranty Date");
        Inspeccion.Validate("Cantidad Lote", Quantity);
        Inspeccion.Validate("Cantidad Inspeccionada", Quantity);

        // Datos proveedor

        Inspeccion."No. proveedor" := GetVendorInspeccion(Inspeccion);
        Inspeccion.TestField("No. proveedor");

        InfoLote.Init();
        if Inspeccion."No. lote inspeccionado" <> '' then
            if InfoLote.Get(Inspeccion."No. producto", Inspeccion."Cód. variante", Inspeccion."No. lote inspeccionado") then begin
                InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                if InfoLote.EstadoAprobadoPrevioCAL_BTC = true then Inspeccion.Validate(Recontrol, true);
                InfoLote.Modify(true);
            end
            else begin
                InfoLote.Init();
                InfoLote.Validate("Item No.", Inspeccion."No. producto");
                InfoLote.Validate("Variant Code", Inspeccion."Cód. variante");
                InfoLote.Validate("Lot No.", Inspeccion."No. lote inspeccionado");
                InfoLote.Validate(FechaCaducidadCAL_BTC, Inspeccion."Fecha caducidad");
                InfoLote.Validate(FechaFabricacionCAL_BTC, Inspeccion."Fecha fabricación");
                InfoLote.Validate(EstadoControlCalidadCAL_BTC, InfoLote.EstadoControlCalidadCAL_BTC::Cuarentena);
                InfoLote.Insert(true);
            end;

        Inspeccion.CalcCantidadSugerida();

        Inspeccion.Insert(true);


        Clear(NumLin);
        RecDetallePlantilla.Reset();
        RecDetallePlantilla.SetRange(Bloqueado, false);
        RecDetallePlantilla.SetRange("Cód. plantilla", Inspeccion."Cód. plantilla");
        RecDetallePlantilla.SetRange("No. revision plantilla", Inspeccion."No. revision plantilla");
        if RecDetallePlantilla.FindSet() then begin
            repeat
                RecDetalleGrupo.Reset();
                RecDetalleGrupo.SetRange(Bloqueado, false);
                RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                if RecDetalleGrupo.FindSet() then
                    repeat
                        RecLinIns.Init();
                        RecLinIns.Validate("Origen inspección", Inspeccion."Origen inspección");
                        RecLinIns.Validate("No. inspección", Inspeccion."No.");
                        RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                        if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                            if Requisitos.Bloqueado = false then begin
                                if Inspeccion."Tipo de Requisitos Específicos" = Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                    ReqEspecificos.Init();
                                    if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, RecDetalleGrupo."Cod. requisito control", Inspeccion."No. producto", Inspeccion."Cód. variante") then
                                        if ReqEspecificos.Bloqueado = false then begin
                                            RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                            RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                            RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                            RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                            RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                            RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                            RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                            NumLin += 10000;
                                            RecLinIns.Validate("No. línea", NumLin);
                                            RecLinIns.Insert(true);
                                        end;
                                end;
                                if Inspeccion."Tipo de Requisitos Específicos" <> Inspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                    RecLinIns.Validate("No. producto", Inspeccion."No. producto");
                                    RecLinIns.Validate("Cód. variante", Inspeccion."Cód. variante");
                                    RecLinIns.Validate("No. proveedor", Inspeccion."No. proveedor");
                                    RecLinIns.Validate("No. cliente", Inspeccion."No. cliente");
                                    RecLinIns.Validate("Cód. tarea", Inspeccion."Cód. tarea");
                                    RecLinIns.Validate("Tipo de Requisitos Específicos", Inspeccion."Tipo de Requisitos Específicos");
                                    RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                    NumLin += 10000;
                                    RecLinIns.Validate("No. línea", NumLin);
                                    RecLinIns.Insert(true);
                                end;
                            end;
                    until RecDetalleGrupo.Next() = 0
                else
                    Message(GrupReqMsg, codPlantilla);
            until RecDetallePlantilla.Next() = 0;
            // Message(InspAlmMsg, Inspeccion."No.");
            // indicamos que se ha creado y si se quiere abrir
            // al final de la funcion

        end
        else
            Message(GrupReqMsg, codPlantilla);

        UpdateNoInspeccionItemLedgerEntry(pItemLedgerEntry, Inspeccion."No.");
        Commit();

        Clear(GestionCalidadSetup);
        GestionCalidadSetup.Get();
        DCActiva := GestionCalidadSetup."Activar aviso apertura inspecc";
        if DCActiva then begin
            SMTPMailSetup.Init();
            SMTPMailSetup.Get();
            SMTPMailSetup.TestField("SMTP Server");
            MailEmisor := SMTPMailSetup."User ID";
            MailReceptores := GestionCalidadSetup."Receptores Apertura Inspeccion";
            PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
            Clear(MailAsunto);
            Clear(MailCuerpo);
            CR := 13;
            LF := 10;
        end;

        if DCActiva then begin
            if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
            if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la apertura de inspección');
            MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección");
            MailCuerpo := 'Inspección de Calidad: ' + Format(Inspeccion."No.") + ' Origen: ' + Format(Inspeccion."Origen inspección") + ' en Estado Abierta y SubEstado: ' +
            Format(Inspeccion."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
            'Producto: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
            'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
            Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
            Clear(cduSMTP);
            cduSMTP.CreateMessage('Aviso de Apertura Inspección', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
            cduSMTP.Send();
            if PopUp then Message('Correo enviado a los Receptores de Apertura Inspección');
        end;
        if Confirm(InspAlmMsg + InspAlmMsg2, false, Inspeccion."No.") then begin
            page.RunModal(page::"Inspección de Calidad_CAL_btc", Inspeccion);
        end;

    end;

    local procedure TestItemLedgerEntry(var ItemLedgerEntry: record "Item Ledger Entry"): Decimal
    var
        ItemNo: code[20];
        LocationCode: code[20];
        lblError: Label 'El %1 debe ser el mismo en todos los %2', comment = 'ESP="El %1 debe ser el mismo en todos los %2"';
    begin
        if ItemLedgerEntry.findset() then
            repeat
                ItemLedgerEntry.TestField("No. Inpección", '');
                if ItemNo = '' then
                    ItemNo := ItemLedgerEntry."Item No.";
                if ItemNo <> ItemLedgerEntry."Item No." then
                    Error(lblError, ItemLedgerEntry.FieldCaption(ItemLedgerEntry."Item No."), ItemLedgerEntry.TableCaption);
                if LocationCode = '' then
                    LocationCode := ItemLedgerEntry."Item No.";
                if LocationCode <> ItemLedgerEntry."Item No." then
                    Error(lblError, ItemLedgerEntry.FieldCaption(ItemLedgerEntry."Location Code"), ItemLedgerEntry.TableCaption);
            Until ItemLedgerEntry.next() = 0;

        ItemLedgerEntry.CalcSums("Remaining Quantity");
        exit(ItemLedgerEntry."Remaining Quantity");
    end;

    local procedure UpdateNoInspeccionItemLedgerEntry(var ItemLedgerEntry: record "Item Ledger Entry"; NoInspeccion: code[20])
    begin
        if ItemLedgerEntry.findset() then
            repeat
                ItemLedgerEntry."No. Inpección" := NoInspeccion;
                ItemLedgerEntry.Modify();
            Until ItemLedgerEntry.next() = 0;
    end;

    local procedure GetVendorInspeccion(Inspeccion: record "Cab inspe eval_CAL_btc"): Code[20]
    var
        Item: record Item;
        DatosInspeccion: page "datos Inspecion";
    begin
        Item.get(Inspeccion."No. producto");
        DatosInspeccion.SetVendor(Item."Vendor No.");
        if DatosInspeccion.RunModal() = Action::OK then
            exit(DatosInspeccion.GetVendor())
        else
            Error('Cancelado usuario');
    end;
}
