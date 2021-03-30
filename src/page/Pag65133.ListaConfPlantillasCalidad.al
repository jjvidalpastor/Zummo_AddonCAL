page 65133 "Lista_Conf_Plantillas_Calidad"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Conf_Plantillas_Calidad;
    Caption = 'Quality Templates Setup', comment = 'ESP="Configuración Plantillas Calidad"';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Origen inspección"; "Origen inspección")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetEditableCodEspecifico();
                    end;
                }
                field(CodEspecifico; CodEspecifico)
                {
                    ApplicationArea = All;
                    Enabled = editableCodEspecifico;
                    Visible = false;
                }
                field(OrigenInspeccionNivel2; OrigenInspeccionNivel2)
                {
                    ApplicationArea = All;
                    Enabled = enabledNivel2;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        SetEditableCodEspecifico();
                    end;
                }
                field(CodEspecificoNivel2; CodEspecificoNivel2)
                {
                    ApplicationArea = All;
                    Enabled = enabledNivel2;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        SetEditableCodEspecifico();
                    end;
                }
                field(OrigenInspeccionNivel3; OrigenInspeccionNivel3)
                {
                    ApplicationArea = All;
                    Enabled = enabledNivel3;
                    Visible = false;
                }
                field(CodEspecificoNivel3; CodEspecificoNivel3)
                {
                    ApplicationArea = All;
                    Enabled = enabledNivel3;
                    Visible = false;
                }
                field(CodPlantillaInspeccion; CodPlantillaInspeccion)
                {
                    ApplicationArea = All;
                }
                field("No. revisión"; "No. revisión")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetEditableCodEspecifico();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetEditableCodEspecifico();
    end;

    local procedure SetEditableCodEspecifico()
    begin
        if "Origen inspección" in ["Origen inspección"::Cliente, "Origen inspección"::Empleado, "Origen inspección"::Producto, "Origen inspección"::Proveedor] then begin
            editableCodEspecifico := true;
            enabledNivel2 := false;
            enabledNivel3 := false;
        end
        else begin
            editableCodEspecifico := false;
            enabledNivel2 := true;
            if CodEspecificoNivel2 <> '' then
                enabledNivel3 := true
            else
                enabledNivel3 := false;
        end;
    end;

    var
        editableCodEspecifico: Boolean;
        enabledNivel2: Boolean;
        enabledNivel3: Boolean;
}
