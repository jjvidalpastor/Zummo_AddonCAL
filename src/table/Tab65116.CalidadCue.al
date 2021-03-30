table 65116 "Calidad Cue"
{
    Caption = 'Calidad Cue', Comment = 'ESP="Pila calidad"';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; ItemLedgerEntryOpen; Integer)
        {
            Caption = 'Item LedgerEntry open', Comment = 'ESP="Mov. productos abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Movimientos de producto"), "Estado inspección" = FILTER(Abierta)));
        }
        field(3; ItemLedgerEntryLanzada; Integer)
        {
            Caption = 'Item LedgerEntry released', Comment = 'ESP="Mov. productos lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Movimientos de producto"), "Estado inspección" = FILTER(Lanzada)));
        }
        field(4; ItemLedgerEntryCertificada; Integer)
        {
            Caption = 'Item LedgerEntry certificate', Comment = 'ESP="Mov. productos certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Movimientos de producto"), "Estado inspección" = FILTER(Certificada)));
        }
        field(5; ItemLedgerEntryTerminada; Integer)
        {
            Caption = 'Item LedgerEntry finish', Comment = 'ESP="Mov. productos terminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Movimientos de producto"), "Estado inspección" = FILTER(Terminada)));
        }
        field(6; ClienteOpen; Integer)
        {
            Caption = 'Customer open', Comment = 'ESP="Cliente abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Cliente), "Estado inspección" = FILTER(Abierta)));
        }
        field(7; ClienteLanzada; Integer)
        {
            Caption = 'Customer lanzada', Comment = 'ESP="Cliente lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Cliente), "Estado inspección" = FILTER(Lanzada)));
        }
        field(8; ClienteCertificada; Integer)
        {
            Caption = 'Customer certificate', Comment = 'ESP="Cliente certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Cliente), "Estado inspección" = FILTER(Certificada)));
        }
        field(9; ClienteTerminada; Integer)
        {
            Caption = 'Customer finish', Comment = 'ESP="Cliente terminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Cliente), "Estado inspección" = FILTER(Terminada)));
        }
        field(10; ProveedorOpen; Integer)
        {
            Caption = 'Vendor open', Comment = 'ESP="Proveedor abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Proveedor), "Estado inspección" = FILTER(Abierta)));
        }
        field(11; ProveedorLanzada; Integer)
        {
            Caption = 'Vendor released', Comment = 'ESP="Proveedor lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Proveedor), "Estado inspección" = FILTER(Lanzada)));
        }
        field(12; ProveedorCertificada; Integer)
        {
            Caption = 'Vendor certificate', Comment = 'ESP="Proveedor certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Proveedor), "Estado inspección" = FILTER(Certificada)));
        }
        field(13; ProveedorTerminada; Integer)
        {
            Caption = 'Vendor finish', Comment = 'ESP="Proveedor terminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Proveedor), "Estado inspección" = FILTER(Terminada)));
        }
        field(14; ProductoOpen; Integer)
        {
            Caption = 'Item open', Comment = 'ESP="Producto abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Producto), "Estado inspección" = FILTER(Abierta)));
        }
        field(15; ProductoLanzada; Integer)
        {
            Caption = 'Item released', Comment = 'ESP="Producto lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Producto), "Estado inspección" = FILTER(Lanzada)));
        }
        field(16; ProductoCertificada; Integer)
        {
            Caption = 'Item certificate', Comment = 'ESP="Item certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Producto), "Estado inspección" = FILTER(Certificada)));
        }
        field(17; ProductoTerminada; Integer)
        {
            Caption = 'Item finish', Comment = 'ESP="Producto terminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Producto), "Estado inspección" = FILTER(Terminada)));
        }
        field(18; LinAlbVtaOpen; Integer)
        {
            Caption = 'Sales Shipment Line open', Comment = 'ESP="Lín. Albarán venta abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán venta"), "Estado inspección" = FILTER(Abierta)));
        }
        field(19; LinAlbVtaLanzada; Integer)
        {
            Caption = 'Sales Shipment Line released', Comment = 'ESP="Lín. Albarán venta lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán venta"), "Estado inspección" = FILTER(Lanzada)));
        }
        field(20; LinAlbVtaCertificada; Integer)
        {
            Caption = 'Sales Shipment Line certificate', Comment = 'ESP="Lín. Albarán venta certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán venta"), "Estado inspección" = FILTER(Certificada)));
        }
        field(21; LinAlbVtaTerminada; Integer)
        {
            Caption = 'Sales Shipment Line finish', Comment = 'ESP="Lín. Albarán venta terminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán venta"), "Estado inspección" = FILTER(Terminada)));
        }
        field(22; LinAlbCompraOpen; Integer)
        {
            Caption = 'Purch. Rcpt. Line open', Comment = 'ESP="Lín. Albarán compra abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán compra"), "Estado inspección" = FILTER(Abierta)));
        }
        field(23; LinAlbCompraLanzada; Integer)
        {
            Caption = 'Purch. Rcpt. Line released', Comment = 'ESP="Lín. Albarán compra lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán compra"), "Estado inspección" = FILTER(Lanzada)));
        }
        field(24; LinAlbCompraCertificada; Integer)
        {
            Caption = 'Purch. Rcpt. Line certificate', Comment = 'ESP="Lín. Albarán compra certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán compra"), "Estado inspección" = FILTER(Certificada)));
        }
        field(25; LinAlbCompraTerminada; Integer)
        {
            Caption = 'Purch. Rcpt. Line finish', Comment = 'ESP="Lín. Albarán compra terminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán compra"), "Estado inspección" = FILTER(Terminada)));
        }
        field(26; EmpleadoOpen; Integer)
        {
            Caption = 'Employee open', Comment = 'ESP="Empleado abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Lín. Albarán compra"), "Estado inspección" = FILTER(Abierta)));
        }
        field(27; EmpleadoLanzada; Integer)
        {
            Caption = 'Employee released', Comment = 'ESP="Empleado lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Empleado), "Estado inspección" = FILTER(Lanzada)));
        }
        field(28; EmpleadoCertificada; Integer)
        {
            Caption = 'Employee certificate', Comment = 'ESP="Empleado certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Empleado), "Estado inspección" = FILTER(Certificada)));
        }
        field(29; EmpleadoTerminada; Integer)
        {
            Caption = 'Employee finish', Comment = 'ESP="Empleado terminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST(Empleado), "Estado inspección" = FILTER(Terminada)));
        }
        field(30; OrdenProduccionOpen; Integer)
        {
            Caption = 'Production Order open', Comment = 'ESP="Orden de producción abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Orden de producción"), "Estado inspección" = FILTER(Abierta)));
        }
        field(31; OrdenProduccionLanzada; Integer)
        {
            Caption = 'Production Order released', Comment = 'ESP="Orden de producción lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Orden de producción"), "Estado inspección" = FILTER(Lanzada)));
        }
        field(32; OrdenProduccionCertificada; Integer)
        {
            Caption = 'Production Order certificate', Comment = 'ESP="Orden de producción certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Orden de producción"), "Estado inspección" = FILTER(Certificada)));
        }
        field(33; OrdenProduccionTerminada; Integer)
        {
            Caption = 'Production Order finish', Comment = 'ESP="Orden de producción terminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Orden de producción"), "Estado inspección" = FILTER(Terminada)));
        }
        field(35; CompOrdenProduccionOpen; Integer)
        {
            Caption = 'Prod. Order component open', Comment = 'ESP="Componente orden de producción abierto"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Componente orden de producción"), "Estado inspección" = FILTER(Abierta)));
        }
        field(36; CompOrdenProduccionLanzada; Integer)
        {
            Caption = 'Prod. Order component released', Comment = 'ESP="Componente orden de producción lanzada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Componente orden de producción"), "Estado inspección" = FILTER(Lanzada)));
        }
        field(37; CompOrdenProduccionCertificada; Integer)
        {
            Caption = 'Prod. Order component certificate', Comment = 'ESP="Componente orden de producción certificada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Componente orden de producción"), "Estado inspección" = FILTER(Certificada)));
        }
        field(38; CompOrdenProduccionTerminada; Integer)
        {
            Caption = 'Prod. Order component finish', Comment = 'ESP="Componente orden de producciónterminada"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab inspe eval_CAL_btc" WHERE("Origen inspección" = CONST("Componente orden de producción"), "Estado inspección" = FILTER(Terminada)));
        }
        field(39; UserIDFilter; Code[20])
        {
            Caption = 'User ID Filter', Comment = 'ESP="Filtro Id. usuario"';
            DataClassification = ToBeClassified;
        }
        field(40; MovProdAlmInspeccion; Integer)
        {
            Caption = 'Item Ledger entry open location', Comment = 'ESP="Mov. productos pendientes almacén"';
            FieldClass = FlowField;
            CalcFormula = Count("Item Ledger Entry" WHERE("Location Code" = field(filtroAlmacenInspe), Open = FILTER(True)));
        }
        field(41; MovProdAlmNoConf; Integer)
        {
            Caption = 'Item Ledger entry open location', Comment = 'ESP="Mov. productos pendientes almacén"';
            FieldClass = FlowField;
            CalcFormula = Count("Item Ledger Entry" WHERE("Location Code" = field(filtroAlmacenNoConf), Open = FILTER(True)));
        }
        field(42; filtroAlmacenInspe; code[20])
        {
            FieldClass = FlowFilter;
        }
        field(43; filtroAlmacenNoConf; code[20])
        {
            FieldClass = FlowFilter;
        }
        field(44; NoConformidadAbierto; Integer)
        {
            Caption = 'Inspection non-conformity open ', Comment = 'ESP="Inspección abierta no conformidad"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab no conformidad_CAL_btc" WHERE("Estado no conformidad" = FILTER(Abierta)));
        }
        field(45; NoConformidadLanzada; Integer)
        {
            Caption = 'Inspection non-conformity released ', Comment = 'ESP="Inspección lanzada no conformidad"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab no conformidad_CAL_btc" WHERE("Estado no conformidad" = FILTER(Lanzada)));
        }
        field(46; NoConformidadCertificada; Integer)
        {
            Caption = 'Inspection non-conformity certificate ', Comment = 'ESP="Inspección certificada no conformidad"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab no conformidad_CAL_btc" WHERE("Estado no conformidad" = FILTER(Certificada)));
        }
        field(47; NoConformidadTermi; Integer)
        {
            Caption = 'Inspection non-conformity finished ', Comment = 'ESP="Inspección terminada no conformidad"';
            FieldClass = FlowField;
            CalcFormula = Count("Cab no conformidad_CAL_btc" WHERE("Estado no conformidad" = FILTER(Certificada)));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
