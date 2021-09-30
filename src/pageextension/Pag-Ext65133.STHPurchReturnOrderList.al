pageextension 65133 "STH PurchReturnOrderList" extends "Purchase Return Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("Pendiente recibir/enviar"; "Pdte recibir/enviar")
            {
                ApplicationArea = all;
            }
        }
    }
}