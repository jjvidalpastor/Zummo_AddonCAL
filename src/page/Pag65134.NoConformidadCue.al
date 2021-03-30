page 65134 "NoConformidadCue"
{
    PageType = CardPart;
    SourceTable = "Calidad Cue";
    Caption = 'Activities non-conformity', Comment = 'ESP="Actividad inspección no conformidad"';
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup(NoConformidad)
            {
                Caption = 'Inpección No conformidad', Comment = 'ESP="Inpección No conformidad"';

                field(NoConformidadAbierto; NoConformidadAbierto)
                {
                    ApplicationArea = All;
                }
                field(NoConformidadLanzada; NoConformidadLanzada)
                {
                    ApplicationArea = All;
                }
                field(NoConformidadCertificada; NoConformidadCertificada)
                {
                    ApplicationArea = All;
                }
                field(NoConformidadTermi; NoConformidadTermi)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Mov. producto almacén inspección")
            {
                field(MovProdAlmInspeccion; MovProdAlmInspeccion)
                {
                    ApplicationArea = All;
                }
            }
            cuegroup("Mov. producto almacén No Conformidad")
            {
                field(MovProdAlmNoConf; MovProdAlmNoConf)
                {
                    ApplicationArea = All;
                }
                field("1"; MovProdAlmNoConf)
                {
                    Caption = 'AddonProduccion';

                    trigger OnDrillDown()
                    begin
                        page.run(50405)
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        ConfCal: Record "Setup Calidad_CAL_btc";
    begin
        RESET();
        if not get() then begin
            INIT();
            INSERT();
        end;
        ConfCal.get();
        FilterGroup(2);
        SetFilter(filtroAlmacenInspe, '=%1', ConfCal.AlmacenInpeccion);
        SetFilter(filtroAlmacenNoConf, '=%1', 'NOCONFORME'); //FSD No me gusta que este hardcodeado!
        FilterGroup(0);
    end;
}
