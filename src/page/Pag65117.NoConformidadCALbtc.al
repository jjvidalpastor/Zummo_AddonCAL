page 65117 "No Conformidad_CAL_btc"
{
    Caption = 'No Conformidad', comment = 'ESP="No conformidad"';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Cab no conformidad_CAL_btc";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = bEditable;

                field("Origen inspección"; "Origen inspección")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. no conformidad"; "No. no conformidad")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //BEGIN FJAB 311019 Cambio campos
                /*
                        field("No. inspección"; "No. inspección")
                        {
                            Editable = false;
                        }
                        */
                field("Nº doc. Origen calidad"; "Nº doc. Origen calidad")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Nº lín. doc. Origen calidad"; "Nº lín. doc. Origen calidad")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //END FJAB 311019
                field("Cód. plantilla"; "Cód. plantilla")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. revisión plantilla"; "No. revisión plantilla")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Descripcion; Descripcion)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calidad concertada"; "Calidad concertada")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Certificado calidad concertada"; "Certificado calidad concertada")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Fecha recepción"; "Fecha recepción")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Acción")
            {
                //Editable = bEditable;

                field("Acción inmediata"; "Acción inmediata")
                {
                    ApplicationArea = All;
                }

                field("Cód. almacén destino"; "Cód. almacén destino")
                {
                    ApplicationArea = All;
                }
                field("Cód. ubicación destino"; "Cód. ubicación destino")
                {
                    ApplicationArea = All;
                }
                field("Purch. Return Order"; "Purch. Return Order")
                {
                    ApplicationArea = all;
                }
                field("Purch. Order"; "Purch. Order")
                {
                    ApplicationArea = all;
                }
                field("Accion inmediata realizada"; "Accion inmediata realizada")
                {
                    ApplicationArea = All;
                }
                field("Fecha acción inmediata"; "Fecha acción inmediata")
                {
                    ApplicationArea = All;
                }
                field("Observaciones no conformidad"; "Observaciones no conformidad")
                {
                    ApplicationArea = All;
                }
                field("Pdte. Enviar Devol."; "Pdte. Enviar Devol.")
                {
                    ApplicationArea = all;
                }
            }
            group("Inspección")
            {
                Visible = false;
                Editable = false;

                field("Estado no conformidad"; "Estado no conformidad")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tipo inspección"; "Tipo inspección")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Objeto inspección"; "Objeto inspección")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetVisible();
                        CurrPage.Update();
                    end;
                }
                field("No. de muestra laboratorio"; "No. de muestra laboratorio")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Condiciones de almacenamiento"; "Condiciones de almacenamiento")
                {
                    ApplicationArea = All;
                }
                /*field("Observaciones no conformidad"; "Observaciones no conformidad")
                {
                    ApplicationArea = All;
                }*/
                group(Control1000000036)
                {
                    ShowCaption = false;
                    Visible = bRecontrolVisible;

                    field(Recontrol; Recontrol)
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
                group(Control1000000077)
                {
                    ShowCaption = false;
                    Visible = bProductoVisible;

                    field("No. producto"; "No. producto")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Descripción producto"; "Descripción producto")
                    {
                        ApplicationArea = All;
                    }
                    field("Cód. variante"; "Cód. variante")
                    {
                        Editable = false;
                        Visible = false;
                        ApplicationArea = All;
                    }
                }
                group(Control1000000073)
                {
                    ShowCaption = false;
                    Visible = bLoteVisible;

                    field("No. lote inspeccionado"; "No. lote inspeccionado")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Cantidad Muestra Inspeccionar"; "Cantidad Muestra Inspeccionar")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Cantidad Lote"; "Cantidad Lote")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Cantidad Inspeccionada"; "Cantidad Inspeccionada")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Unidad de medida"; "Unidad de medida")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Fecha fabricación"; "Fecha fabricación")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Fecha caducidad"; "Fecha caducidad")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
            }
            part(Control1000000022; "Líneas No Conformidad_CAL_btc")
            {
                Editable = bEditable;
                ShowFilter = false;
                ApplicationArea = All;
                //BEGIN FJAB 311019 Cambio campos
                /*
                        SubPageLink = "Origen inspección" = FIELD("Origen inspección"),
                                      "No. inspección" = FIELD("No. inspección"),
                                      "No. no conformidad" = FIELD("No. no conformidad");
                        SubPageView = SORTING("Origen inspección", "No. inspección", "No. no conformidad", "No. línea");
                        */
                SubPageLink = "No. inspección" = FIELD("No. inspección"), "No. no conformidad" = FIELD("No. no conformidad");
                SubPageView = SORTING("No. inspección", "No. no conformidad", "No. línea");
                //END FJAB 311019
            }
            group("Inf-Conformidad")
            {
                Visible = false;
                Caption = 'Conformidad';
                Editable = bEditable;

                field(Conformidad; Conformidad)
                {
                    ApplicationArea = All;
                }
                field("No conformidad"; "No conformidad")
                {
                    ApplicationArea = All;
                }
                field("SubEstado inspección"; "SubEstado inspección")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Defectos; Defectos)
                {
                    ApplicationArea = All;
                }
                field("Defectos clase A"; "Defectos clase A")
                {
                    ApplicationArea = All;
                }
                field("Defectos clase B"; "Defectos clase B")
                {
                    ApplicationArea = All;
                }
                field("Defectos clase C"; "Defectos clase C")
                {
                    ApplicationArea = All;
                }
            }
            group("Almacén")
            {
                Editable = bEditable;

                field("Cód. almacén"; "Cód. almacén")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Descripción almacén"; "Descripción almacén")
                {
                    ApplicationArea = All;
                }
                field("Cód. ubicación"; "Cód. ubicación")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Descripción ubicación"; "Descripción ubicación")
                {
                    ApplicationArea = All;
                }
            }
            group(Terceros)
            {
                Editable = bEditable;

                field("No. proveedor"; "No. proveedor")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Descripción proveedor"; "Descripción proveedor")
                {
                    ApplicationArea = All;
                }
                field("No. cliente"; "No. cliente")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Descripción cliente"; "Descripción cliente")
                {
                    ApplicationArea = All;
                }
            }
            group(Detalle)
            {
                Visible = false;

                field("No. pedido proveedor"; "No. pedido proveedor")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. línea pedido proveedor"; "No. línea pedido proveedor")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. pedido cliente"; "No. pedido cliente")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. línea pedido cliente"; "No. línea pedido cliente")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. orden produccion"; "No. orden produccion")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. línea orden producción"; "No. línea orden producción")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. ruta produccion"; "No. ruta produccion")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. operación ruta fabricación"; "No. operación ruta fabricación")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Nº línea componente producción"; "Nº línea componente producción")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cód. tarea"; "Cód. tarea")
                {
                    Editable = false;
                    Visible = bProcesoVisible;
                    ApplicationArea = All;
                }
            }
            group(Control)
            {
                Editable = bEditable;

                field("Veredicto no conformidad"; "Veredicto no conformidad")
                {
                    ApplicationArea = All;
                }
                field("Fecha creación"; "Fecha creación")
                {
                    ApplicationArea = All;
                }
                field("Usuario creación"; "Usuario creación")
                {
                    ApplicationArea = All;
                }
                field("Fecha última modificación"; "Fecha última modificación")
                {
                    ApplicationArea = All;
                }
                field("Usuario última modificación"; "Usuario última modificación")
                {
                    ApplicationArea = All;
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
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000061; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000062; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Change &Status")
            {
                Caption = 'Change &Status', Comment = 'ESP="Cambiar Estado"';
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Cab No Conf Status Mgt_CAL_BTC";
                ApplicationArea = All;
            }
            action(MakeDevolution)
            {
                Caption = 'Crear Devol. Compra', comment = 'ESP="Crear Devol. Compra"';
                Image = ReturnOrder;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    funcCalidad: Codeunit "Cab Inspec Status Mgt_CAL_btc";
                begin
                    funcCalidad.CrearReturnOrderNoConformidad(Rec);
                end;
            }
            action(DeleteDevolution)
            {
                Caption = 'Eliminar Devol. Compra', comment = 'ESP="Eliminar Devol. Compra"';
                Image = DeleteRow;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    funcCalidad: Codeunit "Cab Inspec Status Mgt_CAL_btc";
                begin
                    funcCalidad.DeleteReturnOrderNoConformidad(Rec);
                end;
            }
        }
        area(Reporting)
        {
            action("Imprimir Devolución")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    rec.TestField("Purch. Return Order");
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::"Return Order");
                    PurchaseHeader.SetRange("No.", Rec."Purch. Return Order");
                    REPORT.RunModal(REPORT::"Devolucion Compra", true, false, PurchaseHeader);
                end;

            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetVisible();
        SetEditable();
    end;

    var
        [InDataSet]
        bProductoVisible: Boolean;
        [InDataSet]
        bMuestraVisible: Boolean;
        [InDataSet]
        bProcesoVisible: Boolean;
        [InDataSet]
        bProveedorVisible: Boolean;
        [InDataSet]
        bLoteVisible: Boolean;
        [InDataSet]
        bEditable: Boolean;
        bClienteVisible: Boolean;
        bRecontrolVisible: Boolean;

    procedure SetVisible()
    begin
        case "Objeto inspección" of
            "Objeto inspección"::Lote:
                begin
                    bProductoVisible := true;
                    bLoteVisible := true;
                    bMuestraVisible := false;
                    bProcesoVisible := false;
                    bProveedorVisible := true;
                    bClienteVisible := true;
                    if Recontrol then
                        bRecontrolVisible := true
                    else
                        bRecontrolVisible := false;
                end;
            "Objeto inspección"::Muestra:
                begin
                    bProductoVisible := true;
                    bLoteVisible := true;
                    bMuestraVisible := true;
                    bProcesoVisible := false;
                    bProveedorVisible := true;
                    bClienteVisible := false;
                end;
            "Objeto inspección"::Proceso:
                begin
                    bProductoVisible := false;
                    bLoteVisible := false;
                    bMuestraVisible := false;
                    bProcesoVisible := true;
                    bProveedorVisible := false;
                    bClienteVisible := false;
                end;
            "Objeto inspección"::"Proveedor/Cliente":
                begin
                    bProductoVisible := false;
                    bLoteVisible := false;
                    bMuestraVisible := false;
                    bProcesoVisible := false;
                    bProveedorVisible := true;
                    bClienteVisible := true;
                end;
            else
                Error('Tipo no esperado');
        end;
    end;

    procedure SetEditable()
    begin
        if ("Estado no conformidad" = "Estado no conformidad"::Abierta) or ("Estado no conformidad" = "Estado no conformidad"::Lanzada) then
            bEditable := true
        else
            bEditable := false;
    end;
}
