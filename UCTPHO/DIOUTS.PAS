Procedure DiurnalOutputOptions;

Begin
  TextColor(MainBoxCol.Frame);
  TextBackground(MainBoxCol.Back);
  FrameInstructions(1,1,36,25);
  Window(1,1,36,25);
  TextColor(MainBoxCol.Text);
  GoToXY(4,1);
  ReverseVideo(MainBoxCol);
  write('POSSIBLE OUTPUT PARAMETERS');
  NormalVideo(MainBoxCol);
  For i := 1 to (TotalCompounds - 1) do
    begin
      GoToXY(2,i+1);
      ReverseVideo(MainBoxCol);
      write(i:2);
      NormalVideo(MainBoxCol);
      write(' ',Compound[i],Units[i]);
    end;
  GoToXY(2,20);
      ReverseVideo(MainBoxCol);
      write('19');
      NormalVideo(MainBoxCol);
  write(' OUR carb','    g O2 m-3 h-1');
  GoToXY(2,21);
      ReverseVideo(MainBoxCol);
      write('20');
      NormalVideo(MainBoxCol);
  write(' OUR nitr','    g O2 m-3 h-1');
  GoToXY(2,22);
      ReverseVideo(MainBoxCol);
      write('21');
      NormalVideo(MainBoxCol);
  write(' OUR tot','     g O2 m-3 h-1');
  GoToXY(2,23);
      ReverseVideo(MainBoxCol);
      write('22');
      NormalVideo(MainBoxCol);
  write(' Volatile solids','   g VSS m-3');
  GoToXY(2,24);
      ReverseVideo(MainBoxCol);
      write('23');
      NormalVideo(MainBoxCol);
  write(' TKN            ','   g N m-3');
  Window(1,1,80,25);

End;  {* output menu *}

