Procedure SelectedPrintParameters;

Begin
  TextColor(MainBoxCol.Frame);
  TextBackground(MainBoxCol.Back);
  FrameInstructions(40,2,70,15);
  TextColor(MainBoxCol.Text);
  GoToXY(8,1);
  ReverseVideo(MainBoxCol);
  Write('SELECTED OUTPUTS');
  NormalVideo(MainBoxCol);

  for i := 1 to 10 do
    begin
      GoToXY(11,i+2);
      Write(i:2,'    ',ShortName[ListParNo[i]]);
    end;
  Window(1,1,80,25);

End;  { selected parameters }


Procedure CheckSelection;

Var
  Remove,Replace     : integer;

Begin

  DiurnalOutputOptions;
  SelectedPrintParameters;
  TextColor(InputBoxCol.Frame);
  TextBackground(InputBoxCol.Back);
  FrameInstructions(40,17,78,24);
  repeat
    TextColor(InputBoxCol.Text);
    TextBackground(InputBoxCol.Back);
    Window(41,18,77,23);
    ClrScr;
    GoToXY(3,2);
    Write('Change any of the above ? Y/N... ');
    repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
    if UpCase(YesNo) = 'Y' then
      begin
        repeat
          GoToXY(3,4);
          ClrEol;
          Write('Remove Selection No. ');
          Read(Remove);
        until Remove in [1..10];

        repeat
          GoToXY(3,6);
          ClrEol;
          Write('Replace with Parameter No. ');
          Read(Replace);
        until Replace in [1..NoDiVars];

        ListParNo[Remove] := Replace;
        TextColor(SelectBoxCol.Text);
        TextBackground(SelectBoxCol.Back);
        Window(41,3,69,14);
        GoToXY(11,Remove+2);
        ClrEol;
        Write(Remove:2,'    ',ShortName[ListParNo[Remove]]);

      end;

  until UpCase(YesNo) = 'N';
  Window(1,1,80,25);

End;  { check selection }


