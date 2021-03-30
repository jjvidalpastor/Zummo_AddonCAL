page 65120 "ChangStOnCabInsp_CAL_btc"
{
    Caption = 'Change Status on inspection', Comment = 'ESP="Cambiar estado de inspección"';
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
            field(FirmPlannedStatus; ProdOrderStatus."Estado inspección")
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
        ProdOrderStatus: Record "Cab inspe eval_CAL_btc";
        PostingDate: Date;
        [InDataSet]
        FirmPlannedStatusEditable: Boolean;
        [InDataSet]
        ReleasedStatusEditable: Boolean;
        [InDataSet]
        FinishedStatusEditable: Boolean;
        NotValidSelErr: Label '%1 is not a valid selection.';

    procedure Set(ProdOrder: Record "Cab inspe eval_CAL_btc")
    begin
        if ProdOrder."Estado inspección" = ProdOrder."Estado inspección"::Terminada then ProdOrder.FieldError("Estado inspección");
        ProdOrderStatus."Estado inspección" := ProdOrder."Estado inspección" + 1;
        PostingDate := WorkDate();
    end;

    procedure ReturnPostingInfo(var Status: Option Simulated,Planned,"Firm Planned",Released,Finished;
    var PostingDate2: Date)
    begin
        Status := ProdOrderStatus."Estado inspección";
        PostingDate2 := PostingDate;
    end;

    procedure CheckStatus(StatusEditable: Boolean)
    begin
        if not StatusEditable then Error(NotValidSelErr, ProdOrderStatus."Estado inspección");
    end;
}
