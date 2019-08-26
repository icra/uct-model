Procedure GraphOutputOptions;

Begin
  TextColor(MainBoxCol.Frame);
  TextBackground(MainBoxCol.Back);
  FrameInstructions(1,1,70,22);
  TextColor(MainBoxCol.Text);
  GoToXY(22,1);
  ReverseVideo(MainBoxCol);
  write('POSSIBLE OUTPUT PARAMETERS');
  NormalVideo(MainBoxCol);
  For I := 1 to (TotalCompounds - 1) do
    begin
      GoToXY(2,I+2);
      ReverseVideo(MainBoxCol);
      Write(I:2);
      NormalVideo(MainBoxCol);
      Write(' ',Compound[I],Units[I]);
    end;

  GoToXY(36,3);
  ReverseVideo(MainBoxCol);
  Write('19');
  NormalVideo(MainBoxCol);
  Write(' OUR carb','    g O2 m-3 h-1');
  GoToXY(36,4);
  ReverseVideo(MainBoxCol);
  Write('20');
  NormalVideo(MainBoxCol);
  Write(' OUR nitr','    g O2 m-3 h-1');
  GoToXY(36,5);
  ReverseVideo(MainBoxCol);
  Write('21');
  NormalVideo(MainBoxCol);
  Write(' OUR tot','     g O2 m-3 h-1');
  GoToXY(36,6);
  ReverseVideo(MainBoxCol);
  Write('22');
  NormalVideo(MainBoxCol);
  Write(' Volatile solids','   g VSS m-3');
  GoToXY(36,7);
  ReverseVideo(MainBoxCol);
  Write('23');
  NormalVideo(MainBoxCol);
  Write(' TKN            ','   g N m-3');
  Window(1,1,80,25);

End;  {* output menu *}

