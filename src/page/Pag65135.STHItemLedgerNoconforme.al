page 65135 "STH Item Ledger No conforme"
{
    Caption = 'Item Ledger No conforme', Comment = 'ESP="Movs. Producto No conforme"';
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableView = sorting("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
    UsageCategory = None;
    Editable = false;

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
                Caption = 'Crear Diario', comment = 'ESP="Crear diario"';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    CreateJnlLineAdjustNeg;
                end;
            }
        }
    }

    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        SourceName: text;
        lblConfirm: Label '¿Desea crear el diario de producto con ajustes negarivos de las %1 líneas seleccionadas?', comment = 'ESP="¿Desea crear el diario de producto con ajustes negarivos de las %1 líneas seleccionadas?"';

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
}