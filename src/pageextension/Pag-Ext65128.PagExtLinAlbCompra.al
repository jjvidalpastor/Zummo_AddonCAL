pageextension 65128 "PagExtLinAlbCompra" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
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
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        recCabInspeccion: Record "Cab inspe eval_CAL_btc";
                        cduNewCalidad: Codeunit Crear_CabInspecCalidad_CAL_BTC;
                        pageCalidad: Page "Inspecciones de Calida_CAL_btc";
                        enumOrigen: Enum OrigenCalidad;
                    begin
                        clear(cduNewCalidad);
                        evaluate(enumOrigen, format(cduNewCalidad.GetTableID(Rec.TableName)));
                        recCabInspeccion.Reset();
                        recCabInspeccion.SetRange("Origen inspección", enumOrigen); // cduNewCalidad.GetTableID(Rec.TableName));
                        recCabInspeccion.SetRange("Nº doc. Origen calidad", "Document No.");
                        recCabInspeccion.SetRange("Nº lín. doc. Origen calidad", "Line No.");
                        recCabInspeccion.FindFirst();
                        Clear(pageCalidad);
                        pageCalidad.SetTableView(recCabInspeccion);
                        pageCalidad.Run();
                    end;
                }
                action("No conformidad")
                {
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        recCabNoConformidad: Record "Cab no conformidad_CAL_btc";
                        cduNewCalidad: Codeunit Crear_CabInspecCalidad_CAL_BTC;
                        pageNoConformidad: Page "No Conformidades_CAL_btc";
                        enumOrigen: Enum OrigenCalidad;
                    begin
                        clear(cduNewCalidad);
                        evaluate(enumOrigen, format(cduNewCalidad.GetTableID(Rec.TableName)));
                        recCabNoConformidad.Reset();
                        recCabNoConformidad.SetRange("Origen inspección", enumOrigen); // cduNewCalidad.GetTableID(Rec.TableName));
                        recCabNoConformidad.SetRange("Nº doc. Origen calidad", "Document No.");
                        recCabNoConformidad.SetRange("Nº lín. doc. Origen calidad", "Line No.");
                        recCabNoConformidad.FindFirst();
                        Clear(pageNoConformidad);
                        pageNoConformidad.SetTableView(recCabNoConformidad);
                        pageNoConformidad.Run();
                    end;
                }
                action("Crear inspección # control visual")
                {
                    Image = CopyFromTask;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        cduNewCalidad: Codeunit Crear_CabInspecCalidad_CAL_BTC;
                    begin
                        TestField(Type, Type::Item);
                        clear(cduNewCalidad);
                        cduNewCalidad.GenerarInspeccionCalidadAlbaran(Rec.TableName, "Document No.", "Line No.", "Buy-from Vendor No.", "No.", true, "Variant Code", "Location Code", "Bin Code", "Unit of Measure Code", 0);
                    end;
                }
            }
        }
    }
}
