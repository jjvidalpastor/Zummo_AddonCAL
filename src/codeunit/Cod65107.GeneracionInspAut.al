codeunit 65107 "GeneracionInspAut"
{
    Permissions = tabledata "Item Ledger Entry" = rmid, tabledata "Purch. Rcpt. Line" = rmid;

    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertItemLedgEntry', '', true, true)]
    local procedure CrearInspeccion(VAR ItemLedgerEntry: Record "Item Ledger Entry";
    ItemJournalLine: Record "Item Journal Line";
    VAR ItemLedgEntryNo: Integer;
    VAR ValueEntryNo: Integer;
    VAR ItemApplnEntryNo: Integer)
    var
        RecConfAddon: Record "Setup Calidad_CAL_btc";
        RecMovProd: Record "Item Ledger Entry";
        RecMovProdEncontrado: Record "Item Ledger Entry";
        ItemApplicationEntry: Record "Item Application Entry";
    begin
        if not RecConfAddon.Get() then exit;
        if not (RecConfAddon."Activar gestión de la calidad") or (RecConfAddon.AlmacenInpeccion = '') then exit;
        if not ComprobarPlantProd() then exit;
        with ItemLedgerEntry do begin
            if "Entry Type" <> "Entry Type"::Transfer then exit;
            IF Positive THEN EXIT;
            RecMovProd.Reset();
            RecMovProd.SetRange("Item No.", "Item No.");
            RecMovProd.SetRange("Document No.", "Document No.");
            RecMovProd.SetRange("Document Line No.", "Document Line No.");
            RecMovProd.SetRange("Posting Date", "Posting Date");
            RecMovProd.SetRange(Positive, TRUE);
            if RecMovProd.FindFirst() then begin
                if RecMovProd."Location Code" <> RecConfAddon.AlmacenInpeccion then exit;
                ItemApplicationEntry.Reset();
                ItemApplicationEntry.SetRange("Item Ledger Entry No.", "Entry No.");
                if ItemApplicationEntry.FindFirst() then begin
                    RecMovProdEncontrado.Reset();
                    RecMovProdEncontrado.SetRange("Entry No.", ItemApplicationEntry."Inbound Item Entry No.");
                    if RecMovProdEncontrado.FindFirst() then //Solo hacemos del primero
                        case RecMovProdEncontrado."Entry Type" of
                            RecMovProdEncontrado."Entry Type"::Purchase:
                                CrearInpDesdeMovProdAalbC(RecMovProdEncontrado."Entry No.", RecMovProd."Entry No.");
                            RecMovProdEncontrado."Entry Type"::Output:
                                CrearInpDesdeMovProdAMovPrd(RecMovProdEncontrado."Entry No.", RecMovProd."Entry No.");
                            RecMovProdEncontrado."Entry Type"::Consumption:
                                CrearInpDesdeMovProdAMovPrd(RecMovProdEncontrado."Entry No.", RecMovProd."Entry No.");
                            else
                                CrearInpDesdeMovProdAMovPrd(RecMovProdEncontrado."Entry No.", RecMovProd."Entry No.");
                        end;
                end;
            end;
        end;
    end;

    local procedure CrearInpDesdeMovProdAMovPrd(NoMov: integer;
    NoMovPendiente: Integer)
    var
        RecMovProd: Record "Item Ledger Entry";
        cduNewCalidad: Codeunit Crear_CabInspecCalidad_CAL_BTC;
    begin
        RecMovProd.Get(NoMov);
        with RecMovProd do begin
            clear(cduNewCalidad);
            cduNewCalidad.GenerarInspeccionCalidadAlbaranAut(TableName(), "Document No.", "Document Line No.", '', "Item No.", false, "Variant Code", "Location Code", '', "Unit of Measure Code", 0, false, NoMovPendiente);
        end;
    end;

    local procedure CrearInpDesdeMovProdAalbC(NoMov: integer;
    NoMovPendiente: Integer)
    var
        RecHcoLinAlbC: Record "Purch. Rcpt. Line";
        RecMovProd: Record "Item Ledger Entry";
        cduNewCalidad: Codeunit Crear_CabInspecCalidad_CAL_BTC;
    begin
        RecMovProd.Get(NoMov);
        with RecHcoLinAlbC do begin
            SetRange("Document No.", RecMovProd."Document No.");
            SetRange("Line No.", RecMovProd."Document Line No.");
            if not FindFirst() then exit;
            clear(cduNewCalidad);
            cduNewCalidad.GenerarInspeccionCalidadAlbaranAut(TableName(), "Document No.", "Line No.", "Buy-from Vendor No.", "No.", true, "Variant Code", "Location Code", "Bin Code", "Unit of Measure Code", 0, false, NoMovPendiente);
        end;
    end;

    local procedure ComprobarPlantProd(): Boolean
    var
        RecConfPlantilla: Record Conf_Plantillas_Calidad;
    begin
        RecConfPlantilla.reset();
        RecConfPlantilla.SetFilter("Origen inspección", '%1|%2|%3|%4', RecConfPlantilla."Origen inspección"::"Componente orden de producción", RecConfPlantilla."Origen inspección"::"Movimientos de producto", RecConfPlantilla."Origen inspección"::"Lín. Albarán compra", RecConfPlantilla."Origen inspección"::"Orden de producción");
        exit(RecConfPlantilla.FindFirst());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLines', '', true, true)]
    local procedure OnAfterPostPurchLines_CreateInpeccion(var PurchHeader: Record "Purchase Header";
    var PurchRcptHeader: Record "Purch. Rcpt. Header";
    var PurchInvHeader: Record "Purch. Inv. Header";
    var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    var ReturnShipmentHeader: Record "Return Shipment Header";
    WhseShip: Boolean;
    WhseReceive: Boolean;
    var PurchLinesProcessed: Boolean;
    CommitIsSuppressed: Boolean)
    var
        paramWAL: Record "Warehouse Activity Line" temporary;
        RecMovProd: Record "Item Ledger Entry";
        ConfAddon: Record "Setup Calidad_CAL_btc";
        RecHcoLinAlbC: Record "Purch. Rcpt. Line";
        Item: Record "Item";
        GeneracionInspAut: Codeunit GeneracionInspAut;
        TipoMtoDiario: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        MensajeFinLbl: Label 'Se han creado las correspondienste inspecciones para las líneas de tipo producto.', Comment = 'ESP="Se han creado las correspondientes inspecciones para las líneas de tipo producto."';
    begin
        ConfAddon.Get();
        RecHcoLinAlbC.Reset();
        RecHcoLinAlbC.SetRange("Document No.", PurchRcptHeader."No.");
        RecHcoLinAlbC.SetRange(Type, RecHcoLinAlbC.Type::Item);
        RecHcoLinAlbC.SetFilter(Quantity, '>%1', 0); //Solo linea con cantidad <> 0
        with RecHcoLinAlbC do begin
            if FindSet() then begin
                repeat
                    IF ConfAddon."Activar gestión de la calidad" THEN begin
                        Item.get(RecHcoLinAlbC."No.");
                        if item.ActivarGestionCalidadCAL_BTC then begin
                            RecMovProd.Reset();
                            RecMovProd.SetRange("Document No.", "Document No.");
                            RecMovProd.SetRange("Document Line No.", "Line No.");
                            if RecMovProd.FindFirst() then begin
                                paramWAL."Location Code" := "Location Code";
                                paramWAL."Item No." := RecHcoLinAlbC."No.";
                                paramWAL."Serial No." := RecMovProd."Serial No.";
                                paramWAL."Lot No." := RecMovProd."Lot No.";
                                paramWAL."Bin Code" := RecHcoLinAlbC."Bin Code";
                                GeneracionInspAut.DiarioReclasificacion(TipoMtoDiario::Transfer, TODAY(), paramWAL, ABS(RecHcoLinAlbC.Quantity), '', '', ConfAddon.AlmacenInpeccion, ConfAddon.AlmacenInpeccion, '', RecMovProd."Entry No.", TRUE);
                            end;
                        end;
                    END;
                until next() = 0;
                Message(MensajeFinLbl);
            end;
        end;
    end;
    /*
          Si la gestión de calidad está activa, es posible que no pueda deshacerse el albarán porque se transfirió el producto al almacén de inspección,
          vuelvo a dejarlo en el almacén del albarán.
      */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeCheckPurchRcptLine', '', true, true)]
    local procedure CDU_5813OnBeforeCheckPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        recItemLedgentry: Record "Item Ledger Entry";
        recLastItemLedgerEntr: Record "Item Ledger Entry";
        recItemLedgEntryPendiente: Record "Item Ledger Entry";
        recFirstItemAppEntry: Record "Item Application Entry";
        recSecondItemAppEntry: Record "Item Application Entry";
        recThirdItemAppEntry: Record "Item Application Entry";
        TipoMtoDiario: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        paramWAL: Record "Warehouse Activity Line" temporary;
        ConfAddon: Record "Setup Calidad_CAL_btc";
    begin
        if recItemLedgentry.get(PurchRcptLine."Item Rcpt. Entry No.") and recItemLedgentry.Positive then begin
            if recItemLedgentry."Remaining Quantity" <> recItemLedgentry.Quantity then begin
                recFirstItemAppEntry.Reset();
                recFirstItemAppEntry.SetRange("Inbound Item Entry No.", PurchRcptLine."Item Rcpt. Entry No.");
                recFirstItemAppEntry.SetFilter("Item Ledger Entry No.", '<>%1', PurchRcptLine."Item Rcpt. Entry No.");
                if recFirstItemAppEntry.FindFirst() then begin
                    recSecondItemAppEntry.Reset();
                    recSecondItemAppEntry.SetRange("Outbound Item Entry No.", recFirstItemAppEntry."Item Ledger Entry No.");
                    recSecondItemAppEntry.SetFilter("Item Ledger Entry No.", '<>%1', recFirstItemAppEntry."Item Ledger Entry No.");
                    if recSecondItemAppEntry.FindFirst() then begin
                        if not recLastItemLedgerEntr.Get(recSecondItemAppEntry."Item Ledger Entry No.") then exit;
                        if recLastItemLedgerEntr.Quantity <> recLastItemLedgerEntr."Remaining Quantity" then exit;
                        ConfAddon.Get();
                        if ConfAddon.AlmacenInpeccion <> recLastItemLedgerEntr."Location Code" then exit;
                        paramWAL."Location Code" := recLastItemLedgerEntr."Location Code";
                        paramWAL."Item No." := recLastItemLedgerEntr."Item No.";
                        paramWAL."Serial No." := recLastItemLedgerEntr."Serial No.";
                        paramWAL."Lot No." := recLastItemLedgerEntr."Lot No.";
                        paramWAL."Bin Code" := recLastItemLedgerEntr."Location Code";
                        DiarioReclasificacion(TipoMtoDiario::Transfer, TODAY(), paramWAL, ABS(PurchRcptLine.Quantity), '', '', PurchRcptLine."Location Code", PurchRcptLine."Bin Code", '', recLastItemLedgerEntr."Entry No.", TRUE);
                        recThirdItemAppEntry.Reset();
                        recThirdItemAppEntry.SetRange("Transferred-from Entry No.", recLastItemLedgerEntr."Entry No.");
                        if recThirdItemAppEntry.FindFirst() then begin
                            PurchRcptLine."Item Rcpt. Entry No." := recThirdItemAppEntry."Inbound Item Entry No.";
                            if PurchRcptLine.Modify() then;
                            recItemLedgEntryPendiente.Reset();
                            recItemLedgEntryPendiente.SetRange("Entry No.", recThirdItemAppEntry."Inbound Item Entry No.");
                            if recItemLedgEntryPendiente.FindFirst() then begin
                                recItemLedgEntryPendiente."Document Type" := recItemLedgEntryPendiente."Document Type"::"Purchase Receipt";
                                recItemLedgEntryPendiente."Document No." := PurchRcptLine."Document No.";
                                recItemLedgEntryPendiente."Document Line No." := PurchRcptLine."Line No.";
                                recItemLedgEntryPendiente."Entry Type" := recItemLedgEntryPendiente."Entry Type"::Purchase;
                                recItemLedgEntryPendiente.Modify();
                            end;
                            Commit();
                        end;
                    end;
                end;
            end;
        end;
    end;

    procedure DiarioReclasificacion(TipoMtoDiario: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
    varFechaReg: Date;
    ParamWAL: Record "Warehouse Activity Line";
    varCantidad: Decimal;
    varUMedida: Code[10];
    varNumDoc: Code[20];
    varAlDest: Code[20];
    varUbicDest: Code[20];
    varRecipDest: Code[20];
    NumMtoAliquidar: Integer;
    ResistrarDirecto: Boolean)
    var
        recItemJnlLine: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        ReservationEntry: Record "Reservation Entry";
        ConfAddon: Record "Setup Calidad_CAL_btc";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        intNumUltimaLinea: Integer;
        CodDiario: Code[20];
        CodSeccion: Code[20];
    begin
        if ConfAddon.Get() then;
        CodDiario := ConfAddon."Journal Template Name";
        CodSeccion := ConfAddon."Journal Batch Name";
        recItemJnlLine.RESET();
        recItemJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        recItemJnlLine.SETRANGE("Journal Template Name", CodDiario);
        recItemJnlLine.SETRANGE("Journal Batch Name", CodSeccion);
        IF recItemJnlLine.FINDLAST() THEN
            intNumUltimaLinea := recItemJnlLine."Line No."
        ELSE
            intNumUltimaLinea := 0;
        recItemJnlLine.INIT();
        recItemJnlLine.VALIDATE("Line No.", (intNumUltimaLinea) + 10000);
        IF (NumMtoAliquidar <> 0) THEN recItemJnlLine."Applies-to Entry" := NumMtoAliquidar;
        recItemJnlLine.VALIDATE("Journal Template Name", ConfAddon."Journal Template Name");
        recItemJnlLine.VALIDATE("Journal Batch Name", ConfAddon."Journal Batch Name");
        recItemJnlLine.VALIDATE("Entry Type", TipoMtoDiario);
        recItemJnlLine.VALIDATE("Posting Date", varFechaReg);
        recItemJnlLine.VALIDATE("Item No.", ParamWAL."Item No.");
        IF varNumDoc = '' THEN BEGIN
            ItemJournalBatch.GET(CodDiario, CodSeccion);
            ItemJournalBatch.TestField(ItemJournalBatch."No. Series");
            varNumDoc := NoSeriesManagement.GetNextNo(ItemJournalBatch."No. Series", TODAY(), TRUE);
        END;
        recItemJnlLine.VALIDATE("Document No.", varNumDoc);
        IF (ParamWAL."Whse. Document No." <> '') THEN recItemJnlLine."Order No." := ParamWAL."Whse. Document No.";
        IF (ParamWAL."Whse. Document Line No." > 0) THEN recItemJnlLine."Order Line No." := ParamWAL."Whse. Document Line No.";
        recItemJnlLine.VALIDATE(Quantity, ABS(varCantidad));
        recItemJnlLine.VALIDATE("Location Code", ParamWAL."Location Code");
        recItemJnlLine.VALIDATE("Bin Code", ParamWAL."Bin Code");
        IF (varAlDest <> '') THEN recItemJnlLine.VALIDATE("New Location Code", varAlDest);
        IF (varUbicDest <> '') THEN recItemJnlLine.VALIDATE("New Bin Code", varUbicDest);
        //Inserto el seguimiento
        IF ((ParamWAL."Lot No." <> '') OR (ParamWAL."Serial No." <> '')) THEN BEGIN
            CreateReservEntry.SetNewSerialLotNo(ParamWAL."Serial No.", ParamWAL."Lot No."); //Es preciso para que se ponga New Lote en la 336
            IF (NumMtoAliquidar > 0) THEN CreateReservEntry.SetApplyToEntryNo(NumMtoAliquidar);
            CreateReservEntry.CreateReservEntryFor(DATABASE::"Item Journal Line", recItemJnlLine."Entry Type", recItemJnlLine."Journal Template Name", recItemJnlLine."Journal Batch Name", 0, //OrderLineNo,
       recItemJnlLine."Line No.", recItemJnlLine."Qty. per Unit of Measure", recItemJnlLine.Quantity, recItemJnlLine."Quantity (Base)", ParamWAL."Serial No.", ParamWAL."Lot No.");
            CreateReservEntry.CreateEntry(recItemJnlLine."Item No.", recItemJnlLine."Variant Code", recItemJnlLine."Location Code", recItemJnlLine.Description, 0D, 0D, 0, ReservationEntry."Reservation Status"::Prospect);
        END;
        RegistrarDiario(recItemJnlLine);
    end;

    local procedure RegistrarDiario(var RecLinDiarioProducto: Record "Item Journal Line")
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        OriginalQuantity: Decimal;
        OriginalQuantityBase: Decimal;
    begin
        CLEAR(ItemJnlPostLine);
        OriginalQuantity := RecLinDiarioProducto.Quantity;
        OriginalQuantityBase := RecLinDiarioProducto."Quantity (Base)";
        IF NOT ItemJnlPostLine.RunWithCheck(RecLinDiarioProducto) THEN ItemJnlPostLine.CheckItemTracking();
        IF RecLinDiarioProducto."Value Entry Type" <> RecLinDiarioProducto."Value Entry Type"::Revaluation THEN BEGIN
            ItemJnlPostLine.CollectTrackingSpecification(TempTrackingSpecification);
            PostWhseJnlLine(RecLinDiarioProducto, OriginalQuantity, OriginalQuantityBase, TempTrackingSpecification);
        END;
    end;

    local procedure PostWhseJnlLine(ItemJnlLine: Record "Item Journal Line";
    OriginalQuantity: Decimal;
    OriginalQuantityBase: Decimal;
    var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        TempWhseJnlLine2: Record "Warehouse Journal Line" temporary;
        ItemJnlTemplate: Record "Item Journal Template";
        Location: Record Location;
        WMSMgmt: Codeunit "WMS Management";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        WITH ItemJnlLine DO BEGIN
            Quantity := OriginalQuantity;
            "Quantity (Base)" := OriginalQuantityBase;
            ItemJnlTemplate.GET("Journal Template Name");
            Location.GET("Location Code");
            IF NOT ("Entry Type" IN ["Entry Type"::Consumption, "Entry Type"::Output]) THEN
                IF Location."Bin Mandatory" THEN
                    IF WMSMgmt.CreateWhseJnlLine(ItemJnlLine, ItemJnlTemplate.Type, WhseJnlLine, FALSE) THEN BEGIN
                        ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempTrackingSpecification, FALSE);
                        IF TempWhseJnlLine2.FINDSET() THEN
                            REPEAT
                                WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, FALSE);
                                WhseJnlPostLine.RUN(TempWhseJnlLine2);
                            UNTIL TempWhseJnlLine2.NEXT() = 0;
                    END;
            IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
                Location.GET("Location Code");
                IF Location."Bin Mandatory" THEN
                    IF WMSMgmt.CreateWhseJnlLine(ItemJnlLine, ItemJnlTemplate.Type, WhseJnlLine, TRUE) THEN BEGIN
                        ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempTrackingSpecification, TRUE);
                        IF TempWhseJnlLine2.FINDSET() THEN
                            REPEAT
                                WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, TRUE);
                                WhseJnlPostLine.RUN(TempWhseJnlLine2);
                            UNTIL TempWhseJnlLine2.NEXT() = 0;
                    END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Profile Offsetting", 'OnAfterSupplyToInvProfile', '', false, false)]
    local procedure OnAfterSupplyToInvProfile(VAR InventoryProfile: Record "Inventory Profile";
    VAR Item: Record Item;
    VAR ToDate: Date;
    VAR ReservEntry: Record "Reservation Entry";
    VAR NextLineNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemTrkgEntry: Record "Reservation Entry" temporary;
        GestionCalidad: Record "Setup Calidad_CAL_btc";
        AlmacenOrigen: Code[100];
    begin
        GestionCalidad.get;
        if not GestionCalidad."Activar gestión de la calidad" then exit;
        if GestionCalidad.AlmacenInpeccion = '' then exit;
        AlmacenOrigen := Item.GetFilter("Location Filter");
        if AlmacenOrigen = '' then exit;
        Item.SetRange("Location Filter", GestionCalidad.AlmacenInpeccion);
        IF ItemLedgEntry.FindLinesWithItemToPlan(Item, FALSE) THEN
            REPEAT
                NextLineNo := NextLineNo + 1000;
                InventoryProfile.INIT;
                InventoryProfile."Line No." := NextLineNo;
                InventoryProfile.TransferFromItemLedgerEntry(ItemLedgEntry, TempItemTrkgEntry);
                InventoryProfile."Due Date" := 0D;
                InventoryProfile."Location Code" := AlmacenOrigen;
                IF NOT InventoryProfile.IsSupply THEN InventoryProfile.ChangeSign;
                InventoryProfile.INSERT;
            UNTIL ItemLedgEntry.NEXT = 0;
        Item.SetRange("Location Filter", AlmacenOrigen);
    end;
}
