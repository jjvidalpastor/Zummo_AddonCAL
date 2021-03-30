pageextension 65102 "PagExtItemLdgEn_CAL_btc" extends "Item Ledger Entries"
{
    layout
    {
    }
    actions
    {
        addafter("&Navigate")
        {
            group(Calidad)
            {
                Visible = false;

                action("Inspecciones de calidad")
                {
                    Image = TaskQualityMeasure;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    RunObject = Page "Inspecciones de Calida_CAL_BTC";
                    //FJAB 311019 Cambio origen
                    //RunPageLink = "Origen inspección" = CONST("Almacén"),
                    /*RunPageLink = "Origen inspección" = CONST("Item Ledger entry"),
                                            "No. producto" = FIELD("Item No."),
                                            "Cód. variante" = FIELD("Variant Code"),
                                            "No. lote inspeccionado" = FIELD("Lot No."),
                                            "No. serie inspeccionado" = FIELD("Serial No.");*/
                    ApplicationArea = All;
                }
                action("No conformidad")
                {
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    RunObject = Page "No Conformidades_CAL_BTC";
                    //FJAB 311019 Cambio origen
                    //RunPageLink = "Origen inspección" = CONST("Almacén"),
                    /*RunPageLink = "Origen inspección" = CONST("Item Ledger entry"),
                                            "No. producto" = FIELD("Item No."),
                                            "Cód. variante" = FIELD("Variant Code"),
                                            "No. lote inspeccionado" = FIELD("Lot No."),
                                            "No. serie inspeccionado" = FIELD("Serial No.");*/
                    ApplicationArea = All;
                }
                action("Crear inspección de calidad")
                {
                    Image = CopyFromTask;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    var
                        funcCalidad: Codeunit "Calidad Mgt_CAL_BTC";
                    begin
                        funcCalidad.CrearInspeccionMovProducto(Rec);
                    end;
                }
            }
        }
    }
}
