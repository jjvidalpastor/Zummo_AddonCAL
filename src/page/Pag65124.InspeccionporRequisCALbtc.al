page 65124 "Inspeccion por Requis_CAL_btc"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = false;
    SourceTable = "Dimension Code Buffer";

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';

                field(ShowColumnName; ShowColumnName)
                {
                    Caption = 'Show Column Name';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShowColumnNameOnAfterValidate();
                    end;
                }
            }
            group("Matrix Options")
            {
                Caption = 'Matrix Options';

                field(MATRIX_ColumnSet; MATRIX_ColumnSet)
                {
                    Caption = 'Column Set';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ShowMatrix)
            {
                Caption = '&Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    MatrixForm: Page "Inspeccion Matrix_CAL_btc";
                begin
                    Clear(MatrixForm);
                    MatrixForm.Load(MATRIX_ColumnCaptions, MATRIX_PrimaryKeyFirstColInSet, MATRIX_CurrSetLength);
                    MatrixForm.RunModal();
                end;
            }
            action("Next Set")
            {
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';
                ApplicationArea = All;

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::Next);
                end;
            }
            action("Previous Set")
            {
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';
                ApplicationArea = All;

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::Previous);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        MATRIX_Step: Option Initial,Previous,Same,Next;
    begin
        MATRIX_NoOfColumns := 32;
        MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
    end;

    var
        ShowColumnName: Boolean;
        MATRIX_ColumnCaptions: array[32] of Text[1024];
        MATRIX_ColumnSet: Text[1024];
        MATRIX_PrimaryKeyFirstColInSet: Text[1024];
        MATRIX_NoOfColumns: Integer;
        MATRIX_CurrSetLength: Integer;
        FiltroOrigen: Option "Recepción","Almacén","Fabricación","Envío","Devolución",Procesos,"Evaluación";
        FiltroRevision: Text[1024];

    local procedure CopyReqToBuf(var TheReq: Record calidad_CAL_btc;
    var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init();
            Code := TheReq."No.";
            Name := TheReq.Descripción;
        end;
    end;

    local procedure FindRec(var DimCodeBuf: Record "Dimension Code Buffer";
    Which: Text[250]): Boolean
    var
        RecReq: Record calidad_CAL_btc;
        Found: Boolean;
    begin
        RecReq."No." := DimCodeBuf.Code;
        Found := RecReq.Find(Which);
        if Found then CopyReqToBuf(RecReq, DimCodeBuf);
        exit(Found);
    end;

    local procedure NextRec(var DimCodeBuf: Record "Dimension Code Buffer";
    Steps: Integer): Integer
    var
        RecReq: Record calidad_CAL_btc;
        ResultSteps: Integer;
    begin
        RecReq."No." := DimCodeBuf.Code;
        ResultSteps := RecReq.Next(Steps);
        if ResultSteps <> 0 then CopyReqToBuf(RecReq, DimCodeBuf);
        exit(ResultSteps);
    end;

    procedure MATRIX_GenerateColumnCaptions(Step: Option Initial,Previous,Same,Next)
    var
        CurrentColumn: Record "Dimension Code Buffer";
        Continue: Boolean;
        Found: Boolean;
        Which: Text[30];
    begin
        MATRIX_CurrSetLength := 0;
        Continue := true;
        Clear(MATRIX_ColumnCaptions);
        MATRIX_ColumnSet := '';
        case Step of
            Step::Initial:
                begin
                    Which := '-';
                    Found := FindRec(CurrentColumn, Which);
                end;
            Step::Previous:
                begin
                    CurrentColumn.SetPosition(MATRIX_PrimaryKeyFirstColInSet);
                    Found := FindRec(CurrentColumn, '=');
                    NextRec(CurrentColumn, -MATRIX_NoOfColumns)
                end;
            Step::Same:
                begin
                    CurrentColumn.SetPosition(MATRIX_PrimaryKeyFirstColInSet);
                    Found := FindRec(CurrentColumn, '=');
                end;
            Step::Next:
                begin
                    CurrentColumn.SetPosition(MATRIX_PrimaryKeyFirstColInSet);
                    Found := FindRec(CurrentColumn, '=');
                    if not (NextRec(CurrentColumn, MATRIX_NoOfColumns) = MATRIX_NoOfColumns) then begin
                        CurrentColumn.SetPosition(MATRIX_PrimaryKeyFirstColInSet);
                        Found := FindRec(CurrentColumn, '=');
                    end
                end;
        end;
        MATRIX_PrimaryKeyFirstColInSet := CurrentColumn.GetPosition();
        if Found then begin
            repeat
                MATRIX_CurrSetLength := MATRIX_CurrSetLength + 1;
                if ShowColumnName then
                    MATRIX_ColumnCaptions[MATRIX_CurrSetLength] := CurrentColumn.Name
                else
                    MATRIX_ColumnCaptions[MATRIX_CurrSetLength] := CurrentColumn.Code;
            until (MATRIX_CurrSetLength = MATRIX_NoOfColumns) or (NextRec(CurrentColumn, 1) <> 1);
            if MATRIX_CurrSetLength = 1 then
                MATRIX_ColumnSet := MATRIX_ColumnCaptions[1]
            else
                MATRIX_ColumnSet := MATRIX_ColumnCaptions[1] + '..' + MATRIX_ColumnCaptions[MATRIX_CurrSetLength];
        end;
    end;

    local procedure LineDimCodeOnAfterValidate()
    begin
        CurrPage.Update();
    end;

    local procedure ColumnDimCodeOnAfterValidate()
    var
        MATRIX_Steps: Option First,Previous,Next;
    begin
        CurrPage.Update();
        MATRIX_GenerateColumnCaptions(MATRIX_Steps::First);
    end;

    local procedure ShowColumnNameOnAfterValidate()
    var
        MATRIX_Step: Option Initial,Previous,Same,Next;
    begin
        MATRIX_GenerateColumnCaptions(MATRIX_Step::Same);
    end;
}
