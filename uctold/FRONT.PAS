Procedure FrontPage;

  Var
   StartX,StartY   :integer;

  Procedure FrameHeading(UpperLeftX,UpperLeftY,LowerRightX,LowerRightY:integer);
  { The  border is specified by the Top LH and Lower RH points }

    Var   i  :integer;

    Begin
      Window(1,1,80,25);
      GotoXY(UpperLeftX+1, UpperLeftY);
      for i := (UpperLeftX + 1) to (LowerRightX - 1) do
        begin
          Write(chr(223));
        end;
      for i := UpperLeftY to LowerRightY do
        begin
          GotoXY(UpperLeftX , i);  Write(chr(219));
          GotoXY(LowerRightX, i);  Write(chr(219));
        end;
      GotoXY(UpperLeftX+1, LowerRightY);
      for i := (LowerRightX - 1) downto (UpperLeftX + 1) do
        begin
          Write(chr(220));
        end;
      QuickBox(UpperLeftX+1,UpperLeftY+1,LowerRightX-1,LowerRightY-1);
    End; { frame heading }

  Procedure Two;
    begin
      write(chr(219));
      write(chr(219));
    end;

  Procedure FourBottom;
    begin
      for i := 1 to 4 do write(chr(220));
    end;

  Procedure FourTop;
    begin
      for i := 1 to 4 do write(chr(223));
    end;

  Procedure Eight;
    begin
      for i := 1 to 8 do write(chr(219));
    end;

Begin  { front page }
  TextColor(FrontCol.Frame);
  TextBackground(FrontCol.Back);
  FrameHeading(4,1,77,17);
  TextColor(FrontCol.Text);

  StartX := 3;
  StartY := 2;
  GoToXY(StartX,StartY);  { first row }
  Two;
  GoToXY(StartX+6,StartY);
  Two;
  GoToXY(StartX+12,StartY);
  Eight;
  GoToXY(StartX+24,StartY);
  Eight;
  GoToXY(StartX+36,StartY);
  Eight;
  GoToXY(StartX+48,StartY);
  Two;
  GoToXY(StartX+60,StartY);
  Eight;
  GoToXY(StartX,StartY+1);  { second row }
  Two;
  GoToXY(StartX+6,StartY+1);
  Two;
  GoToXY(StartX+12,StartY+1);
  Two;
  GoToXY(StartX+27,StartY+1);
  Two;
  GoToXY(StartX+36,StartY+1);
  Two;
  GoToXY(StartX+42,StartY+1);
  Two;
  GoToXY(StartX+48,StartY+1);
  Two;
  GoToXY(StartX+62,StartY+1);
  Two;
  GoToXY(StartX+66,StartY+1);
  Two;
  GoToXY(StartX,StartY+2);  { third row }
  Two;
  GoToXY(StartX+6,StartY+2);
  Two;
  GoToXY(StartX+12,StartY+2);
  Two;
  GoToXY(StartX+27,StartY+2);
  Two;
  GoToXY(StartX+36,StartY+2);
  Two;
  GoToXY(StartX+42,StartY+2);
  Two;
  GoToXY(StartX+48,StartY+2);
  Two;
  GoToXY(StartX+62,StartY+2);
  Two;
  GoToXY(StartX+66,StartY+2);
  Two;
  GoToXY(StartX,StartY+3);  { fourth row }
  Two;
  GoToXY(StartX+6,StartY+3);
  Two;
  GoToXY(StartX+12,StartY+3);
  Two;
  GoToXY(StartX+27,StartY+3);
  Two;
  GoToXY(StartX+36,StartY+3);
  Two;
  GoToXY(StartX+42,StartY+3);
  Two;
  GoToXY(StartX+48,StartY+3);
  Two;
  GoToXY(StartX+62,StartY+3);
  Two;
  GoToXY(StartX+66,StartY+3);
  Two;
  GoToXY(StartX,StartY+4);  { fifth row }
  Eight;
  GoToXY(StartX+12,StartY+4);
  Eight;
  GoToXY(StartX+27,StartY+4);
  Two;
  GoToXY(StartX+36,StartY+4);
  Eight;
  GoToXY(StartX+48,StartY+4);
  Eight;
  GoToXY(StartX+60,StartY+4);
  Eight;

  GoToXY(StartX+3,StartY+7);
  ReverseVideo(FrontCol);
  write(' ACTIVATED SLUDGE SYSTEM SIMULATION PROGRAM - DECEMBER 1990 ');
  GoToXY(StartX+1,StartY+9);
  NormalVideo(FrontCol);
  write('COPYRIGHT - University of Cape Town - All Rights Reserved Worldwide');
  GoToXY(StartX+8,StartY+11);
  write('Disk may be copied but not offered for lease or sale');
  GoToXY(StartX+24,StartY+12);
  write('in part or in full.');
  Window(1,1,80,25);

  StartX := 4;
  StartY := 19;
  GoToXY(StartX,StartY);
  write(chr(201));
  for i := 1 to 31 do write(chr(205));
  write(chr(187));
  GoToXY(StartX,StartY+1);
  write(chr(186),' Depts Chemical/Civil Eng.     ',chr(186));
  GoToXY(StartX,StartY+2);
  write(chr(186),' University of Cape Town       ',chr(186));
  GoToXY(StartX,StartY+3);
  write(chr(186),' Rondebosch 7700  South Africa ',chr(186));
  GoToXY(StartX,StartY+4);
  write(chr(200));
  for i := 1 to 31 do write(chr(205));
  write(chr(188));

  StartX := 45;
  StartY := 19;
  GoToXY(StartX,StartY);
  write(chr(201));
  for i := 1 to 31 do write(chr(205));
  write(chr(187));
  GoToXY(StartX,StartY+1);
  write(chr(186),' Program written by P Dold,    ',chr(186));
  GoToXY(StartX,StartY+2);
  write(chr(186),'   A Billing, M Wentzel,       ',chr(186));
  GoToXY(StartX,StartY+3);
  write(chr(186),'   G Ekama and G Marais.       ',chr(186));
  GoToXY(StartX,StartY+4);
  write(chr(200));
  for i := 1 to 31 do write(chr(205));
  write(chr(188));

  GoToXY(55,25);
  write('Hit key to continue...');
  repeat until KeyPressed;
  Key := ReadKey;
End;  {* front page *}

