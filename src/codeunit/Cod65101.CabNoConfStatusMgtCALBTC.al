codeunit 65101 "Cab No Conf Status Mgt_CAL_BTC"
{
    Permissions = TableData "Source Code Setup" = r, TableData "Production Order" = rimd, TableData "Prod. Order Capacity Need" = rid, TableData "Inventory Adjmt. Entry (Order)" = rim;
    TableNo = "Cab no conformidad_CAL_btc";

    trigger OnRun()
    var
        ChangeStatusForm: Page ChangeStatOnCabNoConf_CAL_btc;
        OldStatus: Option Abierta,Lanzada,Certificada,Terminada;
    begin
        OldStatus := "Estado no conformidad";
        ChangeStatusForm.Set(Rec);
        if ChangeStatusForm.RunModal() = ACTION::Yes then begin
            ChangeStatusForm.ReturnPostingInfo(NewStatus, NewPostingDate);
            ChangeStatusOnProdOrder(Rec, NewStatus, NewPostingDate);
            Commit();
            // TODO: Comentado mensaje información
            //Message(Text000Msg, OldStatus, TableCaption(), "No. inspección", NewStatus, ToProdOrder.TableCaption(), "No. inspección");
        end;
    end;

    var
        ToProdOrder: Record "Production Order";
        RecLins: Record "Lin no conformidad_CAL_btc";
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        SMTPMailSetup: Record "SMTP Mail Setup";
        cduSMTP: Codeunit "SMTP Mail";
        Text000Msg: Label '%2 %3  with status %1 has been changed to %5 %6 with status %4.';
        NewStatus: Option Abierta,Lanzada,Certificada,Terminada;
        NewPostingDate: Date;
        MailEmisor: Text[50];
        MailReceptores: Text[150];
        MailAsunto: Text[300];
        MailCuerpo: Text[600];
        TipoMtoDiario: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        ItemLedgerEntry: Record "Item Ledger Entry";
        GenereacionInspAut: Codeunit GeneracionInspAut;
        ParWAL: Record "Warehouse Activity Line" temporary;
        DCActiva: Boolean;
        CR: Char;
        LF: Char;
        PopUp: Boolean;
        gCambioPorPDA: Boolean;

    procedure ChangeStatusOnProdOrder(var ProdOrder: Record "Cab no conformidad_CAL_btc";
    NewStatus: Option Abierta,Lanzada,Certificada,Terminada;
    NewPostingDate: Date)
    begin
        //TODO: Revisar si es necesaria esta función 
        if (ProdOrder."Estado no conformidad" = ProdOrder."Estado no conformidad"::Abierta) and (NewStatus <> NewStatus::Lanzada) then Error('Estado Abierta sólo puede cambiar a Lanzada');
        if (ProdOrder."Estado no conformidad" = ProdOrder."Estado no conformidad"::Lanzada) and (NewStatus = NewStatus::Terminada) then Error('Estado Lanzada sólo puede cambiar a Abierta o Certificada');
        if (ProdOrder."Estado no conformidad" = ProdOrder."Estado no conformidad"::Certificada) and (NewStatus <> NewStatus::Terminada) then Error('Estado Confirmada sólo puede cambiar a Terminada');
        Clear(GestionCalidadSetup);
        GestionCalidadSetup.Get();
        DCActiva := GestionCalidadSetup."Activar doble confirmacion";
        if DCActiva then begin
            Clear(SMTPMailSetup);
            SMTPMailSetup.Get();
            SMTPMailSetup.TestField("SMTP Server");
            MailEmisor := SMTPMailSetup."User ID";
            MailReceptores := GestionCalidadSetup."Receptores DC Calidad";
            //if ProdOrder."Origen inspección" = ProdOrder."Origen inspección"::"Mat.Gráfico" then
            //MailReceptores := GestionCalidadSetup."Receptores DC Mat.Graph";
            PopUp := GestionCalidadSetup."Activar aviso mensajes emisor";
            Clear(MailAsunto);
            Clear(MailCuerpo);
            CR := 13;
            LF := 10;
        end;
        if NewStatus = NewStatus::Certificada then begin
            //if not gCambioPorPDA then
            //    ControlUsuarioCertificada(UserId(), ProdOrder);
            ProdOrder.Validate("SubEstado inspección", ProdOrder."SubEstado inspección"::Rechazado);
        end;
        if NewStatus = NewStatus::Terminada then begin
            if NewStatus = NewStatus::Terminada then begin
                //
                //IF ProdOrder."Evaluación Inspección" = ProdOrder."Evaluación Inspección"::Conforme then begin
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Entry No.", ProdOrder.EntryNo);
                if ItemLedgerEntry.FindFirst() then begin
                    ParWAL."Location Code" := ItemLedgerEntry."Location Code";
                    ParWAL."Item No." := ItemLedgerEntry."Item No.";
                    ParWAL."Serial No." := ItemLedgerEntry."Serial No.";
                    ParWAL."Lot No." := ItemLedgerEntry."Lot No.";
                    ParWAL."Bin Code" := ItemLedgerEntry."Location Code";
                    GenereacionInspAut.DiarioReclasificacion(TipoMtoDiario::Transfer, TODAY(), ParWAL, ABS(ItemLedgerEntry.Quantity), '', '', ProdOrder."Cód. almacén destino", ProdOrder."Cód. ubicación destino", '', ItemLedgerEntry."Entry No.", TRUE);
                end;
                //END;
                //Error('PARADO');
            end;
        end;
        if (NewStatus = NewStatus::Lanzada) and (DCActiva = true) then begin
            if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la doble confirmación');
            if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la doble confirmación');
            MailAsunto := 'Aviso Automático. No Conformidad: ' + Format(ProdOrder."No. no conformidad") + ' Lanzada por: ' + Format(UserId()) + ' Pendiente de Certificar';
            MailCuerpo := 'No Conformidad: ' + Format(ProdOrder."No. no conformidad") + ' Origen: ' + Format(ProdOrder."Origen inspección") + ' en Estado Lanzada y SubEstado: ' + Format(ProdOrder."SubEstado inspección") + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Producto: ' + Format(ProdOrder."No. producto") + ' - ' + ProdOrder."Descripción producto" + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Pendiente de Certificar (doble confirmación) en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de dobles confirmaciones';
            Clear(cduSMTP);
            cduSMTP.CreateMessage('Doble Confirmación', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
            cduSMTP.Send();
            if PopUp then Message('Correo enviado a los Certificadores');
        end;
        ProdOrder.Validate("Estado no conformidad", NewStatus);
        ProdOrder.Modify(true);
        Clear(RecLins);
        RecLins.Reset();
        RecLins.SetRange("Origen inspección", ProdOrder."Origen inspección");
        RecLins.SetRange("No. inspección", ProdOrder."No. inspección");
        RecLins.SetRange("No. no conformidad", ProdOrder."No. no conformidad");
        if RecLins.FindSet() then
            repeat
                RecLins.Validate("Estado no conformidad", NewStatus);
                RecLins.Modify(true);
            until RecLins.Next() = 0
        else
            Message('Atención: No Conformidad sin líneas');
    end;

    procedure ControlUsuarioCertificada(CodUsuario: Code[50];
    ProdOrder: Record "Cab no conformidad_CAL_btc"): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        GestionCalidadSetup.Get();
        if not GestionCalidadSetup."Activar doble confirmacion" then exit(true);
        UserSetup.Init();
        if not UserSetup.Get(CodUsuario) then Error('El usuario no dispone de configuración');
        if (ProdOrder."Lanzado por usuario" = CodUsuario) then Error('Aviso de Doble Confirmación. El usuario que certifica debe ser distinto al que lanza. Diríjase a su supervisor');
    end;

    procedure CambioPorPDA()
    begin
        gCambioPorPDA := true;
    end;
}
