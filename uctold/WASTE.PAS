Procedure WastageAndFlows;
Var WasteTemp:real;

  Procedure WasteTitles;
    Begin
      ClrScr;
      AssignCrt(OutFile);
      Rewrite(OutFile);
      write(OutFile,Chr(201));
      for k := 1 to 70 do write(OutFile,Chr(205)); writeln(OutFile,Chr(187));
      write(Chr(186),'    Iterative Wastage Rate Calculation');
      writeln('                  Wastage rate  ',Chr(186));
      write(OutFile,Chr(200));
      for k := 1 to 70 do write(OutFile,Chr(205)); writeln(OutFile,Chr(188));
      writeln;
    End; { waste titles }

  Procedure SeedWaste;
    Begin
      FlowWaste := VolumeTotal/Rs;    { initial estimate - only }
                                      { correct if RAS recycle  }
                                      { to first reactor        }
      TracerConcIn := 100.0;
      Tracer[0] := 0.0;
      for k := 1 to LastReactor do
        Tracer[k] := FlowFeed*TracerConcIn*Rs/VolumeTotal;
      Tracer[LastReactor+1] := (FlowFeed+FlowRASrecycle-FlowWaste)/FlowRASrecycle
                                   *Tracer[LastReactor];
    End; { seed waste }

    Begin  { wastage and flows }
      WasteTitles;
      SeedWaste;
      Repeat
        FlowWastePrevious := FlowWaste;
        FlowDivisionSS;
        for k := 1 to LastReactor+1 do
          C[k,1] := Tracer[k];
        ScaleValues(1);
        Newton(1);
        for k := 1 to LastReactor+1 do
          Tracer[k] := C[k,1];
        MassTracer := 0.0;
        for k := 1 to LastReactor do
          MassTracer := MassTracer+Tracer[k]*Vol[k];
        FlowWaste := (MassTracer/Rs)/Tracer[LastReactor];
      Until(ABS(FlowWaste-FlowWastePrevious)/FlowWaste) < 0.0001;
      GoToXY(20,13);
      WasteTemp:=FlowWaste*ScaleFactor;
      write ('Wastage rate = ',WasteTemp:8:3);
      Delay(2000);
      FlowWasteAvg := FlowWaste;
    End; { wastage and flows }
