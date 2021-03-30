page 65116 "No Conformidades_CAL_btc"
{
    Caption = 'No Conformidades', Comment = 'ESP="No Conformidades"';
    CardPageID = "No Conformidad_CAL_btc";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cab no conformidad_CAL_btc";
    UsageCategory = Lists;
    //BEGIN FJAB 311019 Cambio campos
    /*
      SourceTableView = SORTING ("Origen inspección", "No. inspección", "No. no conformidad")
                        ORDER(Ascending);
      */
    SourceTableView = SORTING("No. inspección", "No. no conformidad") ORDER(Ascending);

    //END FJAB 311019
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
                field("No. no conformidad"; "No. no conformidad")
                {
                    ApplicationArea = All;
                }
                //BEGIN FJAB 311019 Cambio campos
                /*
                        field("No. inspección"; "No. inspección")
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
                field("Cód. plantilla"; "Cód. plantilla")
                {
                    ApplicationArea = All;
                }
                field("Estado no conformidad"; "Estado no conformidad")
                {
                    ApplicationArea = All;
                }
                field("Evaluación Inspección"; "Evaluación Inspección")
                {
                    ApplicationArea = All;
                }
                field("SubEstado inspección"; "SubEstado inspección")
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
                field("Cód. variante"; "Cód. variante")
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
                field("No. de muestra laboratorio"; "No. de muestra laboratorio")
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
        area(navigation)
        {
            action("Matriz de No Conformidades")
            {
                Caption = 'Matriz de No Conformidades';
                Ellipsis = true;
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    pageNoConformidades: Page "No Conformidad por Req_CAL_btc";
                begin
                    Clear(pageNoConformidades);
                    pageNoConformidades.RunModal();
                end;
            }
        }
        area(reporting)
        {
            action("Informe No Conformidad")
            {
                Ellipsis = true;
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    RecNoConform.Reset();
                    RecNoConform.SetRange("No. inspección", "No. inspección");
                    RecNoConform.SetRange("No. no conformidad", "No. no conformidad");
                    REPORT.RunModal(REPORT::"Informe No Conformidad_CAL_BTC", true, false, RecNoConform);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetFilter("Estado no conformidad", '<>Terminada');
    end;

    var
        RecNoConform: Record "Cab no conformidad_CAL_btc";
}
