tableextension 65112 "TabExtLotNoInfo_CAL_btc" extends "Lot No. Information"
{
    fields
    {
        field(65100; InspeccionDeCalidadCAL_BTC; Boolean)
        {
            Caption = 'Inspeccion de calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65101; NoConformidadCAL_BTC; Boolean)
        {
            Caption = 'No conformidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65102; FechaCaducidadCAL_BTC; Date)
        {
            Caption = 'Fecha caducidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = true;
        }
        field(65103; EstadoControlCalidadCAL_BTC; Option)
        {
            Caption = 'Estado control calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = true;
            OptionCaption = 'Pendiente,Cuarentena,Aprobado,Recontrolado,Rechazado';
            OptionMembers = Pendiente,Cuarentena,Aprobado,Recontrolado,Rechazado;

            trigger OnValidate()
            begin
                Validate(Blocked, false);
                Validate(EstadoAprobadoPrevioCAL_BTC);
                if (EstadoControlCalidadCAL_BTC = EstadoControlCalidadCAL_BTC::Cuarentena) or (EstadoControlCalidadCAL_BTC = EstadoControlCalidadCAL_BTC::Rechazado) then Validate(Blocked, true);
            end;
        }
        field(65104; EstadoAprobadoPrevioCAL_BTC; Boolean)
        {
            Caption = 'Estado aprobado previo';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;

            trigger OnValidate()
            begin
                if EstadoAprobadoPrevioCAL_BTC = false then
                    if EstadoControlCalidadCAL_BTC = EstadoControlCalidadCAL_BTC::Aprobado then begin
                        Validate(EstadoAprobadoPrevioCAL_BTC, true);
                        Validate(FechaCaducidadPreviaCAL_BTC, FechaCaducidadCAL_BTC);
                    end;
            end;
        }
        field(65105; NoLoteExternoCAL_BTC; Code[20])
        {
            Caption = 'No. lote externo';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65106; FechaFabricacionCAL_BTC; Date)
        {
            Caption = 'Fecha fabricacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = true;
        }
        field(65107; FechaCaducidadPreviaCAL_BTC; Date)
        {
            Caption = 'Fecha caducidad previa';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65108; FotografiaAdjuntaCAL_BTC; Boolean)
        {
            Caption = 'Fotografia adjunta';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65109; ControlVisualObligCAL_BTC; Boolean)
        {
            Caption = 'Control visual obligatorio';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;

            trigger OnValidate()
            begin
                if ControlVisualObligCAL_BTC = true then
                    Validate(EstadoRevisionVisualCAL_BTC, EstadoRevisionVisualCAL_BTC::Pendiente)
                else
                    EstadoRevisionVisualCAL_BTC := EstadoRevisionVisualCAL_BTC::"No Obligatorio";
            end;
        }
        field(65110; FechaRecepcionCAL_BTC; Date)
        {
            Caption = 'Fecha recepcion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65111; ObservacionesCAL_BTC; Text[50])
        {
            Caption = 'Observaciones';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65112; AlbaranProveedorSICAL_BTC; Boolean)
        {
            Caption = 'Albaran Proveedor SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65113; AlbaranProveedorNOCAL_BTC; Boolean)
        {
            Caption = 'Albaran Proveedor NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65114; MercanciaConformeSICAL_BTC; Boolean)
        {
            Caption = 'Mercancia Conforme SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65115; MercanciaConformeNOCAL_BTC; Boolean)
        {
            Caption = 'Mercancia Conforme NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65116; FichaSeguridadSICAL_BTC; Boolean)
        {
            Caption = 'Ficha Seguridad SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65117; FichaSeguridadNOCAL_BTC; Boolean)
        {
            Caption = 'Ficha Seguridad NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65118; CertificadoAnalisisSICAL_BTC; Boolean)
        {
            Caption = 'Certificado Analisis SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65119; CertificadoAnalisisNOCAL_BTC; Boolean)
        {
            Caption = 'Certificado Analisis NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65120; RecipientesConformesSICAL_BTC; Boolean)
        {
            Caption = 'Recipientes Conformes SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65121; RecipientesConformesNOCAL_BTC; Boolean)
        {
            Caption = 'Recipientes Conformes NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65122; "Cierr/PrecinConformesSICAL_BTC"; Boolean)
        {
            Caption = 'Cierres/Precintos Conformes SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65123; "Cierr/PrecinConformesNOCAL_BTC"; Boolean)
        {
            Caption = 'Cierres/Precintos Conformes NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65124; PaletsLimpiosSICAL_BTC; Boolean)
        {
            Caption = 'Palets Limpios SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65125; PaletsLimpiosNOCAL_BTC; Boolean)
        {
            Caption = 'Palets Limpios NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65126; EtiqProveedorVisibleSICAL_BTC; Boolean)
        {
            Caption = 'Etiquetas Proveedor Visible SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65127; EtiqProveedorVisibleNOCAL_BTC; Boolean)
        {
            Caption = 'Etiquetas Proveedor Visible NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65128; "AusenciaContam/ManipuSICAL_BTC"; Boolean)
        {
            Caption = 'Ausencia Contam/Manipu SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65131; "AusenciaContam/ManipuNOCAL_BTC"; Boolean)
        {
            Caption = 'Ausencia Contam/Manipu NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65132; RecipientesLoteXPaletSICAL_BTC; Boolean)
        {
            Caption = 'Recipientes Lote por Palet SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65133; RecipientesLoteXPaletNOCAL_BTC; Boolean)
        {
            Caption = 'Recipientes Lote por Palet NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65134; CertificadPlaguicidasSICAL_BTC; Boolean)
        {
            Caption = 'Certificado Plaguicidas SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65135; CertificadPlaguicidasNOCAL_BTC; Boolean)
        {
            Caption = 'Certificado Plaguicidas NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65140; EstadoEnvasadoSICAL_BTC; Boolean)
        {
            Caption = 'Estado Envasado SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65141; EstadoEnvasadoNOCAL_BTC; Boolean)
        {
            Caption = 'Estado Envasado NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65142; EstadoEtiquetadoSICAL_BTC; Boolean)
        {
            Caption = 'Estado Etiquetado SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65143; EstadoEtiquetadoNOCAL_BTC; Boolean)
        {
            Caption = 'Estado Etiquetado NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65144; EstadoSanitarioSICAL_BTC; Boolean)
        {
            Caption = 'Estado Sanitario SI';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65145; EstadoSanitarioNOCAL_BTC; Boolean)
        {
            Caption = 'Estado Sanitario NO';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65200; MarcarTodoOKCAL_BTC; Boolean)
        {
            Caption = 'Marcar Todo OK';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';

            trigger OnValidate()
            begin
                if MarcarTodoOKCAL_BTC = true then Validate(MarcarTodoNOOKCAL_BTC, false);
                if MarcarTodoOKCAL_BTC = true then begin
                    AlbaranProveedorSICAL_BTC := true;
                    MercanciaConformeSICAL_BTC := true;
                    CertificadoAnalisisSICAL_BTC := true;
                    RecipientesConformesSICAL_BTC := true;
                    "Cierr/PrecinConformesSICAL_BTC" := true;
                    PaletsLimpiosSICAL_BTC := true;
                    EtiqProveedorVisibleSICAL_BTC := true;
                    "AusenciaContam/ManipuSICAL_BTC" := true;
                    RecipientesLoteXPaletSICAL_BTC := true;
                    FichaSeguridadSICAL_BTC := true;
                    CertificadPlaguicidasSICAL_BTC := true;
                    EstadoEnvasadoSICAL_BTC := true;
                    EstadoEtiquetadoSICAL_BTC := true;
                    EstadoSanitarioSICAL_BTC := true;
                end
                else begin
                    AlbaranProveedorSICAL_BTC := false;
                    MercanciaConformeSICAL_BTC := false;
                    CertificadoAnalisisSICAL_BTC := false;
                    RecipientesConformesSICAL_BTC := false;
                    "Cierr/PrecinConformesSICAL_BTC" := false;
                    PaletsLimpiosSICAL_BTC := false;
                    EtiqProveedorVisibleSICAL_BTC := false;
                    "AusenciaContam/ManipuSICAL_BTC" := false;
                    RecipientesLoteXPaletSICAL_BTC := false;
                    FichaSeguridadSICAL_BTC := false;
                    CertificadPlaguicidasSICAL_BTC := false;
                    EstadoEnvasadoSICAL_BTC := false;
                    EstadoEtiquetadoSICAL_BTC := false;
                    EstadoSanitarioSICAL_BTC := false;
                end;
            end;
        }
        field(65201; MarcarTodoNOOKCAL_BTC; Boolean)
        {
            Caption = 'Marcar Todo NO OK';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';

            trigger OnValidate()
            begin
                if MarcarTodoNOOKCAL_BTC = true then Validate(MarcarTodoOKCAL_BTC, false);
                if MarcarTodoNOOKCAL_BTC = true then begin
                    AlbaranProveedorNOCAL_BTC := true;
                    MercanciaConformeNOCAL_BTC := true;
                    CertificadoAnalisisNOCAL_BTC := true;
                    RecipientesConformesNOCAL_BTC := true;
                    "Cierr/PrecinConformesNOCAL_BTC" := true;
                    PaletsLimpiosNOCAL_BTC := true;
                    EtiqProveedorVisibleNOCAL_BTC := true;
                    "AusenciaContam/ManipuNOCAL_BTC" := true;
                    RecipientesLoteXPaletNOCAL_BTC := true;
                    FichaSeguridadNOCAL_BTC := true;
                    CertificadPlaguicidasNOCAL_BTC := true;
                end
                else begin
                    AlbaranProveedorNOCAL_BTC := false;
                    MercanciaConformeNOCAL_BTC := false;
                    CertificadoAnalisisNOCAL_BTC := false;
                    RecipientesConformesNOCAL_BTC := false;
                    "Cierr/PrecinConformesNOCAL_BTC" := false;
                    PaletsLimpiosNOCAL_BTC := false;
                    EtiqProveedorVisibleNOCAL_BTC := false;
                    "AusenciaContam/ManipuNOCAL_BTC" := false;
                    RecipientesLoteXPaletNOCAL_BTC := false;
                    FichaSeguridadNOCAL_BTC := false;
                    CertificadPlaguicidasNOCAL_BTC := false;
                end;
            end;
        }
        field(65202; UsuarioCreacionCAL_BTC; Code[50])
        {
            Caption = 'Usuario creacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID(UsuarioCreacionCAL_BTC);
            end;
        }
        field(65203; FechaUltimaModificacionCAL_BTC; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65204; UsuarioUltimaModificCAL_BTC; Code[50])
        {
            Caption = 'Usuario ultima modificacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID(UsuarioUltimaModificCAL_BTC);
            end;
        }
        field(65300; VisadoXUsuarioCAL_BTC; Code[50])
        {
            Caption = 'Lanzado por usuario';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID(VisadoXUsuarioCAL_BTC);
            end;
        }
        field(65301; FechaVisadoCAL_BTC; DateTime)
        {
            Caption = 'Fecha lanzamiento';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65302; RevisadoXusuarioCAL_BTC; Code[50])
        {
            Caption = 'Lanzado por usuario';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID(RevisadoXusuarioCAL_BTC);
            end;
        }
        field(65303; FechaRevisadoCAL_BTC; DateTime)
        {
            Caption = 'Fecha lanzamiento';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65304; EstadoRevisionVisualCAL_BTC; Option)
        {
            Caption = 'Estado revisión visual';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            OptionCaption = 'Pendiente,Visado,Revisado,No Obligatorio';
            OptionMembers = Pendiente,Visado,Revisado,"No Obligatorio";

            trigger OnValidate()
            var
                GestionCalidadSetupCAL_BTC: Record "Setup Calidad_CAL_btc";
                SMTPMailSetupCAL_BTC: Record "SMTP Mail Setup";
                UserSetup: Record "User Setup";
                cduSMTP: Codeunit "SMTP Mail";
                Respuesta: Boolean;
                PopUp: Boolean;
                DCActivaCAL_BTC: Boolean;
                DateTimeBlank: DateTime;
                MailEmisorCAL_BTC: Text[50];
                MailReceptoresCAL_BTC: Text[150];
                MailAsuntoCAL_BTC: Text[300];
                MailCuerpoCAL_BTC: Text[600];
                CR: Char;
                LF: Char;
            begin
                if ControlVisualObligCAL_BTC = true then if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::"No Obligatorio" then Error('Aviso: La inspección visual es obligatoria');
                if ControlVisualObligCAL_BTC = false then begin
                    Respuesta := DIALOG.Confirm(ControlVisualNoObligaQst, true, "Lot No.");
                    ControlVisualObligCAL_BTC := Respuesta;
                    if ControlVisualObligCAL_BTC = false then Error('Aviso: La inspección visual no es obligatoria');
                    Validate(ControlVisualObligCAL_BTC);
                end;
                Clear(DateTimeBlank);
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Pendiente then begin
                    Clear(VisadoXUsuarioCAL_BTC);
                    Validate(FechaVisadoCAL_BTC, DateTimeBlank);
                    Clear(RevisadoXusuarioCAL_BTC);
                    Validate(FechaRevisadoCAL_BTC, DateTimeBlank);
                    Clear("Test Quality");
                end;
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Pendiente then
                    if InspeccionDeCalidadCAL_BTC = false then begin
                        Clear("Test Quality");
                        Validate(EstadoControlCalidadCAL_BTC, EstadoControlCalidadCAL_BTC::Cuarentena);
                    end;
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Revisado then if TestQualityCAL_BTC = TestQualityCAL_BTC::Bad then Validate(TestQualityCAL_BTC, TestQualityCAL_BTC::Blocked);
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Revisado then if TestQualityCAL_BTC = TestQualityCAL_BTC::Blocked then Validate(Blocked, true);
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Revisado then if TestQualityCAL_BTC = TestQualityCAL_BTC::Blocked then if EstadoControlCalidadCAL_BTC = EstadoControlCalidadCAL_BTC::Cuarentena then if InspeccionDeCalidadCAL_BTC = false then Validate(EstadoControlCalidadCAL_BTC, EstadoControlCalidadCAL_BTC::Rechazado);
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Revisado then if TestQualityCAL_BTC <> TestQualityCAL_BTC::Blocked then if InspeccionDeCalidadCAL_BTC = false then Validate(EstadoControlCalidadCAL_BTC, EstadoControlCalidadCAL_BTC::Aprobado);
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Revisado then if TestQualityCAL_BTC = TestQualityCAL_BTC::Blocked then if InspeccionDeCalidadCAL_BTC = false then Validate(EstadoControlCalidadCAL_BTC, EstadoControlCalidadCAL_BTC::Rechazado);
                if (EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Visado) then begin
                    GestionCalidadSetupCAL_BTC.Init();
                    GestionCalidadSetupCAL_BTC.Get();
                    DCActivaCAL_BTC := GestionCalidadSetupCAL_BTC."Activar doble confirmacion";
                    if DCActivaCAL_BTC then begin
                        SMTPMailSetupCAL_BTC.Init();
                        SMTPMailSetupCAL_BTC.Get();
                        SMTPMailSetupCAL_BTC.TestField("SMTP Server");
                        MailEmisorCAL_BTC := SMTPMailSetupCAL_BTC."User ID";
                        if ProcedenciaCreacionCAL_BTC = ProcedenciaCreacionCAL_BTC::"Recepción" then MailReceptoresCAL_BTC := GestionCalidadSetupCAL_BTC."Receptores DC Control Visual R";
                        if ProcedenciaCreacionCAL_BTC = ProcedenciaCreacionCAL_BTC::"Fabricación" then MailReceptoresCAL_BTC := GestionCalidadSetupCAL_BTC."Receptores DC Control Visual F";
                        PopUp := GestionCalidadSetupCAL_BTC."Activar aviso mensajes emisor";
                        CR := 13;
                        LF := 10;
                    end;
                end;
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Visado then begin
                    if "Test Quality" = "Test Quality"::" " then Error('Atención: antes de visar debe cualificar el control visual: Bueno, Promedio, Bloquear');
                    Validate(FechaVisadoCAL_BTC, CurrentDateTime());
                    VisadoXUsuarioCAL_BTC := UserId();
                    Clear(RevisadoXusuarioCAL_BTC);
                    Validate(FechaRevisadoCAL_BTC, DateTimeBlank);
                    if DCActivaCAL_BTC = true then begin
                        if MailEmisorCAL_BTC = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la doble confirmación');
                        if MailReceptoresCAL_BTC = '' then Error('Atención: debe configurar los usuarios receptores del aviso de visado para la doble confirmación');
                        MailAsuntoCAL_BTC := 'Aviso Automático. Control Visual del Lote: ' + Format("Lot No.") + ' Visado por: ' + Format(VisadoXUsuarioCAL_BTC) + 'Control Visual: ' + Format("Test Quality") + ' Prioridad: ' + Format(PrioridadCAL_BTC) + ' - Pendiente de Revisar';
                        MailCuerpoCAL_BTC := 'Control Visual del Lote: ' + Format("Lot No.") + ' del Producto: ' + Format("Item No.") + ' - ' + Description + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'en Estado Visado ' + ' por: ' + Format(VisadoXUsuarioCAL_BTC) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Control Visual: ' + Format("Test Quality") + ' Prioridad: ' + Format(PrioridadCAL_BTC) + ' - Pendiente de Revisar (doble confirmación) en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisorCAL_BTC + ' por el sistema de dobles confirmaciones';
                        Clear(cduSMTP);
                        cduSMTP.CreateMessage('Doble Confirmación', MailEmisorCAL_BTC, MailReceptoresCAL_BTC, MailAsuntoCAL_BTC, MailCuerpoCAL_BTC, false);
                        cduSMTP.Send();
                        if PopUp then Message('Correo enviado a los Revisores');
                    end;
                end;
                if (EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Revisado) then begin
                    GestionCalidadSetupCAL_BTC.Init();
                    GestionCalidadSetupCAL_BTC.Get();
                    DCActivaCAL_BTC := GestionCalidadSetupCAL_BTC."Activar doble confirmacion";
                    if DCActivaCAL_BTC then begin
                        SMTPMailSetupCAL_BTC.Init();
                        SMTPMailSetupCAL_BTC.Get();
                        SMTPMailSetupCAL_BTC.TestField("SMTP Server");
                        MailEmisorCAL_BTC := SMTPMailSetupCAL_BTC."User ID";
                        if ProcedenciaCreacionCAL_BTC = ProcedenciaCreacionCAL_BTC::"Recepción" then MailReceptoresCAL_BTC := GestionCalidadSetupCAL_BTC."Receptores Cert. Insp. Recep.";
                        if ProcedenciaCreacionCAL_BTC = ProcedenciaCreacionCAL_BTC::"Fabricación" then MailReceptoresCAL_BTC := GestionCalidadSetupCAL_BTC."Receptores Cert. Insp. Fabrica";
                        PopUp := GestionCalidadSetupCAL_BTC."Activar aviso mensajes emisor";
                        CR := 13;
                        LF := 10;
                    end;
                end;
                if EstadoRevisionVisualCAL_BTC = EstadoRevisionVisualCAL_BTC::Revisado then begin
                    if TestQualityCAL_BTC = TestQualityCAL_BTC::" " then Error('Atención: antes de revisar debe cualificar el control visual: Bueno, Promedio, Bloquear');
                    if FechaVisadoCAL_BTC = DateTimeBlank then Error('Estado Pendiente sólo puede cambiar a Visado');
                    Validate(FechaRevisadoCAL_BTC, CurrentDateTime());
                    RevisadoXusuarioCAL_BTC := UserId();
                    if DCActivaCAL_BTC then begin
                        UserSetup.Init();
                        if not UserSetup.Get(RevisadoXusuarioCAL_BTC) then Error('El usuario no dispone de configuración');
                        if UserSetup.Get(RevisadoXusuarioCAL_BTC) then if UserSetup.SupervisorDCControlVisuCAL_BTC = false then Error('Usuario no autorizado para realizar la revisión visual (Doble Confirmación en Control Visual)');
                        if (VisadoXUsuarioCAL_BTC = RevisadoXusuarioCAL_BTC) then Error('Aviso de Doble Confirmación. El usuario que revisa debe ser distinto al que visa. Consulte a su supervisor');
                        if MailEmisorCAL_BTC = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la doble confirmación');
                        if MailReceptoresCAL_BTC = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la revisión');
                        MailAsuntoCAL_BTC := 'Aviso Automático. Control Visual del Lote: ' + Format("Lot No.") + ' Revisado por: ' + Format(RevisadoXusuarioCAL_BTC) + 'Control Visual: ' + Format("Test Quality") + ' Prioridad: ' + Format(PrioridadCAL_BTC);
                        MailCuerpoCAL_BTC := 'Control Visual del Lote: ' + Format("Lot No.") + ' del Producto: ' + Format("Item No.") + ' - ' + Description + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'en Estado Revisado ' + ' por: ' + Format(RevisadoXusuarioCAL_BTC) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Control Visual: ' + Format("Test Quality") + ' Prioridad: ' + Format(PrioridadCAL_BTC) + ' - Revisado en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisorCAL_BTC + ' por el sistema de dobles confirmaciones';
                        Clear(cduSMTP);
                        cduSMTP.CreateMessage('Doble Confirmación', MailEmisorCAL_BTC, MailReceptoresCAL_BTC, MailAsuntoCAL_BTC, MailCuerpoCAL_BTC, false);
                        cduSMTP.Send();
                        if PopUp then Message('Correo enviado a los Receptores del Control Visual');
                    end;
                end;
            end;
        }
        field(65400; ProcedenciaCreacionCAL_BTC; Option)
        {
            Caption = 'Procedencia creación';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
            OptionCaption = 'Recepción,Fabricación';
            OptionMembers = "Recepción","Fabricación";
        }
        field(65401; LoteOrigenReclasificaCAL_BTC; Code[20])
        {
            Caption = 'Nº Lote Origen Reclasificación';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65402; PrioridadCAL_BTC; Option)
        {
            Caption = 'Prioridad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
            OptionCaption = ' ,A,B,C,D,E';
            OptionMembers = " ",A,B,C,D,E;
        }
        field(65403; ProdOrderNoCAL_BTC; Code[20])
        {
            Caption = 'Prod. Order No.';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released | Finished));
        }
        field(65404; FechaCaducidadAnteriorCAL_BTC; Date)
        {
            Caption = 'Fecha caducidad anterior';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65405; FechaCaduCambiadaPorCAL_BTC; Code[50])
        {
            Caption = 'Fecha caducidad cambiada por';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65406; FechaFabricacionAnteriCAL_BTC; Date)
        {
            Caption = 'Fecha fabricación anterior';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65407; FechaFabricacionCambiXCAL_BTC; Code[50])
        {
            Caption = 'Fecha fabricación cambiada por';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65408; TestQualityCAL_BTC; Option)
        {
            Caption = 'Test Quality';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Good,Average,Bad,Blocked';
            OptionMembers = " ",Good,"Average",Bad,Blocked;
        }
    }
    var
        ControlVisualNoObligaQst: Label 'El Control Visual no es Obligatorio para este Lote %1 ¿Desea hacerlo obligatorio?';
}
