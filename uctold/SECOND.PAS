Procedure SecondPage;

  Var
   StartX,StartY,DimNo   :integer;

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

Begin  { second page }
  TextColor(FrontCol.Frame);
  TextBackground(FrontCol.Back);
  FrameHeading(4,3,77,22);

  TextColor(FrontCol.Text);
  StartX := 3;
  StartY := 0;

  GoToXY(StartX+2,StartY+3);
  ReverseVideo(FrontCol);
  write('USER INSTRUCTION ON DIMENSIONS FOR FLOWRATES AND REACTOR VOLUMES');
  NormalVideo(FrontCol);
  GoToXY(StartX+5,StartY+5);
  write('Any consistent pair of dimensions may be used for entering');
  GoToXY(StartX+5,StartY+6);
  write('reactor volumes and flowrates. Select one of the following');
  GoToXY(StartX+5,StartY+7);
  write('pairs:');

  ReverseVideo(FrontCol);
  GoToXY(StartX+9,StartY+9);
  write(' VOLUMES ');
  GoToXY(StartX+20,StartY+9);
  write(' FLOWRATES ');
  NormalVideo(FrontCol);

  GoToXY(StartX+5,StartY+11);
  write('1.      l          l d-1');
  GoToXY(StartX+5,StartY+12);
  write('2.     m3         m3 d-1');
  GoToXY(StartX+5,StartY+13);
  write('3.     Ml         Ml d-1');
  GoToXY(StartX+5,StartY+14);
  write('4.     mg         mg d-1 (mgd)');

  GoToXY(StartX+43,StartY+11);
  write('l  = litres');
  GoToXY(StartX+43,StartY+12);
  write('m3 = cubic metres');
  GoToXY(StartX+43,StartY+13);
  write('Ml = megalitres (1000 m3)');
  GoToXY(StartX+43,StartY+14);
  write('mg = million gallons');

  GoToXY(StartX+10,StartY+17);
  write('Enter selected dimensions (1,2,3 or 4)... ');
  DimNo := GetInteger(1,4);
  case DimNo of
    1: VolType := ' l';
    2: VolType := 'm3';
    3: VolType := 'Ml';
    4: VolType := 'mg';
   end;

  Window(1,1,80,25);

End;  {* second page *}
