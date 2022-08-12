page 65136 "datos Inspecion"
{
    Caption = 'Datos Inspecion';
    PageType = StandardDialog;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(VendorNo; VendorNo)
                {
                    ApplicationArea = all;
                    Caption = 'Cód. proveedor', comment = 'ESP="Cód. proveedor"';

                    TableRelation = Vendor."No.";

                    trigger OnValidate()
                    begin
                        UpdateVendor();
                    end;
                }
                field(VendorName; VendorName)
                {
                    ApplicationArea = all;
                    Caption = 'Nombre', comment = 'ESP="Nombre"';
                    Editable = false;
                }
            }
        }
    }

    var
        Vendor: record Vendor;
        VendorNo: code[20];
        VendorName: Text;


    procedure SetVendor(VendorCode: Code[20])
    begin
        VendorNo := VendorCode;
        UpdateVendor();
    end;

    procedure GetVendor(): code[20]
    begin
        exit(VendorNo);
    end;

    local procedure UpdateVendor()
    begin
        VendorName := '';
        if Vendor.get(VendorNo) then
            VendorName := Vendor.Name;
    end;
}
