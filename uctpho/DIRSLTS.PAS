Procedure DiRslts;
  Begin
    TextColor(PrBoxCol.Frame);
    TextBackground(PrBoxCol.Back);
    FrameInstructions(8,10,73,18);
    TextColor(PrBoxCol.Text);
    msg('Do you want a hardcopy of diurnal results ? Y/N...',6,4);
    repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
    If UpCase(YesNo) = 'Y' then
      begin
        assign(OutFile,'PRN');
        rewrite(OutFile);
        for i := 1 to 3 do writeln(OutFile);
        OutputIntHours := DataIntHours;
        OutputDiurnalResponse;
        for i := 1 to 5 do writeln(OutFile);
        close(OutFile);
      end;
    Window(1,1,80,25);
  End;  { diurnal results }
