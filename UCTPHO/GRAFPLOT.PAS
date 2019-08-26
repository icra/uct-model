Procedure PlotGraph;

var

 OffsetXLeft,OffsetXRight,
 OffsetYTop,OffsetYBot,
 DivisionsX,DivisionsY,
 TickLengthX,TickLengthY,
 LetterScale,LetterWidth,LetterHeight,
 NameLength,UnitLength,
 XPos,YPos,
 X1,X2,Y1,Y2,
 ULX,ULY,LRX,LRY                          : Integer;

 YVal,XAxisRange    : Real;

 LabelY             : String[5];
 DumString          : String[15];


Procedure InitGraphDims;
  Begin
    XAxisRange   := 24.0;
    DivisionsX   := 12;
    DivisionsY   := 5;
    OffsetXLeft  := GetMaxX div 8;
    OffsetXRight := GetMaxX div 12;
    OffsetYTop   := GetMaxY div 6;
    OffsetYBot   := GetMaxY div 5;
    ULX          := OffsetXLeft;
    ULY          := OffsetYTop;
    LRX          := GetMaxX - OffsetXRight;
    LRY          := GetMaxY - OffsetYBot;
    TickLengthY  := GetMaxX div 50;
    TickLengthX  := GetMaxY div 40;
  End; { init graph coords }


Procedure DrawGraphBox;
  Begin
    SetColor(GraphCol.Frame);
    SetBkColor(GraphCol.Back);
    SetLineStyle(SolidLn,0,ThickWidth);
    Rectangle(ULX,ULY,LRX,LRY);
    SetLineStyle(SolidLn,0,NormWidth);
    for j := 0 to DivisionsX do
      begin
        XPos := round(ULX + j*(LRX-ULX)/DivisionsX*1.0);
        Line(XPos,LRY,XPos,LRY-TickLengthX);
        Line(XPos,ULY,XPos,ULY+TickLengthX);
      end;
    for j := 0 to DivisionsY do
      begin
        YPos := round(LRY - j*(LRY-ULY)/DivisionsY*1.0);
        Line(ULX,YPos,ULX+TickLengthY,YPos);
        Line(LRX,YPos,LRX-TickLengthY,YPos);
      end;
  End;  { draw graph box }


Procedure AxisLetters;
  Begin
    LetterScale  := 1;
    SetTextStyle(DefaultFont,HorizDir,LetterScale);
    LetterWidth  := TextWidth('0');
    LetterHeight := TextHeight('0');
  End;  { init graphs }


Procedure LabelXAxis;
  Begin
    SetColor(GraphCol.Text);
    SetBkColor(GraphCol.Back);
    YPos := LRY + LetterHeight ;
    OutTextXY(round(ULX + 0*(LRX-ULX)/6.0 -LetterWidth/2.0),YPos,'0');
    OutTextXY(round(ULX + 1*(LRX-ULX)/6.0 -LetterWidth/2.0),YPos,'4');
    OutTextXY(round(ULX + 2*(LRX-ULX)/6.0 -LetterWidth/2.0),YPos,'8');
    OutTextXY(round(ULX + 3*(LRX-ULX)/6.0 -LetterWidth/1.0),YPos,'12');
    OutTextXY(round(ULX + 4*(LRX-ULX)/6.0 -LetterWidth/1.0),YPos,'16');
    OutTextXY(round(ULX + 5*(LRX-ULX)/6.0 -LetterWidth/1.0),YPos,'20');
    OutTextXY(round(ULX + 6*(LRX-ULX)/6.0 -LetterWidth/1.0),YPos,'24');
  End;  { label x axis }


Procedure LabelYAxis;
  Begin
    SetColor(GraphCol.Text);
    SetBkColor(GraphCol.Back);
    XPos := ULX - round(5.5 * LetterWidth);
    for j := 0 to DivisionsY do
      begin
        YVal := j*ScaleMax[GraphParNo]/(1.0*DivisionsY);
        if ScaleMax[GraphParNo] > 10
          then Str(YVal:5:0,LabelY)
          else Str(YVal:5:1,LabelY);
        YPos := LRY - j*(LRY-ULY) div DivisionsY - LetterHeight div 2;
        OutTextXY(XPos,YPos,LabelY);
      end;
  End;  { label y axis }


