pageextension 65127 "PagExtStandardTask_CAL_btc" extends "Standard Tasks"
{
    layout
    {
        addafter(Code)
        {
            field(ActivarGestionCalidadCAL_BTC; ActivarGestionCalidadCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(CodPlantillaProcesosCAL_BTC; CodPlantillaProcesosCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
