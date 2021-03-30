tableextension 65103 "TabExtItemLdgrEntry_CAL_btc" extends "Item Ledger Entry"
{
    fields
    {
        field(65100; InspeccionCalidadCAL_BTC; Boolean)
        {
            Caption = 'Inspeccion de calidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
        }
        field(65101; NoConformidadCAL_BTC; Boolean)
        {
            Caption = 'No conformidad';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
        }
        field(65200; UsuarioRegistroCAL_BTC; Code[50])
        {
            Caption = 'Usuario creacion';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(65201; DatetimeRegistroCAL_BTC; DateTime)
        {
            Caption = 'Datetime registro';
            DataClassification = ToBeClassified;
            Description = 'CAL1.00';
            Editable = false;
        }
    }
    /*
        keys
        {
            key(Key1; "Item No.", "Variant Code", "Location Code", "Lot No.", "Serial No.", "Posting Date")
            {
            }
        }
        */
}
