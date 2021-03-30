tableextension 65100 "TabExtCustomer_CAL_btc" extends Customer
{
    fields
    {
        field(65002; InspeccionCalidadAGR_BTC; Boolean)
        {
            Caption = 'Inspeccion evaluacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65003; NoConformidadAGR_BTC; Boolean)
        {
            Caption = 'No conformidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
        field(65004; EstadoHomologacionAGR_BTC; Option)
        {
            Caption = 'Estado homologacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            OptionMembers = " ","En evaluación","No homologado",Homologado,Inactivo;
        }
        field(65005; EstadoHomologadoAGR_BTC; Option)
        {
            Caption = 'Estado homologado';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            OptionMembers = " ","Evaluación superada","Certificado calidad","Proveedor único","Histórico";
        }
        field(65007; FechaUltimaEvaluAGR_BTC; Date)
        {
            Caption = 'Fecha ultima evaluacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65100; ActivarGestDeCalidadAGR_BTC; Boolean)
        {
            Caption = 'Activar gestion de la calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65101; CodPlantillaReclamaAGR_BTC; Code[20])
        {
            Caption = 'Cod. plantilla evaluacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Evaluación"));
            //TODO: Revisar relación plantilla envaluación cliente
        }
        field(65102; FechaHomologacionAGR_BTC; Date)
        {
            Caption = 'Fecha homologación';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65103; FechaUltimaReclamacionAGR_BTC; Date)
        {
            Caption = 'Fecha última reclamación';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65200; LastDateBlockedAGR_BTC; Date)
        {
            Caption = 'Last date blocked';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            Editable = false;
        }
    }
}
