page 65121 "ChangeStatOnCabNoConf_CAL_btc"
{
    Caption = 'Change Status on inspection', Comment = 'ESP="Cambiar estado a inpección"';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    InstructionalText = 'Do you want to change the status of this inspection?';
    ModifyAllowed = false;
    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field(FirmPlannedStatus; ProdOrderStatus."Estado no conformidad")
            {
                Caption = 'New Status';
                ApplicationArea = All;
            }
            field(PostingDate; PostingDate)
            {
                Caption = 'Posting Date';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnInit()
    begin
        FinishedStatusEditable := true;
        ReleasedStatusEditable := true;
        FirmPlannedStatusEditable := true;
    end;

    var
        ProdOrderStatus: Record "Cab no conformidad_CAL_btc";
        PostingDate: Date;
        [InDataSet]
        FirmPlannedStatusEditable: Boolean;
        [InDataSet]
        ReleasedStatusEditable: Boolean;
        [InDataSet]
        FinishedStatusEditable: Boolean;
        NoValidSelErr: Label '%1 is not a valid selection.';

    procedure Set(ProdOrder: Record "Cab no conformidad_CAL_btc")
    begin
        if ProdOrder."Estado no conformidad" = ProdOrder."Estado no conformidad"::Terminada then ProdOrder.FieldError("Estado no conformidad");
        ProdOrderStatus."Estado no conformidad" := ProdOrder."Estado no conformidad" + 1;
        PostingDate := WorkDate();
    end;

    procedure ReturnPostingInfo(var Status: Option Simulated,Planned,"Firm Planned",Released,Finished;
    var PostingDate2: Date)
    begin
        Status := ProdOrderStatus."Estado no conformidad";
        PostingDate2 := PostingDate;
    end;

    procedure CheckStatus(StatusEditable: Boolean)
    begin
        if not StatusEditable then Error(NoValidSelErr, ProdOrderStatus."Estado no conformidad");
    end;
}
