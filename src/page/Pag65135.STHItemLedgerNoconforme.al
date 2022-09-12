page 65135 "STH Item Ledger No conforme"
{
    Caption = 'Item Ledger No conforme', Comment = 'ESP="Movs. Producto No conforme"';
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableView = sorting("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
    UsageCategory = None;
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Entry';

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Entry Type field.';
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("No. Inpección"; "No. Inpección")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(ActivarGestionCalidadCAL_BTC; ActivarGestionCalidadCAL_BTC)
                {
                    ApplicationArea = all;
                }
                field("Default Vendor No."; "Default Vendor No.")
                {
                    ApplicationArea = NONE;
                }
                field("Default Vendor Name"; "Default Vendor Name")
                {
                    ApplicationArea = NONE;
                }
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Description field.';
                    Visible = false;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Description field.';
                    Visible = false;
                }
                field(SourceName; SourceName)
                {
                    Caption = 'Name', comment = 'ES="Nombre"';
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Description field.';
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = NONE;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Remaining Quantity"; "Remaining Quantity")
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("No. no conformidad"; "No. no conformidad")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = NONE;
                }
                field("Order Type"; "Order Type")
                {
                    ApplicationArea = NONE;

                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = NONE;
                }
                field("Order Line No."; "Order Line No.")
                {
                    ApplicationArea = NONE;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = NONE;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateJnlLineAdjust)
            {
                ApplicationArea = All;
                Caption = 'Crear Diario', comment = 'ESP="Crear Ajuste  Negativo"';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    CreateJnlLineAdjustNeg;
                end;
            }
            action(CreateJnlLineReclasificacion)
            {
                ApplicationArea = All;
                Caption = 'Crear Reclasificación', comment = 'ESP="Crear Reclasificación"';
                Image = BinJournal;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    CreateJnlLineReclas;
                end;
            }
            action(CreateQualityInspeccion)
            {
                ApplicationArea = All;
                Caption = 'Crear Inspección Calidad', comment = 'ESP="Crear Inspección Calidad"';
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    CreateQualityInspeccionItem;
                end;
            }
        }
        area(Reporting)
        {

            action("Imprimir Etiqueta")
            {
                ApplicationArea = all;
                Caption = 'Imprimir Etiqueta', comment = 'ESP="Imprimir Etiqueta"';
                ToolTip = 'Imprimir etiqueta', comment = 'ESP="Imprimir etiqueta"';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = PrintReport;

                trigger OnAction()
                var
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    Selection: Integer;
                begin
                    Selection := STRMENU('1.-Expedición,2.-Embalaje,3.-Materia Prima,4.-Prod.Terminado', 1);
                    // Message(Format(Selection));
                    ItemLedgerEntry.Reset();
                    IF Selection > 0 THEN begin

                        ItemLedgerEntry.SetRange("Entry No.", Rec."Entry No.");
                        if ItemLedgerEntry.FindFirst() then
                            case Selection of
                                1:
                                    Report.Run(50107, false, false, ItemLedgerEntry);  // Report::EtiquetaDeExpedicion
                                2:
                                    Report.Run(50110, false, false, ItemLedgerEntry);  // Report::EtiquetaEmbalaje
                                3:
                                    Report.Run(50108, false, false, ItemLedgerEntry);  // Report::EtiquetaMateriaPrima
                                4:
                                    Report.Run(50109, false, false, ItemLedgerEntry);  // Report::EtiquetaProductoTerminado

                            end;
                    end;
                end;

            }
        }
        area(Navigation)
        {
            group("Ent&ry")
            {
                Caption = '&Movimiento', comment = 'ESP="&Movimiento"';

                action(Dimensiones)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensiones', comment = 'ESP="Dimensiones"';
                    ToolTip = 'Permite ver o editar dimensiones, como el área, el proyecto o el departamento, que pueden asignarse a los documentos de venta y compra para distribuir costes y analizar el historial de transacciones.';
                    AccessByPermission = TableData Dimension = R;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ShortcutKey = 'Mayús+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action(SetDimensionFilter)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Establecer filtro de dimensión';
                    Ellipsis = true;
                    Image = "Filter";
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Limita los movimientos según los filtros de dimensión especificados. NOTA: Si usa un número alto de combinaciones de dimensiones, es posible que esta función no funcione y se puede generar un mensaje de que SQL Server solo admite un máximo de 2100 parámetros.';

                    trigger OnAction()
                    var
                        DimensionSetIDFilter: page "Dimension Set ID Filter";
                    begin
                        SETFILTER("Dimension Set ID", DimensionSetIDFilter.LookupFilter);
                    end;
                }
                action("&Value Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Movs. &valor';
                    Image = ValueLedger;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Value Entries";
                    RunPageLink = "Item Ledger Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Item Ledger Entry No.");
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'Permite ver el historial de los importes registrados que afectan al valor del producto. Los movimientos de valor se crean para todas las transacciones con el producto.';
                }
            }
            group("&Application")
            {
                Caption = '&Aplicación';
                Image = Apply;
                action("Applied E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Movs. liquidados';
                    Image = Approve;
                    ToolTip = 'Permite ver los movimientos liquidados en este registro.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Show Applied Entries", Rec);
                    end;
                }
                action("Reservation Entries")
                {
                    AccessByPermission = TableData Item = R;
                    ApplicationArea = Reservation;
                    Caption = 'Movs. reserva';
                    Image = ReservationLedger;
                    ToolTip = 'Permite ver los movimientos para cada reserva que se realiza, ya sea manual o automáticamente.';

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(true);
                    end;
                }
                action("Application Worksheet")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hoja liquidación';
                    Image = ApplicationWorksheet;
                    ToolTip = 'Permite ver las liquidaciones de artículo que se crean automáticamente entre los movimientos contables de productos durante las transacciones de productos.';

                    trigger OnAction()
                    var
                        ApplicationWorksheet: Page "Application Worksheet";
                    begin
                        Clear(ApplicationWorksheet);
                        ApplicationWorksheet.SetRecordToShow(Rec);
                        ApplicationWorksheet.Run();
                    end;
                }
            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Navegar';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category4;
                ShortCutKey = 'Shift+Ctrl+I';
                ToolTip = 'Permite buscar todos los movimientos y los documentos que existen para el número de documento y la fecha de registro que constan en el movimiento o el documento seleccionado.';

                trigger OnAction()
                var
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run();
                end;
            }
        }
    }


    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        SourceName: text;
        lblConfirm: Label '¿Desea crear el diario de producto con ajustes negarivos de las %1 líneas seleccionadas?', comment = 'ESP="¿Desea crear el diario de producto con ajustes negarivos de las %1 líneas seleccionadas?"';
        lblConfirmReclas: Label '¿Desea crear el diario de reclasificación producto de las %1 líneas seleccionadas?', comment = 'ESP="¿Desea crear el diario de reclasificación de producto de las %1 líneas seleccionadas?"';

    trigger OnAfterGetRecord()
    begin
        SourceName := '';
        case Rec."Source Type" of
            Rec."Source Type"::Vendor:
                begin
                    if Vendor.get(Rec."Source No.") then
                        SourceName := Vendor.Name;
                end;
            Rec."Source Type"::Customer:
                begin
                    if Customer.get(Rec."Source No.") then
                        SourceName := Customer.Name;
                end;
        end;
    end;

    local procedure CreateJnlLineAdjustNeg()
    var
        CALMgtFunction: Codeunit "Calidad Mgt_CAL_BTC";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        // Función que a todos los registros seleccionados 
        // Creara el diario de productos con ajuste negativo, con misma cantidad pendiente y coste por unidad.
        CurrPage.SetSelectionFilter(ItemLedgerEntry);
        if Confirm(lblConfirm, false, ItemLedgerEntry.Count) then
            CALMgtFunction.CreateJnlLineAdjustNeg(ItemLedgerEntry);

    end;

    local procedure CreateJnlLineReclas()
    var
        CALMgtFunction: Codeunit "Calidad Mgt_CAL_BTC";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        // Función que a todos los registros seleccionados 
        // Creara el diario de productos con ajuste negativo, con misma cantidad pendiente y coste por unidad.
        CurrPage.SetSelectionFilter(ItemLedgerEntry);
        if Confirm(lblConfirmReclas, false, ItemLedgerEntry.Count) then
            CALMgtFunction.CreateJnlLineReclasificacion(ItemLedgerEntry);

    end;

    local procedure CreateQualityInspeccionItem()
    var
        CALMgtFunction: Codeunit "Calidad Mgt_CAL_BTC";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        // Función que a todos los registros seleccionados 
        // Creara el diario de productos con ajuste negativo, con misma cantidad pendiente y coste por unidad.
        CurrPage.SetSelectionFilter(ItemLedgerEntry);
        if Confirm(lblConfirm, false, ItemLedgerEntry.Count) then
            CALMgtFunction.CrearInspeccionProducto(ItemLedgerEntry);

    end;
}