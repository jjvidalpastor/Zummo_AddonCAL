codeunit 65100 "Cab Inspec Status Mgt_CAL_btc"
{
    Permissions = TableData "Item Ledger Entry" = rm, TableData "Source Code Setup" = r, TableData "Production Order" = rimd, TableData "Prod. Order Capacity Need" = rid, TableData "Inventory Adjmt. Entry (Order)" = rim;
    TableNo = "Cab inspe eval_CAL_btc";

    trigger OnRun()
    var
        ChangeStatusForm: Page ChangStOnCabInsp_CAL_btc;
        OldStatus: Option Abierta,Lanzada,Certificada,Terminada;
        RequisitosErr: Label 'Debe rellenar el campo Resultado condición, para las líneas que afectan a conformidad.', Comment = 'ESP="Debe rellenar el campo Resultado condición, para las líneas que afectan a conformidad."';
    begin
        ValidacionRequisitos(Rec);
        OldStatus := "Estado inspección";
        Commit();
        ChangeStatusForm.Set(Rec);
        if ChangeStatusForm.RunModal() = ACTION::Yes then begin
            ChangeStatusForm.ReturnPostingInfo(NewStatus, NewPostingDate);
            ChangeStatusOnProdOrder(Rec, NewStatus, NewPostingDate);
            Commit();
            Message(Text000Msg, OldStatus, TableCaption(), "No.", NewStatus, TableCaption(), "No.");
        end;
    end;

    var
        ToProdOrder: Record "Production Order";
        RecLins: Record "Lin inspe eval_CAL_btc";
        TipoMtoDiario: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        InfoLote: Record "Lot No. Information";
        MovProducto: Record "Item Ledger Entry";
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        SMTPMailSetup: Record "SMTP Mail Setup";
        cduSMTP: Codeunit "SMTP Mail";
        NewStatus: Option Abierta,Lanzada,Certificada,Terminada;
        Text000Msg: Label '%2 %3  with status %1 has been changed to %5 %6 with status %4.', Comment = 'ESP="%2 %3 con estado %1 ha sido cambiada a %5 %6 con estado %4."';
        NewPostingDate: Date;
        boolCrearNoConf: Boolean;
        InspConLineasErr: Label 'Inspección de Calidad %1 con requisitos No Conformes. Antes de certificar debe proceder a revisar los requisitos no conformes y/o crear una No Conformidad.';
        MailEmisor: Text[50];
        MailReceptores: Text[150];
        MailAsunto: Text[300];
        MailCuerpo: Text[600];
        DCActiva: Boolean;
        InsNoConfoEvaluarConfErr: Label 'Inspección de Calidad %1 con requisitos No Conformes y Evaluación Conforme. Antes de certificar debe proceder a revisar los requisitos no conformes y/o eliminar la No Conformidad.';
        InsConforEvaluarNoConfErr: Label 'Inspección de Calidad %1 con requisitos Conformes (o No Conformes pero sin afectación a Conformidad) y Evaluación No Conforme. Antes de certificar debe proceder a revisar líneas conformes y/o crear una No Conformidad.';
        boolContaDefect: Boolean;
        ContaPuntos: Decimal;
        CR: Char;
        LF: Char;
        ConDefectos: Text[50];
        PopUp: Boolean;
        gCambioPorPDA: Boolean;
        ContaRequPdtes: Integer;
        ContaAceptables: Integer;
        ContaNoAceptables: Integer;
        ReqCriticosNoRespon: Integer;
        ContaRequisitos: Integer;
        ContaDefectoA: Integer;
        ContaDefectoB: Integer;
        ContaDefectoC: Integer;
        InsConLineasPdtesEvaluarMsg: Label 'Aviso: Inspección de Calidad %1 con %2 requisitos pendientes de Evaluar.';
        InsConTodasPdtesEvaluarMsg: Label 'Aviso: Inspección de Calidad %1 con todas los requisitos pendientes de Evaluar.';
        InsConReqCriticosNoRespErr: Label 'Inspección de Calidad %1 con %2 requisitos críticos pendientes de Evaluar.';
        ItemLedgerEntry: Record "Item Ledger Entry";
        GenereacionInspAut: Codeunit GeneracionInspAut;
        ParWAL: Record "Warehouse Activity Line" temporary;

    procedure ChangeStatusOnProdOrder(var ProdOrder: Record "Cab inspe eval_CAL_btc";
    NewStatus: Option Abierta,Lanzada,Certificada,Terminada;
    NewPostingDate: Date)
    var
        Inspeccion: Record "Cab inspe eval_CAL_btc";
        OrdProd: Record "Production Order";
        ProductOrderLine: Record "Prod. Order Line";
    begin
        //S20/00403
        if (ProdOrder."Estado inspección" = ProdOrder."Estado inspección"::Abierta) and (NewStatus <> NewStatus::Lanzada) then Error('Estado Abierta sólo puede cambiar a Lanzada');
        if (ProdOrder."Estado inspección" = ProdOrder."Estado inspección"::Lanzada) and (NewStatus = NewStatus::Terminada) then Error('Estado Lanzada sólo puede cambiar a Abierta o Certificada');
        //if (ProdOrder."Estado inspección" = ProdOrder."Estado inspección"::Certificada) and (NewStatus <> NewStatus::Terminada) then
        //  Error('Estado Confirmada sólo puede cambiar a Terminada');
        if (ProdOrder."Estado inspección" = ProdOrder."Estado inspección"::Certificada) and not (NewStatus = NewStatus::Terminada) then exit;
        //FIN S20/00403
        GestionCalidadSetup.Init();
        GestionCalidadSetup.Get();
        DCActiva := GestionCalidadSetup."Activar doble confirmacion";
        if DCActiva then begin
            SMTPMailSetup.Init();
            SMTPMailSetup.Get();
            SMTPMailSetup.TestField("SMTP Server");
            MailEmisor := SMTPMailSetup."User ID";
            MailReceptores := GestionCalidadSetup."Receptores DC Calidad";
            /*if ProdOrder."Origen inspección" = ProdOrder."Origen inspección"::"Mat.Gráfico" then
                      MailReceptores := GestionCalidadSetup."Receptores DC Mat.Graph";*/
            PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
            Clear(MailAsunto);
            Clear(MailCuerpo);
            CR := 13;
            LF := 10;
        end;
        if (NewStatus = NewStatus::Abierta) then begin
            ProdOrder.Validate(Conformidad, false);
            ProdOrder.Validate("No conformidad", false);
        end;
        /*
            if (NewStatus = NewStatus::Lanzada) or (NewStatus = NewStatus::Certificada) or (NewStatus = NewStatus::Terminada) then
                if ProdOrder."Origen inspección" = ProdOrder."Origen inspección"::"Fabricación" then
                    if ProdOrder."No. orden produccion" <> '' then begin
                        OrdProd.Reset();
                        OrdProd.SetCurrentKey("No.", Status);
                        OrdProd.SetRange("No.", ProdOrder."No. orden produccion");
                        if OrdProd.FindFirst() then
                            if ProductOrderLine.Get(OrdProd.Status, OrdProd."No.", 10000) then
                                ProdOrder."Cantidad Lote" := ProductOrderLine."Finished Quantity";
                    end;
            */
        if (NewStatus = NewStatus::Lanzada) or (NewStatus = NewStatus::Certificada) then if (ProdOrder."Evaluación Inspección" = ProdOrder."Evaluación Inspección"::" ") then Error('Inspección pendiente de Evaluar');
        if (NewStatus = NewStatus::Lanzada) or (NewStatus = NewStatus::Certificada) then if (ProdOrder."Cantidad Inspeccionada" = 0) then Error('Inspección sin Cantidad Inspeccionada');
        if (NewStatus = NewStatus::Lanzada) or (NewStatus = NewStatus::Certificada) then begin
            boolCrearNoConf := false;
            boolContaDefect := false;
            ContaDefectoA := 0;
            ContaDefectoB := 0;
            ContaDefectoC := 0;
            ContaPuntos := 0;
            ContaRequPdtes := 0;
            ContaAceptables := 0;
            ContaNoAceptables := 0;
            ContaRequisitos := 0;
            ReqCriticosNoRespon := 0;
            Clear(RecLins);
            RecLins.Reset();
            //RecLins.SetCurrentKey("Origen inspección", "No. inspección", "No. línea");
            //RecLins.SetRange("Origen inspección", ProdOrder."Origen inspección");
            RecLins.SetRange("No. inspección", ProdOrder."No.");
            if RecLins.FindSet() then
                repeat
                    ContaPuntos := ContaPuntos + RecLins.Puntos;
                    if RecLins.Defecto = true then begin
                        boolContaDefect := true;
                        if RecLins."Clase defecto" = RecLins."Clase defecto"::A then ContaDefectoA := ContaDefectoA + 1;
                        if RecLins."Clase defecto" = RecLins."Clase defecto"::B then ContaDefectoB := ContaDefectoB + 1;
                        if RecLins."Clase defecto" = RecLins."Clase defecto"::C then ContaDefectoC := ContaDefectoC + 1;
                    end;
                    RecLins.Validate(Conformidad, true);
                    if RecLins."Requisito no conforme" = true then if RecLins."Afecta conformidad" = true then RecLins.Validate("No conformidad", true);
                    if RecLins."No conformidad" = true then boolCrearNoConf := true;
                    if RecLins.Aptitud = RecLins.Aptitud::" " then ContaRequPdtes := ContaRequPdtes + 1;
                    if RecLins.Aptitud = RecLins.Aptitud::Aceptable then ContaAceptables := ContaAceptables + 1;
                    if RecLins.Aptitud = RecLins.Aptitud::"No Aceptable" then ContaNoAceptables := ContaNoAceptables + 1;
                    if (RecLins."Requisito crítico" = true) and (RecLins.Aptitud = RecLins.Aptitud::" ") then ReqCriticosNoRespon := ReqCriticosNoRespon + 1;
                    ContaRequisitos := ContaRequisitos + 1;
                until RecLins.Next() = 0;
            ProdOrder."Puntos totales" := ContaPuntos;
            ProdOrder.Defectos := boolContaDefect;
            ProdOrder."Defectos clase A" := ContaDefectoA;
            ProdOrder."Defectos clase B" := ContaDefectoB;
            ProdOrder."Defectos clase C" := ContaDefectoC;
            ProdOrder."Requisitos pendientes evaluar" := ContaRequPdtes;
            ProdOrder."Requisitos aceptables" := ContaAceptables;
            ProdOrder."Requisitos no aceptables" := ContaNoAceptables;
            ProdOrder."Requisitos totales" := ContaRequisitos;
            if ReqCriticosNoRespon > 0 then Error(InsConReqCriticosNoRespErr, ProdOrder."No.", ReqCriticosNoRespon);
            /*if ReqCriticosNoRespon = 0 then
                      if ContaRequPdtes > 0 then
                          if ContaRequPdtes <> ContaRequisitos then Message(InsConLineasPdtesEvaluarMsg, ProdOrder."No.", ProdOrder."Requisitos pendientes evaluar");

                  if ReqCriticosNoRespon = 0 then
                      if ContaRequPdtes > 0 then
                          if ContaRequPdtes = ContaRequisitos then begin
                              if (NewStatus = NewStatus::Certificada) then Error(InsConTodasPdtesEvaluarMsg, ProdOrder."No.");
                              if (NewStatus = NewStatus::Lanzada) then Message(InsConTodasPdtesEvaluarMsg, ProdOrder."No.");
                          end;*/
            if (boolCrearNoConf = true) and (ProdOrder."No conformidad" = false) then begin
                ProdOrder.Validate(Conformidad, false);
                if (NewStatus = NewStatus::Certificada) then Error(InspConLineasErr, ProdOrder."No.");
                //if (NewStatus = NewStatus::Lanzada) then Message(InspConLineasErr, ProdOrder."No.");
            end;
            if (boolCrearNoConf = false) and (ProdOrder."No conformidad" = true) then ProdOrder.Validate(Conformidad, true);
            if (boolCrearNoConf = false) and (ProdOrder.Conformidad = false) then ProdOrder.Validate(Conformidad, true);
            if (ProdOrder."No conformidad" = true) and (ProdOrder."Evaluación Inspección" <> ProdOrder."Evaluación Inspección"::"No Conforme") then begin
                if (NewStatus = NewStatus::Certificada) then Error(InsNoConfoEvaluarConfErr, ProdOrder."No.");
                //if (NewStatus = NewStatus::Lanzada) then Message(InsNoConfoEvaluarConfErr, ProdOrder."No.");
            end;
            if (ProdOrder.Conformidad = true) and (ProdOrder."Evaluación Inspección" <> ProdOrder."Evaluación Inspección"::Conforme) then begin
                if (NewStatus = NewStatus::Certificada) then Error(InsConforEvaluarNoConfErr, ProdOrder."No.");
                //if (NewStatus = NewStatus::Lanzada) then Message(InsConforEvaluarNoConfErr, ProdOrder."No.");
            end;
        end;
        if NewStatus = NewStatus::Lanzada then begin
            if ProdOrder."No conformidad" = false then
                ProdOrder.Validate("SubEstado inspección", ProdOrder."SubEstado inspección"::Cuarentena)
            else
                ProdOrder.Validate("SubEstado inspección", ProdOrder."SubEstado inspección"::Cuarentena);
            //Message('Aviso. Mientras la inspección no se certifique el lote permanecerá en cuarentena');
        end;
        if NewStatus = NewStatus::Certificada then begin
            if not gCambioPorPDA then ControlUsuarioCertificada(UserId(), ProdOrder);
            if ProdOrder."No conformidad" = false then
                ProdOrder.Validate("SubEstado inspección", ProdOrder."SubEstado inspección"::Aprobado)
            else
                ProdOrder.Validate("SubEstado inspección", ProdOrder."SubEstado inspección"::Rechazado);
            if (ProdOrder."SubEstado inspección" = ProdOrder."SubEstado inspección"::Aprobado) and (ProdOrder.Recontrol = true) then ProdOrder.Validate("SubEstado inspección", ProdOrder."SubEstado inspección"::Recontrolado);
            if (ProdOrder."SubEstado inspección" = ProdOrder."SubEstado inspección"::Recontrolado) and (ProdOrder."Nueva fecha caducidad" = 0D) then Error('En los recontroles es obligatorio indicar la nueva fecha de caducidad');
            if not gCambioPorPDA then ControlFechaCaducidad(UserId(), ProdOrder);
        end;
        if NewStatus = NewStatus::Terminada then begin
            //
            IF ProdOrder."Evaluación Inspección" = ProdOrder."Evaluación Inspección"::Conforme then begin
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Entry No.", ProdOrder.EntryNo);
                if ItemLedgerEntry.FindFirst() then begin
                    ParWAL."Location Code" := ItemLedgerEntry."Location Code";
                    ParWAL."Item No." := ItemLedgerEntry."Item No.";
                    ParWAL."Serial No." := ItemLedgerEntry."Serial No.";
                    ParWAL."Lot No." := ItemLedgerEntry."Lot No.";
                    ParWAL."Bin Code" := ItemLedgerEntry."Location Code";
                    GenereacionInspAut.DiarioReclasificacion(TipoMtoDiario::Transfer, TODAY(), ParWAL, ABS(ItemLedgerEntry.Quantity), '', '', ProdOrder."Cód. almacén", ProdOrder."Cód. ubicación", '', ItemLedgerEntry."Entry No.", TRUE);
                end;
            END;
            //Error('PARADO');
        end;
        /*if (NewStatus = NewStatus::Lanzada) and (DCActiva = true) then begin
                if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la doble confirmación');
                if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la doble confirmación');
                if ProdOrder."Origen inspección" = ProdOrder."Origen inspección"::"Fabricación" then
                    MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(ProdOrder."No.") + ' Lanzada por: ' + Format(UserId()) +
                    ' Pendiente de Certificar' + ' Prioridad: ' + Format(ProdOrder.Prioridad);
                if ProdOrder."Origen inspección" <> ProdOrder."Origen inspección"::"Fabricación" then
                    MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(ProdOrder."No.") + ' Lanzada por: ' + Format(UserId()) +
                    ' Pendiente de Certificar';
                MailCuerpo := 'Inspección de Calidad: ' + Format(ProdOrder."No.") + ' Origen: ' + Format(ProdOrder."Origen inspección") + ' en Estado Lanzada y SubEstado: ' +
                Format(ProdOrder."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                'Producto: ' + Format(ProdOrder."No. producto") + ' - ' + ProdOrder."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                'Pendiente de Certificar (doble confirmación) en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de dobles confirmaciones';
                Clear(cduSMTP);
                cduSMTP.CreateMessage('Doble Confirmación', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                cduSMTP.Send();
                if PopUp then Message('Correo enviado a los Certificadores');
            end;*/
        ProdOrder.Validate("Estado inspección", NewStatus);
        ProdOrder.Modify(true);
        if NewStatus = NewStatus::Certificada then begin
            InfoLote.Init();
            if ProdOrder."No. lote inspeccionado" <> '' then
                if InfoLote.Get(ProdOrder."No. producto", ProdOrder."Cód. variante", ProdOrder."No. lote inspeccionado") then begin
                    if (ProdOrder."Evaluación Inspección" = ProdOrder."Evaluación Inspección"::Conforme) then begin
                        //if (InfoLote."Test Quality" = InfoLote."Test Quality"::"4") then
                        //    Error('Atención: Está dando conformidad a un lote con control visual negativo. Consulte a su supervisor');
                        if InfoLote.EstadoRevisionVisualCAL_BTC = InfoLote.EstadoRevisionVisualCAL_BTC::Pendiente then Error('Atención: Está dando conformidad a un lote con control visual pendiente. Consulte a su supervisor');
                        if InfoLote.EstadoRevisionVisualCAL_BTC = InfoLote.EstadoRevisionVisualCAL_BTC::Visado then Error('Atención: Está dando conformidad a un lote con control visual sin revisar. Consulte a su supervisor');
                    end;
                    InfoLote.Validate(NoConformidadCAL_BTC, ProdOrder."No conformidad");
                    InfoLote.EstadoControlCalidadCAL_BTC := ProdOrder."SubEstado inspección";
                    InfoLote.Validate(EstadoControlCalidadCAL_BTC);
                    if (ProdOrder."SubEstado inspección" = ProdOrder."SubEstado inspección"::Recontrolado) and (ProdOrder."Nueva fecha caducidad" <> 0D) then InfoLote.Validate(FechaCaducidadCAL_BTC, ProdOrder."Nueva fecha caducidad");
                    InfoLote.Modify(true);
                end;
        end;
        if NewStatus = NewStatus::Certificada then
            if (ProdOrder."SubEstado inspección" = ProdOrder."SubEstado inspección"::Recontrolado) and (ProdOrder."Nueva fecha caducidad" <> 0D) then begin
                MovProducto.Reset();
                MovProducto.SetCurrentKey("Item No.", "Variant Code", "Lot No.", "Serial No.");
                MovProducto.SetRange("Item No.", ProdOrder."No. producto");
                MovProducto.SetRange("Variant Code", ProdOrder."Cód. variante");
                MovProducto.SetRange("Serial No.", ProdOrder."No. serie inspeccionado");
                MovProducto.SetRange("Lot No.", ProdOrder."No. lote inspeccionado");
                MovProducto.SetRange(Open, true);
                if MovProducto.FindSet() then MovProducto.ModifyAll("Expiration Date", ProdOrder."Nueva fecha caducidad");
            end;
        Clear(RecLins);
        RecLins.Reset();
        //RecLins.SetRange("Origen inspección", ProdOrder."Origen inspección");
        RecLins.SetRange("No. inspección", ProdOrder."No.");
        if RecLins.FindSet() then
            repeat
                RecLins.Validate("Estado inspección", NewStatus);
                RecLins.Modify(true);
            until RecLins.Next() = 0
        else
            Message('Atención: Inspección de Calidad sin líneas');
        Inspeccion := ProdOrder;
        Clear(DCActiva);
        if NewStatus = NewStatus::Certificada then
            if Inspeccion.Conformidad then /*if Inspeccion."Origen inspección" = Inspeccion."Origen inspección"::"Recepción" then begin
                    Clear(GestionCalidadSetup);
                    GestionCalidadSetup.Get();
                    DCActiva := GestionCalidadSetup."Activar aviso cert. insp. rec.";
                    if DCActiva then begin
                        Clear(SMTPMailSetup);
                        SMTPMailSetup.Get();
                        SMTPMailSetup.TestField("SMTP Server");
                        MailEmisor := SMTPMailSetup."User ID";
                        MailReceptores := GestionCalidadSetup."Receptores Cert. Insp. Recep.";
                        PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                        Clear(MailAsunto);
                        Clear(MailCuerpo);
                        Clear(ConDefectos);
                        if ProdOrder.Defectos = true then ConDefectos := 'Lote Liberado con Defectos Leves: ' else ConDefectos := 'Lote Liberado: ';
                        CR := 13;
                        LF := 10;
                    end;

                    if DCActiva then begin
                        if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                        if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de los certificados de inspección recepción');
                        MailAsunto := 'Aviso Automático. Certificación de Inspección Materia Prima/Acond. Primario: ' + Format(Inspeccion."No. producto") + ' - ' +
                        Inspeccion."Descripción producto" + ' - ' + ConDefectos + Format(Inspeccion."No. lote inspeccionado");
                        MailCuerpo := 'Certificación de Inspección Materia Prima/Acond. Primario: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') +
                        Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Origen: ' + Format(Inspeccion."Origen inspección") + ' - Proveedor: ' +
                        Inspeccion."Descripción proveedor" + ' - Nº Pedido: ' + Format(Inspeccion."No. pedido proveedor") + ' por: ' + Format(UserId()) +
                        Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                        ConDefectos + Format(Inspeccion."No. lote inspeccionado") + ' - Cantidad: ' + Format(Inspeccion."Cantidad Lote") + ' ' + Format(Inspeccion."Unidad de medida") +
                        ' - Fecha caducidad: ' + Format(Inspeccion."Fecha caducidad") + ' - Fecha fabricación: ' + Format(Inspeccion."Fecha fabricación") +
                        Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                        Clear(cduSMTP);
                        cduSMTP.CreateMessage('Aviso de Certificación de Inspección Materia Prima/Acond. Primario', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                        cduSMTP.Send();
                        if PopUp then Message('Correo enviado a los Receptores de Certificación de Inspección de Productos Recibidos');
                    end;
                end;*/
        Clear(DCActiva);
        if NewStatus = NewStatus::Certificada then
            if Inspeccion.Conformidad then /*if Inspeccion."Origen inspección" = Inspeccion."Origen inspección"::"Fabricación" then begin
                    Clear(GestionCalidadSetup);
                    GestionCalidadSetup.Get();
                    DCActiva := GestionCalidadSetup."Activar aviso cert. insp. fab.";
                    if DCActiva then begin
                        Clear(SMTPMailSetup);
                        SMTPMailSetup.Get();
                        SMTPMailSetup.TestField("SMTP Server");
                        MailEmisor := SMTPMailSetup."User ID";
                        MailReceptores := GestionCalidadSetup."Receptores Cert. Insp. Fabrica";
                        PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                        Clear(MailAsunto);
                        Clear(MailCuerpo);
                        Clear(ConDefectos);
                        if ProdOrder.Defectos = true then ConDefectos := 'Lote Liberado con Defectos Leves: ' else ConDefectos := 'Lote Liberado: ';
                        CR := 13;
                        LF := 10;
                    end;

                    if DCActiva then begin
                        if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                        if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de los certificados de inspección fabricados');
                        MailAsunto := 'Aviso Automático. Certificación de Inspección Producto Fabricado: ' + Format(Inspeccion."No. producto") + ' - ' +
                        Inspeccion."Descripción producto" + ' - ' + ConDefectos + Format(Inspeccion."No. lote inspeccionado") + ' Prioridad: ' + Format(ProdOrder.Prioridad);
                        MailCuerpo := 'Certificación de Inspección Producto Fabricado: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') +
                        Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Origen: ' + Format(Inspeccion."Origen inspección") +
                        ' - Nº Orden Producción: ' + Format(Inspeccion."No. orden produccion") + ' Prioridad: ' + Format(ProdOrder.Prioridad) + ' por: ' + Format(UserId()) +
                        Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                        ConDefectos + Format(Inspeccion."No. lote inspeccionado") + ' - Cantidad: ' + Format(Inspeccion."Cantidad Lote") + ' ' + Format(Inspeccion."Unidad de medida") +
                        ' - Fecha caducidad: ' + Format(Inspeccion."Fecha caducidad") + ' - Fecha fabricación: ' + Format(Inspeccion."Fecha fabricación") +
                        Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                        Clear(cduSMTP);
                        cduSMTP.CreateMessage('Aviso de Certificación de Inspección Fabricados', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                        cduSMTP.Send();
                        if PopUp then Message('Correo enviado a los Receptores de Certificación de Inspección de Productos Fabricados');
                    end;
                end;*/
        Clear(DCActiva);
        /*if NewStatus = NewStatus::Certificada then
                  if Inspeccion.Conformidad then
                      if Inspeccion."Origen inspección" = Inspeccion."Origen inspección"::"Mat.Gráfico" then begin
                          Clear(GestionCalidadSetup);
                          GestionCalidadSetup.Get();
                          DCActiva := GestionCalidadSetup."Activar aviso cert. insp. grap";
                          if DCActiva then begin
                              Clear(SMTPMailSetup);
                              SMTPMailSetup.Get();
                              SMTPMailSetup.TestField("SMTP Server");
                              MailEmisor := SMTPMailSetup."User ID";
                              MailReceptores := GestionCalidadSetup."Receptores Cert. Insp. Mat.Gra";
                              PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
                              Clear(MailAsunto);
                              Clear(MailCuerpo);
                              Clear(ConDefectos);
                              if ProdOrder.Defectos = true then ConDefectos := 'Lote Liberado con Defectos Leves: ' else ConDefectos := 'Lote Liberado: ';
                              CR := 13;
                              LF := 10;
                          end;

                          if DCActiva then begin
                              if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la gestión de avisos');
                              if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de los certificados de inspección mat.gráfico');
                              MailAsunto := 'Aviso Automático. Certificación de Inspección Material Gráfico: ' + Format(Inspeccion."No. producto") + ' - ' +
                              Inspeccion."Descripción producto" + ' - ' + ConDefectos + Format(Inspeccion."No. lote inspeccionado");
                              MailCuerpo := 'Certificación de Inspección Material Gráfico: ' + Format(Inspeccion."No. producto") + ' - ' + Inspeccion."Descripción producto" + Format(CR, 0, '<CHAR>') +
                              Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Origen: ' + Format(Inspeccion."Origen inspección") + ' - Proveedor: ' +
                              Inspeccion."Descripción proveedor" + ' - Nº Pedido: ' + Format(Inspeccion."No. pedido proveedor") + ' por: ' + Format(UserId()) +
                              Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') +
                              ConDefectos + Format(Inspeccion."No. lote inspeccionado") + ' - Cantidad: ' + Format(Inspeccion."Cantidad Lote") + ' ' + Format(Inspeccion."Unidad de medida") +
                              ' - Fecha caducidad: ' + Format(Inspeccion."Fecha caducidad") + ' - Fecha fabricación: ' + Format(Inspeccion."Fecha fabricación") +
                              Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de avisos';
                              Clear(cduSMTP);
                              cduSMTP.CreateMessage('Aviso de Certificación de Inspección Material Gráfico', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                              cduSMTP.Send();
                              if PopUp then Message('Correo enviado a los Receptores de Certificación de Inspección de Material Gráfico');
                          end;
                      end;*/
    end;

    procedure CambioPorPDA()
    begin
        gCambioPorPDA := true;
    end;

    procedure ControlUsuarioCertificada(CodUsuario: Code[50];
    ProdOrder: Record "Cab inspe eval_CAL_btc"): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        GestionCalidadSetup.Get();
        if not GestionCalidadSetup."Activar doble confirmacion" then exit(true);
        UserSetup.Init();
        if not UserSetup.Get(CodUsuario) then Error('El usuario no dispone de configuración');
        if (ProdOrder."Lanzado por usuario" = CodUsuario) then Error('Aviso de Doble Confirmación. El usuario que certifica debe ser distinto al que lanza. Diríjase a su supervisor');
    end;

    procedure ControlFechaCaducidad(CodUsuario: Code[50];
    ProdOrder: Record "Cab inspe eval_CAL_btc")
    var
        UserSetup: Record "User Setup";
    begin
        exit; //ZZZ No se hace esta parte, se quita.
        UserSetup.Get(CodUsuario);
        if UserSetup.NuevaCaducidadLoteCAL_BTC then exit;
        if (ProdOrder."SubEstado inspección" = ProdOrder."SubEstado inspección"::Recontrolado) and (ProdOrder."Nueva fecha caducidad" <= ProdOrder."Fecha caducidad") then Error('La nueva fecha de caducidad debe ser superior a la fecha de caducidad actual');
    end;

    local procedure ValidacionRequisitos(var cabInp: Record "Cab inspe eval_CAL_btc"): Boolean
    var
        Lininsp: Record "Lin inspe eval_CAL_btc";
        CabIn: Record "Cab inspe eval_CAL_btc";
    begin
        Lininsp.Reset();
        Lininsp.SetRange("No. inspección", cabInp."No.");
        Lininsp.SetRange("Afecta conformidad", true);
        Lininsp.SetRange("Requisito conforme", false);
        if not Lininsp.FindFirst() then begin
            Lininsp.SetRange("Requisito conforme", true);
            if Lininsp.FindFirst() then begin
                CabIn.Get(Lininsp."No. inspección");
                cabInp.Validate("Evaluación Inspección", cabInp."Evaluación Inspección"::Conforme);
                cabInp.Modify();
            end;
        end;
    end;
}
