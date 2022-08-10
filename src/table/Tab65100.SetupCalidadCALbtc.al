table 65100 "Setup Calidad_CAL_btc"
{
    Caption = 'Configuración Calidad';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "No. serie insp. recepcion"; Code[10])
        {
            Caption = 'No. serie insp. recepcion';
            TableRelation = "No. Series";
        }
        field(3; "No. serie insp. fabricación"; Code[10])
        {
            Caption = 'No. serie insp. fabricacion';
            TableRelation = "No. Series";
        }
        field(4; "No. serie insp. procesos"; Code[10])
        {
            Caption = 'No. serie insp. procesos';
            TableRelation = "No. Series";
        }
        field(5; "No. serie insp. almacén"; Code[10])
        {
            Caption = 'No. serie insp. almacen';
            TableRelation = "No. Series";
        }
        field(6; "No. serie insp. devolución"; Code[10])
        {
            Caption = 'No. serie insp. devolucion';
            TableRelation = "No. Series";
        }
        field(7; "No. serie insp. evaluación"; Code[10])
        {
            Caption = 'No. serie insp. evaluacion';
            TableRelation = "No. Series";
        }
        field(9; "No. serie no conformidades"; Code[20])
        {
            Caption = 'No. serie no conformidades';
            TableRelation = "No. Series";
        }
        field(10; "Cód. almacén inspeccion cal."; Code[10])
        {
            Caption = 'Cod. almacen inspeccion cal.';
            TableRelation = Location;
        }
        field(11; "Cód. almacén cuarentena cal."; Code[10])
        {
            Caption = 'Cod. almacen cuarentena cal.';
            TableRelation = Location;
        }
        field(12; "Cód. almacén no conformes"; Code[10])
        {
            Caption = 'Cod. almacen no conformes';
            TableRelation = Location;
        }
        field(14; "Cód. almacén devolución a prov"; Code[10])
        {
            Caption = 'Cod. almacen devolucion a prov';
            TableRelation = Location;
        }
        field(15; "Cód. almacén prod. a reclasifi"; Code[10])
        {
            Caption = 'Cod. almacen prod. a reclasifi';
            TableRelation = Location;
        }
        field(16; "Cód. almacén prod. a reproces."; Code[10])
        {
            Caption = 'Cod. almacen prod. a reproces.';
            TableRelation = Location;
        }
        field(17; "Cód. almacén prod. a reciclar"; Code[10])
        {
            Caption = 'Cod. almacen prod. a reciclar';
            TableRelation = Location;
        }
        field(18; "Cód. almacén prod. a rechazar"; Code[10])
        {
            Caption = 'Cod. almacen prod. a rechazar';
            TableRelation = Location;
        }
        field(19; "Fecha creación"; DateTime)
        {
            Caption = 'Fecha creacion';
            Editable = false;
        }
        field(20; "Usuario creación"; Code[50])
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
        field(21; "Fecha ultima modificación"; DateTime)
        {
            Caption = 'Fecha ultima modificacion';
            Editable = false;
        }
        field(22; "Usuario ultima modificación"; Code[50])
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
        field(23; "Activar gestión de la calidad"; Boolean)
        {
            Caption = 'Activar gestion de la calidad';
        }
        field(24; "Cód. plantilla recepción pred"; Code[20])
        {
            Caption = 'Cod. plantilla recepcion pred.';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Recepción"));
            //TODO: Revisar relaciones de plantillas
        }
        field(25; "Cód. plantilla almacén pred"; Code[20])
        {
            Caption = 'Cod. plantilla almacen predet.';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Almacén"));
            //TODO: Revisar relaciones de plantillas
        }
        field(26; "Cód. plantilla fabricación pre"; Code[20])
        {
            Caption = 'Cod. plantilla fabricacion pre';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Fabricación"));
            //TODO: Revisar relaciones de plantillas
        }
        field(27; "Cód. plantilla envio predeter"; Code[20])
        {
            Caption = 'Cod. plantilla envio predeter.';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Envío"));
            //TODO: Revisar relaciones de plantillas
        }
        field(28; "Cód. plantilla devolución pred"; Code[20])
        {
            Caption = 'Cod. plantilla devolucion pred';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Devolución"));
            //TODO: Revisar relaciones de plantillas
        }
        field(29; "Cód. plantilla procesos pred"; Code[20])
        {
            Caption = 'Cod. plantilla procesos predet';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST (Procesos));
            //TODO: Revisar relaciones de plantillas
        }
        field(30; "Cód. plantilla evaluación pred"; Code[20])
        {
            Caption = 'Cod. plantilla evaluacion pred';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Evaluación"));
            //TODO: Revisar relaciones de plantillas
        }
        field(31; "No. serie insp. envío"; Code[10])
        {
            Caption = 'No. serie insp. envio';
            TableRelation = "No. Series";
        }
        field(32; "No. serie insp. reclamación"; Code[10])
        {
            Caption = 'No. serie insp. reclamación';
            TableRelation = "No. Series";
        }
        field(33; "Cód. plantilla reclamación pre"; Code[20])
        {
            Caption = 'Cod. plantilla reclamación predet';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Reclamación"));
            //TODO: Revisar relaciones de plantillas
        }
        field(34; "No. serie insp. muestras"; Code[10])
        {
            Caption = 'No. serie insp. muestras';
            TableRelation = "No. Series";
        }
        field(35; "Cód. plantilla muestras predet"; Code[20])
        {
            Caption = 'Cod. plantilla muestras predet';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST (Muestras));
            //TODO: Revisar relaciones de plantillas
        }
        field(36; "No. serie insp. mat. graph"; Code[10])
        {
            Caption = 'No. serie insp. material gráfico';
            TableRelation = "No. Series";
        }
        field(37; "Cód. plantilla mat. graph pred"; Code[20])
        {
            Caption = 'Cod. plantilla material gráfico predet';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Mat.Gráfico"));
            //TODO: Revisar relaciones de plantillas
        }
        field(50000; "Activar doble confirmacion"; Boolean)
        {
            Caption = 'Activar doble confirmación';
        }
        field(50001; "Receptores DC Calidad"; Text[150])
        {
            Caption = 'Receptores DC Calidad';
        }
        field(50002; "Receptores DC Fabricacion"; Text[150])
        {
            Caption = 'Receptores DC Fabricación';
        }
        field(50003; "Receptores DC Formulacion"; Text[150])
        {
            Caption = 'Receptores DC Formulación';
        }
        field(50004; "Receptores Apertura Inspeccion"; Text[150])
        {
            Caption = 'Receptores Apertura Inspeccion';
        }
        field(50005; "Receptores Recepcion Producto"; Text[150])
        {
            Caption = 'Receptores Recepción Producto';
        }
        field(50006; "Receptores Apertura No Confor"; Text[150])
        {
            Caption = 'Receptores Apertura No Conformidad';
        }
        field(50007; "Receptores Fabricacion Produc"; Text[150])
        {
            Caption = 'Receptores Fabricacion Producto';
        }
        field(50008; "Receptores Recep Mat.Graph"; Text[150])
        {
            Caption = 'Receptores Recepción Material Gráfico';
        }
        field(50009; "Receptores Apertura Insp Graph"; Text[150])
        {
            Caption = 'Receptores Apertura Insp. Material Gráfico';
        }
        field(50010; "Activar aviso apertura inspecc"; Boolean)
        {
            Caption = 'Activar aviso apertura inspección genérica';
        }
        field(50011; "Activar aviso recepcion produc"; Boolean)
        {
            Caption = 'Activar aviso recepción producto';
        }
        field(50012; "Activar aviso apertura noconf"; Boolean)
        {
            Caption = 'Activar aviso apertura no conformidad';
        }
        field(50013; "Activar aviso fabricacion prod"; Boolean)
        {
            Caption = 'Activar aviso fabricación producto';
        }
        field(50014; "Activar aviso recepcion graph"; Boolean)
        {
            Caption = 'Activar aviso recepción material gráfico';
        }
        field(50015; "Activar aviso apert insp graph"; Boolean)
        {
            Caption = 'Activar aviso apertura insp. material gráfico';
        }
        field(50016; "Activar aviso cert. insp. rec."; Boolean)
        {
            Caption = 'Activar aviso certificación insp. recepción producto';
        }
        field(50017; "Activar aviso cert. insp. fab."; Boolean)
        {
            Caption = 'Activar aviso certificación insp. fabricación producto';
        }
        field(50018; "Activar aviso cert. insp. grap"; Boolean)
        {
            Caption = 'Activar aviso certificación insp. material gráfico';
        }
        field(50019; "Activar aviso mensajes emisor"; Boolean)
        {
            Caption = 'Activar aviso mensajes pop-up al emisor';
        }
        field(50020; "Item Category Code Graph"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(50021; "Receptores Cert. Insp. Recep."; Text[150])
        {
            Caption = 'Receptores Certificación Insp. Recep. Producto';
        }
        field(50022; "Receptores Cert. Insp. Fabrica"; Text[150])
        {
            Caption = 'Receptores Certificación Insp. Fabricación Producto';
        }
        field(50023; "Receptores Cert. Insp. Mat.Gra"; Text[150])
        {
            Caption = 'Receptores Certificación Insp. Material Gráfico';
        }
        field(50050; "Almacén depósito para muestras"; Code[10])
        {
            Caption = 'Almacén depósito para muestras';
            TableRelation = Location;
        }
        field(50054; "Receptores DC Control Visual R"; Text[150])
        {
            Caption = 'Receptores DC Control Visual Recepción';
        }
        field(50055; "Receptores DC Control Visual F"; Text[150])
        {
            Caption = 'Receptores DC Control Visual Fabricación';
        }
        field(50056; "Receptores DC Mat.Graph"; Text[150])
        {
            Caption = 'Receptores DC Material Gráfico';
        }
        field(50100; "Activar triple confirmacion LM"; Boolean)
        {
            Caption = 'Activar triple confirmación LM';

            trigger OnValidate()
            begin
                if ("Activar triple confirmacion LM" = true) and ("Activar doble confirmacion" = false) then Error('Atención: No se puede activar la triple confirmación en Listas de Materiales sin activar la doble confirmación');
            end;
        }
        field(38; "No. serie Cab. Inspección"; Code[20])
        {
            Caption = 'Cab Series No. Inspection', comment = 'ESP="Nº Serie Cab. Inspección"';
            TableRelation = "No. Series";
        }
        //BTC FSD 03.02.2020 Creacion de nuevo campo para trasnferencia de almacen.
        field(50057; "AlmacenInpeccion"; Code[20])
        {
            Caption = 'Almacén Inspección', Comment = 'ESP="Almacén Inspección"';
            TableRelation = Location.Code;
        }
        field(50058; "Journal Template Name"; code[10])
        {
            Caption = 'Journal Template Name', Comment = 'ESP="Nombre libro diario"';
            TableRelation = "Item Journal Template";
        }
        field(50059; "Journal Batch Name"; code[10])
        {
            Caption = 'Journal Batch Name', Comment = 'ESP="Nombre sección diario"';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(50060; "Journal Template No conforme"; code[10])
        {
            Caption = 'Journal Template Name No conforme', Comment = 'ESP="Nombre libro diario No conforme"';
            TableRelation = "Item Journal Template";
        }
        field(50061; "Journal Batch No conforme"; code[10])
        {
            Caption = 'Journal Batch Name No conforme', Comment = 'ESP="Nombre sección diario No conforme"';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template No conforme"));
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        Validate("Fecha creación", CurrentDateTime());
        "Usuario creación" := CopyStr(UserId(), 1, 50);
    end;

    trigger OnModify()
    begin
        Validate("Fecha ultima modificación", CurrentDateTime());
        "Usuario ultima modificación" := CopyStr(UserId(), 1, 50);
    end;
}
