table 65103 "Grupos inspec x planta_CAL_btc"
{
    Caption = 'Grupos de inspeccion por plant';

    fields
    {
        field(1; "Cód. plantilla"; Code[10])
        {
            Caption = 'Cod. plantilla';
            TableRelation = "Plantilla de inseval_CAL_btc"."No.";
        }
        field(2; "No. revision plantilla"; Integer)
        {
            Caption = 'No. revision plantilla';
            TableRelation = "Plantilla de inseval_CAL_btc"."No. revisión" WHERE("No." = FIELD("Cód. plantilla"));
        }
        field(3; "No. orden"; Integer)
        {
            Caption = 'No. orden';
        }
        field(4; "Cod. grupo inspección"; Code[10])
        {
            Caption = 'Cod. grupo inspeccion';
            TableRelation = inspeccion_CAL_btc;

            trigger OnValidate()
            var
                Grupo: Record inspeccion_CAL_btc;
            begin
                if Grupo.Get("Cod. grupo inspección") then begin
                    Validate(Descripción, Grupo.Descripción);
                    Validate("Omitir impresión", Grupo."Omitir impresión");
                end
                else begin
                    Validate(Descripción, '');
                    Validate("Omitir impresión", false);
                end;
            end;
        }
        field(5; "Descripción"; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Omitir impresión"; Boolean)
        {
            Caption = 'Omitir impresion';
        }
        field(7; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(8; "Fecha creación"; Date)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(9; "Usuario creación"; Code[50])
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
        field(10; "Fecha ultima modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(11; "Usuario ultima modificación"; Code[50])
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
        key(Key1; "Cód. plantilla", "No. revision plantilla", "No. orden")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        EstadoPlantilla();
        if PlantillaCertificada = true then Error(TexPlantillaCertificadaMsg);
    end;

    trigger OnInsert()
    begin
        EstadoPlantilla();
        if PlantillaCertificada = true then Error(TexPlantillaCertificadaMsg);
        Validate("Fecha creación", WorkDate());
        "Usuario creación" := UserId();
    end;

    trigger OnModify()
    begin
        EstadoPlantilla();
        if PlantillaCertificada = true then Error(TexPlantillaCertificadaMsg);
        Validate("Fecha ultima modificación", CurrentDateTime());
        "Usuario ultima modificación" := UserId();
    end;

    var
        Plantilla: Record "Plantilla de inseval_CAL_btc";
        PlantillaCertificada: Boolean;
        TexPlantillaCertificadaMsg: Label 'Atención: Plantilla en estado certificada no puede ser modificada o borrada';

    local procedure EstadoPlantilla()
    begin
        PlantillaCertificada := true;
        Plantilla.Reset();
        Plantilla.SetRange("No.", "Cód. plantilla");
        Plantilla.SetRange("No. revisión", "No. revision plantilla");
        Plantilla.SetRange(Bloqueado, false);
        Plantilla.SetRange("Version activa", true);
        Plantilla.SetRange(Estado, Plantilla.Estado::Certificada);
        if Plantilla.FindLast() = false then PlantillaCertificada := false;
    end;
}
