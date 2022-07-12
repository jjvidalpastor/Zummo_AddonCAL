tableextension 65120 "Purchase Cue" extends "Purchase Cue"
{
    fields
    {

        field(65100; DevolCompra; Integer)
        {
            Caption = 'Purchase Return Order', Comment = 'ESP="Devoluciones de compra"';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER("Return Order"), "Completely Received" = const(false)));
        }
        field(65101; HistEnvioDevolCompra; Integer)
        {
            Caption = 'Pending Posted Return Shipment', Comment = 'ESP="Hist. envío Devolución de compra pdtes."';
            FieldClass = FlowField;
            CalcFormula = Count("Return Shipment Header" where("Is Completly Invoiced" = const(false)));
        }
        field(65102; HistAbonoCompra; Integer)
        {
            Caption = 'Posted CR Memo Invoice', Comment = 'ESP="Hist. Abono de compra"';
            FieldClass = FlowField;
            CalcFormula = Count("Purch. Cr. Memo Hdr.");
        }
    }
}