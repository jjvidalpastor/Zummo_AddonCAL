page 65127 "No Conformidad Matrix_CAL_btc"
{
    Caption = 'No Conformidad Matrix';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Cab no conformidad_CAL_btc";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;

                field("Origen inspección"; "Origen inspección")
                {
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ApplicationArea = All;
                }
                field("No. no conformidad"; "No. no conformidad")
                {
                    ApplicationArea = All;
                }
                field("Estado no conformidad"; "Estado no conformidad")
                {
                    ApplicationArea = All;
                }
                //BEGIN FJAB 311019 Cambio campos
                /*
                        field("No. inspección"; "No. inspección")
                        {
                            Style = Strong;
                            StyleExpr = Emphasize;
                        }
                        */
                field("Nº doc. Origen calidad"; "Nº doc. Origen calidad")
                {
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ApplicationArea = All;
                }
                field("Nº lín. doc. Origen calidad"; "Nº lín. doc. Origen calidad")
                {
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ApplicationArea = All;
                }
                //END FJAB 311019
                field("Cód. plantilla"; "Cód. plantilla")
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
                field("No. lote inspeccionado"; "No. lote inspeccionado")
                {
                    ApplicationArea = All;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[1];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field1Visible;
                    ApplicationArea = All;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[2];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field2Visible;
                    ApplicationArea = All;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[3];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field3Visible;
                    ApplicationArea = All;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[4];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field4Visible;
                    ApplicationArea = All;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[5];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field5Visible;
                    ApplicationArea = All;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[6];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field6Visible;
                    ApplicationArea = All;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[7];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field7Visible;
                    ApplicationArea = All;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[8];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field8Visible;
                    ApplicationArea = All;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[9];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field9Visible;
                    ApplicationArea = All;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[10];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field10Visible;
                    ApplicationArea = All;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[11];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field11Visible;
                    ApplicationArea = All;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[12];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field12Visible;
                    ApplicationArea = All;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[13];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field13Visible;
                    ApplicationArea = All;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[14];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field14Visible;
                    ApplicationArea = All;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[15];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field15Visible;
                    ApplicationArea = All;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[16];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field16Visible;
                    ApplicationArea = All;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[17];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field17Visible;
                    ApplicationArea = All;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[18];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field18Visible;
                    ApplicationArea = All;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[19];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field19Visible;
                    ApplicationArea = All;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[20];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field20Visible;
                    ApplicationArea = All;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[21];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field21Visible;
                    ApplicationArea = All;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[22];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field22Visible;
                    ApplicationArea = All;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[23];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field23Visible;
                    ApplicationArea = All;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[24];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field24Visible;
                    ApplicationArea = All;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[25];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field25Visible;
                    ApplicationArea = All;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[26];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field26Visible;
                    ApplicationArea = All;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[27];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field27Visible;
                    ApplicationArea = All;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[28];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field28Visible;
                    ApplicationArea = All;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[29];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field29Visible;
                    ApplicationArea = All;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[30];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field30Visible;
                    ApplicationArea = All;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[31];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field31Visible;
                    ApplicationArea = All;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    AutoFormatType = 1;
                    //BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaptions[32];
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Visible = Field32Visible;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        MATRIX_Steps: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 0;
        MatrixRecord.SetPosition(MATRIX_PrimKeyFirstCol);
        if MATRIX_OnFindRecord('=><') then begin
            MATRIX_CurrentColumnOrdinal := 1;
            repeat
                MATRIX_ColumnOrdinal := MATRIX_CurrentColumnOrdinal;
                MATRIX_OnAfterGetRecord();
                MATRIX_Steps := MATRIX_OnNextRecord(1);
                MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + MATRIX_Steps;
            until (MATRIX_CurrentColumnOrdinal - MATRIX_Steps = MATRIX_NoOfMatrixColumns) or (MATRIX_Steps = 0);
            if MATRIX_CurrentColumnOrdinal <> 1 then MATRIX_OnNextRecord(1 - MATRIX_CurrentColumnOrdinal);
        end;
        FormatLine();
    end;

    trigger OnInit()
    begin
        Field32Visible := true;
        Field31Visible := true;
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
    end;

    trigger OnOpenPage()
    begin
        MATRIX_NoOfMatrixColumns := ArrayLen(MATRIX_CellData);
        FindRec(MatrixRecord, '=');
        SetColumnVisibility();
    end;

    var
        MatrixRecord: Record "Dimension Code Buffer";
        MatrixHeader: Text[50];
        MatrixValue: Text[1024];
        MATRIX_CellData: array[32] of Text;
        MATRIX_ColumnCaptions: array[32] of Text[1024];
        MATRIX_PrimKeyFirstCol: Text[1024];
        MATRIX_ColumnOrdinal: Integer;
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_CurrSetLength: Integer;
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        [InDataSet]
        Field21Visible: Boolean;
        [InDataSet]
        Field22Visible: Boolean;
        [InDataSet]
        Field23Visible: Boolean;
        [InDataSet]
        Field24Visible: Boolean;
        [InDataSet]
        Field25Visible: Boolean;
        [InDataSet]
        Field26Visible: Boolean;
        [InDataSet]
        Field27Visible: Boolean;
        [InDataSet]
        Field28Visible: Boolean;
        [InDataSet]
        Field29Visible: Boolean;
        [InDataSet]
        Field30Visible: Boolean;
        [InDataSet]
        Field31Visible: Boolean;
        [InDataSet]
        Field32Visible: Boolean;
        Emphasize: Boolean;
        ShowColumnName: Boolean;
        ShowDefName: Boolean;

    local procedure FindRec(var DimCodeBuf: Record "Dimension Code Buffer";
    Which: Text[1024]): Boolean
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

    local procedure CopyReqToBuf(var TheRecReq: Record calidad_CAL_btc;
    var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init();
            Code := TheRecReq."No.";
            Name := TheRecReq.Descripción;
        end;
    end;

    local procedure MATRIX_UpdateMatrixRecord(MATRIX_NewColumnOrdinal: Integer)
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        MATRIX_ColumnOrdinal := MATRIX_NewColumnOrdinal;
        MatrixRecord.SetPosition(MATRIX_PrimKeyFirstCol);
        MATRIX_OnFindRecord('=');
        MATRIX_CurrentColumnOrdinal := 1;
        if MATRIX_ColumnOrdinal <> 1 then MATRIX_OnNextRecord(MATRIX_ColumnOrdinal - 1);
    end;

    local procedure MATRIX_OnFindRecord(Which: Text[1024]): Boolean
    begin
        exit(FindRec(MatrixRecord, Which));
    end;

    local procedure MATRIX_OnNextRecord(Steps: Integer): Integer
    begin
        exit(NextRec(MatrixRecord, Steps));
    end;

    local procedure MATRIX_OnAfterGetRecord()
    begin
        if ShowColumnName then
            MatrixHeader := MatrixRecord.Name
        else
            MatrixHeader := MatrixRecord.Code;
        MatrixValue := CalcValue();
        MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixValue;
    end;

    procedure Load(NewMATRIX_ColumnCaptions: array[32] of Text[1024];
    NewPrimKeyFirstCol: Text[1024];
    CurrSetLength: Integer;
    pShowDefName: Boolean)
    begin
        CopyArray(MATRIX_ColumnCaptions, NewMATRIX_ColumnCaptions, 1);
        MATRIX_PrimKeyFirstCol := NewPrimKeyFirstCol;
        MATRIX_CurrSetLength := CurrSetLength;
        ShowDefName := pShowDefName;
    end;

    procedure SetColumnVisibility()
    begin
        Field1Visible := MATRIX_CurrSetLength >= 1;
        Field2Visible := MATRIX_CurrSetLength >= 2;
        Field3Visible := MATRIX_CurrSetLength >= 3;
        Field4Visible := MATRIX_CurrSetLength >= 4;
        Field5Visible := MATRIX_CurrSetLength >= 5;
        Field6Visible := MATRIX_CurrSetLength >= 6;
        Field7Visible := MATRIX_CurrSetLength >= 7;
        Field8Visible := MATRIX_CurrSetLength >= 8;
        Field9Visible := MATRIX_CurrSetLength >= 9;
        Field10Visible := MATRIX_CurrSetLength >= 10;
        Field11Visible := MATRIX_CurrSetLength >= 11;
        Field12Visible := MATRIX_CurrSetLength >= 12;
        Field13Visible := MATRIX_CurrSetLength >= 13;
        Field14Visible := MATRIX_CurrSetLength >= 14;
        Field15Visible := MATRIX_CurrSetLength >= 15;
        Field16Visible := MATRIX_CurrSetLength >= 16;
        Field17Visible := MATRIX_CurrSetLength >= 17;
        Field18Visible := MATRIX_CurrSetLength >= 18;
        Field19Visible := MATRIX_CurrSetLength >= 19;
        Field20Visible := MATRIX_CurrSetLength >= 20;
        Field21Visible := MATRIX_CurrSetLength >= 21;
        Field22Visible := MATRIX_CurrSetLength >= 22;
        Field23Visible := MATRIX_CurrSetLength >= 23;
        Field24Visible := MATRIX_CurrSetLength >= 24;
        Field25Visible := MATRIX_CurrSetLength >= 25;
        Field26Visible := MATRIX_CurrSetLength >= 26;
        Field27Visible := MATRIX_CurrSetLength >= 27;
        Field28Visible := MATRIX_CurrSetLength >= 28;
        Field29Visible := MATRIX_CurrSetLength >= 29;
        Field30Visible := MATRIX_CurrSetLength >= 30;
        Field31Visible := MATRIX_CurrSetLength >= 31;
        Field32Visible := MATRIX_CurrSetLength >= 32;
    end;

    procedure FormatLine()
    begin
        Emphasize := false;
    end;

    procedure CalcValue() Resultado: Text
    var
        RecLin: Record "Lin no conformidad_CAL_btc";
    begin
        Clear(Resultado);
        Clear(RecLin);
        RecLin.SetRange("Origen inspección", "Origen inspección");
        //BEGIN FJAB 311019 Cambio campos
        //RecLin.SetRange("No. inspección", "No. inspección");
        RecLin.SetRange("Nº doc. Origen calidad", "Nº doc. Origen calidad");
        RecLin.SetRange("Nº lín. doc. Origen calidad", "Nº lín. doc. Origen calidad");
        //END FJAB 311019
        RecLin.SetRange("No. no conformidad", "No. no conformidad");
        RecLin.SetRange("Cód. requisito control", MatrixRecord.Code);
        if RecLin.FindSet() then
            if ShowDefName then
                Resultado := RecLin."Descripción defecto"
            else
                Resultado := RecLin."Cód. defecto";
        exit(Resultado);
    end;
}
