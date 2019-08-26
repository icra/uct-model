  Procedure OutputSteadyState;

    Procedure RowWriter;
      Begin   { row writer }
        write(OutFile,C0[j]:6:1);
        for k := 1 to LastReactor do write(OutFile,C[k,j]:7:1);
      End; { row writer }

    Begin   { steady state output }
      ClrScr;
      write(OutFile,'  *****  STEADY STATE RESULTS *****',
                    '              Inversions = ',Inversions);
      writeln(OutFile);
      writeln(OutFile,'COMPOUND              INPUT           REACTOR');
      write(OutFile,'                                ');
      for k := 1 to LastReactor do write(OutFile,k:2,'     ');writeln(OutFile);
      for j := 1 to (TotalCompounds - 1) do
        begin
          write(OutFile,Compound[j],' =  ');
          RowWriter;
          writeln(OutFile,Units[j]);
        end;
      for k := 1 to LastReactor do
        begin
          XvTot[k]:=0.0;
          for i := 1 to 6 do XvTot[k] := XvTot[k]+C[k,i]/CODVSS;
        end;
      UtilizationRates;
      write(OutFile,'Volatile SS         =        ');
      for k := 1 to LastReactor do write(OutFile,XvTot[k]:7:1);
      write(OutFile,' g VSS m-3 '); writeln(OutFile);
      write(OutFile,'OUR carbonaceous    =        ');
      for k := 1 to LastReactor do write(OutFile,Oc[k]:7:1);
      write(OutFile,' g O2 m-3 h-1 '); writeln(OutFile);
      write(OutFile,'OUR autotrophs      =        ');
      for k := 1 to LastReactor do write(OutFile,On[k]:7:1);
      write(OutFile,' g O2 m-3 h-1 '); writeln(OutFile);
      write(OutFile,'OUR total           =        ');
      for k := 1 to LastReactor do write(OutFile,Ot[k]:7:1);
      write(OutFile,' g O2 m-3 h-1 '); writeln(OutFile);
      write(OutFile,'Denit. rate         =        ');
      for k := 1 to LastReactor do write(OutFile,Denit[k]:7:1);
      writeln(OutFile,' g NO3-N m-3 h-1 ');
  End; { steady state output }

Procedure SteadyStateResults;
  Begin
    TextColor(PrBoxCol.Frame);
    TextBackground(PrBoxCol.Back);
    FrameInstructions(8,10,73,18);
    TextColor(PrBoxCol.Text);
    msg('Do you want a hardcopy of steady state results ? Y/N...',2,4);
    repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
    If UpCase(YesNo) = 'Y' then
      begin
        assign(OutFile,'PRN');
        rewrite(OutFile);
        for i := 1 to 3 do writeln(OutFile);
        OutputSteadyState;
        for i := 1 to 5 do writeln(OutFile);
        close(OutFile);
      end;
    Window(1,1,80,25);
  End;  { steady state results - hardcopy }
