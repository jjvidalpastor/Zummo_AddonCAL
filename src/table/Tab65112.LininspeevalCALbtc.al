table 65112 "Lin inspe eval_CAL_btc"
{
    Caption = 'Lin. inspeccion/eval. calidad';

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
            //ObsoleteState = Removed;
        }
        field(4; "No. línea"; Integer)
        {
            Caption = 'No. linea';
            Editable = false;
        }
        field(8; "Estado inspección"; Option)
        {
            Caption = 'Estado inspeccion';
            Editable = false;
            OptionCaption = 'Abierta,Lanzada,Certificada,Terminada';
            OptionMembers = Abierta,Lanzada,Certificada,Terminada;
        }
        field(9; "Cód. grupo inspección"; Code[10])
        {
            Caption = 'Cod. grupo inspeccion';
            Editable = false;
            TableRelation = inspeccion_CAL_btc;

            trigger OnValidate()
            var
                Grupo: Record inspeccion_CAL_btc;
            begin
                if Grupo.Get("Cód. grupo inspección") then begin
                    Validate(Descripción, Grupo.Descripción);
                    Validate("Omitir impresión", Grupo."Omitir impresión");
                end
                else begin
                    Validate(Descripción, '');
                    Validate("Omitir impresión", false);
                end;
            end;
        }
        field(10; "Descripción"; Text[60])
        {
            Caption = 'Descripcion';
            Editable = false;
        }
        field(11; "Omitir impresión"; Boolean)
        {
            Caption = 'Omitir impresion';
        }
        field(12; "Cód. requisito control"; Code[10])
        {
            Caption = 'Cod. requisito control';
            Editable = false;
            TableRelation = calidad_CAL_btc;

            trigger OnValidate()
            begin
                if "Tipo de Requisitos Específicos" <> "Tipo de Requisitos Específicos"::"Sólo Específicos" then CargaRequisitos();
                if "Tipo de Requisitos Específicos" <> "Tipo de Requisitos Específicos"::"Sin Específicos" then RevReqEspecificos();
            end;
        }
        field(13; "Descripción requisito"; Text[50])
        {
            Caption = 'Descripcion requisito';
            Editable = false;
        }
        field(14; "Requisito crítico"; Boolean)
        {
            Caption = 'Requisito critico';
            Editable = false;
        }
        field(15; "Unidad de medida"; Code[10])
        {
            Caption = 'Unidad de medida';
            Editable = false;
            TableRelation = "Unit of Measure";
        }
        field(16; "Cód. Procedimiento"; Code[10])
        {
            Caption = 'Cód. Procedimiento';
            Editable = false;
        }
        field(17; "Tipo control"; Option)
        {
            Caption = 'Tipo control';
            Editable = true;
            OptionCaption = ' ,Condición,Valor,Texto,Puntaje';
            OptionMembers = " ","Condición",Valor,Texto,Puntaje;
        }
        field(18; "Condición esperada"; Option)
        {
            Caption = 'Condición esperada';
            Editable = false;
            OptionCaption = ' ,Ausencia,Presencia,Conforme';
            OptionMembers = " ",Ausencia,Presencia,Conforme;
        }
        field(19; "Valor mínimo"; Decimal)
        {
            Caption = 'Valor minimo';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(20; "Valor máximo"; Decimal)
        {
            Caption = 'Valor maximo';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(21; "Texto especificación"; Text[65])
        {
            Caption = 'Texto especificación';
            Editable = false;
        }
        field(22; "Valor medio"; Decimal)
        {
            Caption = 'Valor maximo';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(23; "Tolerancia s/valor medio (%)"; Decimal)
        {
            Caption = 'Tolerancia s/valor medio (%)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(24; "Peso del requisito"; Decimal)
        {
            Caption = 'Peso del requisito';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(25; "Cód. defecto si fallo"; Code[10])
        {
            Caption = 'Cod. defecto si fallo';
            Editable = false;
            TableRelation = "Defectos_CAL_btc";
        }
        field(26; "Afecta conformidad"; Boolean)
        {
            Caption = 'Afecta conformidad';
            Editable = false;
        }
        field(27; "Requisito conforme"; Boolean)
        {
            Caption = 'Requisito conforme';
            Editable = false;

            trigger OnValidate()
            begin
                if "Requisito conforme" = true then "Requisito no conforme" := false;
            end;
        }
        field(28; "Requisito no conforme"; Boolean)
        {
            Caption = 'Requisito no conforme';
            Editable = false;

            trigger OnValidate()
            begin
                if "Requisito no conforme" = true then "Requisito conforme" := false;
            end;
        }
        field(29; "Resultado texto"; Text[50])
        {
            Caption = 'Resultado texto';
            Editable = true;

            trigger OnValidate()
            begin
                if "Resultado texto" = '=' then "Resultado texto" := "Texto especificación";
                if "Resultado texto" = "Texto especificación" then
                    Validate(Aptitud, Aptitud::Aceptable)
                else
                    Validate(Aptitud, Aptitud::"No Aceptable");
            end;
        }
        field(30; "Resultado condición"; Option)
        {
            Caption = 'Resultado condición';
            Editable = true;
            OptionCaption = ' -,Ausencia,Presencia,Conforme,No Conforme';
            OptionMembers = " ",Ausencia,Presencia,Conforme,"No Conforme";

            trigger OnValidate()
            var
                CabIns: Record "Cab inspe eval_CAL_btc";
            begin
                if "Resultado condición" = "Condición esperada" then
                    Validate(Aptitud, Aptitud::Aceptable)
                else
                    Validate(Aptitud, Aptitud::"No Aceptable");
            end;
        }
        field(31; "Resultado valor"; Decimal)
        {
            Caption = 'Resultado valor';
            DecimalPlaces = 0 : 5;
            Editable = true;

            trigger OnValidate()
            begin
                if "Tipo control" = "Tipo control"::Valor then begin
                    if ("Resultado valor" >= "Valor mínimo") and ("Resultado valor" <= "Valor máximo") then
                        Validate(Aptitud, Aptitud::Aceptable)
                    else
                        Validate(Aptitud, Aptitud::"No Aceptable");
                    ToleraMin := "Valor medio" - ("Valor medio" * "Tolerancia s/valor medio (%)") / 100;
                    ToleraMax := "Valor medio" + ("Valor medio" * "Tolerancia s/valor medio (%)") / 100;
                    if (ToleraMin > 0) then
                        if Abs("Resultado valor") >= ToleraMin then
                            Validate(Aptitud, Aptitud::Aceptable)
                        else
                            Validate(Aptitud, Aptitud::"No Aceptable");
                    if (ToleraMax > 0) then
                        if Abs("Resultado valor") <= ToleraMax then
                            Validate(Aptitud, Aptitud::Aceptable)
                        else
                            Validate(Aptitud, Aptitud::"No Aceptable");
                end;
                if "Tipo control" = "Tipo control"::Puntaje then
                    if "Peso del requisito" > 0 then
                        Puntos := "Resultado valor" * "Peso del requisito"
                    else
                        Puntos := "Resultado valor";
            end;
        }
        field(32; Aptitud; Option)
        {
            Caption = 'Aptitud';
            Editable = true;
            OptionMembers = " ",Aceptable,"No Aceptable";

            trigger OnValidate()
            begin
                Validate("Requisito conforme", false);
                Validate("Requisito no conforme", false);
                if Aptitud = Aptitud::"No Aceptable" then Validate("Requisito no conforme", true);
                if Aptitud = Aptitud::Aceptable then Validate("Requisito conforme", true);
            end;
        }
        field(33; Defecto; Boolean)
        {
            Caption = 'Defecto';
            Editable = false;
        }
        field(34; "Cód. defecto"; Code[10])
        {
            Caption = 'Cod. defecto';
            Editable = true;
            TableRelation = "Defectos_CAL_btc";

            trigger OnValidate()
            var
                Defectos: Record "Defectos_CAL_btc";
            begin
                if Defectos.Get("Cód. defecto") then begin
                    Validate(Defecto, true);
                    Validate("Descripción defecto", Defectos.Descripción);
                    Validate("Clase defecto", Defectos."Clase de defecto");
                end
                else begin
                    Validate(Defecto, false);
                    Validate("Descripción defecto", '');
                    Validate("Clase defecto", "Clase defecto"::" ");
                    Validate("Observaciones defecto", '');
                end;
            end;
        }
        field(35; "Descripción defecto"; Text[50])
        {
            Caption = 'Descripción defecto';
            Editable = false;
        }
        field(36; "Clase defecto"; Option)
        {
            Caption = 'Clase defecto';
            OptionCaption = ' ,A,B,C';
            OptionMembers = " ",A,B,C;
        }
        field(39; "Observaciones defecto"; Text[50])
        {
            Caption = 'Observaciones defecto';
            Editable = true;
        }
        field(41; "Fecha creación"; DateTime)
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
        field(51; "Fecha certificación"; DateTime)
        {
            Caption = 'Fecha aprobacion';
            Editable = false;
        }
        field(52; "No. producto"; Code[20])
        {
            Caption = 'No. producto';
            TableRelation = Item;
        }
        field(53; "Cód. variante"; Code[10])
        {
            Caption = 'Cod. variante';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("No. producto"));
        }
        field(54; "No. proveedor"; Code[20])
        {
            Caption = 'No. proveedor';
            TableRelation = Vendor;
        }
        field(55; "No. cliente"; Code[20])
        {
            Caption = 'No. cliente';
            TableRelation = Customer;
        }
        field(56; "Cód. tarea"; Code[10])
        {
            Caption = 'Cod. tarea';
            TableRelation = "Standard Task".Code;
        }
        field(57; "Requisito específico"; Boolean)
        {
            Caption = 'Requisito específico';
            Editable = false;
        }
        field(58; Conformidad; Boolean)
        {
            Caption = 'Conformidad';
            Editable = false;

            trigger OnValidate()
            begin
                if Conformidad = true then "No conformidad" := false;
            end;
        }
        field(59; "No conformidad"; Boolean)
        {
            Caption = 'No conformidad';
            Editable = false;

            trigger OnValidate()
            begin
                if "No conformidad" = true then Conformidad := false;
            end;
        }
        field(60; "Fecha lanzamiento"; DateTime)
        {
            Caption = 'Fecha lanzamiento';
        }
        field(61; "Lanzado por usuario"; Code[50])
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
                UserMgt.LookupUserID("Lanzado por usuario");
            end;
        }
        field(100; Puntos; Decimal)
        {
            Caption = 'Puntos';
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
        field(50000; "Decision DT"; Option)
        {
            Caption = 'Decision DT';
            OptionCaption = ' , Conforme, No Conforme';
            OptionMembers = " "," Conforme"," No Conforme";
        }
        field(50001; "Motivo DT"; Text[50])
        {
            Caption = 'Motivo DT';
        }
        field(104; "Nº doc. Origen calidad"; Code[20])
        {
            Caption = 'Quality Origin Doc. No.', comment = 'ESP="Nº. Doc. Origen calidad"';
            TableRelation = "Cab inspe eval_CAL_btc"."Nº doc. Origen calidad" WHERE("Origen inspección" = FIELD("Origen inspección")); //FJAB 311019
        }
        field(105; "Nº lín. doc. Origen calidad"; Integer)
        {
            Caption = 'Quality Origin Doc. Line No.', comment = 'ESP="Nº. Línea Doc. Origen calidad"';
            TableRelation = "Cab inspe eval_CAL_btc"."Nº lín. doc. Origen calidad" WHERE("Origen inspección" = FIELD("Origen inspección"), "Nº doc. Origen calidad" = field("Nº doc. Origen calidad")); //FJAB 311019
        }
    }
    keys
    {
        //BEGIN FJAB 301019 Cambiar clave primaria
        //key(Key1; "Origen inspección", "No. inspección", "No. línea") { }
        //key(Key1; "Origen inspección", "Nº doc. Origen calidad", "Nº lín. doc. Origen calidad", "No. línea") { }
        key(Key1; "No. inspección", "No. línea")
        {
        }
        //END FJAB 301019
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if "Estado inspección" <> "Estado inspección"::Abierta then Error('Atención: Sólo se puede borrar una Línea de Inspección de Calidad Abierta');
    end;

    trigger OnInsert()
    begin
        Validate("Fecha creación", CurrentDateTime());
        "Usuario creación" := FORMAT(UserId());
    end;

    trigger OnModify()
    begin
        Validate("Fecha última modificación", CurrentDateTime());
        "Usuario última modificación" := UserId();
        CabInspeccion.Init();
        //FJAB 311019 Clave cambiada
        //if CabInspeccion.Get("Origen inspección", "No. inspección") then begin
        //if CabInspeccion.Get("Origen inspección", "Nº doc. Origen calidad", "Nº lín. doc. Origen calidad") then begin
        if CabInspeccion.get("No. inspección") then begin
            CabInspeccion.Validate("Fecha última modificación", CurrentDateTime());
            CabInspeccion."Usuario última modificación" := UserId();
            CabInspeccion.Modify();
        end;
    end;

    var
        ReqEspecificos: Record "Req Control especifico_CAL_btc";
        Requisito: Record calidad_CAL_btc;
        CabInspeccion: Record "Cab inspe eval_CAL_btc";
        ValoresMsg: Label 'Texto %1 %2 %3 Fin';
        ToleraMin: Decimal;
        ToleraMax: Decimal;

    local procedure RevReqEspecificos()
    begin
        //TODO: Revisar creación de requisitos específicos
        /*
              ReqEspecificos.Init();
              case "Origen inspección" of
                  "Origen inspección"::"Recepción":
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, "Cód. requisito control", "No. producto", "Cód. variante") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  "Origen inspección"::"Almacén":
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, "Cód. requisito control", "No. producto", "Cód. variante") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  "Origen inspección"::"Fabricación":
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, "Cód. requisito control", "No. producto", "Cód. variante") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  "Origen inspección"::"Envío":
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, "Cód. requisito control", "No. producto", "Cód. variante") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  "Origen inspección"::"Devolución":
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, "Cód. requisito control", "No. producto", "Cód. variante") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  "Origen inspección"::Procesos:
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::"Proceso Fabricación", "Cód. requisito control", "Cód. tarea") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  "Origen inspección"::"Evaluación":
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::"Evaluación Proveedor", "Cód. requisito control", "No. proveedor") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  "Origen inspección"::"Reclamación":
                      begin
                          if "No. proveedor" <> '' then
                              if ReqEspecificos.Get(ReqEspecificos.Tipo::"Reclamación Proveedor", "Cód. requisito control", "No. proveedor") then
                                  if ReqEspecificos.Bloqueado = false then
                                      CargaRequisitosEspecificos();
                          if "No. cliente" <> '' then
                              if ReqEspecificos.Get(ReqEspecificos.Tipo::"Reclamación Cliente", "Cód. requisito control", "No. cliente") then
                                  if ReqEspecificos.Bloqueado = false then
                                      CargaRequisitosEspecificos();
                      end;
                  "Origen inspección"::Muestras:
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, "Cód. requisito control", "No. producto", "Cód. variante") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  "Origen inspección"::"Mat.Gráfico":
                      if ReqEspecificos.Get(ReqEspecificos.Tipo::Producto, "Cód. requisito control", "No. producto", "Cód. variante") then
                          if ReqEspecificos.Bloqueado = false then
                              CargaRequisitosEspecificos();
                  else
                      Error('Tipo no esperado');
              end;
              */
    end;

    local procedure CargaRequisitos()
    begin
        Clear(Requisito);
        if Requisito.Get("Cód. requisito control") then begin
            Validate("Descripción requisito", Requisito.Descripción);
            Validate("Omitir impresión", Requisito."Omitir impresión");
            Validate("Requisito crítico", Requisito."Requisito crítico");
            Validate("Unidad de medida", Requisito."Unidad de medida");
            Validate("Cód. Procedimiento", Requisito."Cód. Procedimiento");
            Validate("Tipo control", Requisito."Tipo control");
            Validate("Condición esperada", Requisito."Condición esperada");
            Validate("Valor mínimo", Requisito."Valor mínimo");
            Validate("Valor máximo", Requisito."Valor máximo");
            Validate("Texto especificación", Requisito."Texto especificación");
            Validate("Valor medio", Requisito."Valor medio");
            Validate("Tolerancia s/valor medio (%)", Requisito."Tolerancia s/valor medio (%)");
            Validate("Peso del requisito", Requisito."Peso del requisito");
            Validate("Cód. defecto si fallo", Requisito."Cod. defecto si fallo");
            Validate("Afecta conformidad", Requisito."Afecta conformidad");
            Validate("Requisito específico", false);
        end;
    end;

    local procedure CargaRequisitosEspecificos()
    begin
        Validate("Descripción requisito", ReqEspecificos."Descripción requisito");
        Validate("Omitir impresión", ReqEspecificos."Omitir impresión");
        Validate("Requisito crítico", ReqEspecificos."Requisito crítico");
        Validate("Unidad de medida", ReqEspecificos."Unidad de medida");
        Validate("Cód. Procedimiento", ReqEspecificos."Cód. Procedimiento");
        Validate("Tipo control", ReqEspecificos."Tipo control");
        Validate("Condición esperada", ReqEspecificos."Condición esperada");
        Validate("Valor mínimo", ReqEspecificos."Valor mínimo");
        Validate("Valor máximo", ReqEspecificos."Valor máximo");
        Validate("Texto especificación", ReqEspecificos."Texto especificación");
        Validate("Valor medio", ReqEspecificos."Valor medio");
        Validate("Tolerancia s/valor medio (%)", ReqEspecificos."Tolerancia s/valor medio (%)");
        Validate("Peso del requisito", ReqEspecificos."Peso del requisito");
        Validate("Cód. defecto si fallo", ReqEspecificos."Cod. defecto si fallo");
        Validate("Afecta conformidad", ReqEspecificos."Afecta conformidad");
        Validate("Requisito específico", true);
    end;
}
