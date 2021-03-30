table 65108 "Defectos_CAL_btc"
{
    Caption = 'Defectos';
    DrillDownPageID = "Defectos_CAL_btc";
    LookupPageID = "Defectos_CAL_btc";

    fields
    {
        field(1; "Código"; Code[10])
        {
            Caption = 'Codigo';
        }
        field(2; "Descripción"; Text[50])
        {
            Caption = 'Descripcion';
        }
        field(3; "Origen inspección"; enum OrigenCalidad)
        {
            /*            
                  Caption = 'Origen inspeccion';
                  OptionCaption = 'Recepción,Almacén,Fabricación,Envío,Devolución,Procesos,Evaluación,Reclamación,Muestras,Mat.Gráfico';
                  OptionMembers = "Recepción","Almacén","Fabricación","Envío","Devolución",Procesos,"Evaluación","Reclamación",Muestras,"Mat.Gráfico";
                  */
            Caption = 'Origin Inspection', comment = 'ESP="Origen Inspección"';
        }
        field(4; "Clase de defecto"; Option)
        {
            Caption = 'Clase de defecto';
            OptionCaption = ' ,A,B,C';
            OptionMembers = " ",A,B,C;
        }
        field(5; "Cód. requisito control"; Code[10])
        {
            Caption = 'Cod. requisito control';
            TableRelation = calidad_CAL_btc;
        }
        field(6; "Cód. causa principal"; Code[10])
        {
            Caption = 'Cod. causa principal';
            TableRelation = "Causa de defectos_CAL_btc";
        }
        field(7; "Cód. causa alternativa"; Code[10])
        {
            Caption = 'Cod. causa alternativa';
            TableRelation = "Causa de defectos_CAL_btc";
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
        field(13; "Afecta Conformidad"; Boolean)
        {
            Caption = 'Afecta Conformidad';
        }
    }
    keys
    {
        key(Key1; "Código")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descripción")
        {
        }
    }
    trigger OnDelete()
    var
        CausaDefecto: Record "Causa de defectos_CAL_btc";
        ReqControlPorProducto: Record "Req Control especifico_CAL_btc";
        ReqControl: Record calidad_CAL_btc;
    begin
        CausaDefecto.SetRange("Cód. defecto habitual", Código);
        if CausaDefecto.FindFirst() then Error('Defecto %1 utilizado en Causa de defecto %2, modifique el registro antes de eliminar el defecto', Código, CausaDefecto."No.");
        CausaDefecto.Reset();
        CausaDefecto.SetRange("Cód. defecto secundario", Código);
        if CausaDefecto.FindFirst() then Error('Defecto %1 utilizado en Causa de defecto %2, modifique el registro antes de eliminar el defecto', Código, CausaDefecto."No.");
        ReqControl.SetRange("Cod. defecto si fallo", Código);
        if ReqControl.FindFirst() then Error('Defecto %1 utilizado en Requisito control calidad %2, modifique el registro antes de eliminar el defecto', Código, ReqControl."No.");
        ReqControlPorProducto.SetRange("Unidad de medida", Código);
        if ReqControlPorProducto.FindFirst() then Error('Defecto %1 utilizado en Requisito control por producto %2 %3 %4, modifique el registro antes de eliminar el defecto', Código, ReqControlPorProducto."Cód. requisito control", ReqControlPorProducto."Descripción requisito", ReqControlPorProducto."Omitir impresión");
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
