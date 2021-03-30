table 65107 "Req Control especifico_CAL_btc"
{
    Caption = 'Req. de control específicos';
    DrillDownPageID = "Requisitos Cont Espec_CAL_btc";
    LookupPageID = "Requisitos Cont Espec_CAL_btc";

    fields
    {
        field(1; "Cód. requisito control"; Code[10])
        {
            Caption = 'Cód. requisito control';
            TableRelation = calidad_CAL_btc;

            trigger OnValidate()
            var
                Requisitos: Record calidad_CAL_btc;
            begin
                if Requisitos.Get("Cód. requisito control") then begin
                    Validate("Descripción requisito", Requisitos.Descripción);
                    Validate("Omitir impresión", Requisitos."Omitir impresión");
                    Validate("Requisito crítico", Requisitos."Requisito crítico");
                    Validate("Unidad de medida", Requisitos."Unidad de medida");
                    Validate("Cód. Procedimiento", Requisitos."Cód. Procedimiento");
                    Validate(Norma, Requisitos.Norma);
                    Validate(Bloqueado, Requisitos.Bloqueado);
                    Validate("Tipo control", Requisitos."Tipo control");
                    if "Tipo control" = "Tipo control"::"Condición" then Validate("Condición esperada", Requisitos."Condición esperada");
                    if "Tipo control" = "Tipo control"::Valor then Validate("Valor mínimo", Requisitos."Valor mínimo");
                    if "Tipo control" = "Tipo control"::Valor then Validate("Valor máximo", Requisitos."Valor máximo");
                    if "Tipo control" = "Tipo control"::Texto then Validate("Texto especificación", Requisitos."Texto especificación");
                    if "Tipo control" = "Tipo control"::Valor then Validate("Valor medio", Requisitos."Valor medio");
                    if "Tipo control" = "Tipo control"::Valor then Validate("Tolerancia s/valor medio (%)", Requisitos."Tolerancia s/valor medio (%)");
                    if "Tipo control" = "Tipo control"::Puntaje then Validate("Peso del requisito", Requisitos."Peso del requisito");
                    Validate("Cod. defecto si fallo", Requisitos."Cod. defecto si fallo");
                    Validate("Afecta conformidad", Requisitos."Afecta conformidad");
                    Validate("Descripción Procedimiento", Requisitos."Descripción Procedimiento");
                end
                else
                    Error('Atención: el código de requisito debe estar definido previamente');
            end;
        }
        field(2; "Descripción requisito"; Text[60])
        {
            Caption = 'Descripcion';
            Editable = true;
        }
        field(3; "Omitir impresión"; Boolean)
        {
            Caption = 'Omitir impresion';
        }
        field(4; "Requisito crítico"; Boolean)
        {
            Caption = 'Requisito critico';

            trigger OnValidate()
            begin
                if "Requisito crítico" = true then Validate("Afecta conformidad", true);
            end;
        }
        field(5; "Unidad de medida"; Code[10])
        {
            Caption = 'Unidad de medida';
            TableRelation = "Unit of Measure";
        }
        field(6; "Cód. Procedimiento"; Code[10])
        {
            Caption = 'Cod. Procedimiento';
            TableRelation = "Procedimientos_CAL_btc";
        }
        field(7; Norma; Text[50])
        {
            Caption = 'Norma';
        }
        field(8; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(9; "Fecha creación"; Date)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(10; "Usuario creación"; Code[50])
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
        field(11; "Fecha ultima modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(12; "Usuario ultima modificación"; Code[50])
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
                UserMgt.LookupUserID("Usuario ultima modificación");
            end;
        }
        field(13; "Tipo control"; Option)
        {
            Caption = 'Tipo control';
            OptionCaption = ' ,Condición,Valor,Texto,Puntaje';
            OptionMembers = " ","Condición",Valor,Texto,Puntaje;
        }
        field(14; "Condición esperada"; Option)
        {
            Caption = 'Condición esperada';
            OptionCaption = ' ,Ausencia,Presencia,Conforme';
            OptionMembers = " ",Ausencia,Presencia,Conforme;

            trigger OnValidate()
            begin
                if "Tipo control" = "Tipo control"::"Condición" then if "Condición esperada" = "Condición esperada"::" " then Error('Atención: Condición esperada debe tener un valor');
            end;
        }
        field(15; "Valor mínimo"; Decimal)
        {
            Caption = 'Valor minimo';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Tipo control" = "Tipo control"::Valor then if "Valor máximo" <> 0 then if "Valor mínimo" > "Valor máximo" then Error('Atención: Valor mínimo %1 tiene que ser menor que Valor máximo %2', "Valor mínimo", "Valor máximo");
            end;
        }
        field(16; "Valor máximo"; Decimal)
        {
            Caption = 'Valor maximo';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Tipo control" = "Tipo control"::Valor then if "Valor mínimo" <> 0 then if "Valor máximo" < "Valor mínimo" then Error('Atención: Valor máximo %1 tiene que ser mayor que Valor mínimo %2', "Valor máximo", "Valor mínimo");
            end;
        }
        field(17; "Texto especificación"; Text[65])
        {
            Caption = 'Texto especificación';

            trigger OnValidate()
            begin
                if "Tipo control" = "Tipo control"::Texto then if "Texto especificación" = '' then Error('Atención: Texto especificación debe tener un valor');
            end;
        }
        field(18; "Valor medio"; Decimal)
        {
            Caption = 'Valor maximo';
            DecimalPlaces = 0 : 5;
        }
        field(19; "Tolerancia s/valor medio (%)"; Decimal)
        {
            Caption = 'Tolerancia s/valor medio (%)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Valor medio" = 0 then if "Tolerancia s/valor medio (%)" > 0 then Error('Atención: La tolerancia s/valor medio se aplica sobre un valor medio');
                if "Valor medio" <> 0 then if "Tolerancia s/valor medio (%)" = 0 then Error('Atención: El valor medio debe tener una tolerancia s/valor medio');
            end;
        }
        field(20; "Peso del requisito"; Decimal)
        {
            Caption = 'Peso del requisito';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "Tipo control" = "Tipo control"::Puntaje then if "Peso del requisito" <= 0 then Error('Atención: Peso del requisito tiene que ser mayor que cero');
            end;
        }
        field(21; "Cod. defecto si fallo"; Code[10])
        {
            Caption = 'Cod. defecto si fallo';
            TableRelation = "Defectos_CAL_btc";
        }
        field(22; "Afecta conformidad"; Boolean)
        {
            Caption = 'Afecta conformidad';

            trigger OnValidate()
            begin
                if ("Requisito crítico" = true) and ("Afecta conformidad" = false) then Error('Atención: si el requisito es crítico afecta a la conformidad');
            end;
        }
        field(23; "Descripción Procedimiento"; Text[150])
        {
            Caption = 'Descripción Procedimiento';
        }
        field(50; Tipo; Option)
        {
            Caption = 'Tipo';
            OptionMembers = Producto,"Proceso Fabricación","Evaluación Proveedor","Reclamación Proveedor","Reclamación Cliente";
        }
        field(51; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Tipo = CONST(Producto)) Item
            ELSE
            IF (Tipo = CONST("Proceso Fabricación")) "Standard Task"
            ELSE
            IF (Tipo = CONST("Evaluación Proveedor")) Vendor
            ELSE
            IF (Tipo = CONST("Reclamación Proveedor")) Vendor
            ELSE
            IF (Tipo = CONST("Reclamación Cliente")) Customer;

            trigger OnValidate()
            begin
                Clear("Descripción Tipo");
                if (Tipo = Tipo::Producto) and (Item.Get("No.") = true) then "Descripción Tipo" := Item.Description;
                if (Tipo = Tipo::"Proceso Fabricación") and (Task.Get("No.") = true) then "Descripción Tipo" := Task.Description;
                if (Tipo = Tipo::"Evaluación Proveedor") and (Vendor.Get("No.") = true) then "Descripción Tipo" := Vendor.Name;
                if (Tipo = Tipo::"Reclamación Proveedor") and (Vendor.Get("No.") = true) then "Descripción Tipo" := Vendor.Name;
                if (Tipo = Tipo::"Reclamación Cliente") and (Customer.Get("No.") = true) then "Descripción Tipo" := Customer.Name;
            end;
        }
        field(52; "Cod. variante"; Code[10])
        {
            Caption = 'Cod. variante';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(53; "Descripción Tipo"; Text[50])
        {
            Caption = 'Descripción Tipo';
            Editable = false;
        }
        field(50000; "Punto de muestreo"; Text[30])
        {
        }
    }
    keys
    {
        key(Key1; Tipo, "Cód. requisito control", "No.", "Cod. variante")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Cód. requisito control", "Descripción requisito")
        {
        }
    }
    trigger OnInsert()
    begin
        Validate("Fecha creación", WorkDate());
        "Usuario creación" := UserId();
    end;

    trigger OnModify()
    begin
        Validate("Fecha ultima modificación", CurrentDateTime());
        "Usuario ultima modificación" := UserId();
    end;

    var
        Item: Record Item;
        Task: Record "Standard Task";
        Vendor: Record Vendor;
        Customer: Record Customer;
}
