table 65102 "inspeccion_CAL_btc"
{
    Caption = 'Grupos de inspección';
    DrillDownPageID = "Grupos de Inspección_CAL_btc";
    LookupPageID = "Grupos de Inspección_CAL_btc";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "Descripción"; Text[100])
        {
            Caption = 'Descripcion';
        }
        field(3; "Omitir impresión"; Boolean)
        {
            Caption = 'Omitir impresion';
        }
        field(4; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(5; "Fecha creación"; Date)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(6; "Usuario creación"; Code[50])
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
        field(7; "Fecha ultima modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(8; "Usuario ultima modificación"; Code[50])
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
        ReqControlPorGrupo: Record "Req Contr x grupo insp_CAL_btc";
        GruposPorPlantilla: Record "Grupos inspec x planta_CAL_btc";
    begin
        GruposPorPlantilla.SetRange("Cod. grupo inspección", "No.");
        if GruposPorPlantilla.FindFirst() then Error('El grupo de inspección %1 se utiliza en la plantilla %2 %3, modifique el regitro antes de eliminar el grupo', "No.", GruposPorPlantilla."Cód. plantilla", GruposPorPlantilla."No. revision plantilla");
        ReqControlPorGrupo.SetRange("Cód. grupo inspección", "No.");
        ReqControlPorGrupo.DeleteAll(true);
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
