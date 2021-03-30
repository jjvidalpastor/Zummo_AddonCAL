tableextension 65105 "TabExtPurchLine_CAL_btc" extends "Purchase Line"
{
    fields
    {
        field(65100; InspeccionDeCalidadCAL_BTC; Boolean)
        {
            Caption = 'Inspeccion de calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = true;
        }
        field(65101; NoConformidadCAL_BTC; Boolean)
        {
            Caption = 'No conformidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = true;
        }
        field(65102; NumInspeccion_btc; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'No. inspection quality', comment = 'ESP="Nº inspección calidad"';
        }
        field(65103; NumNoConformidad_btc; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'No. Nonconformity', comment = 'ESP="Nº No conformidad"';
        }
    }
}
