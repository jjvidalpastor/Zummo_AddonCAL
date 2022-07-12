tableextension 65119 "Return Shipment Header" extends "Return Shipment Header"
{
    fields
    {
        field(65100; "Is Completly Invoiced"; Boolean)
        {
            Caption = 'Is Completly Invoiced', Comment = 'ES==Completamente facturado';
            FieldClass = FlowField;
            CalcFormula = - exist("Return Shipment Line" where("Document No." = field("No."), "Return Qty. Shipped Not Invd." = filter(<> 0)));
        }
    }
}
