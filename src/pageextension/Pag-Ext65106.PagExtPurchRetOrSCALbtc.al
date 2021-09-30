pageextension 65106 "PagExtPurchRetOrS_CAL_btc" extends "Purchase Return Order Subform"
{
    layout
    {
        addafter("Bin Code")
        {
            field(InspeccionDeCalidadCAL_BTC; InspeccionDeCalidadCAL_BTC)
            {
                ApplicationArea = All;
            }
            field(NoConformidadCAL_BTC; NoConformidadCAL_BTC)
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Line")
        {
            group(Calidad)
            {
                action("Inspecciones de calidad")
                {
                    Image = TaskQualityMeasure;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Inspecciones de Calida_CAL_btc";
                    ApplicationArea = All;

                    //TODO: Revisar qué tipo de origen tiene que ser
                    /*
                              RunPageLink = "Origen inspección" = CONST ("Devolución"),
                                            "No. pedido proveedor" = FIELD ("Document No."),
                                            "No. línea pedido proveedor" = FIELD ("Line No.");
                              */
                    trigger OnAction()
                    begin
                        if InspeccionDeCalidadCAL_BTC = false then Error('Atención: Inspección de Calidad no creada');
                    end;
                }
                action("No conformidad")
                {
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "No Conformidades_CAL_btc";
                    ApplicationArea = All;

                    //TODO: Revisar qué tipo de origen tiene que ser
                    /*
                              RunPageLink = "Origen inspección" = CONST ("Devolución"),
                                            "No. pedido proveedor" = FIELD ("Document No."),
                                            "No. línea pedido proveedor" = FIELD ("Line No.");
                              */
                    trigger OnAction()
                    begin
                        if NoConformidadCAL_BTC = false then Error('Atención: No conformidad no creada');
                    end;
                }
                action("Crear inspección de calidad")
                {
                    Image = CopyFromTask;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        funcCalidad: Codeunit "Calidad Mgt_CAL_BTC";
                    begin
                        funcCalidad.CrearInspeccionLinPedidoCompra(Rec);
                    end;
                }
                action(CrearReposicion)
                {
                    ApplicationArea = all;
                    Caption = 'Reposición Líneas', comment = 'ESP="Reposición Líneas"';
                    Image = ReturnReceipt;

                    trigger OnAction()
                    begin
                        CrearReposicion();
                    end;
                }
            }
        }
    }

    var
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        lblMsg: Label 'Se va a realizar la/s linea/s de reposición. \¿Desea continuar?', comment = 'Se va a realizar la/s linea/s de reposición. \¿Desea continuar?';

    local procedure CrearReposicion()
    Var
        Linea: Integer;
    begin
        if not Confirm(lblMsg, false) then
            exit;
        PurchLine2.Reset();
        PurchLine2.SetRange("Document Type", Rec."Document Type");
        PurchLine2.SetRange("Document No.", Rec."Document No.");
        if PurchLine2.FindLast() then
            Linea := PurchLine2."Line No." + 10000
        else
            Linea := 10000;

        CurrPage.SetSelectionFilter(PurchLine);
        if PurchLine.findset() then
            repeat
                PurchLine2.Init();
                PurchLine2.TransferFields(PurchLine);
                PurchLine2."Line No." := Linea;
                PurchLine2.Validate(Quantity, -PurchLine.Quantity);
                PurchLine2.Insert();
                Linea += 10000;
            Until PurchLine.next() = 0;
    end;
}
