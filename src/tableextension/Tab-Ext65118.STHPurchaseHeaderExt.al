tableextension 65118 "STH_Purchase_Header_Ext" extends "Purchase Header"
{
    fields
    {
        field(65100; No_inspection; Code[20])
        {
            Caption = 'No. inspection', Comment = 'ESP="Núm. Inspección"';
            TableRelation = "Cab no conformidad_CAL_btc"."No. inspección";
            DataClassification = CustomerContent;

        }
        field(65101; No_no_conformidad; Code[20])
        {
            Caption = 'No. not conformity', Comment = 'ESP="No. No conformidad"';
            TableRelation = "Cab no conformidad_CAL_btc"."No. no conformidad";
            DataClassification = CustomerContent;
        }

        field(65102; "Pdte recibir/enviar"; Boolean)
        {
            Caption = 'Pdte recibir/enviar', comment = 'ESP="Pdte recibir/enviar"';
            FieldClass = FlowField;
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Outstanding Quantity" = filter(> 0)));
        }
    }
}

























