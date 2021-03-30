tableextension 65108 "TabExtStandardTask_CAL_btc" extends "Standard Task"
{
    fields
    {
        field(65100; ActivarGestionCalidadCAL_BTC; Boolean)
        {
            Caption = 'Activar gestion de la calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
        }
        field(65101; CodPlantillaProcesosCAL_BTC; Code[20])
        {
            Caption = 'Cod. plantilla procesos';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST (Procesos));
            //TODO: Revisar relación plantilla envaluación procesos
        }
    }
}
