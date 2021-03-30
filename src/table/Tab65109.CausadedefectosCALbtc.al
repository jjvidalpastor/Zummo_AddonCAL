table 65109 "Causa de defectos_CAL_btc"
{
    Caption = 'Causa de Efectos';
    DrillDownPageID = "Causas de Defectos_CAL_btc";
    LookupPageID = "Causas de Defectos_CAL_btc";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "Descripción"; Text[50])
        {
            Caption = 'Descripcion';
        }
        field(3; "Descripcion 2"; Text[50])
        {
            Caption = 'Descripcion 2';
        }
        field(4; "Descripcion 3"; Text[50])
        {
            Caption = 'Descripcion 3';
        }
        field(5; "Cód. acción inmediata"; Code[10])
        {
            Caption = 'Cod. accion inmediata';
            TableRelation = "Accion_CAL_btc"."No." WHERE(Tipo = CONST(Inmediata));
        }
        field(6; "Cód. acción correctiva"; Code[10])
        {
            Caption = 'Cod. accion correctiva';
            TableRelation = "Accion_CAL_btc"."No." WHERE(Tipo = CONST(Correctiva));
        }
        field(7; "Cód. acción preventiva"; Code[10])
        {
            Caption = 'Cod. accion preventiva';
            TableRelation = "Accion_CAL_btc"."No." WHERE(Tipo = CONST(Preventiva));
        }
        field(8; "Cód. defecto habitual"; Code[10])
        {
            Caption = 'Cod. defecto habitual';
            TableRelation = "Defectos_CAL_btc";
        }
        field(9; "Cód. defecto secundario"; Code[10])
        {
            Caption = 'Cod. defecto secundario';
            TableRelation = "Defectos_CAL_btc";
        }
        field(10; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(11; "Fecha creación"; Date)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(12; "Usuario creación"; Code[50])
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
        field(13; "Fecha última modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(14; "Usuario última modificación"; Code[50])
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
