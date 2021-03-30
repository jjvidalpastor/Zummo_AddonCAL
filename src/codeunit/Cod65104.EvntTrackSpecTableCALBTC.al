codeunit 65104 "EvntTrackSpecTable_CAL_BTC"
{
    // version CAL1.00
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 336, 'OnAfterValidateEvent', 'New Lot No.', false, false)]
    [TryFunction]
    local procedure OnAfterValidateNewLot_btc(var Rec: Record "Tracking Specification";
    var xRec: Record "Tracking Specification";
    CurrFieldNo: Integer)
    var
        CalidadMgt_CAL_BTC: Codeunit "Calidad Mgt_CAL_BTC";
    begin
        Clear(CalidadMgt_CAL_BTC);
        CalidadMgt_CAL_BTC.CrearInfoLote(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 336, 'OnAfterValidateEvent', 'Lot No.', false, false)]
    local procedure OnAfterValidateLotNo_btc(var Rec: Record "Tracking Specification";
    var xRec: Record "Tracking Specification";
    CurrFieldNo: Integer)
    var
        CalidadMgt_CAL_BTC: Codeunit "Calidad Mgt_CAL_BTC";
    begin
        Clear(CalidadMgt_CAL_BTC);
        CalidadMgt_CAL_BTC.CrearInfoLote(Rec);
    end;
}
