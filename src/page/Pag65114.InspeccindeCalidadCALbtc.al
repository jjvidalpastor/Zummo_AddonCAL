page 65114 "Inspección de Calidad_CAL_btc"
{
    Caption = 'Inspección de Calidad', Comment = 'EPS="Inspección de Calidad"';
    PageType = Card;
    SourceTable = "Cab inspe eval_CAL_btc";
    RefreshOnActivate = true;
    DeleteAllowed = false;

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
                //BEGIN FJAB 311019 Cambio en campos
                /*
                        field("No."; "No.")
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
                field(NoDocLinOrigen_btc; NoDocLinOrigen_btc)
                {
                    ApplicationArea = All;
                }
                field("Cód. plantilla"; "Cód. plantilla")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Descripción"; Descripción)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Fecha creación"; "Fecha creación")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Producto)
            {
                Caption = 'Producto';

                field("No. producto"; "No. producto")
                {
                    Editable = bMuestraVisible;
                    ApplicationArea = All;
                }
                field("Descripción producto"; "Descripción producto")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(EntryNo; EntryNo)
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Inspección")
            {
                Editable = bEditable;

                field("Estado inspección"; "Estado inspección")
                {
                    Editable = false;
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

                    trigger OnValidate()
                    begin
                        SetVisible();
                        CurrPage.Update();
                    end;
                }
                field("No. de muestra laboratorio"; "No. de muestra laboratorio")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Condiciones de almacenamiento"; "Condiciones de almacenamiento")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Observaciones inspección"; "Observaciones inspección")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fecha fabricación"; "Fecha fabricación")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fecha caducidad"; "Fecha caducidad")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                group(Control1000000062)
                {
                    ShowCaption = false;
                    Visible = bLoteVisible;

                    field("No. lote inspeccionado"; "No. lote inspeccionado")
                    {
                        Visible = false;
                        Editable = bProductoLoteProveedor;
                        ApplicationArea = All;
                    }
                    field(ControlVisual; ControlVisual)
                    {
                        Visible = false;
                        Caption = 'Control Visual';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(EstadoRevisionVisual; EstadoRevisionVisual)
                    {
                        Visible = false;
                        Caption = 'Estado Revisión Visual';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Cantidad Muestra Inspeccionar"; "Cantidad Muestra Inspeccionar")
                    {
                        Visible = false;
                        Editable = bProductoLoteProveedor;
                        ApplicationArea = All;
                    }
                    field("Cantidad Lote"; "Cantidad Lote")
                    {
                        Visible = false;
                        Editable = bProductoLoteProveedor;
                        ApplicationArea = All;
                    }
                    field("Cantidad Inspeccionada"; "Cantidad Inspeccionada")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        BlankZero = false;
                    }
                    field("Unidad de medida"; "Unidad de medida")
                    {
                        Visible = false;
                        Editable = bProductoLoteProveedor;
                        ApplicationArea = All;
                    }
                    field(Recontrol; Recontrol)
                    {
                        Visible = false;
                        Editable = false;
                        //Visible = bRecontrolVisible;
                        ApplicationArea = All;
                    }
                    field("Nueva fecha caducidad"; "Nueva fecha caducidad")
                    {
                        Editable = bRecontrolVisible;
                        Visible = false;
                        //Visible = bRecontrolVisible;
                        ApplicationArea = All;
                    }
                    field("Evaluación Inspección"; "Evaluación Inspección")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = true;
                    }
                }
            }
            group(ReturnQty)
            {
                Caption = 'Cantidades parciales a devolver', comment = 'ESP="Cantidades parciales a devolver"';

                field(QtytoReturn; QtytoReturn)
                {
                    ApplicationArea = all;
                }
                field(InspeccionReturn; InspeccionReturn)
                {
                    ApplicationArea = all;
                }
                field("Cód. almacén destino"; "Cód. almacén destino")
                {
                    ApplicationArea = all;
                }
            }
            part(Control1000000056; "Líneas Inspección Cal_CAL_btc")
            {
                Editable = bEditable;
                ShowFilter = false;
                ApplicationArea = All;
                UpdatePropagation = Both;
                //BEGIN FJAB 311019 Cambio campos
                /*
                        SubPageLink = "Origen inspección" = FIELD("Origen inspección"),
                                      "No. inspección" = FIELD("No.");
                        SubPageView = SORTING("Origen inspección", "No. inspección", "No. línea");
                        */
                SubPageLink = "No. inspección" = FIELD("No.");
                SubPageView = SORTING("No. inspección", "No. línea");
                //END FJAB 311019
            }
            group("Inf-Conformidad")
            {
                Caption = 'Conformidad';
                Editable = bEditable;
                Visible = false;

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
                field("No. No conformidad"; "No. No conformidad")
                {
                    ApplicationArea = All;
                }
                field("Requisitos totales"; "Requisitos totales")
                {
                    ApplicationArea = All;
                }
                field("Requisitos pendientes evaluar"; "Requisitos pendientes evaluar")
                {
                    ApplicationArea = All;
                }
                field("Requisitos aceptables"; "Requisitos aceptables")
                {
                    ApplicationArea = All;
                }
                field("Requisitos no aceptables"; "Requisitos no aceptables")
                {
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
                    Editable = bMuestraVisible;
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
                    Editable = bProductoLoteProveedor;
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
                    ApplicationArea = All;
                }
                field("Puntos totales"; "Puntos totales")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Control)
            {
                Editable = bEditable;

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
                field("Fecha terminación"; "Fecha terminación")
                {
                    ApplicationArea = All;
                }
                field("Terminado por usuario"; "Terminado por usuario")
                {
                    ApplicationArea = All;
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
                //BEGIN FJAB 311019 Cambio cmapos
                /*
                        RunPageLink = "Origen inspección" = FIELD("Origen inspección"),
                                      "No. inspección" = FIELD("No.");
                        */
                RunPageLink = "No. inspección" = FIELD("No.");

                //END FJAB 311019
                trigger OnAction()
                begin
                    if "No conformidad" = false then Error('Atención: No conformidad no creada');
                end;
            }
        }
        area(processing)
        {
            action("Change &Status")
            {
                Caption = 'Change &Status', comment = 'ESP="Cambiar E&stado"';
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Cab Inspec Status Mgt_CAL_btc";
                ApplicationArea = All;
            }
            action("Crear no conformidad")
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    funcCalidad: Codeunit "Calidad Mgt_CAL_BTC";
                    funcCalidadV2: Codeunit Crear_CabInspecCalidad_CAL_BTC;
                begin
                    //BEGIN FJAB 311019 Cambiamos codeunit
                    //funcCalidad.CrearNoConformidad(Rec);
                    CLEAR(funcCalidadV2);
                    funcCalidadV2.CrearNoConformidad(Rec);
                    //END FJAB 311019
                end;
            }
            action("Crear inspección parcial")
            {
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    funcCalidad: Codeunit "Cab Inspec Status Mgt_CAL_btc";
                begin
                    rec.TestField(InspeccionReturn, '');
                    funcCalidad.DividirOrdenProd(Rec);
                end;
            }
            action("Eliminar Inspección")
            {
                Image = DeleteQtyToHandle;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    funcCalidad: Codeunit "Cab Inspec Status Mgt_CAL_btc";
                begin
                    funcCalidad.DeleteProdOrden(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetVisible();
        SetEditable();
    end;

    trigger OnAfterGetRecord()
    var
        OrdProd: Record "Production Order";
        ProductOrderLine: Record "Prod. Order Line";
    begin
        Clear(ControlVisual);
        Clear(EstadoRevisionVisual);
        Clear(InfoLote);
        if "No. lote inspeccionado" <> '' then
            if InfoLote.Get("No. producto", "Cód. variante", "No. lote inspeccionado") then begin
                ControlVisual := InfoLote."Test Quality";
                EstadoRevisionVisual := InfoLote.EstadoRevisionVisualCAL_BTC;
            end;
        //BEGIN FJAB 311019 Cálculo cantidad
        //TODO: Revisar cálculo cantidad lote
        /*
              if "Origen inspección" = "Origen inspección"::"Fabricación" then
                  if "No. orden produccion" <> '' then begin
                      OrdProd.Reset();
                      OrdProd.SetCurrentKey("No.", Status);
                      OrdProd.SetRange("No.", "No. orden produccion");
                      if OrdProd.FindFirst() then
                          if ProductOrderLine.Get(OrdProd.Status, OrdProd."No.", 10000) then
                              "Cantidad Lote" := ProductOrderLine."Finished Quantity";
                  end;
              */
        //END FJAB 311019
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        bProductoLoteProveedor := true;
        bProductoVisible := true;
        bLoteVisible := true;
        bMuestraVisible := true;
        bProcesoVisible := false;
        bProveedorVisible := true;
        bClienteVisible := false;
    end;

    var
        InfoLote: Record "Lot No. Information";
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
        bProductoLoteProveedor: Boolean;
        ControlVisual: Option " ",Bueno,Promedio,Bloquear,Bloqueado;
        EstadoRevisionVisual: Option Pendiente,Visado,Revisado,"No Obligatorio";

    procedure SetVisible()
    begin
        case "Objeto inspección" of
            "Objeto inspección"::Lote:
                begin
                    bProductoLoteProveedor := false;
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
                    bProductoLoteProveedor := true;
                    bProductoVisible := true;
                    bLoteVisible := true;
                    bMuestraVisible := true;
                    bProcesoVisible := false;
                    bProveedorVisible := true;
                    bClienteVisible := false;
                end;
            "Objeto inspección"::Proceso:
                begin
                    bProductoLoteProveedor := false;
                    bProductoVisible := false;
                    bLoteVisible := false;
                    bMuestraVisible := false;
                    bProcesoVisible := true;
                    bProveedorVisible := false;
                    bClienteVisible := false;
                end;
            "Objeto inspección"::"Proveedor/Cliente":
                begin
                    bProductoLoteProveedor := false;
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
        //BEGIN FJAB 311019 Visibilidad campos page
        //TODO: Control visibilidad campos page por ser de Origen Muestras
        /*
              if "Origen inspección" = "Origen inspección"::Muestras then begin
                  bProductoLoteProveedor := true;
                  bProductoVisible := true;
                  bLoteVisible := true;
                  bMuestraVisible := true;
                  bProcesoVisible := false;
                  bProveedorVisible := true;
                  bClienteVisible := false;
              end;
              */
        //END FJAB 311019
    end;

    procedure SetEditable()
    begin
        if ("Estado inspección" = "Estado inspección"::Abierta) or ("Estado inspección" = "Estado inspección"::Lanzada) then
            bEditable := true
        else
            bEditable := false;
    end;
}
