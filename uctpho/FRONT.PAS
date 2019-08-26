Procedure FrontPage;

  Var
   StartX,StartY   :Integer;

PROCEDURE FrameHeading(UpperLeftX,UpperLeftY,LowerRightX,LowerRightY:Integer);
{ The  border is specified by the Top LH and Lower RH points }

Var   I,J  :Integer;

BEGIN
  Window(1,1,80,25);
  GotoXY(UpperLeftX+1, UpperLeftY);
  for I := (UpperLeftX + 1) to (LowerRightX - 1) do
  begin
    Write(chr(223));
  end;
  for I := UpperLeftY to LowerRightY do
  begin
    GotoXY(UpperLeftX , I);  Write(chr(219));
    GotoXY(LowerRightX, I);  Write(chr(219));
  end;
  GotoXY(UpperLeftX+1, LowerRightY);
  for I := (LowerRightX - 1) downto (UpperLeftX + 1) do
  begin
    Write(chr(220));
  end;
  QuickBox(UpperLeftX+1,UpperLeftY+1,LowerRightX-1,LowerRightY-1);
END; { Frame heading }

procedure Two;
begin
 write(chr(219));
 write(chr(219));
end;

procedure FourBottom;
begin
 for i := 1 to 4 do write(chr(220));
end;

procedure FourTop;
begin
 for i := 1 to 4 do write(chr(223));
end;

procedure Eight;
begin
 for i := 1 to 8 do write(chr(219));
end;

Begin
  TextColor(FrontCol.Frame);
  TextBackground(FrontCol.Back);
  FrameHeading(4,2,77,18);
  TextColor(FrontCol.Text);
  StartX := 3;
  StartY := 2;
  GoToXY(StartX,StartY);  { first row }
  Two;                           { U }
  GoToXY(StartX+6,StartY);
  Two;                           { U }
  GoToXY(StartX+12,StartY);
  Eight;                         { C }
  GoToXY(StartX+24,StartY);
  Eight;                         { T }
  GoToXY(StartX+36,StartY);
  Eight;                         { P }
  GoToXY(StartX+48,StartY);
  Two;                           { H }
  GoToXY(StartX+54,StartY);
  Two;                           { H }
  GoToXY(StartX+60,StartY);
  Eight;                         { O }
  GoToXY(StartX,StartY+1);  { second row }
  Two;                           { U }
  GoToXY(StartX+6,StartY+1);
  Two;                           { U }
  GoToXY(StartX+12,StartY+1);
  Two;                           { C }
  GoToXY(StartX+27,StartY+1);
  Two;                           { T }
  GoToXY(StartX+36,StartY+1);
  Two;                           { P }
  GoToXY(StartX+42,StartY+1);
  Two;                           { P }
  GoToXY(StartX+48,StartY+1);
  Two;                           { H }
  GoToXY(StartX+54,StartY+1);
  Two;                           { H }
  GoToXY(StartX+60,StartY+1);
  Two;                           { O }
  GoToXY(StartX+66,StartY+1);
  Two;                           { O }
  GoToXY(StartX,StartY+2);  { third row }
  Two;                           { U }
  GoToXY(StartX+6,StartY+2);
  Two;                           { U }
  GoToXY(StartX+12,StartY+2);
  Two;                           { C }
  GoToXY(StartX+27,StartY+2);
  Two;                           { T }
  GoToXY(StartX+36,StartY+2);
  Eight;                         { P }
  GoToXY(StartX+48,StartY+2);
  Eight;                         { H }
  GoToXY(StartX+60,StartY+2);
  Two;                           { O }
  GoToXY(StartX+66,StartY+2);
  Two;                           { O }
  GoToXY(StartX,StartY+3);  { fourth row }
  Two;                           { U }
  GoToXY(StartX+6,StartY+3);
  Two;                           { U }
  GoToXY(StartX+12,StartY+3);
  Two;                           { C }
  GoToXY(StartX+27,StartY+3);
  Two;                           { T }
  GoToXY(StartX+36,StartY+3);
  Two;                           { P }
  GoToXY(StartX+48,StartY+3);
  Two;                           { H }
  GoToXY(StartX+54,StartY+3);
  Two;                           { H }
  GoToXY(StartX+60,StartY+3);
  Two;                           { O }
  GoToXY(StartX+66,StartY+3);
  Two;                           { O }
  GoToXY(StartX,StartY+4);  { fifth row }
  Eight;                          { U }
  GoToXY(StartX+12,StartY+4);
  Eight;                          { C }
  GoToXY(StartX+27,StartY+4);
  Two;                            { T }
  GoToXY(StartX+36,StartY+4);
  Two;                            { P }
  GoToXY(StartX+48,StartY+4);
  Two;                            { H }
  GoToXY(StartX+54,StartY+4);
  Two;                            { H }
  GoToXY(StartX+60,StartY+4);
  Eight;                          { O }

  GoToXY(StartX+3,StartY+7);
  ReverseVideo(FrontCol);
  write('NDBEPR SIMULATION PROGRAM (UCTOLD VERSION) - VERSION 1.0');
  GoToXY(StartX+1,StartY+9);
  NormalVideo(FrontCol);
  write('COPYRIGHT - University of Cape Town - All Rights Reserved Worldwide');
  GoToXY(StartX+8,StartY+11);
  write('Disk may be copied but not offered for lease or sale');
  GoToXY(StartX+24,StartY+12);
  write('in part or in full.');
  Window(1,1,80,25);

  StartX := 4;
  StartY := 20;
  GoToXY(StartX,StartY);
  write(chr(201));
  for i := 1 to 31 do write(chr(205));
  write(chr(187));
  GoToXY(StartX,StartY+1);
  write(chr(186),' Depts Civil/Chemical Eng.     ',chr(186));
  GoToXY(StartX,StartY+2);
  write(chr(186),' University of Cape Town       ',chr(186));
  GoToXY(StartX,StartY+3);
  write(chr(186),' Rondebosch 7700  South Africa ',chr(186));
  GoToXY(StartX,StartY+4);
  write(chr(200));
  for i := 1 to 31 do write(chr(205));
  write(chr(188));

  StartX := 45;
  StartY := 20;
  GoToXY(StartX,StartY);
  write(chr(201));
  for i := 1 to 31 do write(chr(205));
  write(chr(187));
  GoToXY(StartX,StartY+1);
  write(chr(186),' Program written by Peter Dold ',chr(186));
  GoToXY(StartX,StartY+2);
  write(chr(186),'      in association with      ',chr(186));
  GoToXY(StartX,StartY+3);
  write(chr(186),' M C Wentzel and  G vR Marais  ',chr(186));
  GoToXY(StartX,StartY+4);
  write(chr(200));
  for i := 1 to 31 do write(chr(205));
  write(chr(188));

  Delay(500);
  repeat until keypressed;
  Key := ReadKey;
End;  {* front page *}
