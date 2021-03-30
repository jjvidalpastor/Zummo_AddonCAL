pageextension 65118 "PagExtCustCard_CAL_btc" extends "Customer Card"
{
    layout
    {
        addafter(PriceAndLineDisc)
        {
            group("Gestión de Calidad")
            {
                field(ActivarGestDeCalidadAGR_BTC; ActivarGestDeCalidadAGR_BTC)
                {
                    ApplicationArea = All;
                }
                field(CodPlantillaReclamaAGR_BTC; CodPlantillaReclamaAGR_BTC)
                {
                    ApplicationArea = All;
                }
                field(InspeccionCalidadAGR_BTC; InspeccionCalidadAGR_BTC)
                {
                    ApplicationArea = All;
                }
                field(NoConformidadAGR_BTC; NoConformidadAGR_BTC)
                {
                    ApplicationArea = All;
                }
                field(FechaUltimaReclamacionAGR_BTC; FechaUltimaReclamacionAGR_BTC)
                {
                    ApplicationArea = All;
                }
                field(EstadoHomologacionAGR_BTC; EstadoHomologacionAGR_BTC)
                {
                    ApplicationArea = All;
                }
                field(EstadoHomologadoAGR_BTC; EstadoHomologadoAGR_BTC)
                {
                    ApplicationArea = All;
                }
                field(FechaHomologacionAGR_BTC; FechaHomologacionAGR_BTC)
                {
                    ApplicationArea = All;
                }
                field(FechaUltimaEvaluAGR_BTC; FechaUltimaEvaluAGR_BTC)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
