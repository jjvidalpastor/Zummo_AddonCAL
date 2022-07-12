pageextension 65101 "Purchase Agent Activities" extends "Purchase Agent Activities"
{
    layout
    {
        addlast(Content)
        {
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
                field(HistAbonoCompra; HistAbonoCompra)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Posted Purchase Credit Memos";
                }
            }
        }
    }
}
