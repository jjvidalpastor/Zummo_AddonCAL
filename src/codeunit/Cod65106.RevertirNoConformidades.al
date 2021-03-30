codeunit 65106 "RevertirNoConformidades"
{
    procedure RevertirNoConformidadDevCompras(var pCabDevolucion: Record "Purchase Header";
    var pCabNoConformidad: record "Cab no conformidad_CAL_btc")
    var
        myInt: Integer;
    begin
        if pCabNoConformidad.FindSet() then
            repeat
                TraspasaNoConformidadPurchLine(pCabDevolucion, pCabNoConformidad);
            until pCabNoConformidad.Next() = 0;
    end;

    local procedure TraspasaNoConformidadPurchLine(var pCabDevolucion: Record "Purchase Header";
    var pCabNoConformidad: record "Cab no conformidad_CAL_btc")
    var
        recPurchLine: Record "Purchase Line";
    begin
        // Línea comentario
        recPurchLine.Init();
        recPurchLine."Document Type" := pCabDevolucion."Document Type";
        recPurchLine."Document No." := pCabDevolucion."No.";
        recPurchLine."Line No." := GetSigLin(pCabDevolucion);
        recPurchLine.Insert();
        recPurchLine.Description := 'Nº Inspección: ' + pCabNoConformidad."No. inspección";
        recPurchLine."Description 2" := 'Nº No conformidad: ' + pCabNoConformidad."No. no conformidad";
        recPurchLine.Modify();
        // Línea real
        recPurchLine.Init();
        recPurchLine."Document Type" := pCabDevolucion."Document Type";
        recPurchLine."Document No." := pCabDevolucion."No.";
        recPurchLine."Line No." := GetSigLin(pCabDevolucion);
        recPurchLine.Insert();
        recPurchLine.Type := recPurchLine.Type::Item;
        recPurchLine.Validate("No.", pCabNoConformidad."No. producto");
        recPurchLine.Validate(Quantity, pCabNoConformidad."Cantidad Inspeccionada");
        recPurchLine.Validate("Unit of Measure Code", pCabNoConformidad."Unidad de medida");
        recPurchLine.Validate("Location Code", pCabNoConformidad."Cód. almacén");
        recPurchLine.Validate("Bin Code", pCabNoConformidad."Cód. ubicación");
        recPurchLine.NumInspeccion_btc := pCabNoConformidad."No. inspección";
        recPurchLine.NumNoConformidad_btc := pCabNoConformidad."No. no conformidad";
        recPurchLine.Modify();
    end;

    local procedure GetSigLin(var pCabDevolucion: Record "Purchase Header"): Integer
    var
        recPurchLine: Record "Purchase Line";
    begin
        recPurchLine.Reset();
        recPurchLine.SetRange("Document Type", pCabDevolucion."Document Type");
        recPurchLine.SetRange("Document No.", pCabDevolucion."No.");
        if recPurchLine.FindLast() then
            exit(recPurchLine."Line No." + 10000)
        else
            exit(10000);
    end;
    // Traspasar no conformidad a la línea del abono, el transferfields no se lo lleva y el evento que se dispara al insertar líneas
    //desde un envío devolución no existe en esta versión
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchaseLinesToDoc', '', true, true)]
    local procedure CU_6620_OnAfterCopyPurchaseLinesToDoc(FromDocType: Option;
    VAR ToPurchaseHeader: Record "Purchase Header";
    VAR FromPurchRcptLine: Record "Purch. Rcpt. Line";
    VAR FromPurchInvLine: Record "Purch. Inv. Line";
    VAR FromReturnShipmentLine: Record "Return Shipment Line";
    VAR FromPurchCrMemoLine: Record "Purch. Cr. Memo Line";
    VAR LinesNotCopied: Integer;
    VAR MissingExCostRevLink: Boolean)
    var
        recPurchLine: Record "Purchase Line";
        recPurchLineDev: Record "Purchase Line";
    begin
        if FromDocType <> 8 then // Envío devolución compra
            exit;
        recPurchLine.Reset();
        recPurchLine.SetRange("Document Type", ToPurchaseHeader."Document Type");
        recPurchLine.SetRange("Document No.", ToPurchaseHeader."No.");
        recPurchLine.Setrange(Type, recPurchLine.Type::Item);
        recPurchLine.SetRange(NumInspeccion_btc, '');
        recPurchLine.SetFilter("Order No.", '<>%1', '');
        if recPurchLine.FindSet() then
            repeat
                recPurchLineDev.Reset();
                recPurchLineDev.SetRange("Document Type", recPurchLineDev."Document Type"::"Return Order");
                recPurchLineDev.SetRange("Document No.", recPurchLine."Order No.");
                recPurchLineDev.SetRange("Line No.", recPurchLine."Order Line No.");
                if recPurchLineDev.FindFirst() then begin
                    recPurchLine.NumInspeccion_btc := recPurchLineDev.NumInspeccion_btc;
                    recPurchLine.NumNoConformidad_btc := recPurchLineDev.NumNoConformidad_btc;
                    recPurchLine.Modify();
                end;
            until recPurchLine.Next() = 0;
    end;
    // Al registrar una devolución de compra con una no conformidad asociada, damos por finalizada la no conformidad para que no aparezca como pendiente
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeReturnShptLineInsert', '', true, true)]
    local procedure CU_90_OnBeforeReturnShptLineInsert(var ReturnShptLine: Record "Return Shipment Line";
    var ReturnShptHeader: Record "Return Shipment Header";
    var PurchLine: Record "Purchase Line";
    CommitIsSupressed: Boolean)
    var
        recCabNoConformidad: Record "Cab no conformidad_CAL_btc";
    begin
        if PurchLine.NumNoConformidad_btc <> '' then begin
            if recCabNoConformidad.Get(PurchLine.NumInspeccion_btc, PurchLine.NumNoConformidad_btc) then begin
                recCabNoConformidad."Acción inmediata" := recCabNoConformidad."Acción inmediata"::"Devolución a prov.";
                recCabNoConformidad.Modify();
            end;
        end;
    end;
}
