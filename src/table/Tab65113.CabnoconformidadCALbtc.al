table 65113 "Cab no conformidad_CAL_btc"
{
    DrillDownPageID = "No Conformidades_CAL_btc";
    LookupPageID = "No Conformidades_CAL_btc";

    fields
    {
        field(1; "Origen inspección"; Enum OrigenCalidad)
        {
            /*
                  Caption = 'Origen inspeccion';
                  Editable = false;
                  OptionCaption = 'Recepción,Almacén,Fabricación,Envío,Devolución,Procesos,Evaluación,Reclamación,Muestras,Mat.Gráfico';
                  OptionMembers = "Recepción","Almacén","Fabricación","Envío","Devolución",Procesos,"Evaluación","Reclamación",Muestras,"Mat.Gráfico";
                  */
            Caption = 'Origin Inspection', comment = 'ESP="Origen Inspección"';
        }
        field(2; "No. inspección"; Code[20])
        {
            Caption = 'No. inspeccion';
            Editable = false;
            //TableRelation = "Cab inspe eval_CAL_btc"."No." WHERE("Origen inspección" = FIELD("Origen inspección"));  //FJAB 311019
            //ObsoleteState = Removed;  //FJAB 311019
            TableRelation = "Cab inspe eval_CAL_btc";
        }
        field(4; "Cód. plantilla"; Code[20])
        {
            Caption = 'Cod. plantilla';
            Editable = false;
            TableRelation = "Plantilla de inseval_CAL_btc"."No.";
        }
        field(5; "No. revisión plantilla"; Integer)
        {
            Caption = 'No. revision plantilla';
            Editable = false;
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
        field(8; "Estado no conformidad"; Option)
        {
            Caption = 'Estado no conformidad';
            OptionCaption = 'Abierta,Lanzada,Certificada,Terminada';
            OptionMembers = Abierta,Lanzada,Certificada,Terminada;

            trigger OnValidate()
            begin
                Clear(DateTimeBlank);
                if "Estado no conformidad" = "Estado no conformidad"::Abierta then begin
                    Clear("Lanzado por usuario");
                    Validate("Fecha lanzamiento", DateTimeBlank);
                    Clear("Certificado por usuario");
                    Validate("Fecha certificación", DateTimeBlank);
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                end;
                if "Estado no conformidad" = "Estado no conformidad"::Lanzada then begin
                    "Lanzado por usuario" := UserId();
                    Validate("Fecha lanzamiento", CurrentDateTime());
                    Clear("Certificado por usuario");
                    Validate("Fecha certificación", DateTimeBlank);
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                end;
                if "Estado no conformidad" = "Estado no conformidad"::Certificada then begin
                    "Certificado por usuario" := UserId();
                    Validate("Fecha certificación", CurrentDateTime());
                    Clear("Terminado por usuario");
                    Validate("Fecha terminación", DateTimeBlank);
                end;
                if "Estado no conformidad" = "Estado no conformidad"::Terminada then begin
                    "Terminado por usuario" := UserId();
                    Validate("Fecha terminación", CurrentDateTime());
                end;
            end;
        }
        field(9; Descripcion; Text[50])
        {
            Caption = 'Descripcion';
        }
        field(10; "Tipo inspección"; Option)
        {
            Caption = 'Tipo inspeccion';
            OptionCaption = 'Normal,Rigurosa,Reducida,Estabilidad';
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
            begin
                CalcFields("Descripción producto");
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
        field(34; "Observaciones no conformidad"; Text[250])
        {
            Caption = 'Observaciones no conformidad';
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
        field(51; "No. no conformidad"; Code[20])
        {
            Caption = 'No. no conformidad';
            Editable = false;
        }
        field(52; "Requisitos pendientes evaluar"; Integer)
        {
            Caption = 'Requisitos pendientes evaluar';
            Editable = false;
        }
        field(53; "Fecha certificación"; DateTime)
        {
            Caption = 'Fecha certificación';
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
        field(58; "Acción inmediata"; Option)
        {
            Caption = 'Accion inmediata';
            OptionMembers = " ",Cuarentena,"No conformes","Devolución a prov.","Prod. a reclasificar","Prod. a reprocesar","Prod. a reciclar","Prod. a desechar";
        }
        field(59; "Cód. almacén destino"; Code[10])
        {
            Caption = 'Cod. almacen destino';
            TableRelation = Location;
        }
        field(60; "Cód. ubicación destino"; Code[20])
        {
            Caption = 'Cod. ubicacion destino';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Cód. almacén destino"));
        }
        field(61; "Accion inmediata realizada"; Boolean)
        {
            Caption = 'Accion inmediata realizada';
            Editable = true;
        }
        field(62; "Fecha acción inmediata"; Date)
        {
            Caption = 'Fecha accion inmediata';
            Editable = false;

            trigger OnValidate()
            begin
                if "Accion inmediata realizada" then Validate("Fecha acción inmediata", WorkDate());
            end;
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
            Editable = false;
            OptionCaption = 'Tª Ambiente,Refrigerada,25º a 60% HR,30º a 60% HR,40º a 75% HR';
            OptionMembers = "Tª Ambiente",Refrigerada,"25º a 60% HR","30º a 60% HR","40º a 75% HR";
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
        field(77; "Evaluación Inspección"; Option)
        {
            Caption = 'Veredicto Inspeccion';
            OptionMembers = " ",Conforme,"No Conforme";
        }
        field(78; "Referencia de la muestra"; Code[20])
        {
            Caption = 'Referencia de la muestra';
            Editable = false;
        }
        field(79; "Proveedor de la muestra"; Code[20])
        {
            Caption = 'Proveedor de la muestra';
            Editable = false;
        }
        field(82; "SubEstado inspección"; Option)
        {
            Caption = 'SubEstado inspección';
            OptionCaption = 'Pendiente,Cuarentena,Aprobado,Recontrolado,Rechazado';
            OptionMembers = Pendiente,Cuarentena,Aprobado,Recontrolado,Rechazado;
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
            OptionCaption = 'Discrecional,Fijo,Porcentual,Probabilístico';
            OptionMembers = Discrecional,Fijo,Porcentual,"Probabilístico";
        }
        field(89; "No. de muestra laboratorio"; Code[20])
        {
            Caption = 'Nº de muestra laboratorio';
            Editable = false;
        }
        field(90; "Veredicto no conformidad"; Text[80])
        {
            Caption = 'Veredicto no conformidad';
        }
        field(91; "Lanzado por usuario"; Code[50])
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
        field(92; "Fecha lanzamiento"; DateTime)
        {
            Caption = 'Fecha lanzamiento';
            Editable = false;
        }
        field(93; "Terminado por usuario"; Code[50])
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
        field(94; "Fecha terminación"; DateTime)
        {
            Caption = 'Fecha terminación';
            Editable = false;
        }
        field(95; "Nº doc. Origen calidad"; Code[20])
        {
            Caption = 'Quality Origin Doc. No.', comment = 'ESP="Nº. Doc. Origen calidad"';
            TableRelation = "Cab inspe eval_CAL_btc"."Nº doc. Origen calidad" WHERE("Origen inspección" = FIELD("Origen inspección")); //FJAB 311019
        }
        field(96; "Nº lín. doc. Origen calidad"; Integer)
        {
            Caption = 'Quality Origin Doc. Line No.', comment = 'ESP="Nº. Línea Doc. Origen calidad"';
            TableRelation = "Cab inspe eval_CAL_btc"."Nº lín. doc. Origen calidad" WHERE("Origen inspección" = FIELD("Origen inspección"), "Nº doc. Origen calidad" = field("Nº doc. Origen calidad")); //FJAB 311019
        }
        field(106; "Nº línea componente producción"; Integer)
        {
            Caption = 'Prod order component line no.', comment = 'ESP="Nº línea componente OP"';
            Editable = false;
        }
        field(50000; EntryNo; Integer)
        {
            Editable = false;
            TableRelation = "Item Ledger Entry"."Entry No.";
        }
        field(50005; "Purch. Return Order"; code[20])
        {
            Editable = false;
            Caption = 'Devol. de compras', comment = 'ESP="Devol. de compras"';
            TableRelation = "Purchase Header"."No." where("Document Type" = const("Return Order"));
        }
        field(50006; "Pdte. Enviar Devol."; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Purchase Line" where("Document Type" = const(Order), "Document No." = field("Purch. Return Order"), "Outstanding Quantity" = filter(> 0)));
            Editable = false;
            Caption = 'Pdte. Enviar Devol.', comment = 'ESP="Pdte. Enviar Devol."';
        }
        field(50007; "Con Reposicion"; Boolean)
        {
            Caption = 'Con Reposición', comment = 'ESP="Con Reposición"';

            trigger OnValidate()
            begin
                TestField("Purch. Return Order", '');
            end;
        }
    }
    keys
    {
        //BEGIN FJAB 311019 Cambiada clave primaria
        //key(Key1; "Origen inspección", "No. inspección", "No. no conformidad") { }
        //key(Key1; "Origen inspección", "Nº doc. Origen calidad", "Nº lín. doc. Origen calidad", "No. no conformidad") { }
        key(Key1; "No. inspección", "No. no conformidad")
        {
        }
        //END FJAB 311019
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        LinNoConf: Record "Lin no conformidad_CAL_btc";
        recCabInspeccion: Record "Cab inspe eval_CAL_btc";
    begin
        if "Estado no conformidad" <> "Estado no conformidad"::Abierta then Error('Atención: Sólo se puede borrar una No Conformidad Abierta');
        Clear(LinNoConf);
        LinNoConf.Reset();
        //LinNoConf.SetRange("Origen inspección", "Origen inspección");
        //BEGIN FJAB 311019 Cambio clave
        LinNoConf.SetRange("No. inspección", "No. inspección");
        //LinNoConf.SetRange("Nº doc. Origen calidad", "Nº doc. Origen calidad");
        //LinNoConf.SetRange("Nº lín. doc. Origen calidad", "Nº lín. doc. Origen calidad");
        if recCabInspeccion.get(Rec."No. inspección") then begin
            recCabInspeccion."No. No conformidad" := '';
            reccabinspeccion."No conformidad" := false;
            recCabInspeccion.Modify();
        end;
        //END FJAB 311019
        LinNoConf.SetRange("No. no conformidad", "No. no conformidad");
        if LinNoConf.FindSet() then LinNoConf.DeleteAll(true);
    end;

    trigger OnInsert()
    var
        CabInspeccion: Record "Cab inspe eval_CAL_btc";
        NoSerieMgmt: Codeunit NoSeriesManagement;
    begin
        Validate("Fecha creación", WorkDate());
        "Usuario creación" := UserId();
        if "No. no conformidad" = '' then begin
            TestField("No. de serie");
            NoSerieMgmt.InitSeries("No. de serie", xRec."No. de serie", "Fecha creación", "No. no conformidad", "No. de serie");
            Validate("Estado no conformidad", "Estado no conformidad"::Abierta);
            //FJAB 311019 Cambio clave
            //if CabInspeccion.Get("Origen inspección", "No. inspección") then
            //if CabInspeccion.Get("Origen inspección", "Nº doc. Origen calidad", "Nº lín. doc. Origen calidad") then
            if CabInspeccion.Get("No. inspección") then CabInspeccion."No. No conformidad" := "No. no conformidad";
            CabInspeccion.Modify();
        end;
    end;

    trigger OnModify()
    begin
        Validate("Fecha última modificación", CurrentDateTime());
        "Usuario última modificación" := UserId();
    end;

    var
        DateTimeBlank: DateTime;
}
