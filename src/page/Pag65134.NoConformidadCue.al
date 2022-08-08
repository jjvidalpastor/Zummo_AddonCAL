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

                    trigger OnDrillDown()
                    var
                        ItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        ConfCal.get();
                        ItemLedgerEntry.FilterGroup := 2;
                        ItemLedgerEntry.SetFilter("Location Code", ConfCal."Cód. almacén no conformes");
                        ItemLedgerEntry.SetRange(Open, true);
                        ItemLedgerEntry.FilterGroup := 0;
                        page.run(65135, ItemLedgerEntry);
                    end;
                }
                field("AddonProduccion"; 0)
                {
                    Caption = 'AddonProduccion';

                    trigger OnDrillDown()
                    begin
                        page.run(50405);
                    end;
                }
            }
        }
    }

    var
        ConfCal: Record "Setup Calidad_CAL_btc";

    trigger OnOpenPage()

    begin
        RESET();
        if not get() then begin
            INIT();
            INSERT();
        end;
        ConfCal.get();
        FilterGroup(2);
        SetFilter(filtroAlmacenInspe, '=%1', ConfCal.AlmacenInpeccion);
        SetFilter(filtroAlmacenNoConf, '=%1', ConfCal."Cód. almacén no conformes");
        FilterGroup(0);
    end;
}
