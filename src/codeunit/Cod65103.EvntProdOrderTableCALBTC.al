codeunit 65103 "EvntProdOrderTable_CAL_BTC"
{
    [EventSubscriber(ObjectType::Table, 5405, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterDelete(var Rec: Record "Production Order";
    RunTrigger: Boolean)
    var
        InfoLote: Record "Lot No. Information";
    begin
        with Rec do begin
            if not RunTrigger then exit;
            if NoLoteCAL_BTC <> '' then begin
                Clear(NoLoteCAL_BTC);
                if InfoLote.Get("Source No.", '', NoLoteCAL_BTC) then if InfoLote.ProdOrderNoCAL_BTC = "No." then InfoLote.Delete();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 5405, 'OnAfterValidateEvent', 'Source No.', false, false)]
    local procedure OnAfterValidate_SourceNo_FillLocation(var Rec: Record "Production Order";
    var xRec: Record "Production Order";
    CurrFieldNo: Integer)
    var
        Item: Record Item;
    begin
        with Rec do if "Source Type" = "Source Type"::Item then begin
                Clear(Item);
                Item.Get("Source No.");
                if "Location Code" = '' then Validate("Location Code", Item.AlmacenPreferCAL_BTC);
                Validate(NoLoteCAL_BTC, "No.");
            end;
    end;
}
