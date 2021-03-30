table 65106 "Req Contr x grupo insp_CAL_btc"
{
    Caption = 'Req. control por grupo inspec.';

    fields
    {
        field(1; "Cód. grupo inspección"; Code[10])
        {
            Caption = 'Cod. grupo inspeccion';
        }
        field(2; "No. orden"; Integer)
        {
            Caption = 'No. orden';
        }
        field(3; "Cod. requisito control"; Code[10])
        {
            Caption = 'Cod. requisito control';
            TableRelation = calidad_CAL_btc;

            trigger OnValidate()
            var
                Requisito: Record calidad_CAL_btc;
            begin
                if Requisito.Get("Cod. requisito control") then begin
                    Validate(Descripción, Requisito.Descripción);
                    Validate("Omitir impresión", Requisito."Omitir impresión");
                    Validate(Bloqueado, Requisito.Bloqueado);
                end
                else begin
                    Validate(Descripción, '');
                    Validate("Omitir impresión", false);
                    Validate(Bloqueado, false);
                end;
            end;
        }
        field(4; "Descripción"; Text[60])
        {
            Caption = 'Descripcion';
        }
        field(8; "Omitir impresión"; Boolean)
        {
            Caption = 'Omitir impresion';
        }
        field(12; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(13; "Fecha creación"; Date)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(14; "Usuario creación"; Code[50])
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
        field(15; "Fecha ultima modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(16; "Usuario ultima modificación"; Code[50])
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
        key(Key1; "Cód. grupo inspección", "No. orden")
        {
        }
    }
    fieldgroups
    {
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
}
