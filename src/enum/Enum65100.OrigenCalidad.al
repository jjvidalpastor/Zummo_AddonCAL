enum 65100 "OrigenCalidad"
{
    Extensible = true;

    value(18; Cliente)
    {
        Caption = 'Customer', comment = 'ESP="Cliente"';
    }

    value(23; Proveedor)
    {
        Caption = 'Vendor', comment = 'ESP="Proveedor"';
    }

    value(27; Producto)
    {
        Caption = 'Item', comment = 'ESP="Producto"';
    }

    value(32; "Movimientos de producto")
    {
        Caption = 'Item Ledger Entry', comment = 'ESP="Movimientos de productos"';
    }

    value(111; "Lín. Albarán venta")
    {
        Caption = 'Sales Shipment Line', comment = 'ESP="Lín. Albarán venta"';
    }

    value(121; "Lín. Albarán compra")
    {
        Caption = 'Purch. Rcpt. Line', comment = 'ESP="Lín. Albarán compra"';
    }

    value(5200; "Empleado")
    {
        Caption = 'Employee', comment = 'ESP="Empleado"';
    }

    value(5405; "Orden de producción")
    {
        Caption = 'Production Order', comment = 'ESP="Orden de producción"';
    }

    value(5407; "Componente orden de producción")
    {
        Caption = 'Prod. Order component', comment = 'ESP="Componente orden de producción"';
    }


}