Procedure NameAxes;
var
 YTextLength : integer;
  Begin
    SetColor(GraphCol.Text);
    SetBkColor(GraphCol.Back);
    SetUserCharSize(4,5,1,2);
    SetTextStyle(TriplexFont,HorizDir,UserCharSize);
    LetterWidth := TextWidth('0');
    LetterHeight := TextHeight('0');
    XPos := (ULX + LRX) div 2 - TextWidth('TIME (hours)') div 2;
    YPos := LRY + trunc(1.5 * LetterHeight);
    OutTextXY(XPos,YPos,'TIME (hours)');
    SetUserCharSize(4,4,1,16);
    SetTextStyle(TriplexFont,VertDir,UserCharSize);
    XPos := ULX - 4 * LetterWidth;
    NameLength := TextWidth(ShortName[GraphParNo]);
    SetUserCharSize(2,4,2,4);
    SetTextStyle(TriplexFont,VertDir,UserCharSize);
    UnitLength := TextWidth('  ('+Units[GraphParNo]+' )');
    YPos := (ULY + LRY) div 2 + (NameLength + UnitLength) div 2 - NameLength;
    SetUserCharSize(4,4,1,1);
    SetTextStyle(TriplexFont,VertDir,UserCharSize);
    OutTextXY(XPos,YPos,ShortName[GraphParNo]);
    YPos := (ULY + LRY) div 2 - (NameLength + UnitLength) div 2 ;
    SetUserCharSize(2,4,2,4);
    SetTextStyle(TriplexFont,VertDir,UserCharSize);
    OutTextXY(XPos,YPos,'  ('+Units[GraphParNo]+' )');
  End;  { init graphs }


Procedure Heading;
  Begin
    SetColor(GraphCol.Text);
    SetBkColor(GraphCol.Back);
    SetUserCharSize(1,1,2,3);
    SetTextStyle(TriplexFont,HorizDir,UserCharSize);
    LetterWidth := TextWidth('0');
    LetterHeight := TextHeight('0');
    XPos := (ULX + LRX) div 2 - TextWidth('DIURNAL  RESPONSE') div 2;
    YPos := ULY - trunc(1.5 * LetterHeight);
    OutTextXY(XPos,YPos,'DIURNAL  RESPONSE');
  End;  { of heading }


Procedure ReactorNos;
  Begin
    SetUserCharSize(4,6,1,2);
    SetTextStyle(TriplexFont,HorizDir,UserCharSize);
    LetterWidth := TextWidth('0');
    LetterHeight := TextHeight('0');
  End;  { of ReactorNos }


Procedure PlotData;
  Begin
    SetBkColor(GraphCol.Back);
    ReactorNos;
    for k := 1 to LastReactor do
      begin
        SetColor(GraphCol.Line[k]);
        j := 0;
        X1 := ULX;
        Y1 := LRY - round(Response[k]^[GraphParNo,j]
                      * (LRY-ULY)/ScaleMax[GraphParNo]);
        if Y1 < ULY Then Y1 := ULY;
        Repeat
          j := j+1;
          X2 := ULX + round(j * DataIntHours*(LRX-ULX)/XAxisRange);
          Y2 := LRY - round(Response[k]^[GraphParNo,j]
                        * (LRY-ULY)/ScaleMax[GraphParNo]);
          if Y2 < ULY Then Y2 := ULY;
          Line(X1,Y1,X2,Y2);
          if j = 4 * k then
            begin
              Str(k:2,LabelY);
              OutTextXY(X2,Y2 - LetterHeight - GetMaxY div 80,LabelY);
            end;
          X1 := X2;
          Y1 := Y2;
        Until j = DataPerDay;
      end;
    End;  { plot data }


Procedure PrintCopy;
  Begin
    SetColor(GraphCol.Text);
    SetBkColor(GraphCol.Back);
    MoveTo(round(0.70*GetMaxX),round(0.95*GetMaxY));
    SetTextStyle(DefaultFont,HorizDir,1);
    OutText('Hardcopy? Y/N... ');
    repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
    If UpCase(YesNo) = 'Y' then
     begin
      SetColor(GraphCol.Back);
      MoveTo(round(0.70*GetMaxX),round(0.95*GetMaxY));
      SetTextStyle(DefaultFont,HorizDir,1);
      OutText('Hardcopy? Y/N... ');
      DumpPlot;
      SetColor(GraphCol.Text);
     end;
  End;  { of PrintCopy }


Begin  { of PlotGraph }

 ClrScr;
 GraphicsVariable;
 InitGraph(GraphDriver,GraphMode,'');
 ErrorCode := GraphResult;
 if ErrorCode <> grOK then
  begin
   ClrScr;
   GotoXY(20,11);
   write('Graphics error - ', GraphErrorMsg(ErrorCode));
   GotoXY(20,13);
   write('You probably have no graphics card!');
   Delay(2000);
   Exit;
  end;

 InitGraphDims;
 DrawGraphBox;
 Heading;
 AxisLetters;
 LabelXAxis;
 LabelYAxis;
 NameAxes;
 PlotData;
 PrintCopy;

 CloseGraph;

End;  { of PlotGraph }