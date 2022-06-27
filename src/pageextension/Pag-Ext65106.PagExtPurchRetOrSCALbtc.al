pageextension 65106 "PagExtPurchRetOrS_CAL_btc" extends "Purchase Return Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field(NumInspeccion_btc; NumInspeccion_btc)
            {
                ApplicationArea = all;
            }
            field(NumNoConformidad_btc; NumNoConformidad_btc)
            {
                ApplicationArea = all;
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
                    // RunObject = Page "Inspecciones de Calida_CAL_btc";
                    ApplicationArea = All;
                    Visible = false;

                    //TODO: Revisar qué tipo de origen tiene que ser
                    /*
                              RunPageLink = "Origen inspección" = CONST ("Devolución"),
                                            "No. pedido proveedor" = FIELD ("Document No."),
                                            "No. línea pedido proveedor" = FIELD ("Line No.");
                              */
                    trigger OnAction()
                    var
                        CabInspeccióndeCalidad: record "Cab inspe eval_CAL_btc";
                        InspeccionesCal: page "Inspecciones de Calida_CAL_btc";
                    begin
                        CabInspeccióndeCalidad.SetRange("No. proveedor", Rec."Buy-from Vendor No.");
                        InspeccionesCal.SetTableView(CabInspeccióndeCalidad);
                        InspeccionesCal.LookupMode := true;
                        if InspeccionesCal.RunModal() = Action::LookupOK then begin
                            // añadimos la linea de y ponemos los datos de la inspección o no conformidad
                        end;

                    end;
                }
                action("No conformidad")
                {
                    Caption = 'Traer No Conformidad', comment = 'ESP="Traer No Conformidad"';
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    //RunObject = Page "No Conformidades_CAL_btc";
                    ApplicationArea = All;


                    trigger OnAction()
                    begin
                        TraerNoConformidad();
                    end;
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
                        funcCalidad.CrearInspeccionLinPedidoCompra(Rec);
                    end;
                }

            }
        }
    }

    var
        PurchaseHeader: Record "Purchase Header";
        FuntionsCal: Codeunit "Cab Inspec Status Mgt_CAL_btc";


    local procedure TraerNoConformidad()
    var
        CabNoconformidad: record "Cab no conformidad_CAL_btc";
        NoconformidadCal: page "No Conformidades_CAL_btc";
    begin
        PurchaseHeader.get(Rec."Document Type", Rec."Document No.");
        CabNoconformidad.SetRange("No. proveedor", PurchaseHeader."Buy-from Vendor No.");
        NoconformidadCal.SetTableView(CabNoconformidad);
        NoconformidadCal.LookupMode := true;
        if NoconformidadCal.RunModal() = Action::LookupOK then begin
            // añadimos la linea de y ponemos los datos de la inspección o no conformidad
            NoconformidadCal.GetRecord(CabNoconformidad);

            PurchaseHeader.No_no_conformidad := CabNoconformidad."No. no conformidad";
            PurchaseHeader.No_inspection := CabNoconformidad."No. inspección";
            PurchaseHeader."Location Code" := CabNoconformidad."Cód. almacén destino";
            PurchaseHeader.Modify();

            CabNoconformidad."Purch. Return Order" := PurchaseHeader."No.";
            CabNoconformidad."Accion inmediata realizada" := true;
            CabNoconformidad."Fecha acción inmediata" := WorkDate();
            CabNoconformidad.Modify();

            FuntionsCal.CrearReturnOrderLine(CabNoconformidad, PurchaseHeader);
        end;
    end;

}
