pageextension 65130 "ProdOrderComponents" extends "Prod. Order Components" //99000818
{
    layout
    {
    }
    actions
    {
        addafter("&Print")
        {
            action("Inspecciones de calidad")
            {
                Image = TaskQualityMeasure;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Caption = 'View quality inspections', comment = 'ESP="Ver inspecciones de calidad"';

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
                    recCabInspeccion.SetRange("Nº doc. Origen calidad", "Prod. Order No.");
                    recCabInspeccion.SetRange("Nº lín. doc. Origen calidad", "Prod. Order Line No.");
                    recCabInspeccion.SetRange("Nº línea componente producción", "Line No.");
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
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Caption = 'See Nonconformities', comment = 'ESP="Ver No conformidades"';

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
                    recCabNoConformidad.SetRange("Nº doc. Origen calidad", "Prod. Order No.");
                    recCabNoConformidad.SetRange("Nº lín. doc. Origen calidad", "Prod. Order Line No.");
                    recCabNoConformidad.SetRange("Nº línea componente producción", "Line No.");
                    recCabNoConformidad.FindFirst();
                    Clear(pageNoConformidad);
                    pageNoConformidad.SetTableView(recCabNoConformidad);
                    pageNoConformidad.Run();
                end;
            }
            action(CrearInspeccionCalidad)
            {
                ApplicationArea = All;
                Caption = 'Create quality inspection', comment = 'ESP="Crear inspección de calidad"';
                Image = CopyFromTask;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    cduNewCalidad: Codeunit Crear_CabInspecCalidad_CAL_BTC;
                begin
                    clear(cduNewCalidad);
                    cduNewCalidad.GenerarInspeccionCalidadAlbaran(Rec.TableName, "Prod. Order No.", "Prod. Order Line No.", '', "Item No.", true, "Variant Code", "Location Code", "Bin Code", "Unit of Measure Code", "Line No.");
                end;
            }
        }
    }
}
