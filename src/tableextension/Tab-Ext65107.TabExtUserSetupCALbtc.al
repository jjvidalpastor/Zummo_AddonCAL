tableextension 65107 "TabExtUserSetup_CAL_btc" extends "User Setup"
{
    fields
    {
        field(65100; SupervisorDCCalidadCAL_BTC; Boolean)
        {
            Caption = 'Supervisor DC Calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
        }
        field(65101; SupervisorDCFabricacionCAL_BTC; Boolean)
        {
            Caption = 'Supervisor DC Fabricación';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
        }
        field(65102; SupervisorDCFormulacionCAL_BTC; Boolean)
        {
            Caption = 'Supervisor DC Formulación';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
        }
        field(65103; SupervisorDCControlVisuCAL_BTC; Boolean)
        {
            Caption = 'Supervisor DC Control Visual';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
        }
        field(65104; NuevaCaducidadLoteCAL_BTC; Boolean)
        {
            Caption = 'Nueva caducidad lote';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
        }
        field(65105; RetrocedeCertificacionCAL_BTC; Boolean)
        {
            Caption = 'Retrocede Certificacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
        }
    }
}
