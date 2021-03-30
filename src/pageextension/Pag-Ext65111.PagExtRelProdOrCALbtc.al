pageextension 65111 "PagExtRelProdOr_CAL_btc" extends "Released Production Order"
{
    layout
    {
        addafter(General)
        {
            group(Calidad)
            {
                Caption = 'Calidad Avanzada';

                field("No.RelatedOrderCAL_BTC"; "No.RelatedOrderCAL_BTC")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(DescriptionRelatedOrderCAL_BTC; DescriptionRelatedOrderCAL_BTC)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PrioridadCAL_BTC; PrioridadCAL_BTC)
                {
                    ApplicationArea = All;
                }
                field(NoLoteCAL_BTC; NoLoteCAL_BTC)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Nº Inspección"; NumInspCAL_BTC)
                {
                    Caption = 'Nº Inspección';
                    ApplicationArea = All;
                    Editable = false;
                    //TODO: Revisar esta relación
                    //TableRelation = "Cab inspe eval_CAL_btc"."No." WHERE ("Origen inspección" = CONST ("Fabricación"));
                }
                field("Estado Inspección"; EstadoInspeccionCAL_BTC)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("SubEstado Inspección"; SubEstadoInspeccionCAL_BTC)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Control Visual"; ControlVisualCAL_BTC)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var
        EstadoInspeccionCAL_BTC: Option Abierta,Lanzada,Certificada,Terminada;
        ControlVisualCAL_BTC: Option " ",Bueno,Promedio,Bloquear,Bloqueado;
        EstadoRevisionVisualCAL_BTC: Option Pendiente,Visado,Revisado,"No Obligatorio";
        NumInspCAL_BTC: Code[20];
        SubEstadoInspeccionCAL_BTC: Option Pendiente,Cuarentena,Aprobado,Recontrolado,Rechazado;
}
