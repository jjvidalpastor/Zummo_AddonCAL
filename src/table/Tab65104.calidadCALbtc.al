table 65104 "calidad_CAL_btc"
{
    Caption = 'Requisitos control de calidad';
    DrillDownPageID = "Requisitos Control_CAL_btc";
    LookupPageID = "Requisitos Control_CAL_btc";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "Descripción"; Text[60])
        {
            Caption = 'Descripcion';
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

            trigger OnValidate()
            var
                Procedimientos: Record "Procedimientos_CAL_btc";
            begin
                if Procedimientos.Get("Cód. Procedimiento") then begin
                    Validate("Tipo control", Procedimientos."Tipo control preferente");
                    Validate("Descripción Procedimiento", Procedimientos.Descripción);
                    Validate(Norma, Procedimientos.Norma);
                    Validate("Unidad de medida", Procedimientos."Unidad medida preferente");
                end;
            end;
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
        field(17; "Texto especificación"; Text[50])
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
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Descripción")
        {
        }
    }
    trigger OnDelete()
    var
        ReqPorGrupo: Record "Req Contr x grupo insp_CAL_btc";
        ReqPorProducto: Record "Req Control especifico_CAL_btc";
    begin
        ReqPorGrupo.SetRange("Cod. requisito control", "No.");
        if ReqPorGrupo.FindFirst() then Error('Requisito %1 utilizado en requisito de control por grupo de inspección %2, modifique el registros antes de eliminar el requisito.', "No.", ReqPorGrupo."Cód. grupo inspección");
        ReqPorProducto.SetRange("Cód. requisito control", "No.");
        if ReqPorProducto.FindFirst() then Error('Requisito %1 utilizado en requisito de control por producto %2, modifique el registros antes de eliminar el requisito.', "No.", ReqPorProducto."No.");
    end;

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
}
