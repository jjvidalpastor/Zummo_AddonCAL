pageextension 65107 "STH Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter("Vendor Shipment No.")
        {
            field(ReturnOrderReposicion; ReturnOrderReposicion)
            {
                ApplicationArea = all;
            }
        }
    }
}
