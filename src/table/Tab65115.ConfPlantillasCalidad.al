table 65115 "Conf_Plantillas_Calidad"
{
    DataClassification = ToBeClassified;
    Caption = 'Quality Templates Setup', comment = 'ESP="Conf. Plantillas Calidad"';
    LookupPageId = Lista_Conf_Plantillas_Calidad;
    DrillDownPageId = Lista_Conf_Plantillas_Calidad;

    fields
    {
        field(1; "Origen inspección"; enum OrigenCalidad)
        {
            Caption = 'Origin Inspection', comment = 'ESP="Origen Inspección"';

            trigger OnValidate()
            begin
                CodEspecifico := '';
                CodEspecificoNivel2 := '';
                CodEspecificoNivel3 := '';
                OrigenInspeccionNivel2 := OrigenInspeccionNivel2::Ninguno;
                OrigenInspeccionNivel3 := OrigenInspeccionNivel3::Ninguno;
            end;
        }
        field(2; CodEspecifico; Code[20])
        {
            Caption = 'Specific code', comment = 'ESP="Código específico"';
            TableRelation = if ("Origen inspección" = const(Cliente)) Customer
            else
            if ("Origen inspección" = const(Proveedor)) Vendor
            else
            if ("Origen inspección" = Const(Producto)) Item where(ActivarGestionCalidadCAL_BTC = const(true))
            else
            if ("Origen inspección" = Const(Empleado)) Employee;
        }
        field(3; CodPlantillaInspeccion; Code[10])
        {
            Caption = 'Inspection Template Code', comment = 'ESP="Cód. Plantilla Inspección"';
            TableRelation = "Plantilla de inseval_CAL_btc"."No.";
        }
        field(4; "No. revisión"; Integer)
        {
            Caption = 'Revision No.', comment = 'ESP="No. Revisión"';
            TableRelation = "Plantilla de inseval_CAL_btc"."No. revisión" where("No." = field(CodPlantillaInspeccion));
        }
        field(5; OrigenInspeccionNivel2; enum TiposCodigosEspecificos)
        {
            Caption = '2nd Origin Inspection Level', comment = 'ESP="2º Nivel Origen Inspección"';

            trigger OnValidate()
            begin
                CodEspecificoNivel2 := '';
                CodEspecificoNivel3 := '';
                OrigenInspeccionNivel3 := OrigenInspeccionNivel3::Ninguno;
            end;
        }
        field(6; CodEspecificoNivel2; Code[20])
        {
            Caption = '2nd Specific code Level', comment = 'ESP="Código específico 2º Nivel"';
            TableRelation = if (OrigenInspeccionNivel2 = const(Cliente)) Customer
            else
            if (OrigenInspeccionNivel2 = const(Proveedor)) Vendor
            else
            if (OrigenInspeccionNivel2 = Const(Producto)) Item where(ActivarGestionCalidadCAL_BTC = const(true))
            else
            if (OrigenInspeccionNivel2 = Const(Empleado)) Employee;
        }
        field(7; OrigenInspeccionNivel3; enum TiposCodigosEspecificos)
        {
            Caption = '3rd Origin Inspection Level', comment = 'ESP="3º Nivel Origen Inspección"';

            trigger OnValidate()
            begin
                CodEspecificoNivel3 := '';
            end;
        }
        field(8; CodEspecificoNivel3; Code[20])
        {
            Caption = '3rd Specific code Level', comment = 'ESP="Código específico 3º Nivel"';
            TableRelation = if (OrigenInspeccionNivel3 = const(Cliente)) Customer
            else
            if (OrigenInspeccionNivel3 = const(Proveedor)) Vendor
            else
            if (OrigenInspeccionNivel3 = Const(Producto)) Item where(ActivarGestionCalidadCAL_BTC = const(true))
            else
            if (OrigenInspeccionNivel3 = Const(Empleado)) Employee;
        }
    }
    keys
    {
        key(PK; "Origen inspección", CodEspecifico, OrigenInspeccionNivel2, CodEspecificoNivel2, OrigenInspeccionNivel3, CodEspecificoNivel3)
        {
            Clustered = true;
        }
    }
}
