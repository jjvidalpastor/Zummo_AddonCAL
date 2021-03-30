page 65119 "SelecNoConformidad"
{
    PageType = List;
    SourceTable = "Cab no conformidad_CAL_btc";
    Caption = 'Nonconformity list', comment = 'ESP="Lista no conformidad"';
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Origen inspección"; "Origen inspección")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. no conformidad"; "No. no conformidad")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Nº doc. Origen calidad"; "Nº doc. Origen calidad")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Nº lín. doc. Origen calidad"; "Nº lín. doc. Origen calidad")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cód. plantilla"; "Cód. plantilla")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Fecha recepción"; "Fecha recepción")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. producto"; "No. producto")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Descripción producto"; "Descripción producto")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cantidad Inspeccionada"; "Cantidad Inspeccionada")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unidad de medida"; "Unidad de medida")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cód. almacén"; "Cód. almacén")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Descripción almacén"; "Descripción almacén")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cód. ubicación"; "Cód. ubicación")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Descripción ubicación"; "Descripción ubicación")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. proveedor"; "No. proveedor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Descripción proveedor"; "Descripción proveedor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. pedido proveedor"; "No. pedido proveedor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. línea pedido proveedor"; "No. línea pedido proveedor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(VerNoConformidad)
            {
                ApplicationArea = All;
                Caption = 'See Nonconformity', comment = 'ESP="Ver No Conformidad"';
                ToolTip = 'Navigate to the Nonconformity card', comment = 'ESP="Navega hasta la ficha de No Conformidad"';
                Image = View;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page "No Conformidad_CAL_btc";
                RunPageOnRec = true;
            }
        }
    }
    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetRange("No. proveedor", globalProveedor);
        SetRange("Acción inmediata", globalEstado);
        FilterGroup(0);
    end;

    procedure SetData(pCodProveedor: code[20];
    pEstado: Integer)
    begin
        globalProveedor := pCodProveedor;
        globalEstado := pEstado;
    end;

    var
        globalProveedor: Code[20];
        globalEstado: Integer;
}
