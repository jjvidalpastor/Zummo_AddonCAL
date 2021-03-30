page 65129 "Histórico Inspecciones_CAL_btc"
{
    Caption = 'Histórico Inspecciones Calidad', Comment = 'ESP="Histórico Inspecciones Calidad"';
    CardPageID = "Inspección de Calidad_CAL_btc";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cab inspe eval_CAL_btc";
    //FJAB 311019 Cambio campos
    //SourceTableView = SORTING ("Origen inspección", "No.")
    SourceTableView = SORTING("No.") ORDER(Ascending) WHERE("Estado inspección" = FILTER(Terminada));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Origen inspección"; "Origen inspección")
                {
                    ApplicationArea = All;
                }
                //BEGIN FJAB 311019 Cambio campos
                /*
                        field("No."; "No.")
                        {
                        }
                        */
                field("Nº doc. Origen calidad"; "Nº doc. Origen calidad")
                {
                    ApplicationArea = All;
                }
                field("Nº lín. doc. Origen calidad"; "Nº lín. doc. Origen calidad")
                {
                    ApplicationArea = All;
                }
                //END FJAB 311019
                field("Estado inspección"; "Estado inspección")
                {
                    ApplicationArea = All;
                }
                field("SubEstado inspección"; "SubEstado inspección")
                {
                    ApplicationArea = All;
                }
                field("Tipo inspección"; "Tipo inspección")
                {
                    ApplicationArea = All;
                }
                field("Objeto inspección"; "Objeto inspección")
                {
                    ApplicationArea = All;
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
                field("Fecha recepción"; "Fecha recepción")
                {
                    ApplicationArea = All;
                }
                field("Fecha fabricación"; "Fecha fabricación")
                {
                    ApplicationArea = All;
                }
                field("Fecha caducidad"; "Fecha caducidad")
                {
                    ApplicationArea = All;
                }
                field("No. pedido proveedor"; "No. pedido proveedor")
                {
                    ApplicationArea = All;
                }
                field("No. pedido cliente"; "No. pedido cliente")
                {
                    ApplicationArea = All;
                }
                field("No. orden produccion"; "No. orden produccion")
                {
                    ApplicationArea = All;
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
                }
                field("Puntos totales"; "Puntos totales")
                {
                    ApplicationArea = All;
                }
                field("Evaluación Inspección"; "Evaluación Inspección")
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
                //BEGIN FJAB 311019 Cambio campos
                /*
                        RunPageLink = "Origen inspección" = FIELD("Origen inspección"),
                                      "No. inspección" = FIELD("No.");
                        */
                RunPageLink = "Origen inspección" = FIELD("Origen inspección"), "Nº doc. Origen calidad" = FIELD("Nº doc. Origen calidad"), "Nº lín. doc. Origen calidad" = field("Nº lín. doc. Origen calidad");
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
                    REPORT.RunModal(REPORT::"Informe Inspeccion_CAL_BTC", true, false, RecInspec);
                end;
            }
        }
    }
    var
        PageInspecciones: Page "Inspeccion por Requis_CAL_btc";
}
