table 65101 "Plantilla de inseval_CAL_btc"
{
    Caption = 'Plantilla de inspección/evaluación';
    DrillDownPageID = "Plantillas Inspección_CAL_btc";
    LookupPageID = "Plantillas Inspección_CAL_btc";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "No. revisión"; Integer)
        {
            Caption = 'No. revision';
            Editable = false;
            InitValue = 0;
        }
        field(3; "Version activa"; Boolean)
        {
            Caption = 'Version activa';

            trigger OnValidate()
            var
                Plantilla: Record "Plantilla de inseval_CAL_btc";
            begin
                if not "Version activa" then begin
                    Clear("Activada por usuario");
                    Validate("Fecha activación", DateTimeBlank);
                end
                else begin
                    if Estado <> Estado::Certificada then Error('Atención: sólo puede activarse una versión en estado certificada');
                    "Activada por usuario" := FORMAT(UserId());
                    Validate("Fecha activación", CurrentDateTime());
                    Clear(DateTimeBlank);
                    Plantilla.SetRange("No.", "No.");
                    Plantilla.SetFilter("No. revisión", '<>%1', "No. revisión");
                    Plantilla.ModifyAll("Version activa", false);
                    Plantilla.ModifyAll("Activada por usuario", '');
                    Plantilla.ModifyAll("Fecha activación", DateTimeBlank);
                end;
            end;
        }
        field(4; Estado; Option)
        {
            Caption = 'Estado';
            OptionCaption = 'Abierta,Lanzada,Certificada,Terminada';
            OptionMembers = Abierta,Lanzada,Certificada,Terminada;

            trigger OnValidate()
            begin
                Clear(DateTimeBlank);
                if Estado = Estado::Abierta then begin
                    Clear("Lanzado por usuario");
                    Validate("Fecha lanzamiento", DateTimeBlank);
                    Clear("Certificado por usuario");
                    Validate("Fecha certificación", DateTimeBlank);
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                    Clear("Version activa");
                    Clear("Activada por usuario");
                    Validate("Fecha activación", DateTimeBlank);
                end;
                if (Estado = Estado::Lanzada) or (Estado = Estado::Certificada) then begin
                    GestionCalidadSetup.Init();
                    GestionCalidadSetup.Get();
                    DCActiva := GestionCalidadSetup."Activar doble confirmacion";
                    if DCActiva then begin
                        SMTPMailSetup.Init();
                        SMTPMailSetup.Get();
                        SMTPMailSetup.TestField("SMTP Server");
                        MailEmisor := SMTPMailSetup."User ID";
                        MailReceptores := GestionCalidadSetup."Receptores DC Calidad";
                        CR := 13;
                        LF := 10;
                    end;
                end;
                if Estado = Estado::Lanzada then begin
                    "Lanzado por usuario" := UserId();
                    Validate("Fecha lanzamiento", CurrentDateTime());
                    Clear("Certificado por usuario");
                    Validate("Fecha certificación", DateTimeBlank);
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                    if DCActiva = true then begin
                        if MailEmisor = '' then Error('Atención: debe configurar el usuario emisor del correo SMTP de la doble confirmación');
                        if MailReceptores = '' then Error('Atención: debe configurar los usuarios receptores del aviso de la doble confirmación');
                        MailAsunto := 'Aviso Automático. Plantilla de Inspección: ' + Format("No.") + ' Lanzada por: ' + Format(UserId()) + ' Pendiente de Certificar';
                        MailCuerpo := 'Plantilla de Inspección: ' + Format("No.") + ' en Estado Lanzada: ' + ' por: ' + Format(UserId()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Pendiente de Certificar (doble confirmación) en fecha/hora: ' + Format(CurrentDateTime()) + Format(CR, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + Format(LF, 0, '<CHAR>') + 'Mensaje automático emitido desde ' + MailEmisor + ' por el sistema de dobles confirmaciones';
                        Clear(cduSMTP);
                        cduSMTP.CreateMessage('Doble Confirmación', MailEmisor, MailReceptores, MailAsunto, MailCuerpo, false);
                        cduSMTP.Send();
                        Message('Correo enviado a los Certificadores');
                    end;
                end;
                if Estado = Estado::Certificada then begin
                    if "Fecha lanzamiento" = DateTimeBlank then Error('Estado Abierta sólo puede cambiar a Lanzada');
                    if DCActiva then begin
                        UserSetup.Init();
                        if not UserSetup.Get(UserId()) then Error('El usuario no dispone de configuración');
                        if ("Lanzado por usuario" = UserId()) then Error('Aviso de Doble Confirmación. El usuario que certifica debe ser distinto al que lanza. Consulte a su supervisor');
                    end;
                    "Certificado por usuario" := UserId();
                    Validate("Fecha certificación", CurrentDateTime());
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                end;
                if Estado = Estado::Terminada then begin
                    if "Fecha certificación" = DateTimeBlank then Error('Estado Lanzada sólo puede cambiar a Certificada');
                    if "Version activa" then Error('Atención: no se puede cambiar a Terminada la plantilla activa. Desactívela primero');
                    "Terminado por usuario" := UserId();
                    Validate("Fecha terminación", CurrentDateTime());
                end;
            end;
        }
        field(5; Descripcion; Text[50])
        {
            Caption = 'Descripcion';
        }
        field(6; "Origen inspección"; enum OrigenCalidad)
        {
            /*
                  Caption = 'Origen inspeccion';
                  OptionCaption = 'Recepción,Almacén,Fabricación,Envío,Devolución,Procesos,Evaluación,Reclamación,Muestras,Mat.Gráfico';
                  OptionMembers = "Recepción","Almacén","Fabricación","Envío","Devolución",Procesos,"Evaluación","Reclamación",Muestras,"Mat.Gráfico";
                  */
            Caption = 'Origin Inspection', comment = 'ESP="Origen Inspección"';
            ObsoleteState = Removed;
        }
        field(7; "Objeto inspección"; Option)
        {
            Caption = 'Objeto inspeccion';
            OptionCaption = 'Lote,Muestra,Proceso,Proveedor/Cliente';
            OptionMembers = Lote,Muestra,Proceso,"Proveedor/Cliente";
        }
        field(8; "Tamaño muestra recomendado"; Decimal)
        {
            Caption = 'Tamaño muestra recomendado';
        }
        field(9; "% muestra recomendado"; Decimal)
        {
            Caption = '% muestra recomendado';
        }
        field(10; "Fecha creación"; Date)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(11; "Usuario creación"; Code[50])
        {
            Caption = 'Usuario creacion';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                UserMgt.LookupUserID("Usuario creación");
            end;
        }
        field(12; "Fecha ultima modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(13; "Usuario ultima modificación"; Code[50])
        {
            Caption = 'Usuario ultima modificacion';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                UserMgt.LookupUserID("Usuario ultima modificación");
            end;
        }
        field(14; "Tipo inspección"; Option)
        {
            Caption = 'Tipo inspeccion';
            OptionCaption = 'Normal,Rigurosa,Reducida,Estabilidad';
            OptionMembers = Normal,Rigurosa,Reducida,Estabilidad;
        }
        field(15; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(16; "Certificado por usuario"; Code[50])
        {
            Caption = 'Certificado  por usuario';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                UserMgt.LookupUserID("Certificado por usuario");
            end;
        }
        field(17; "Fecha certificación"; DateTime)
        {
            Caption = 'Fecha certificación';
            Editable = false;
        }
        field(18; "Activada por usuario"; Code[50])
        {
            Caption = 'Activada por usuario';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                UserMgt.LookupUserID("Activada por usuario");
            end;
        }
        field(19; "Fecha activación"; DateTime)
        {
            Caption = 'Fecha activación';
            Editable = false;
        }
        field(20; "Lanzado por usuario"; Code[50])
        {
            Caption = 'Lanzado por usuario';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                UserMgt.LookupUserID("Lanzado por usuario");
            end;
        }
        field(21; "Fecha lanzamiento"; DateTime)
        {
            Caption = 'Fecha lanzamiento';
            Editable = false;
        }
        field(83; "Terminado por usuario"; Code[50])
        {
            Caption = 'Lanzado por usuario';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                UserMgt.LookupUserID("Terminado por usuario");
            end;
        }
        field(84; "Fecha terminación"; DateTime)
        {
            Caption = 'Fecha lanzamiento';
            Editable = false;
        }
        field(88; "Criterio de muestreo"; Option)
        {
            Caption = 'Criterio de muestreo';
            OptionCaption = 'Discrecional,Fijo,Porcentual,Probabilístico';
            OptionMembers = Discrecional,Fijo,Porcentual,"Probabilístico";
        }
        field(89; "Tipo de Requisitos Específicos"; Option)
        {
            Caption = 'Tipo de Requisitos Específicos';
            OptionCaption = 'Sin Específicos,Específicos y No Específicos,Sólo Específicos';
            OptionMembers = "Sin Específicos","Específicos y No Específicos","Sólo Específicos";
        }
        field(90; TablaOrigen; Integer)
        {
            Caption = 'Origin Table ID', comment = 'ESP="Id Tabla Origen"';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
            ObsoleteState = Removed;

            trigger OnValidate()
            begin
                //CodEspecifico := '';
            end;
        }
        field(91; NombreTablaOrigen; Text[30])
        {
            Editable = false;
            Caption = 'Origin tablename', comment = 'ESP="Nombre Tabla Origen"';
            /*
                  FieldClass = FlowField;
                  CalcFormula = lookup (AllObjWithCaption."Object Name" where("Object Type" = CONST(Table), "Object ID" = field(TablaOrigen)));
                  */
            ObsoleteState = Removed;
        }
        field(93; CaptionTablaOrigen; Text[30])
        {
            Editable = false;
            Caption = 'Origin table caption', comment = 'ESP="Caption Tabla Origen"';
            /*
                  FieldClass = FlowField;
                  CalcFormula = lookup (AllObjWithCaption."Object Caption" where("Object Type" = CONST(Table), "Object ID" = field(TablaOrigen)));
                  */
            ObsoleteState = Removed;
        }
        field(92; CodEspecifico; Code[20])
        {
            Caption = 'Specific code', comment = 'ESP="Código específico"';
            ObsoleteState = Removed;
            /*TableRelation = if (TablaOrigenEspecifico = const(Cliente)) Customer
                    else
                    if (TablaOrigenEspecifico = const(Proveedor)) Vendor
                    else
                    if (TablaOrigenEspecifico = Const(Producto)) Item
                    else
                    if (TablaOrigenEspecifico = Const(Empleado)) Employee
                    ; */
        }
        field(94; TablaOrigenEspecifico; Enum TiposCodigosEspecificos)
        {
            Caption = 'Source table specific code', comment = 'ESP="Tabla origen código específico"';
            ObsoleteState = Removed;

            trigger OnValidate()
            begin
                //CodEspecifico := '';
            end;
        }
    }
    keys
    {
        key(Key1; "No.", "No. revisión")
        {
        }
        /*key(Key2; "Origen inspección", "No.", "No. revisión")
              {
              }*/
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "No. revisión", Descripcion)
        {
        }
    }
    trigger OnDelete()
    var
        GruposPorPlantilla: Record "Grupos inspec x planta_CAL_btc";
    begin
        if "Version activa" then Error('Atención: no se puede borrar la plantilla activa');
        if Estado <> Estado::Abierta then Error('Atención: solo se puede borrar una plantilla en estado Abierta');
        GruposPorPlantilla.SetRange("Cód. plantilla", "No.");
        GruposPorPlantilla.SetRange("No. revision plantilla", "No. revisión");
        GruposPorPlantilla.DeleteAll(true);
    end;

    trigger OnInsert()
    var
    begin
        Validate("Fecha creación", WorkDate());
        "Usuario creación" := UserId();
        SetNumRevision();
    end;

    trigger OnModify()
    var
    begin
        Validate("Fecha ultima modificación", CurrentDateTime());
        "Usuario ultima modificación" := UserId();
    end;

    var
        UserSetup: Record "User Setup";
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        SMTPMailSetup: Record "SMTP Mail Setup";
        UserMgt: Codeunit "User Management";
        cduSMTP: Codeunit "SMTP Mail";
        DateTimeBlank: DateTime;
        DCActiva: Boolean;
        MailEmisor: Text[50];
        MailReceptores: Text[150];
        MailAsunto: Text[300];
        MailCuerpo: Text[500];
        CR: Char;
        LF: Char;

    procedure EsVersionActiva()
    var
        Plantilla: Record "Plantilla de inseval_CAL_btc";
    begin
        Plantilla.SetRange("No.", "No.");
        Plantilla.SetFilter("No. revisión", '<>%1', "No. revisión");
        if Plantilla.Count() = 0 then begin
            Validate("Version activa", true);
            exit;
        end;
        Plantilla.FindLast();
        if Plantilla."No. revisión" < "No. revisión" then begin
            Validate("Version activa", true);
            exit;
        end;
        Validate("Version activa", false);
    end;

    procedure SetNumRevision()
    var
        Plantilla: Record "Plantilla de inseval_CAL_btc";
    begin
        Plantilla.SetRange("No.", "No.");
        if Plantilla.FindLast() then
            "No. revisión" := Plantilla."No. revisión" + 1
        else
            "No. revisión" := 1;
    end;
}
