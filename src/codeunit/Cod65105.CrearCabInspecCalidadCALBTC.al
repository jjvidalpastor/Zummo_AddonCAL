codeunit 65105 "Crear_CabInspecCalidad_CAL_BTC"
{
    local procedure CalidadActiva(): Boolean
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
    begin
        if GestionCalidadSetup.Get() then
            exit(GestionCalidadSetup."Activar gestión de la calidad")
        else
            exit(false);
    end;

    procedure GetTableID(pNombreTabla: Text): Integer
    var
        recObject: Record AllObjWithCaption;
        lbErrorTabla: Label 'Table: %1 not found', comment = 'ESP="No encontrada tabla: %1"';
    begin
        recObject.Reset();
        recObject.SetRange("Object Type", recObject."Object Type"::Table);
        recObject.SetRange("Object Name", pNombreTabla);
        if recObject.FindFirst() then
            exit(recObject."Object ID")
        else
            Error(StrSubstNo(lbErrorTabla, pNombreTabla));
    end;

    local procedure GeneraInspeccionDesdePlantilla(var pPlantilla: Record "Plantilla de inseval_CAL_btc";
    pNombreTabla: Text;
    pCodProducto: code[20];
    pNumDocOrigen: code[20];
    pNumLinDocOrigen: Integer;
    pClienteProv: code[20];
    pVariante: code[10];
    pAlmacen: code[10];
    pUbicacion: code[20];
    pUnidadMedida: code[10];
    pCompras: Boolean;
    pNumLinDetalle2: Integer;
    var FromCDU90: boolean;
    Nomov: Integer)
    var
        recCabInspCalidad: Record "Cab inspe eval_CAL_btc";
        recItem: Record Item;
        recVendor: Record Vendor;
        recCustomer: Record Customer;
        RecHcoLinAlbC: Record "Purch. Rcpt. Line"; //BTC FSD 03.02.2020
        enumOrigen: Enum OrigenCalidad;
        lbErrorPlantillaExiste: Label 'Quality inspection for source already exists: %1, document: %2, line: %3', comment = 'ESP="Ya existe inspección de calidad para origen: %1, documento: %2, línea: %3"';
        lbErrorAlmacen: Label 'It is required to report warehouse code in the table: %1', comment = 'ESP="Se requiere informar de código de almacén en la tabla: %1"';
        lbErrorProductoSinControl: Label 'Product: %1 without quality management or visual control configured', Comment = 'ESP="Producto: %1 sin gestión de calidad ni control visual configurado"';
        lbCabCreada: Label 'Created inspection template for Origin: %1, Document No.: %2, Line No.: %3', Comment = 'ESP="Creada inspección de calidad para Origen: %1, Nº documento: %2, Nº línea: %3"';
        lbInpeccionExistente: Label 'A quality inspection already exists for %1 %2 line: %3 Do you want to create another?', comment = 'ESP="Ya existe una inspección de calidad para %1 %2 línea: %3 ¿Desea crear otra?"';
        lbErrorProcesoCancelado: Label 'Process canceled by user', comment = 'ESP="Proceso cancelado por el usuario"';
    begin
        if not CalidadActiva() then exit;
        // Solucion error al convertir directamente de entero a Enum en versiones 130 o anteriores
        evaluate(enumOrigen, format(GetTableID(pNombreTabla)));
        //  enumOrigen := GetTableID(pNombreTabla);
        if recItem.Get(pCodProducto) then begin
            if not recItem.ActivarGestionCalidadCAL_BTC and not recItem.ControlVisuObligatorioCAL_BTC then Error(StrSubstNo(lbErrorProductoSinControl, pCodProducto));
        end;
        recCabInspCalidad.Reset();
        recCabInspCalidad.SetRange("Origen inspección", enumOrigen);
        recCabInspCalidad.SetRange("Nº doc. Origen calidad", pNumDocOrigen);
        recCabInspCalidad.SetRange("Nº lín. doc. Origen calidad", pNumLinDocOrigen);
        if pNumLinDetalle2 <> 0 then recCabInspCalidad.SetRange("Nº línea componente producción", pNumLinDetalle2);
        if recCabInspCalidad.FindFirst() then if not Confirm(StrSubstNo(lbInpeccionExistente, Format(enumOrigen), pNumDocOrigen, pNumLinDocOrigen)) then error(lbErrorProcesoCancelado);
        // Crear cabecera inspección
        clear(recCabInspCalidad);
        recCabInspCalidad.Init();
        recCabInspCalidad."Origen inspección" := enumOrigen;
        recCabInspCalidad."Nº doc. Origen calidad" := pNumDocOrigen;
        recCabInspCalidad."Nº lín. doc. Origen calidad" := pNumLinDocOrigen;
        recCabInspCalidad.EntryNo := nomov;
        //BTC FSD 03.02.2020 Se rellena el campo cantidad inspeccionada con la cantidad recepcionada el albaran compra
        //Si la cantidad es = 0 cero no creamos nada!
        if RecHcoLinAlbC.Get(pNumDocOrigen, pNumLinDocOrigen) then begin
            if RecHcoLinAlbC.Quantity = 0 then exit;
            recCabInspCalidad."Cantidad Inspeccionada" := RecHcoLinAlbC.Quantity
        end;
        //FIN BTC
        recCabInspCalidad.Insert(true);
        recCabInspCalidad.Validate("Cód. plantilla", pPlantilla."No.");
        recCabInspCalidad.Validate("No. revision plantilla", pPlantilla."No. revisión");
        recCabInspCalidad.Validate(Descripción, pPlantilla.Descripcion);
        recCabInspCalidad.Validate("Tipo inspección", pPlantilla."Tipo inspección");
        recCabInspCalidad.Validate("Objeto inspección", pPlantilla."Objeto inspección");
        recCabInspCalidad.Validate("Criterio de muestreo", pPlantilla."Criterio de muestreo");
        recCabInspCalidad.Validate("Tamaño muestra recomendado", pPlantilla."Tamaño muestra recomendado");
        recCabInspCalidad.Validate("% muestra recomendado", pPlantilla."% muestra recomendado");
        recCabInspCalidad.Validate("Tipo de Requisitos Específicos", pPlantilla."Tipo de Requisitos Específicos");
        recCabInspCalidad.Validate("No. producto", pCodProducto);
        recCabInspCalidad.Validate("Cód. variante", pVariante);
        recCabInspCalidad.Validate("Cód. almacén", pAlmacen);
        recCabInspCalidad.Validate("Cód. ubicación", pUbicacion);
        //ZZZ --> Se comenta por que no tiene mucho sentido, puede venir de otro sitio
        /*
            if pClienteProv = '' then begin  // Creada desde fabricación
                recCabInspCalidad.validate("No. línea orden producción", pNumLinDocOrigen);
                recCabInspCalidad.validate("No. orden produccion", pNumDocOrigen);
                recCabInspCalidad."Nº línea componente producción" := pNumLinDetalle2;
            end;
            */
        if pCompras then
            recCabInspCalidad.Validate("No. proveedor", pClienteProv)
        else
            recCabInspCalidad.Validate("No. cliente", pClienteProv);
        recCabInspCalidad.Validate("Unidad de medida", pUnidadMedida);
        recCabInspCalidad."Fecha creación" := WorkDate();
        if recCabInspCalidad."Cód. almacén" = '' then Error(StrSubstNo(lbErrorAlmacen, pNombreTabla));
        recCabInspCalidad.CalcCantidadSugerida();
        //BTC FSD 03.02.2020 Insertamos con estado conforme siempre, ya que en las líneas controlamos si cambia el estado.
        recCabInspCalidad.Validate("Evaluación Inspección", recCabInspCalidad."Evaluación Inspección"::" ");
        recCabInspCalidad.Modify();
        // Generar líneas inspección
        GeneraLinInspeccion(recCabInspCalidad);
        // Enviar email aviso
        EnviaAvisoEmailAperturaInspeccion(recCabInspCalidad);
        if pClienteProv <> '' then // Si no hay cliente ni proveedor estamos en fabricación
            if pCompras then begin
                recVendor.Get(pClienteProv);
                recVendor.Validate(InspeccionCalidadAGR_BTC, true);
                //recVendor.Validate(FechaUltimaReclamacionAGR_BTC, WorkDate());
                recVendor.Modify(true);
            end
            else begin
                recCustomer.Get(pClienteProv);
                recCustomer.Validate(InspeccionCalidadAGR_BTC, true);
                //recCustomer.Validate(FechaUltimaReclamacionAGR_BTC, WorkDate());
                recCustomer.Modify(true);
            end;
        if FromCDU90 then Message(StrSubstNo(lbCabCreada, Format(enumOrigen), pNumDocOrigen, pNumLinDocOrigen));
    end;

    local procedure GeneraLinInspeccion(var pCabInspeccion: Record "Cab inspe eval_CAL_btc")
    var
        recDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        recDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        recLinIns: Record "Lin inspe eval_CAL_btc";
        recReqEspecificos: Record "Req Control especifico_CAL_btc";
        recRequisitos: Record calidad_CAL_btc;
        NumLin: Integer;
        GrupReqMsg: Label 'Grupo de Requisitos Plantilla %1 No Disponible. Revise Grupos de Requisitos Bloqueados.';
    begin
        NumLin := 0;
        RecDetallePlantilla.Reset();
        RecDetallePlantilla.SetRange(Bloqueado, false);
        RecDetallePlantilla.SetRange("Cód. plantilla", pCabInspeccion."Cód. plantilla");
        RecDetallePlantilla.SetRange("No. revision plantilla", pCabInspeccion."No. revision plantilla");
        if RecDetallePlantilla.FindSet() then begin
            repeat
                RecDetalleGrupo.Reset();
                RecDetalleGrupo.SetRange(Bloqueado, false);
                RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                if RecDetalleGrupo.FindSet() then
                    repeat
                        RecLinIns.Init();
                        recLinIns."No. inspección" := pCabInspeccion."No.";
                        RecLinIns.Validate("Origen inspección", pCabInspeccion."Origen inspección");
                        RecLinIns.Validate("Nº doc. Origen calidad", pCabInspeccion."Nº doc. Origen calidad");
                        RecLinIns.Validate("Nº lín. doc. Origen calidad", pCabInspeccion."Nº lín. doc. Origen calidad");
                        RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                        recLinIns."Afecta conformidad" := true;
                        recLinIns."Resultado texto" := '-';
                        if recRequisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                            if not recRequisitos.Bloqueado then begin
                                if pCabInspeccion."Tipo de Requisitos Específicos" = pCabInspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                    recReqEspecificos.Init();
                                    if recReqEspecificos.Get(recReqEspecificos.Tipo::Producto, RecDetalleGrupo."Cod. requisito control", pCabInspeccion."No. producto", pCabInspeccion."Cód. variante") then
                                        if recReqEspecificos.Bloqueado = false then begin
                                            RecLinIns.Validate("No. producto", pCabInspeccion."No. producto");
                                            RecLinIns.Validate("Cód. variante", pCabInspeccion."Cód. variante");
                                            RecLinIns.Validate("No. proveedor", pCabInspeccion."No. proveedor");
                                            RecLinIns.Validate("No. cliente", pCabInspeccion."No. cliente");
                                            RecLinIns.Validate("Cód. tarea", pCabInspeccion."Cód. tarea");
                                            RecLinIns.Validate("Tipo de Requisitos Específicos", pCabInspeccion."Tipo de Requisitos Específicos");
                                            RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                            recLinIns.Validate("Descripción requisito", recDetalleGrupo."Descripción");
                                            NumLin += 10000;
                                            RecLinIns.Validate("No. línea", NumLin);
                                            RecLinIns.Insert(true);
                                        end;
                                end
                                else
                                    if pCabInspeccion."Tipo de Requisitos Específicos" <> pCabInspeccion."Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                        RecLinIns.Validate("No. producto", pCabInspeccion."No. producto");
                                        RecLinIns.Validate("Cód. variante", pCabInspeccion."Cód. variante");
                                        RecLinIns.Validate("No. proveedor", pCabInspeccion."No. proveedor");
                                        RecLinIns.Validate("No. cliente", pCabInspeccion."No. cliente");
                                        RecLinIns.Validate("Cód. tarea", pCabInspeccion."Cód. tarea");
                                        RecLinIns.Validate("Tipo de Requisitos Específicos", pCabInspeccion."Tipo de Requisitos Específicos");
                                        RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                        recLinIns.Validate("Descripción requisito", recDetalleGrupo."Descripción");
                                        NumLin += 10000;
                                        RecLinIns.Validate("No. línea", NumLin);
                                        RecLinIns.Insert(true);
                                    end;
                            end;
                    until RecDetalleGrupo.Next() = 0
                else
                    Message(GrupReqMsg, pCabInspeccion."Cód. plantilla");
            until RecDetallePlantilla.Next() = 0;
        end;
    end;
    // Busca en la configuración de plantillas una que se adapte a ordenes de producción
    local procedure BuscaPlantillaProduccion(var recConfPlantillas: Record Conf_Plantillas_Calidad;
    recItem: Record Item;
    pNombreTabla: Text)
    var
        enumOrigen: enum OrigenCalidad;
        enumTipoCod: enum TiposCodigosEspecificos;
    begin
        evaluate(enumOrigen, format(GetTableID(recItem.TableName)));
        recConfPlantillas.Reset();
        recConfPlantillas.SetRange("Origen inspección", enumOrigen);
        recConfPlantillas.SetRange(CodEspecifico, recItem."No.");
        if not recConfPlantillas.FindFirst() then begin
            evaluate(enumOrigen, format(GetTableID(pNombreTabla)));
            recConfPlantillas.SetRange("Origen inspección", enumOrigen);
            recConfPlantillas.SetRange(CodEspecifico, '');
            recConfPlantillas.FindFirst();
            // Pasamos a nivel 2
            evaluate(enumTipoCod, format(GetTableID(recItem.TableName)));
            recConfPlantillas.SetRange(OrigenInspeccionNivel2, enumTipoCod); // GetTableID(recItem.TableName));
            recConfPlantillas.SetRange(CodEspecificoNivel2, recItem."No.");
            if not recConfPlantillas.FindFirst() then begin
                // No encuentro nivel 2 vuelvo a nivel 1
                recConfPlantillas.SetRange(OrigenInspeccionNivel2, recConfPlantillas.OrigenInspeccionNivel2::Ninguno);
                recConfPlantillas.SetRange(CodEspecificoNivel2, '');
            end;
        end;
        recConfPlantillas.FindFirst();
    end;
    // Busca en la configuración de plantillas, una que se adapte a compras y ventas, sin tener en cuenta empleados u ordenes de producción
    local procedure BuscaPlantilla(var recConfPlantillas: Record Conf_Plantillas_Calidad;
    recItem: Record Item;
    var recVendor: Record Vendor;
    var recCustomer: record Customer;
    pCompras: Boolean;
    pNombreTabla: Text)
    var
        enumOrigen: enum OrigenCalidad;
        enumTipoCod: enum TiposCodigosEspecificos;
    begin
        recConfPlantillas.Reset();
        evaluate(enumOrigen, format(GetTableID(recItem.TableName)));
        recConfPlantillas.SetRange("Origen inspección", enumOrigen); // GetTableID(recItem.TableName));
        recConfPlantillas.SetRange(CodEspecifico, recItem."No.");
        if not recConfPlantillas.FindFirst() then begin
            if pCompras then begin
                evaluate(enumOrigen, format(GetTableID(recVendor.TableName)));
                recConfPlantillas.SetRange("Origen inspección", enumOrigen); // GetTableID(recVendor.TableName));
                recConfPlantillas.SetRange(CodEspecifico, recVendor."No.");
            end
            else begin
                evaluate(enumOrigen, format(GetTableID(recCustomer.TableName)));
                recConfPlantillas.SetRange("Origen inspección", enumOrigen); // GetTableID(recCustomer.TableName));
                recConfPlantillas.SetRange(CodEspecifico, recCustomer."No.");
            end;
            if not recConfPlantillas.FindFirst() then begin
                evaluate(enumOrigen, format(GetTableID(pNombreTabla)));
                recConfPlantillas.SetRange("Origen inspección", enumOrigen); // GetTableID(pNombreTabla));
                recConfPlantillas.SetRange(CodEspecifico, '');
                recConfPlantillas.FindFirst();
                // Pasamos a nivel 2
                evaluate(enumTipoCod, format(GetTableID(recItem.TableName)));
                recConfPlantillas.SetRange(OrigenInspeccionNivel2, enumTipoCod); // GetTableID(recItem.TableName));
                recConfPlantillas.SetRange(CodEspecificoNivel2, recItem."No.");
                if not recConfPlantillas.FindFirst() then begin
                    if pCompras then begin
                        evaluate(enumTipoCod, format(GetTableID(recVendor.TableName)));
                        recConfPlantillas.SetRange(OrigenInspeccionNivel2, enumTipoCod); // GetTableID(recVendor.TableName));
                        recConfPlantillas.SetRange(CodEspecificoNivel2, recVendor."No.");
                    end
                    else begin
                        evaluate(enumTipoCod, format(GetTableID(recCustomer.TableName)));
                        recConfPlantillas.SetRange(OrigenInspeccionNivel2, enumTipoCod); // GetTableID(recCustomer.TableName));
                        recConfPlantillas.SetRange(CodEspecificoNivel2, recCustomer."No.");
                    end;
                    // Pasamos a nivel 3
                    if recConfPlantillas.FindFirst() then begin
                        evaluate(enumTipoCod, format(GetTableID(recItem.TableName)));
                        recConfPlantillas.SetRange(OrigenInspeccionNivel3, enumTipoCod); // GetTableID(recItem.TableName));
                        recConfPlantillas.SetRange(CodEspecificoNivel3, recItem."No.");
                        // Si no encuentro nivel 3 vuelvo a nivel 2
                        if not recConfPlantillas.FindFirst() then begin
                            recConfPlantillas.SetRange(OrigenInspeccionNivel3, recConfPlantillas.OrigenInspeccionNivel3::Ninguno);
                            recConfPlantillas.SetRange(CodEspecificoNivel3, '');
                            // Si no encuentro nivel 2 vuelvo a nivel 1
                            if not recConfPlantillas.FindFirst() then begin
                                recConfPlantillas.SetRange(OrigenInspeccionNivel2, recConfPlantillas.OrigenInspeccionNivel2::Ninguno);
                                recConfPlantillas.SetRange(CodEspecificoNivel2, '');
                            end;
                        end;
                    end
                    else begin
                        // No encuentro nivel 2 vuelvo a nivel 1
                        recConfPlantillas.SetRange(OrigenInspeccionNivel2, recConfPlantillas.OrigenInspeccionNivel2::Ninguno);
                        recConfPlantillas.SetRange(CodEspecificoNivel2, '');
                    end;
                end
                else begin
                    // Pasamos a nivel 3
                    if pCompras then begin
                        evaluate(enumTipoCod, format(GetTableID(recVendor.TableName)));
                        recConfPlantillas.SetRange(OrigenInspeccionNivel3, enumTipoCod); // GetTableID(recVendor.TableName));
                        recConfPlantillas.SetRange(CodEspecificoNivel3, recVendor."No.");
                    end
                    else begin
                        evaluate(enumTipoCod, format(GetTableID(recCustomer.TableName)));
                        recConfPlantillas.SetRange(OrigenInspeccionNivel3, enumTipoCod); // GetTableID(recCustomer.TableName));
                        recConfPlantillas.SetRange(CodEspecificoNivel3, recCustomer."No.");
                    end;
                    // Si no encuentro nivel 3 vuelvo a nivel 2
                    if not recConfPlantillas.FindFirst() then begin
                        recConfPlantillas.SetRange(OrigenInspeccionNivel3, recConfPlantillas.OrigenInspeccionNivel3::Ninguno);
                        recConfPlantillas.SetRange(CodEspecificoNivel3, '');
                        // Si no encuentro nivel 2 vuelvo a nivel 1
                        if not recConfPlantillas.FindFirst() then begin
                            recConfPlantillas.SetRange(OrigenInspeccionNivel2, recConfPlantillas.OrigenInspeccionNivel2::Ninguno);
                            recConfPlantillas.SetRange(CodEspecificoNivel2, '');
                        end;
                    end;
                end;
            end;
        end;
        recConfPlantillas.FindFirst();
    end;

    procedure GenerarInspeccionCalidadAlbaran(pNombreTabla: Text;
    pNumDocumento: code[10];
    pNumLinDocumento: Integer;
    pClienteProveedor: code[20];
    pProducto: code[20];
    pCompras: Boolean;
    pVariante: code[10];
    pAlmacen: code[10];
    pUbicacion: code[20];
    pUnidadMedida: code[10];
    pLineaDetalle2: Integer)
    var
        recItem: Record Item;
        recVendor: Record Vendor;
        recCustomer: record Customer;
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        intNumRevision: Integer;
        codPlantilla: Code[20];
        lbErrorPlantillaNoencontrada: Label 'No active template found in Certified status for: %1', Comment = 'ESP="No se ha encontrado plantilla activa en estado Certificada para: %1"';
        recConfPlantillas: Record Conf_Plantillas_Calidad;
        FromCdu90: Boolean;
    begin
        CalidadActiva();
        recItem.Get(pProducto);
        if pClienteProveedor <> '' then begin // Si está vacío, su origen no es compras ni ventas
            if pCompras then
                recVendor.Get(pClienteProveedor)
            else
                recCustomer.Get(pClienteProveedor);
        end;
        // Obtener plantilla en base a la configuración de plantillas
        if pClienteProveedor = '' then // Si no hay cliente o proveedor, estamos en fabricación
            BuscaPlantillaProduccion(recConfPlantillas, recItem, pNombreTabla)
        else
            BuscaPlantilla(recConfPlantillas, recItem, recVendor, recCustomer, pCompras, pNombreTabla);
        Plantilla.get(recConfPlantillas.CodPlantillaInspeccion, recConfPlantillas."No. revisión");
        // Generar cabecera y líneas inspección y mandar aviso por email
        FromCdu90 := true;
        GeneraInspeccionDesdePlantilla(Plantilla, pNombreTabla, pProducto, pNumDocumento, pNumLinDocumento, pClienteProveedor, pVariante, pAlmacen, pUbicacion, pUnidadMedida, pCompras, pLineaDetalle2, FromCdu90, 0);
    end;

    procedure GenerarInspeccionCalidadAlbaranAut(pNombreTabla: Text;
    pNumDocumento: code[10];
    pNumLinDocumento: Integer;
    pClienteProveedor: code[20];
    pProducto: code[20];
    pCompras: Boolean;
    pVariante: code[10];
    pAlmacen: code[10];
    pUbicacion: code[20];
    pUnidadMedida: code[10];
    pLineaDetalle2: Integer;
    FromCDU90: Boolean;
    NoMov: Integer)
    var
        recItem: Record Item;
        recVendor: Record Vendor;
        recCustomer: record Customer;
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        intNumRevision: Integer;
        codPlantilla: Code[20];
        lbErrorPlantillaNoencontrada: Label 'No active template found in Certified status for: %1', Comment = 'ESP="No se ha encontrado plantilla activa en estado Certificada para: %1"';
        recConfPlantillas: Record Conf_Plantillas_Calidad;
    begin
        CalidadActiva();
        recItem.Get(pProducto);
        if pClienteProveedor <> '' then begin // Si está vacío, su origen no es compras ni ventas
            if pCompras then
                recVendor.Get(pClienteProveedor)
            else
                recCustomer.Get(pClienteProveedor);
        end;
        // Obtener plantilla en base a la configuración de plantillas
        if pClienteProveedor = '' then // Si no hay cliente o proveedor, estamos en fabricación
            BuscaPlantillaProduccion(recConfPlantillas, recItem, pNombreTabla)
        else
            BuscaPlantilla(recConfPlantillas, recItem, recVendor, recCustomer, pCompras, pNombreTabla);
        Plantilla.get(recConfPlantillas.CodPlantillaInspeccion, recConfPlantillas."No. revisión");
        // Generar cabecera y líneas inspección y mandar aviso por email
        GeneraInspeccionDesdePlantilla(Plantilla, pNombreTabla, pProducto, pNumDocumento, pNumLinDocumento, pClienteProveedor, pVariante, pAlmacen, pUbicacion, pUnidadMedida, pCompras, pLineaDetalle2, FromCDU90, NoMov);
    end;

    local procedure EnviaAvisoEmailAperturaInspeccion(var pCabInspCalidad: Record "Cab inspe eval_CAL_btc")
    var
        recConfCalidad: Record "Setup Calidad_CAL_btc";
        SMTPMailSetup: Record "SMTP Mail Setup";
        MailReceptores: Text[150];
        MailAsunto: Text[300];
        MailCuerpo: Text[600];
        CR: Char;
        LF: Char;
    begin
        recConfCalidad.Get();
        recConfCalidad.TestField("Receptores Apertura Inspeccion");
        if not recConfCalidad."Activar aviso apertura inspecc" then exit;
        SMTPMailSetup.Get();
        MailReceptores := recConfCalidad."Receptores Apertura Inspeccion";
        Clear(MailAsunto);
        Clear(MailCuerpo);
        CR := 13;
        LF := 10;
        MailAsunto := 'Aviso Automático. Inspección de Calidad: ' + Format(pCabInspCalidad."No.") + ' Origen: ' + Format(pCabInspCalidad."Origen inspección") + ' Nº: ' + pCabInspCalidad."Nº doc. Origen calidad";
        MailCuerpo := 'Inspección de Calidad: ' + Format(pCabInspCalidad."No.") + ' Origen: ' + Format(pCabInspCalidad."Origen inspección") + ' en Estado Abierta y SubEstado: ' + Format(pCabInspCalidad."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Producto: ' + Format(pCabInspCalidad."No. producto") + ' - ' + pCabInspCalidad."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Pendiente de Analizar en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + SMTPMailSetup."User ID" + ' por el sistema de avisos';
        SendEmail(MailAsunto, MailCuerpo, MailReceptores, 'Aviso de Apertura Inspección');
    end;

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
        InspSinLineasMsg: Label 'Inspección de Calidad Nº doc. Origen: %1 Nº lín. doc origen: %2 sin Requisito No Conforme y Afectación a Conformidad para Crear No Conformidad. Revise líneas de Inspección.';
        NconForMsg: Label 'No Conformidad %1 creada';
    begin
        if pInspeccion."Estado inspección" = pInspeccion."Estado inspección"::Abierta then Error('En Estado Abierta no puede crear una No Conformidad. Se requiere que la Inspección esté Lanzada o Certificada');
        if pInspeccion."Estado inspección" = pInspeccion."Estado inspección"::Terminada then Error('En Estado Terminada no puede crear una No Conformidad. Se requiere que la Inspección esté Lanzada o Certificada');
        if pInspeccion."Evaluación Inspección" <> pInspeccion."Evaluación Inspección"::"No Conforme" then Error('Inspección con Evaluación Conforme. Se requiere que la Inspección esté Evaluada No Conforme');
        if pInspeccion."No conformidad" = false then begin
            boolCrearNoConf := false;
            LinInspeccion.Reset();
            LinInspeccion.SetRange("No. inspección", pInspeccion."No.");
            if LinInspeccion.FindSet() then
                repeat
                    LinInspeccion.Validate(Conformidad, true);
                    if LinInspeccion."Requisito no conforme" then if LinInspeccion."Afecta conformidad" then LinInspeccion.Validate("No conformidad", true);
                    if LinInspeccion."No conformidad" then begin
                        boolCrearNoConf := true;
                        TmpLinInspeccion.Init();
                        TmpLinInspeccion.TransferFields(LinInspeccion);
                        TmpLinInspeccion.Insert(false);
                    end;
                    LinInspeccion.Modify();
                until LinInspeccion.Next() = 0;
            if not boolCrearNoConf then Error(InspSinLineasMsg, pInspeccion."Nº doc. Origen calidad", pInspeccion."Nº lín. doc. Origen calidad");
        end;
        pInspeccion.Validate("No conformidad", true);
        if pInspeccion."Estado inspección" = pInspeccion."Estado inspección"::Certificada then
            pInspeccion.Validate("SubEstado inspección", pInspeccion."SubEstado inspección"::Rechazado)
        else
            pInspeccion.Validate("SubEstado inspección", pInspeccion."SubEstado inspección"::Cuarentena);
        pInspeccion.Modify(true);
        LinInspeccion.Reset();
        LinInspeccion.SetRange("No. inspección", pInspeccion."No.");
        if not LinInspeccion.FindFirst() then Message('Atención: Inspección de Calidad sin líneas');
        if pInspeccion."No. No conformidad" <> '' then Error('No Conformidad creada con anterioridad');
        if pInspeccion."No. proveedor" <> '' then
            if Vendor.Get(pInspeccion."No. proveedor") then begin
                Vendor.Validate(NoConformidadAGR_BTC, true);
                Vendor.Modify(true);
            end;
        if pInspeccion."No. cliente" <> '' then
            if Customer.Get(pInspeccion."No. cliente") then begin
                Customer.Validate(NoConformidadAGR_BTC, true);
                Customer.Modify(true);
            end;
        /*
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
            */
        GestionCalidadSetup.Get();
        GestionCalidadSetup.TestField("No. serie no conformidades");
        if pInspeccion."No. No conformidad" = '' then begin
            Clear(numSerie);
            CabNoConf.Init();
            numSerie := GestionCalidadSetup."No. serie no conformidades";
            CabNoConf.TransferFields(pInspeccion);
            CabNoConf.Validate(CabNoConf."No. de serie", numSerie);
            CabNoConf."Nº doc. Origen calidad" := pInspeccion."Nº doc. Origen calidad";
            CabNoConf."Nº lín. doc. Origen calidad" := pInspeccion."Nº lín. doc. Origen calidad";
            if pInspeccion."Origen inspección" in [pInspeccion."Origen inspección"::Producto] then begin
                CabNoConf."Cód. almacén destino" := CabNoConf."Cód. almacén";
                CabNoConf."Cód. ubicación destino" := CabNoConf."Cód. ubicación";
            end;

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
                //BEGIN FJAB 311019 Cambio campos
                LinNoConf."Nº doc. Origen calidad" := CabNoConf."Nº doc. Origen calidad";
                LinNoConf."Nº lín. doc. Origen calidad" := CabNoConf."Nº lín. doc. Origen calidad";
                //END FJAB 311019
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
        EnviaAvisoEmailAperturaNoConformidad(CabNoConf);
    end;

    local procedure EnviaAvisoEmailAperturaNoConformidad(var pCabNoConf: Record "Cab no conformidad_CAL_btc")
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        CR: Char;
        LF: Char;
        MailReceptores: Text[150];
        MailAsunto: Text[300];
        MailCuerpo: Text[600];
        SMTPMailSetup: Record "SMTP Mail Setup";
    begin
        GestionCalidadSetup.Get();
        pCabNoConf.CalcFields("Descripción producto");
        if not GestionCalidadSetup."Activar aviso apertura noconf" then exit;
        GestionCalidadSetup.TestField("Receptores Apertura No Confor");
        SMTPMailSetup.Get();
        CR := 13;
        LF := 10;
        MailReceptores := GestionCalidadSetup."Receptores Apertura No Confor";
        Clear(MailAsunto);
        Clear(MailCuerpo);
        MailAsunto := 'Aviso Automático. No Conformidad: ' + Format(pCabNoConf."No. no conformidad") + ' Abierta por: ' + Format(UserId()) + ' Pendiente de Resolver';
        MailCuerpo := 'No Conformidad: ' + Format(pCabNoConf."No. no conformidad") + ' Origen: ' + Format(pCabNoConf."Origen inspección") + ' de la Inspección: ' + Format(pCabNoConf."Nº doc. Origen calidad") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Producto: ' + Format(pCabNoConf."No. producto") + ' - ' + pCabNoConf."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Pendiente de Resolver en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + SMTPMailSetup."User ID" + ' por el sistema de avisos';
        SendEmail(MailAsunto, MailCuerpo, MailReceptores, 'Aviso de Apertura No Conformidad');
    end;

    local procedure SendEmail(pAsunto: Text;
    pCuerpo: Text;
    pMailReceptores: Text;
    pSenderName: Text)
    var
        SMTPMailSetup: Record "SMTP Mail Setup";
        cduSMTP: Codeunit "SMTP Mail";
        MailEmisor: Text;
    begin
        SMTPMailSetup.Get();
        SMTPMailSetup.TestField("SMTP Server");
        SMTPMailSetup.TestField("User ID");
        MailEmisor := SMTPMailSetup."User ID";
        Clear(cduSMTP);
        cduSMTP.CreateMessage(pSenderName, MailEmisor, pMailReceptores, pAsunto, pCuerpo, false);
        cduSMTP.Send();
    end;
}
