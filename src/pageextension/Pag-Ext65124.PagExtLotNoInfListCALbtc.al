pageextension 65124 "PagExtLotNoInfList_CAL_btc" extends "Lot No. Information List"
{
    layout
    {
        modify("Test Quality")
        {
            Visible = false;
        }
        addafter("Test Quality")
        {
            field(TestQualityCAL_BTC; TestQualityCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
        addafter("Expired Inventory")
        {
            field(ControlVisualObligCAL_BTC; ControlVisualObligCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(EstadoRevisionVisualCAL_BTC; EstadoRevisionVisualCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(VisadoXUsuarioCAL_BTC; VisadoXUsuarioCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(FechaVisadoCAL_BTC; FechaVisadoCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(RevisadoXusuarioCAL_BTC; RevisadoXusuarioCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(FechaRevisadoCAL_BTC; FechaRevisadoCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(InspeccionDeCalidadCAL_BTC; InspeccionDeCalidadCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(NoConformidadCAL_BTC; NoConformidadCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(FechaFabricacionCAL_BTC; FechaFabricacionCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(FechaCaducidadCAL_BTC; FechaCaducidadCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(FechaRecepcionCAL_BTC; FechaRecepcionCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(EstadoControlCalidadCAL_BTC; EstadoControlCalidadCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(ProcedenciaCreacionCAL_BTC; ProcedenciaCreacionCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(ProdOrderNoCAL_BTC; ProdOrderNoCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(PrioridadCAL_BTC; PrioridadCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
