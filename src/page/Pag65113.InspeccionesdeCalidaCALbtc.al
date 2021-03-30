page 65113 "Inspecciones de Calida_CAL_btc"
{
    Caption = 'Inspecciones de Calidad', Comment = 'ESP="Inspecciones de Calidad"';
    CardPageID = "Inspección de Calidad_CAL_btc";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cab inspe eval_CAL_btc";
    UsageCategory = Lists;
    //FJAB 311019 Clave cambiada
    //SourceTableView = SORTING ("Origen inspección", "No.") ORDER(Ascending);
    SourceTableView = SORTING("No.") ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Documento borrado"; esborrado)
                {
                    ApplicationArea = All;
                }
                field("Origen inspección"; "Origen inspección")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Nº doc. Origen calidad"; "Nº doc. Origen calidad")
                {
                    ApplicationArea = All;
                }
                field("Nº lín. doc. Origen calidad"; "Nº lín. doc. Origen calidad")
                {
                    ApplicationArea = All;
                }
                //END FJAB 311019
                field(NoDocLinOrigen_btc; NoDocLinOrigen_btc)
                {
                    ApplicationArea = All;
                }
                field("Estado inspección"; "Estado inspección")
                {
                    ApplicationArea = All;
                }
                field("SubEstado inspección"; "SubEstado inspección")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Tipo inspección"; "Tipo inspección")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Objeto inspección"; "Objeto inspección")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. producto"; "No. producto")
                {
                    ApplicationArea = All;
                }
                field("Descripción producto"; "Descripción producto")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Cód. almacén"; "Cód. almacén")
                {
                    ApplicationArea = All;
                }
                field("Cód. ubicación"; "Cód. ubicación")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. proveedor"; "No. proveedor")
                {
                    ApplicationArea = All;
                }
                field("No. cliente"; "No. cliente")
                {
                    ApplicationArea = All;
                }
                field("No. lote inspeccionado"; "No. lote inspeccionado")
                {
                    ApplicationArea = All;
                }
                field(ControlVisual; ControlVisual)
                {
                    Caption = 'Control Visual';
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field(EstadoRevisionVisual; EstadoRevisionVisual)
                {
                    Caption = 'Estado Revisión Visual';
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha lanzamiento"; "Fecha lanzamiento")
                {
                    ApplicationArea = All;
                }
                field("Lanzado por usuario"; "Lanzado por usuario")
                {
                    ApplicationArea = All;
                }
                field("Fecha certificación"; "Fecha certificación")
                {
                    ApplicationArea = All;
                }
                field("Certificado por usuario"; "Certificado por usuario")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha recepción"; "Fecha recepción")
                {
                    ApplicationArea = All;
                }
                field("Fecha fabricación"; "Fecha fabricación")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha caducidad"; "Fecha caducidad")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Nueva fecha caducidad"; "Nueva fecha caducidad")
                {
                    Caption = 'Nueva fecha caducidad';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. pedido proveedor"; "No. pedido proveedor")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. pedido cliente"; "No. pedido cliente")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. orden produccion"; "No. orden produccion")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Prioridad; Prioridad)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Conformidad; Conformidad)
                {
                    ApplicationArea = All;
                }
                field("No conformidad"; "No conformidad")
                {
                    ApplicationArea = All;
                }
                field("No. No conformidad"; "No. No conformidad")
                {
                    ApplicationArea = All;
                }
                field("No. de muestra laboratorio"; "No. de muestra laboratorio")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Puntos totales"; "Puntos totales")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Evaluación Inspección"; "Evaluación Inspección")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Recontrol; Recontrol)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000053; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000054; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action("Ver no conformidad")
            {
                Image = InteractionLog;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "No Conformidades_CAL_btc";
                ApplicationArea = All;
                //BEGIN FJAB 311019 Cambiada clave
                /*
                        RunPageLink = "Origen inspección" = FIELD("Origen inspección"),
                                      "No. inspección" = FIELD("No.");
                        */
                RunPageLink = "No. inspección" = FIELD("No.");
                //END FJAB 311019
                RunPageMode = Edit;

                trigger OnAction()
                begin
                    if "No conformidad" = false then Error('Atención: No conformidad no creada');
                end;
            }
            action("Matriz de Inspecciones")
            {
                Caption = 'Matriz de Inspecciones';
                Ellipsis = true;
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Clear(PageInspecciones);
                    PageInspecciones.RunModal();
                end;
            }
        }
        area(reporting)
        {
            action("Informe Inspección")
            {
                Ellipsis = true;
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecInspec: Record "Cab inspe eval_CAL_btc";
                begin
                    RecInspec.Reset();
                    RecInspec.SetRange("No.", "No.");
                    REPORT.run(REPORT::"Informe Inspeccion_CAL_BTC", true, false, RecInspec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Clear(ControlVisual);
        Clear(EstadoRevisionVisual);
        Clear(InfoLote);
        if "No. lote inspeccionado" <> '' then
            if InfoLote.Get("No. producto", "Cód. variante", "No. lote inspeccionado") then begin
                ControlVisual := InfoLote."Test Quality";
                EstadoRevisionVisual := InfoLote.EstadoRevisionVisualCAL_BTC;
            end;
        esborrado := borrado();
    end;

    trigger OnOpenPage()
    begin
        //SetFilter("Estado inspección", '<>Terminada')
    end;

    var
        InfoLote: Record "Lot No. Information";
        PageInspecciones: Page "Inspeccion por Requis_CAL_btc";
        ControlVisual: Option " ",Bueno,Promedio,Bloquear,Bloqueado;
        EstadoRevisionVisual: Option Pendiente,Visado,Revisado,"No Obligatorio";
        [InDataSet]
        esborrado: Boolean;

    local procedure borrado(): Boolean
    var
        venta: Record "Sales Line";
        compra: Record "Purchase Line";
        orden: Record "Prod. Order Line";
    begin
        if "Estado inspección" <> "Estado inspección"::Abierta then exit(false);
        //FJAB 311019 Solo se encarga de mostrar un campo en la page
        //TODO: Comentada función que muestra un campo calculado al vuelo en la page
        /*
            case "Origen inspección" of
                "Origen inspección"::"Recepción":
                    begin
                        compra.Reset();
                        compra.SetRange("Document Type", compra."Document Type"::Order);
                        compra.SetRange("Document No.", "No. pedido proveedor");
                        compra.SetRange("Line No.", "No. línea pedido proveedor");
                        compra.SetRange("No.", "No. producto");
                        compra.SetRange("Variant Code", "Cód. variante");
                        if not compra.FindFirst() then
                            exit(true);
                    end;
                "Origen inspección"::"Devolución":
                    begin
                        compra.Reset();
                        compra.SetRange("Document Type", compra."Document Type"::"Return Order");
                        compra.SetRange("Document No.", "No. pedido proveedor");
                        compra.SetRange("Line No.", "No. línea pedido proveedor");
                        compra.SetRange("No.", "No. producto");
                        compra.SetRange("Variant Code", "Cód. variante");
                        if not compra.FindFirst() then
                            exit(true);
                    end;
                "Origen inspección"::"Envío":
                    begin
                        venta.Reset();
                        venta.SetRange("Document Type", venta."Document Type"::Order);
                        venta.SetRange("Document No.", "No. pedido cliente");
                        venta.SetRange("Line No.", "No. línea pedido cliente");
                        venta.SetRange("No.", "No. producto");
                        venta.SetRange("Variant Code", "Cód. variante");
                        if not venta.FindFirst() then
                            exit(true);
                    end;
                "Origen inspección"::"Reclamación":
                    begin
                        venta.Reset();
                        venta.SetRange("Document Type", venta."Document Type"::"Return Order");
                        venta.SetRange("Document No.", "No. pedido cliente");
                        venta.SetRange("Line No.", "No. línea pedido cliente");
                        venta.SetRange("No.", "No. producto");
                        venta.SetRange("Variant Code", "Cód. variante");
                        if not venta.FindFirst() then
                            exit(true);
                    end;
                "Origen inspección"::"Fabricación":
                    begin
                        orden.Reset();
                        orden.SetFilter(Status, '%1|%2', orden.Status::Released, orden.Status::Finished);
                        orden.SetRange("Prod. Order No.", "No. orden produccion");
                        orden.SetRange("Line No.", "No. línea orden producción");
                        orden.SetRange("Item No.", "No. producto");
                        orden.SetRange("Variant Code", "Cód. variante");
                        if not orden.FindFirst() then
                            exit(true);
                    end;
            end;
            */
        //END FJAB 311019
        exit(false);
    end;
}
