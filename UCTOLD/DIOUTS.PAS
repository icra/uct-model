Procedure DiurnalOutputOptions;

Begin
  TextColor(MainBoxCol.Frame);
  TextBackground(MainBoxCol.Back);
  FrameInstructions(2,2,36,25);
  TextColor(MainBoxCol.Text);
  GoToXY(4,2);
  ReverseVideo(MainBoxCol);
  write('POSSIBLE OUTPUT PARAMETERS');
  NormalVideo(MainBoxCol);
  For I := 1 to (TotalCompounds - 1) do
    begin
      GoToXY(2,I+3);
      Write(I:2,' ',Compound[I],Units[I]);
    end;
  GoToXY(2,17);
  Write('14 ','OUR carb','    g O2 m-3 h-1');
  GoToXY(2,18);
  Write('15 ','OUR nitr','    g O2 m-3 h-1');
  GoToXY(2,19);
  Write('16 ','OUR tot','     g O2 m-3 h-1');
  GoToXY(2,20);
  Write('17 ','Volatile solids','   g VSS m-3');
  GoToXY(2,21);
  Write('18 ','TKN            ','   g N m-3');
  Window(1,1,80,25);

End;  {* output menu *}

