tableextension 65109 "TabExtVendor_CAL_btc" extends Vendor
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
        field(65004; EstadoHomologacAGR_BTC; Option)
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
        field(65006; ResultadoUltEvaAGR_BTC; Decimal)
        {
            Caption = 'Resultado ultima evaluacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65007; FechaUltEvaluAGR_BTC; Date)
        {
            Caption = 'Fecha ultima evaluacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65100; ActivarGestCalidadAGR_BTC; Boolean)
        {
            Caption = 'Activar gestion de la calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65101; CodPlanEvoAGR_BTC; Code[20])
        {
            Caption = 'Cod. plantilla evaluacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
            //TableRelation = "Plantilla de inseval_CAL_btc" WHERE ("Origen inspección" = CONST ("Evaluación"));
            //TODO: Revisar relación plantilla envaluación proveedor
        }
        field(65102; "FechaHomologaciónAGR_BTC"; Date)
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
            Editable = false;
        }
        field(65110; CertifISO9001AGR_BTC; Boolean)
        {
            Caption = 'Certificado ISO 9001';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65111; CertificadoBRCAGR_BTC; Boolean)
        {
            Caption = 'Certificado BRC';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65112; CertificadoIFSAGR_BTC; Boolean)
        {
            Caption = 'Certificado IFS';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65113; CertificadoISO22000AGR_BTC; Boolean)
        {
            Caption = 'Certificado ISO 22000';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65114; CertificadoGMPAGR_BTC; Boolean)
        {
            Caption = 'Certificado GMP';
            DataClassification = ToBeClassified;
            Description = 'CAL1.0';
        }
        field(65115; FechaCaducidadGMPAGR_BTC; Date)
        {
            Caption = 'Fecha caducidad GMP';
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
