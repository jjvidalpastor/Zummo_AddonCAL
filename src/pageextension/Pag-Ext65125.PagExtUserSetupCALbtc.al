pageextension 65125 "PagExtUserSetup_CAL_btc" extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field(SupervisorDCCalidadCAL_BTC; SupervisorDCCalidadCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(SupervisorDCFabricacionCAL_BTC; SupervisorDCFabricacionCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(SupervisorDCFormulacionCAL_BTC; SupervisorDCFormulacionCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(SupervisorDCControlVisuCAL_BTC; SupervisorDCControlVisuCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(NuevaCaducidadLoteCAL_BTC; NuevaCaducidadLoteCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(RetrocedeCertificacionCAL_BTC; RetrocedeCertificacionCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
