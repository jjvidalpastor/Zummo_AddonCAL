table 65105 "Procedimientos_CAL_btc"
{
    Caption = 'Procedimientos';
    DrillDownPageID = "Procedimientos_CAL_btc";
    LookupPageID = "Procedimientos_CAL_btc";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; "Descripción"; Text[150])
        {
            Caption = 'Descripcion';
        }
        field(3; "Unidad medida preferente"; Code[10])
        {
            Caption = 'Unidad medida preferente';
            TableRelation = "Unit of Measure";
        }
        field(4; "Tipo control preferente"; Option)
        {
            Caption = 'Tipo control';
            OptionCaption = ' ,Condición,Valor,Texto,Puntaje';
            OptionMembers = " ","Condición",Valor,Texto,Puntaje;
        }
        field(5; "No. suministrador"; Code[20])
        {
            Caption = 'No. proveedor';
            TableRelation = Vendor;
        }
        field(6; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(7; "Fecha creación"; Date)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(8; "Usuario creación"; Code[50])
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
        field(9; "Fecha ultima modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(10; "Usuario ultima modificacón"; Code[50])
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
                UserMgt.LookupUserID("Usuario ultima modificacón");
            end;
        }
        field(11; "Aptitud del Procedimiento"; Text[50])
        {
            Caption = 'Aptitud del Procedimiento';
        }
        field(12; Norma; Text[50])
        {
            Caption = 'Norma';
        }
        field(13; "Grupo inspección preferente"; Code[10])
        {
            Caption = 'Grupo inspección preferente';
            TableRelation = inspeccion_CAL_btc;
        }
        field(14; "Requisito control preferente"; Code[10])
        {
            Caption = 'Requisito control preferente';
            TableRelation = calidad_CAL_btc;
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
        RequisitoControl: Record calidad_CAL_btc;
    begin
        RequisitoControl.SetRange("Cód. Procedimiento", "No.");
        if RequisitoControl.FindFirst() then Error('El instrumento de medida %1 utiliza en el requisito de control %2, modifique el registro antes de elimina el instrumento', "No.", RequisitoControl."No.");
    end;

    trigger OnInsert()
    begin
        Validate("Fecha creación", WorkDate());
        "Usuario creación" := UserId();
    end;

    trigger OnModify()
    begin
        Validate("Fecha ultima modificación", CurrentDateTime());
        "Usuario ultima modificacón" := UserId();
    end;
}
