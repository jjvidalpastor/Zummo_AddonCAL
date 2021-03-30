tableextension 65106 "TabExtRetRcptLin_CAL_btc" extends "Return Receipt Line"
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
    }
}
