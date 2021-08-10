table 65111 "Cab inspe eval_CAL_btc"
{
    Caption = 'Cab. inspeccion/eval. calidad';
    DrillDownPageID = "Inspecciones de Calida_CAL_btc";
    LookupPageID = "Inspecciones de Calida_CAL_btc";

    fields
    {
        field(1; "Origen inspección"; enum OrigenCalidad)
        {
            /*Caption = 'Origen inspección';
                  OptionCaption = 'Recepción,Almacén,Fabricación,Envío,Devolución,Procesos,Evaluación,Reclamación,Muestras,Mat.Gráfico';
                  OptionMembers = "Recepción","Almacén","Fabricación","Envío","Devolución",Procesos,"Evaluación","Reclamación",Muestras,"Mat.Gráfico";
                  ObsoleteState = Removed;*/
            Caption = 'Origin Inspection', comment = 'ESP="Origen Inspección"';
            Editable = false;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            //ObsoleteState = Removed;
        }
        field(4; "Cód. plantilla"; Code[20])
        {
            Caption = 'Cod. plantilla';
            TableRelation = "Plantilla de inseval_CAL_btc"."No.";
        }
        field(5; "No. revision plantilla"; Integer)
        {
            Caption = 'No. revision plantilla';
            TableRelation = "Plantilla de inseval_CAL_btc"."No. revisión";
        }
        field(6; "Calidad concertada"; Boolean)
        {
            Caption = 'Calidad concertada';
        }
        field(7; "Certificado calidad concertada"; Code[20])
        {
            Caption = 'Certificado calidad concertada';
        }
        field(8; "Estado inspección"; Option)
        {
            Caption = 'Estado inspeccion';
            OptionCaption = 'Abierta,Lanzada,Certificada,Terminada';
            OptionMembers = Abierta,Lanzada,Certificada,Terminada;

            trigger OnValidate()
            begin
                Clear(DateTimeBlank);
                if "Estado inspección" = "Estado inspección"::Abierta then begin
                    Clear("Lanzado por usuario");
                    Validate("Fecha lanzamiento", DateTimeBlank);
                    Clear("Certificado por usuario");
                    Validate("Fecha certificación", DateTimeBlank);
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                end;
                if "Estado inspección" = "Estado inspección"::Lanzada then begin
                    "Lanzado por usuario" := UserId();
                    Validate("Fecha lanzamiento", CurrentDateTime());
                    Clear("Certificado por usuario");
                    Validate("Fecha certificación", DateTimeBlank);
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                end;
                if "Estado inspección" = "Estado inspección"::Certificada then begin
                    "Certificado por usuario" := UserId();
                    Validate("Fecha certificación", CurrentDateTime());
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                end;
                if "Estado inspección" = "Estado inspección"::Terminada then begin
                    "Terminado por usuario" := UserId();
                    Validate("Fecha terminación", CurrentDateTime());
                end;
            end;
        }
        field(9; "Descripción"; Text[50])
        {
            Caption = 'Descripcion';
        }
        field(10; "Tipo inspección"; Option)
        {
            Caption = 'Tipo inspeccion';
            OptionMembers = Normal,Rigurosa,Reducida,Estabilidad;
        }
        field(11; "Objeto inspección"; Option)
        {
            Caption = 'Objeto inspeccion';
            OptionCaption = 'Lote,Muestra,Proceso,Proveedor/Cliente';
            OptionMembers = Lote,Muestra,Proceso,"Proveedor/Cliente";
        }
        field(12; "Tamaño muestra recomendado"; Decimal)
        {
            BlankZero = true;
            Caption = 'Tamaño muestra recomendado';
        }
        field(13; "% muestra recomendado"; Decimal)
        {
            BlankZero = true;
            Caption = '% muestra recomendado';
        }
        field(14; "No. producto"; Code[20])
        {
            Caption = 'No. producto';
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                CalcFields("Descripción producto");
                CalcFields("Item Category Code");
                CalcFields("Product Group Code");
                if not Item.Get("No. producto") then begin
                    Validate("Unidad de medida", '');
                    Validate("Calidad concertada", false);
                    Validate("Certificado calidad concertada", '');
                    //TODO: Revisar caso de muestras
                end;
                /*
                          end else
                              if ("Origen inspección" = "Origen inspección"::Muestras) then begin
                                  BorradoLineas();
                                  Validate("Unidad de medida", Item."Base Unit of Measure");
                                  Validate("Calidad concertada", Item.CalidadConcertadaCAL_BTC);
                                  Validate("Certificado calidad concertada", Item.CertificCalidadConcertCAL_BTC);
                                  CrearLineas();
                              end;
                          */
            end;
        }
        field(15; "Cód. variante"; Code[10])
        {
            Caption = 'Cod. variante';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("No. producto"));
        }
        field(16; "Cantidad Lote"; Decimal)
        {
            BlankZero = true;
            Caption = 'Cantidad Lote';
            DecimalPlaces = 0 : 0;
        }
        field(17; "Unidad de medida"; Code[10])
        {
            Caption = 'Unidad de medida';
            TableRelation = "Unit of Measure";
        }
        field(18; "No. lote inspeccionado"; Code[20])
        {
            Caption = 'No. lote inspeccionado';
            TableRelation = "Lot No. Information"."Lot No." WHERE("Item No." = FIELD("No. producto"), "Variant Code" = FIELD("Cód. variante"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RecInfo.Reset();
                if RecInfo.Get("No. producto", '', "No. lote inspeccionado") then begin
                    "Fecha fabricación" := RecInfo.FechaFabricacionCAL_BTC;
                    "Fecha caducidad" := RecInfo.FechaCaducidadCAL_BTC;
                end;
            end;
        }
        field(19; "No. serie inspeccionado"; Code[20])
        {
            Caption = 'No. serie inspeccionado';
            TableRelation = "Serial No. Information"."Serial No." WHERE("Item No." = FIELD("No. producto"), "Variant Code" = FIELD("Cód. variante"));
            ValidateTableRelation = false;
        }
        field(20; "Fecha caducidad"; Date)
        {
            Caption = 'Fecha caducidad';
        }
        field(21; "Cód. almacén"; Code[10])
        {
            Caption = 'Cod. almacen';
            TableRelation = Location;

            trigger OnValidate()
            begin
                CalcFields("Descripción almacén");
            end;
        }
        field(22; "Cód. ubicación"; Code[20])
        {
            Caption = 'Cod. ubicacion';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Cód. almacén"));

            trigger OnValidate()
            begin
                CalcFields("Descripción ubicación");
            end;
        }
        field(23; "No. proveedor"; Code[20])
        {
            Caption = 'No. proveedor';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                CalcFields("Descripción proveedor");
            end;
        }
        field(24; "No. cliente"; Code[20])
        {
            Caption = 'No. cliente';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CalcFields("Descripción cliente");
            end;
        }
        field(25; "No. pedido proveedor"; Code[20])
        {
            Caption = 'No. pedido proveedor';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FILTER(Order | "Return Order"));
        }
        field(26; "No. pedido cliente"; Code[20])
        {
            Caption = 'No. pedido cliente';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order | "Return Order"));
        }
        field(31; "No. orden produccion"; Code[20])
        {
            Caption = 'No. orden produccion';
            TableRelation = "Production Order"."No.";
        }
        field(32; "No. ruta produccion"; Code[20])
        {
            Caption = 'No. ruta produccion';
            TableRelation = "Routing Header";
        }
        field(33; "Fecha recepción"; Date)
        {
            Caption = 'Fecha recepcion';
        }
        field(34; "Observaciones inspección"; Text[50])
        {
            Caption = 'Observaciones inspeccion';
        }
        field(35; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(36; Conformidad; Boolean)
        {
            Caption = 'Conformidad';
            Editable = false;

            trigger OnValidate()
            begin
                if Conformidad = true then "No conformidad" := false;
            end;
        }
        field(37; "No conformidad"; Boolean)
        {
            Caption = 'No conformidad';
            Editable = false;

            trigger OnValidate()
            begin
                if "No conformidad" = true then Conformidad := false;
            end;
        }
        field(38; "No. No conformidad"; Code[20])
        {
            Caption = 'No. No conformidad';
            Editable = true;
            //BEGIN FJAB 311019 Cambio clave
            /*
                  TableRelation = "Cab no conformidad_CAL_btc"."No. no conformidad" WHERE("Origen inspección" = FIELD("Origen inspección"),
                                                                                           "No. inspección" = FIELD("No."));
                  */
            TableRelation = "Cab no conformidad_CAL_btc"."No. no conformidad" WHERE("Origen inspección" = FIELD("Origen inspección"), "Nº doc. Origen calidad" = FIELD("Nº doc. Origen calidad"), "Nº lín. doc. Origen calidad" = field("Nº lín. doc. Origen calidad"));
            //END FJAB 311019
        }
        field(39; Prioridad; Option)
        {
            Caption = 'Prioridad';
            Editable = false;
            OptionCaption = ' ,A,B,C,D,E';
            OptionMembers = " ",A,B,C,D,E;
        }
        field(40; "No. de serie"; Code[20])
        {
            Caption = 'No. de serie';
            Editable = false;
        }
        field(41; "Fecha creación"; Date)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(42; "Usuario creación"; Code[50])
        {
            Caption = 'Usuario creacion';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("Usuario creación");
            end;
        }
        field(43; "Fecha última modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(44; "Usuario última modificación"; Code[50])
        {
            Caption = 'Usuario ultima modificacion';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("Usuario última modificación");
            end;
        }
        field(45; "Certificado por usuario"; Code[50])
        {
            Caption = 'Certificado por usuario';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("Certificado por usuario");
            end;
        }
        field(46; "Descripción producto"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("No. producto")));
            Caption = 'Descripcion producto';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "Descripción almacén"; Text[50])
        {
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Cód. almacén")));
            Caption = 'Descripcion almacen';
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; "Descripción ubicación"; Text[50])
        {
            CalcFormula = Lookup(Bin.Description WHERE("Location Code" = FIELD("Cód. almacén"), Code = FIELD("Cód. ubicación")));
            Caption = 'Descripcion ubicacion';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Descripción proveedor"; Text[50])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("No. proveedor")));
            Caption = 'Descripcion proveedor';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Descripción cliente"; Text[50])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("No. cliente")));
            Caption = 'Descripcion cliente';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Requisitos pendientes evaluar"; Integer)
        {
            Caption = 'Requisitos pendientes evaluar';
            Editable = false;
        }
        field(54; Defectos; Boolean)
        {
            Caption = 'Defectos';
            Editable = false;
        }
        field(55; "Defectos clase A"; Integer)
        {
            BlankZero = true;
            Caption = 'Defectos clase A';
            Editable = false;
        }
        field(56; "Defectos clase B"; Integer)
        {
            BlankZero = true;
            Caption = 'Defectos clase B';
            Editable = false;
        }
        field(57; "Defectos clase C"; Integer)
        {
            BlankZero = true;
            Caption = 'Defectos clase C';
            Editable = false;
        }
        field(63; "Cód. tarea"; Code[10])
        {
            Caption = 'Cod. tarea';
            TableRelation = "Standard Task".Code;
        }
        field(64; "Cantidad Muestra Inspeccionar"; Decimal)
        {
            BlankZero = true;
            Caption = 'Cantidad Muestra a Inspeccionar';
            DecimalPlaces = 0 : 0;
        }
        field(65; "No. línea pedido proveedor"; Integer)
        {
            BlankZero = true;
            Caption = 'No. linea pedido proveedor';
        }
        field(66; "No. línea pedido cliente"; Integer)
        {
            BlankZero = true;
            Caption = 'No. linea pedido cliente';
        }
        field(68; "Cantidad Inspeccionada"; Decimal)
        {
            BlankZero = true;
            Caption = 'Cantidad Lote Inspeccionada';
            DecimalPlaces = 0 : 0;
        }
        field(69; "No. línea orden producción"; Integer)
        {
            BlankZero = true;
            Caption = 'No. linea orden produccion';
        }
        field(70; "Condiciones de almacenamiento"; Option)
        {
            Caption = 'Condiciones de almacenamiento';
            OptionCaption = ',Tª AMBIENTE,CONGELACION,REFRIGERACION,25ºC/60% HR,30ºC/60% HR';
            OptionMembers = ,"Tª AMBIENTE",CONGELACION,REFRIGERACION,"25ºC/60% HR","30ºC/60% HR";
        }
        field(71; "No. operación ruta fabricación"; Code[10])
        {
            Caption = 'No. operacion ruta fabricacion';
        }
        field(72; "Requisitos aceptables"; Integer)
        {
            Caption = 'Requisitos aceptables';
            Editable = false;
        }
        field(73; "Requisitos no aceptables"; Integer)
        {
            Caption = 'Requisitos no aceptables';
            Editable = false;
        }
        field(74; "Requisitos totales"; Integer)
        {
            Caption = 'Requisitos totales';
            Editable = false;
        }
        field(76; "Fecha certificación"; DateTime)
        {
            Caption = 'Fecha certificación';
            Editable = false;
        }
        field(77; "Evaluación Inspección"; Option)
        {
            Caption = 'Veredicto Inspeccion';
            OptionMembers = " ",Conforme,"No Conforme";
            OptionCaption = 'Nothing,According,Not compliant', Comment = 'ESP="Ninguno,Conforme,No Conforme"';
            Editable = false;
        }
        field(78; "Referencia de la muestra"; Code[20])
        {
            Caption = 'Referencia de la muestra';
        }
        field(79; "Proveedor de la muestra"; Code[20])
        {
            Caption = 'Proveedor de la muestra';
        }
        field(80; "Lanzado por usuario"; Code[50])
        {
            Caption = 'Lanzado por usuario';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("Certificado por usuario");
            end;
        }
        field(81; "Fecha lanzamiento"; DateTime)
        {
            Caption = 'Fecha lanzamiento';
            Editable = false;
        }
        field(82; "SubEstado inspección"; Option)
        {
            Caption = 'SubEstado inspección';
            OptionCaption = 'Pendiente,Cuarentena,Aprobado,Recontrolado,Rechazado';
            OptionMembers = Pendiente,Cuarentena,Aprobado,Recontrolado,Rechazado;
        }
        field(83; "Terminado por usuario"; Code[50])
        {
            Caption = 'Lanzado por usuario';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("Certificado por usuario");
            end;
        }
        field(84; "Fecha terminación"; DateTime)
        {
            Caption = 'Fecha terminación';
            Editable = false;
        }
        field(85; "Nueva fecha caducidad"; Date)
        {
            Caption = 'Nueva fecha caducidad';

            trigger OnValidate()
            begin
                UserSetup.Get(UserId());
                if not UserSetup.NuevaCaducidadLoteCAL_BTC then begin
                    Clear(DateBlank);
                    if ("Fecha caducidad" <> DateBlank) and ("Nueva fecha caducidad" <> DateBlank) then if ("Fecha caducidad" > "Nueva fecha caducidad") then Error('La nueva fecha de caducidad debe superior a la actual fecha de caducidad');
                end;
            end;
        }
        field(86; Recontrol; Boolean)
        {
            Caption = 'Recontrol';
        }
        field(87; "Fecha fabricación"; Date)
        {
            Caption = 'Fecha fabricación';
            Editable = false;
        }
        field(88; "Criterio de muestreo"; Option)
        {
            Caption = 'Criterio de muestreo';
            Editable = false;
            OptionCaption = 'DISCRECIONAL,FIJO,PORCENTUAL,PROBABILISTICO';
            OptionMembers = DISCRECIONAL,FIJO,PORCENTUAL,PROBABILISTICO;
        }
        field(89; "No. de muestra laboratorio"; Code[20])
        {
            Caption = 'Nº de muestra laboratorio';
        }
        field(100; "Puntos totales"; Decimal)
        {
            Caption = 'Puntos totales';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(101; "Tipo de Requisitos Específicos"; Option)
        {
            Caption = 'Tipo de Requisitos Específicos';
            Editable = false;
            OptionCaption = 'Sin Específicos,Específicos y No Específicos,Sólo Específicos';
            OptionMembers = "Sin Específicos","Específicos y No Específicos","Sólo Específicos";
        }
        field(102; "Item Category Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Item Category Code" WHERE("No." = FIELD("No. producto")));
            Caption = 'Item Category Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category";
        }
        field(103; "Product Group Code"; Code[10])
        {
            //Campo obsoleto 
            //CalcFormula = Lookup (Item."Product Group Code" WHERE ("No." = FIELD ("No. producto")));
            Caption = 'Product Group Code';
            Editable = false;
            //FieldClass = FlowField;
            //TableRelation = "Product Group".Code WHERE ("Item Category Code" = FIELD ("Item Category Code"));
            Enabled = false;
        }
        field(104; "Nº doc. Origen calidad"; Code[20])
        {
            Caption = 'Quality Origin Doc. No.', comment = 'ESP="Nº. Doc. Origen calidad"';
            Editable = false;
        }
        field(105; "Nº lín. doc. Origen calidad"; Integer)
        {
            Caption = 'Quality Origin Doc. Line No.', comment = 'ESP="Nº. Línea Doc. Origen calidad"';
            Editable = false;
        }
        field(106; "Nº línea componente producción"; Integer)
        {
            Caption = 'Prod order component line no.', comment = 'ESP="Nº línea componente OP"';
            Editable = false;
        }
        field(107; "NoDocLinOrigen_btc"; code[20])
        {
            Caption = 'Nº. línea origen calidad', comment = 'ESP="Nº. línea origen calidad."';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Line"."Document No." where("Document No." = field("Nº doc. Origen calidad"), "Line No." = field("Nº lín. doc. Origen calidad")));
        }
        field(50000; EntryNo; Integer)
        {
            Editable = false;
            TableRelation = "Item Ledger Entry"."Entry No.";
        }
        field(50001; QtytoReturn; Decimal)
        {
            TableRelation = "Item Ledger Entry"."Entry No.";
            Caption = 'Cantidad a devolver', comment = 'ESP="Cantidad a devolver"';
        }

        field(50002; InspeccionReturn; code[20])
        {
            Caption = 'Nº Inspección', comment = 'ESP="Nº Inspección"';
            Editable = false;
            TableRelation = "Item Ledger Entry"."Entry No.";
        }
        field(50003; "Cód. almacén destino"; Code[10])
        {
            Caption = 'Cod. almacen destino';
            TableRelation = Location;

            trigger OnValidate()
            begin
                if Rec."Cód. almacén" = rec."Cód. almacén destino" then
                    Error(text000);
            end;
        }
    }
    keys
    {
        //BEGIN FJAB 301019 Cambiar clave
        //key(Key1; "Origen inspección", "No.") {}
        //key(Key1; "Origen inspección", "Nº doc. Origen calidad", "Nº lín. doc. Origen calidad") { }
        key(Key1; "No.")
        {
        }
        //END FJAB 301019
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        BorradoLineas();
    end;

    trigger OnInsert()
    var
        GestionCalidadSetup: Record "Setup Calidad_CAL_btc";
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        NoSerieMgmt: Codeunit NoSeriesManagement;
    begin
        Validate("Fecha recepción", WorkDate());
        Validate("Fecha creación", WorkDate());
        "Usuario creación" := UserId();
        Validate("SubEstado inspección", "SubEstado inspección"::Cuarentena);
        //TODO: Revisar caso inserción de tipo muestras
        //BEGIN FJAB 311019 Esto crea cabecera y líneas de inspección con origen de muestras si no hay número de serie
        /*
            if "No. de serie" <> '' then
                NoSerieMgmt.InitSeries("No. de serie", xRec."No. de serie", "Fecha creación", "No.", "No. de serie")
            else begin
                Message(AvisInspMuestraMsg);

                GestionCalidadSetup.Get();
                GestionCalidadSetup.TestField("Activar gestión de la calidad");
                GestionCalidadSetup.TestField("No. serie insp. muestras");
                GestionCalidadSetup.TestField("Cód. plantilla muestras predet");
                GestionCalidadSetup.TestField("Almacén depósito para muestras");

                Validate("Origen inspección", "Origen inspección"::Muestras);
                Validate("No. de serie", GestionCalidadSetup."No. serie insp. muestras");
                NoSerieMgmt.InitSeries("No. de serie", xRec."No. de serie", "Fecha creación", "No.", "No. de serie");

                Plantilla.Reset();
                Plantilla.SetRange("No.", GestionCalidadSetup."Cód. plantilla muestras predet");
                Plantilla.SetRange(Bloqueado, false);
                Plantilla.SetRange("Version activa", true);
                Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
                if Plantilla.FindLast() = false then Error(PlanNDisErr, GestionCalidadSetup."Cód. plantilla muestras predet");

                Validate("Cód. plantilla", GestionCalidadSetup."Cód. plantilla muestras predet");
                Validate("No. revision plantilla", Plantilla."No. revisión");
                Validate(Descripción, Plantilla.Descripcion);
                Validate("Objeto inspección", Plantilla."Objeto inspección");
                Validate("Tipo inspección", Plantilla."Tipo inspección");
                Validate("Criterio de muestreo", Plantilla."Criterio de muestreo");
                Validate("Tamaño muestra recomendado", Plantilla."Tamaño muestra recomendado");
                Validate("% muestra recomendado", Plantilla."% muestra recomendado");
                Validate("Tipo de Requisitos Específicos", Plantilla."Tipo de Requisitos Específicos");
                Validate("Cód. almacén", GestionCalidadSetup."Almacén depósito para muestras");

                CrearLineas();
            end;
            */
        GestionCalidadSetup.Get;
        GestionCalidadSetup.TestField("No. serie Cab. Inspección");
        "No. de serie" := GestionCalidadSetup."No. serie Cab. Inspección";
        NoSerieMgmt.InitSeries("No. de serie", xRec."No. de serie", "Fecha creación", "No.", "No. de serie")//END FJAB 311019
    end;

    trigger OnModify()
    begin
        Validate("Fecha última modificación", CurrentDateTime());
        "Usuario última modificación" := UserId();
    end;

    var
        LinInspeccion: Record "Lin inspe eval_CAL_btc";
        RecDetallePlantilla: Record "Grupos inspec x planta_CAL_btc";
        RecDetalleGrupo: Record "Req Contr x grupo insp_CAL_btc";
        RecLinIns: Record "Lin inspe eval_CAL_btc";
        Requisitos: Record calidad_CAL_btc;
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        UserSetup: Record "User Setup";
        RecInfo: Record "Lot No. Information";
        PlanNDisErr: Label 'Plantilla %1 No Disponible. Revise Versiones Activas y/o Certificadas';
        GrupReqMsg: Label 'Grupo de Requisitos Plantilla %1 No Disponible. Revise Grupos de Requisitos Bloqueados';
        GrupPlaMsg: Label 'Plantilla %1 sin Grupo de Requisitos';
        InspMueMsg: Label 'Inspección de Calidad de Producto en Recepción %1 creada';
        AvisInspMuestraMsg: Label 'La creación directa de una Inspección está reservada a las Muestras. Para los demás casos diríjase a la transacción correspondiente. Se procede a crear Inspección de Muestras';
        DateTimeBlank: DateTime;
        DateBlank: Date;
        NumLin: Integer;
        text000: Label 'No puede ser el almacén destino el mismo que el origen', comment = 'ESP="No puede ser el almacén destino el mismo que el origen"';

    procedure CalcCantidadSugerida()
    begin
        if "Criterio de muestreo" = "Criterio de muestreo"::DISCRECIONAL then exit;
        if "Criterio de muestreo" = "Criterio de muestreo"::FIJO then Validate("Cantidad Muestra Inspeccionar", "Tamaño muestra recomendado");
        if "Criterio de muestreo" = "Criterio de muestreo"::PORCENTUAL then if ("Cantidad Lote" > 0) and ("% muestra recomendado" > 0) then Validate("Cantidad Muestra Inspeccionar", Round("Cantidad Lote" * "% muestra recomendado") / 100);
        if "Criterio de muestreo" = "Criterio de muestreo"::PROBABILISTICO then if ("Cantidad Lote" > 0) then Validate("Cantidad Muestra Inspeccionar", Round((2 * (Power("Cantidad Lote", 0.5))) + 1));
    end;
    //BEGIN FJAB 311019 Solo se usa en el caso de las muestras
    /*
      local procedure CrearLineas()
      begin

          Clear(NumLin);
          RecDetallePlantilla.Reset();
          RecDetallePlantilla.SetRange(Bloqueado, false);
          RecDetallePlantilla.SetRange("Cód. plantilla", "Cód. plantilla");
          RecDetallePlantilla.SetRange("No. revision plantilla", "No. revision plantilla");
          if RecDetallePlantilla.FindSet() then
              repeat
                  RecDetalleGrupo.Reset();
                  RecDetalleGrupo.SetRange(Bloqueado, false);
                  RecDetalleGrupo.SetRange("Cód. grupo inspección", RecDetallePlantilla."Cod. grupo inspección");
                  if RecDetalleGrupo.FindSet() then
                      repeat
                          RecLinIns.Init();
                          RecLinIns.Validate("Origen inspección", "Origen inspección");
                          RecLinIns.Validate("No. inspección", "No.");
                          RecLinIns.Validate("Cód. grupo inspección", RecDetalleGrupo."Cód. grupo inspección");
                          if Requisitos.Get(RecDetalleGrupo."Cod. requisito control") then
                              if Requisitos.Bloqueado = false then begin
                                  if "Tipo de Requisitos Específicos" = "Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                      ReqEspecificos.Init();
                                      if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, RecDetalleGrupo."Cod. requisito control", "No. producto", "Cód. variante") then
                                          if ReqEspecificos.Bloqueado = false then begin
                                              RecLinIns.Validate("No. producto", "No. producto");
                                              RecLinIns.Validate("Cód. variante", "Cód. variante");
                                              RecLinIns.Validate("No. proveedor", "No. proveedor");
                                              RecLinIns.Validate("No. cliente", "No. cliente");
                                              RecLinIns.Validate("Cód. tarea", "Cód. tarea");
                                              RecLinIns.Validate("Tipo de Requisitos Específicos", "Tipo de Requisitos Específicos");
                                              RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                              NumLin += 10000;
                                              RecLinIns.Validate("No. línea", NumLin);
                                              RecLinIns.Insert(true);
                                          end;
                                  end;
                                  if "Tipo de Requisitos Específicos" <> "Tipo de Requisitos Específicos"::"Sólo Específicos" then begin
                                      RecLinIns.Validate("No. producto", "No. producto");
                                      RecLinIns.Validate("Cód. variante", "Cód. variante");
                                      RecLinIns.Validate("No. proveedor", "No. proveedor");
                                      RecLinIns.Validate("No. cliente", "No. cliente");
                                      RecLinIns.Validate("Cód. tarea", "Cód. tarea");
                                      RecLinIns.Validate("Tipo de Requisitos Específicos", "Tipo de Requisitos Específicos");
                                      RecLinIns.Validate("Cód. requisito control", RecDetalleGrupo."Cod. requisito control");
                                      NumLin += 10000;
                                      RecLinIns.Validate("No. línea", NumLin);
                                      RecLinIns.Insert(true);
                                  end;
                              end;
                      until RecDetalleGrupo.Next() = 0
                  else
                      Message(GrupReqMsg, "Cód. plantilla");
              until RecDetallePlantilla.Next() = 0
          else
              Message(GrupReqMsg, "Cód. plantilla");
      end;
      */
    //END FJAB 311019
    local procedure BorradoLineas()
    begin
        if "Estado inspección" <> "Estado inspección"::Abierta then Error('Atención: Sólo se puede borrar una Inspección de Calidad Abierta');
        CLEAR(LinInspeccion);
        LinInspeccion.Reset();
        //LinInspeccion.SetRange("Origen inspección", "Origen inspección");
        //BEGIN FJAB 311019 Cambio clave
        LinInspeccion.SetRange("No. inspección", "No.");
        //LinInspeccion.SetRange("Nº doc. Origen calidad", "Nº doc. Origen calidad");
        //LinInspeccion.SetRange("Nº lín. doc. Origen calidad", "Nº lín. doc. Origen calidad");
        //END FJAB 311019
        if LinInspeccion.FindSet() then LinInspeccion.DeleteAll(true);
    end;
}
