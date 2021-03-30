table 65110 "Accion_CAL_btc"
{
    Caption = 'Accion';
    DrillDownPageID = "Accion List_CAL_btc";
    LookupPageID = "Accion List_CAL_btc";

    fields
    {
        field(1; Tipo; Option)
        {
            Caption = 'Tipo';
            OptionMembers = Inmediata,Correctiva,Preventiva;
        }
        field(2; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(3; "Descripción"; Text[50])
        {
            Caption = 'Descripcion';
        }
        field(4; "Descripción 2"; Text[50])
        {
            Caption = 'Descripcion 2';
        }
        field(5; "Descripción 3"; Text[50])
        {
            Caption = 'Descripcion 3';
        }
        field(6; "Acción inmediata"; Option)
        {
            Caption = 'Accion inmediata';
            OptionMembers = " ",Cuarentena,"No Conformes","Devolución a Prov.","Prod. a Reclasificar","Prod. a Reprocesar","Prod. a Reciclar","Prod. a Desechar";
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
        field(10; "Fecha última modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(11; "Usuario última modificación"; Code[50])
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
        key(Key1; Tipo, "No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Tipo, "No.", "Descripción")
        {
        }
    }
    trigger OnDelete()
    var
        CausaDeDefectos: Record "Causa de defectos_CAL_btc";
    begin
        case Tipo of
            Tipo::Inmediata:
                CausaDeDefectos.SetRange("Cód. acción inmediata", "No.");
            Tipo::Correctiva:
                CausaDeDefectos.SetRange("Cód. acción correctiva", "No.");
            Tipo::Preventiva:
                CausaDeDefectos.SetRange("Cód. acción preventiva", "No.");
            else
                Error('Tipo no esperado');
        end;
        if CausaDeDefectos.FindFirst() then Error('Accción %1 %2 utilizada en Causa defecto %3, modifique el registro antes de eliminar la Acción', Tipo, "No.", CausaDeDefectos."No.");
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
