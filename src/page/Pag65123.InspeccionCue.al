page 65123 "InspeccionCue"
{
    PageType = CardPart;
    SourceTable = "Calidad Cue";
    Caption = 'Activities', Comment = 'ESP="Actividad inspección calidad"';
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup(Clientes)
            {
                Visible = false;

                field(ClienteOpen; ClienteOpen)
                {
                    ApplicationArea = All;
                }
                field(ClienteLanzada; ClienteLanzada)
                {
                    ApplicationArea = All;
                }
                field(ClienteCertificada; ClienteCertificada)
                {
                    ApplicationArea = All;
                }
                field(ClienteTerminada; ClienteTerminada)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup(Provedor)
            {
                Visible = false;

                field(ProveedorOpen; ProveedorOpen)
                {
                    ApplicationArea = All;
                }
                field(ProveedorLanzada; ProveedorLanzada)
                {
                    ApplicationArea = All;
                }
                field(ProveedorCertificada; ProveedorCertificada)
                {
                    ApplicationArea = All;
                }
                field(ProveedorTerminada; ProveedorTerminada)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Movimiento producto")
            {
                Caption = 'Item Ledger Entry Inspection', Comment = 'ESP="Movimiento Producto Inspección"';

                field(ItemLedgerEntryOpen; ItemLedgerEntryOpen)
                {
                    ApplicationArea = All;
                }
                field(ItemLedgerEntryLanzada; ItemLedgerEntryLanzada)
                {
                    ApplicationArea = All;
                }
                field(ItemLedgerEntryCertificada; ItemLedgerEntryCertificada)
                {
                    ApplicationArea = All;
                }
                field(ItemLedgerEntryTerminada; ItemLedgerEntryTerminada)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Lín. Albarán venta")
            {
                Visible = false;

                field(LinAlbVtaOpen; LinAlbVtaOpen)
                {
                    ApplicationArea = All;
                }
                field(LinAlbVtaLanzada; LinAlbVtaLanzada)
                {
                    ApplicationArea = All;
                }
                field(LinAlbVtaCertificada; LinAlbVtaCertificada)
                {
                    ApplicationArea = All;
                }
                field(LinAlbVtaTerminada; LinAlbVtaTerminada)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Lín. Albarán compra")
            {
                Caption = 'Purch. Rcpt. Line Inspection', Comment = 'ESP="Lín. Albarán Compra Inspección"';

                field(LinAlbCompraOpen; LinAlbCompraOpen)
                {
                    ApplicationArea = All;
                }
                field(LinAlbCompraLanzada; LinAlbCompraLanzada)
                {
                    ApplicationArea = All;
                }
                field(LinAlbCompraCertificada; LinAlbCompraCertificada)
                {
                    ApplicationArea = All;
                }
                field(LinAlbCompraTerminada; LinAlbCompraTerminada)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup(Producto)
            {
                // Visible = false;

                field(ProductoOpen; ProductoOpen)
                {
                    ApplicationArea = All;
                }
                field(ProductoLanzada; ProductoLanzada)
                {
                    ApplicationArea = All;
                }
                field(ProductoCertificada; ProductoCertificada)
                {
                    ApplicationArea = All;
                }
                field(ProductoTerminada; ProductoTerminada)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Devoluciones Proveedor")
            {
                Caption = 'Devoluciones proveedor', comment = 'ESP="Devoluciones proveedor"';
                field(DevolCompra; DevolCompra)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Purchase Return Order List";
                }
                field(HistEnvioDevolCompra; HistEnvioDevolCompra)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Posted Return Shipments";
                }
            }
            cuegroup(Empleado)
            {
                Visible = false;

                field(EmpleadoOpen; EmpleadoOpen)
                {
                    ApplicationArea = All;
                }
                field(EmpleadoLanzada; EmpleadoLanzada)
                {
                    ApplicationArea = All;
                }
                field(EmpleadoCertificada; EmpleadoCertificada)
                {
                    ApplicationArea = All;
                }
                field(EmpleadoTerminada; EmpleadoTerminada)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Orden de producción")
            {
                Visible = false;

                field(OrdenProduccionOpen; OrdenProduccionOpen)
                {
                    ApplicationArea = All;
                }
                field(OrdenProduccionLanzada; OrdenProduccionLanzada)
                {
                    ApplicationArea = All;
                }
                field(OrdenProduccionCertificada; OrdenProduccionCertificada)
                {
                    ApplicationArea = All;
                }
                field(OrdenProduccionTerminada; OrdenProduccionTerminada)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Comp. Orden de producción")
            {
                Visible = false;

                field(CompOrdenProduccionOpen; CompOrdenProduccionOpen)
                {
                    ApplicationArea = All;
                }
                field(CompOrdenProduccionLanzada; CompOrdenProduccionLanzada)
                {
                    ApplicationArea = All;
                }
                field(CompOrdenProduccionCertificada; CompOrdenProduccionCertificada)
                {
                    ApplicationArea = All;
                }
                field(CompOrdenProduccionTerminada; CompOrdenProduccionTerminada)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        RESET();
        if not get() then begin
            INIT();
            INSERT();
        end;
    end;
}
