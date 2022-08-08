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
        field(65211; "No. no conformidad"; Code[20])
        {
            Caption = 'No. no conformidad';
            Editable = false;
            TableRelation = "Cab no conformidad_CAL_btc" where("No. no conformidad" = field("No. no conformidad"));
        }
        field(65250; "Default Vendor No."; code[20])
        {
            Caption = 'Default Vendor No.', comment = 'ESP="Cód. proveedor defecto"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Vendor No." where("No." = field("Item No.")));
        }
        field(65251; "Default Vendor Name"; text[100])
        {
            Caption = 'Default Vendor Name', comment = 'ESP="Nombre proveedor defecto"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Default Vendor No.")));
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
