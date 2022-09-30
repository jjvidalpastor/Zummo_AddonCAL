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

            trigger OnLookup()
            var
                Cabinspeeval_CAL_btc: record "Cab inspe eval_CAL_btc";
                InspeccionesdeCalida_CAL_btc: page "Inspecciones de Calida_CAL_btc";
            begin
                Cabinspeeval_CAL_btc.SetRange("No.", NumInspeccion_btc);
                InspeccionesdeCalida_CAL_btc.SetTableView(Cabinspeeval_CAL_btc);
                InspeccionesdeCalida_CAL_btc.RunModal();
            end;
        }
        field(65103; NumNoConformidad_btc; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'No. Nonconformity', comment = 'ESP="Nº No conformidad"';

            trigger OnLookup()
            var
                Cabnoconformidad_CAL_btc: record "Cab no conformidad_CAL_btc";
                NoConformidades_CAL_btc: page "No Conformidades_CAL_btc";
            begin
                Cabnoconformidad_CAL_btc.SetRange("No. no conformidad", NumNoConformidad_btc);
                NoConformidades_CAL_btc.SetTableView(Cabnoconformidad_CAL_btc);
                NoConformidades_CAL_btc.RunModal();
            end;
        }
    }
}
