pageextension 65131 "PurchaseReturnOrder" extends "Purchase Return Order" //6640
{

    actions
    {
        addafter(GetPostedDocumentLinesToReverse)
        {
            action(RevertirNoConformidad)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = ReturnCustomerBill;
                Caption = 'Reverse lines Nonconformity', comment = 'ESP="Revertir líneas No conformidad"';
                ToolTip = 'It allows to revert Nonconformity lines', comment = 'ESP="Permite revertir líneas de No conformidades"';

                trigger OnAction()
                var
                    recCabNoConformidad: Record "Cab no conformidad_CAL_btc";
                    pageListaNoConformidad: Page SelecNoConformidad;
                    cduRevertConf: Codeunit RevertirNoConformidades;
                begin
                    recCabNoConformidad.Reset();
                    Clear(pageListaNoConformidad);
                    pageListaNoConformidad.LookupMode(true);
                    pageListaNoConformidad.SetData("Buy-from Vendor No.", 0);
                    if pageListaNoConformidad.RunModal() = Action::LookupOK then begin
                        //pageListaNoConformidad.GetRecord(recCabNoConformidad);
                        pageListaNoConformidad.SetSelectionFilter(recCabNoConformidad);
                        clear(cduRevertConf);
                        cduRevertConf.RevertirNoConformidadDevCompras(Rec, recCabNoConformidad);
                    end
                    else
                        exit;
                end;
            }
            action(CrearReposicion)
            {
                ApplicationArea = all;
                Caption = 'Crear Reposición', comment = 'ESP="Crear Reposición"';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CrearReposicionDevCompra();
                end;

            }
        }
    }
}
