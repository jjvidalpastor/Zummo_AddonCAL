enum 65101 "TiposCodigosEspecificos"
{
    Extensible = true;

    value(0; Ninguno)
    {
        Caption = ' ', comment = 'ESP=" "';
    }

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

    value(5200; Empleado)
    {
        Caption = 'Employee', comment = 'ESP="Empleado"';
    }
}