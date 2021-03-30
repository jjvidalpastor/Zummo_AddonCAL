tableextension 65115 "PurchInvLine" extends "Purch. Inv. Line" //123
{
    fields
    {
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
