table 65114 "Lin no conformidad_CAL_btc"
{
    Caption = 'Lin. no conformidad';

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
        field(4; "No. no conformidad"; Code[20])
        {
            Caption = 'No. no conformidad';
            Editable = false;
        }
        field(6; "No. línea"; Integer)
        {
            Caption = 'No. linea';
            Editable = false;
        }
        field(8; "Estado no conformidad"; Option)
        {
            Caption = 'Estado no conformidad';
            Editable = false;
            OptionCaption = 'Abierta,Lanzada,Certificada,Terminada';
            OptionMembers = Abierta,Lanzada,Certificada,Terminada;
        }
        field(9; "Cod. grupo inspección"; Code[10])
        {
            Caption = 'Cod. grupo inspeccion';
            Editable = false;
            TableRelation = inspeccion_CAL_btc;
        }
        field(10; "Descripción"; Text[50])
        {
            Caption = 'Descripcion';
            Editable = false;
        }
        field(12; "Cód. requisito control"; Code[10])
        {
            Caption = 'Cod. requisito control';
            Editable = false;
            TableRelation = calidad_CAL_btc;
        }
        field(13; "Descripción requisito"; Text[50])
        {
            Caption = 'Descripcion requisito';
            Editable = false;
        }
        field(14; "No. línea inspección"; Integer)
        {
            Caption = 'No. linea inspeccion';
            Editable = false;
        }
        field(15; "Cód. defecto"; Code[10])
        {
            Caption = 'Cod. defecto';
            Editable = true;
            TableRelation = "Defectos_CAL_btc";

            trigger OnValidate()
            var
                Defectos: Record "Defectos_CAL_btc";
            begin
                if Defectos.Get("Cód. defecto") then begin
                    Validate("Descripción defecto", Defectos.Descripción);
                    Validate("Clase defecto", Defectos."Clase de defecto");
                end
                else begin
                    Validate("Descripción defecto", '');
                    Validate("Clase defecto", "Clase defecto"::" ");
                    Validate("Observaciones defecto", '');
                end;
            end;
        }
        field(16; "Descripción defecto"; Text[50])
        {
            Caption = 'Descripcion defecto';
            Editable = false;
        }
        field(17; "Clase defecto"; Option)
        {
            Caption = 'Clase defecto';
            Editable = false;
            OptionCaption = ' ,A,B,C';
            OptionMembers = " ",A,B,C;
        }
        field(18; "Observaciones defecto"; Text[50])
        {
            Caption = 'Observaciones defecto';
            Editable = true;
        }
        field(19; "Cód. causa preliminar"; Code[10])
        {
            Caption = 'Cod. causa preliminar';
            TableRelation = "Causa de defectos_CAL_btc";
        }
        field(20; "Descripcion causa preliminar"; Text[50])
        {
            CalcFormula = Lookup("Causa de defectos_CAL_btc"."Descripción" WHERE("No." = FIELD("Cód. causa preliminar")));
            Caption = 'Descripcion causa preliminar';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Cód. causa final"; Code[10])
        {
            Caption = 'Cod. causa final';
            TableRelation = "Causa de defectos_CAL_btc";
        }
        field(22; "Descripción causa final"; Text[50])
        {
            CalcFormula = Lookup("Causa de defectos_CAL_btc"."Descripción" WHERE("No." = FIELD("Cód. causa final")));
            Caption = 'Descripcion causa final';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Observaciones causas"; Text[50])
        {
            Caption = 'Observaciones causas';
        }
        field(24; "Cód. acción inmediata"; Code[10])
        {
            Caption = 'Cod. accion inmediata';
            TableRelation = "Accion_CAL_btc"."No." WHERE(Tipo = CONST(Inmediata));
        }
        field(25; "Cód. acción correctiva"; Code[10])
        {
            Caption = 'Cod. accion preventiva';
            TableRelation = "Accion_CAL_btc"."No." WHERE(Tipo = CONST(Correctiva));
        }
        field(26; "Cód. acción preventiva"; Code[10])
        {
            Caption = 'Cod. accion correctiva';
            TableRelation = "Accion_CAL_btc"."No." WHERE(Tipo = CONST(Preventiva));
        }
        field(27; "Observaciones acciones"; Text[50])
        {
            Caption = 'Observaciones acciones';
        }
        field(29; "Acción inmediata realizada"; Boolean)
        {
            Caption = 'Accion inmediata realizada';
            Editable = true;
        }
        field(30; "Fecha accion inmediata"; Date)
        {
            Caption = 'Fecha accion inmediata';
            Editable = true;
        }
        field(31; "Acción correctiva realizada"; Boolean)
        {
            Caption = 'Accion correctiva realizada';
            Editable = true;
        }
        field(32; "Fecha acción correctiva"; Date)
        {
            Caption = 'Fecha accion correctiva';
            Editable = true;
        }
        field(33; "Acción preventiva realizada"; Boolean)
        {
            Caption = 'Accion preventiva realizada';
            Editable = true;
        }
        field(34; "Fecha acción preventiva"; Date)
        {
            Caption = 'Fecha accion preventiva';
            Editable = true;
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
        field(45; "Aprobado por usuario"; Code[50])
        {
            Caption = 'Aprobado por usuario';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("Aprobado por usuario");
            end;
        }
        field(46; "Tipo control"; Option)
        {
            Caption = 'Tipo control';
            Editable = false;
            OptionCaption = ' ,Condición,Valor,Texto,Puntaje';
            OptionMembers = " ","Condición",Valor,Texto,Puntaje;
        }
        field(52; "No. producto"; Code[20])
        {
            Caption = 'No. producto';
            Editable = false;
            TableRelation = Item;
        }
        field(53; "Cód. variante"; Code[10])
        {
            Caption = 'Cod. variante';
            Editable = false;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("No. producto"));
        }
        field(54; "No. proveedor"; Code[20])
        {
            Caption = 'No. proveedor';
            Editable = false;
            TableRelation = Vendor;
        }
        field(55; "No. cliente"; Code[20])
        {
            Caption = 'No. cliente';
            Editable = false;
            TableRelation = Customer;
        }
        field(56; "Cód. tarea"; Code[10])
        {
            Caption = 'Cod. tarea';
            Editable = false;
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
        field(60; "Nº doc. Origen calidad"; Code[20])
        {
            Caption = 'Quality Origin Doc. No.', comment = 'ESP="Nº. Doc. Origen calidad"';
            TableRelation = "Cab no conformidad_CAL_btc"."Nº doc. Origen calidad" WHERE("Origen inspección" = FIELD("Origen inspección")); //FJAB 311019
        }
        field(61; "Nº lín. doc. Origen calidad"; Integer)
        {
            Caption = 'Quality Origin Doc. Line No.', comment = 'ESP="Nº. Línea Doc. Origen calidad"';
            TableRelation = "Cab no conformidad_CAL_btc"."Nº lín. doc. Origen calidad" WHERE("Origen inspección" = FIELD("Origen inspección"), "Nº doc. Origen calidad" = field("Nº doc. Origen calidad")); //FJAB 311019
        }
    }
    keys
    {
        //BEGIN FJAB 311019 Cambiada clave
        //key(Key1; "Origen inspección", "No. inspección", "No. no conformidad", "No. línea") { }
        //key(Key1; "Origen inspección", "Nº doc. Origen calidad", "Nº lín. doc. Origen calidad", "No. no conformidad", "No. línea") { }
        key(Key1; "No. inspección", "No. no conformidad", "No. línea")
        {
        }
        //END FJAB 311019
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if "Estado no conformidad" <> "Estado no conformidad"::Abierta then Error('Atención: Sólo se puede borrar una Línea de No Conformidad Abierta');
    end;

    trigger OnInsert()
    begin
        Validate("Fecha creación", WorkDate());
        "Usuario creación" := UserId();
    end;

    trigger OnModify()
    begin
        Validate("Fecha última modificación", CurrentDateTime());
        "Usuario última modificación" := UserId();
    end;
}
