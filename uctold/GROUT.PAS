Procedure SelectedGraphParameters;

Begin
  TextColor(SelectBoxCol.Frame);
  TextBackground(SelectBoxCol.Back);
  FrameInstructions(40,1,78,10);
  TextColor(SelectBoxCol.Text);
  Window(41,2,77,9);
  ClrScr;
  GoToXY(6,2);
  ReverseVideo(MainBoxCol);
  write('SELECTED PLOTTING OUTPUTS');
  NormalVideo(MainBoxCol);
  GoToXY(4,5);
  write(ShortName[GraphParNo]);
  if LastReactor > 1 Then write(' in all reactors');
  Window(1,1,80,25);
End;  { selected parameters }


Procedure GraphicsVariable;

Var
  Remove,Replace     : Integer;

Begin

  DiurnalOutputOptions;
  SelectedGraphParameters;
  TextColor(InputBoxCol.Frame);
  TextBackground(InputBoxCol.Back);
  FrameInstructions(40,12,78,23);

  repeat
    TextColor(InputBoxCol.Text);
    TextBackground(InputBoxCol.Back);
    Window(41,13,77,22);
    ClrScr;
    GoToXY(3,2);
    write('Change this selection? Y/N... ');
    Repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
    if UpCase(YesNo) = 'Y' then
      begin
        repeat
          GoToXY(3,4);
          ClrEol;
          write('Change to Parameter No. ');
          Readln(GraphParNo);
        until GraphParNo in [1..NoDiVars];
        Window(41,2,77,9);
        TextColor(SelectBoxCol.Text);
        TextBackground(SelectBoxCol.Back);
        GoToXY(4,5);
        ClrEol;
        write(ShortName[GraphParNo]);
        if LastReactor > 1 then write(' in all reactors');
      end;

  until UpCase(YesNo) = 'N';
  Window(1,1,80,25);
  GraphicsMenu.CurrentOption := 3;

End;  { graphics variable }
