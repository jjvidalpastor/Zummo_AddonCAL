tableextension 65118 "STH_Purchase_Header_Ext" extends "Purchase Header"
{
    fields
    {
        field(65100; No_inspection; Code[20])
        {
            Caption = 'No. inspection', Comment = 'ESP="Núm. Inspección"';
            TableRelation = "Cab no conformidad_CAL_btc"."No. inspección";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(65101; No_no_conformidad; Code[20])
        {
            Caption = 'No. not conformity', Comment = 'ESP="No. No conformidad"';
            TableRelation = "Cab no conformidad_CAL_btc"."No. no conformidad";
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(65102; "Pdte recibir/enviar"; Boolean)
        {
            Caption = 'Pdte recibir/enviar', comment = 'ESP="Pdte recibir/enviar"';
            FieldClass = FlowField;
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Outstanding Quantity" = filter(> 0)));
            Editable = false;
        }
        field(65103; ReturnOrderReposicion; Code[20])
        {
            Caption = 'Dev. Compra reposición', Comment = 'ESP="Dev. Compra reposición"';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purchase Header"."No." where("Document Type" = const("Return Order"), "No." = field(ReturnOrderReposicion));
        }
        field(65104; PurchOrderReposicion; Code[20])
        {
            Caption = 'Ped. Compra reposición', Comment = 'ESP="Ped. Compra reposición"';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order), "No." = field(PurchOrderReposicion));
        }
    }

    procedure CrearReposicionDevCompra()
    var
        Functions: Codeunit "Calidad Mgt_CAL_BTC";
    begin
        Functions.CrearReposicionDevCompra(Rec);
    end;
}

























