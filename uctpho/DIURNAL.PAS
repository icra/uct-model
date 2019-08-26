  Procedure OutputDiurnalResponse;
    Begin
      DeltaData := ROUND(OutputIntHours/DataIntHours);
      For k := 1 to LastReactor do
        begin
          writeln(OutFile); writeln(OutFile);
          writeln(OutFile,'  *****  DIURNAL RESPONSE RESULTS *****');
          TimeOfData := -OutputIntHours;
          DataNo := -DeltaData;
          writeln(OutFile); writeln(OutFile);
          writeln(OutFile,'Reactor ',k,'          Cycle number ',CycleNo);
          writeln(OutFile);
          write(OutFile,'  TIME');
          for i := 1 to 10 do
            write(OutFile,ShortName[ListParNo[i]]:7);
          writeln(OutFile); writeln(OutFile);

          while DataNo < DataPerDay do
            begin
              DataNo := DataNo+DeltaData;
              TimeOfData := TimeOfData+OutputIntHours;
              write(OutFile,TimeOfData:6:1);
              for i := 1 to 10 do
                write(OutFile,Response[k]^[ListParNo[i],DataNo]:7:1);
              writeln(OutFile);
            end;
        end;
      writeln(OutFile);writeln(OutFile);
    End;  { output diurnal response }


  Procedure StoreResponse(DataNo : integer);
    Begin
      for k := 1 to LastReactor do
        begin
          for i := 1 to (TotalCompounds - 1) do Response[k]^[i,DataNo]:=C[k,i];
          Response[k]^[19,DataNo] := Oc[k];
          Response[k]^[20,DataNo] := On[k];
          Response[k]^[21,DataNo] := Ot[k];
          Response[k]^[22,DataNo] := 0.0;
          for j := 1 to 8 do Response[k]^[22,DataNo]
                              := Response[k]^[22,DataNo] + C[k,j]/CODVSS;
          Response[k]^[23,DataNo] := C[k,13]+C[k,14]+Fnous*Nti;
        end;
    End;  { store response }


  Procedure Diurnal;

  Var  L,m : integer;

    Begin

      ClrScr;
      InflowIntHours := 24.0/NoDiurnalInts; { influent data increment time }
      IntegIntDays := DataIntHours/24.0;
      DeltaTlarge := DataIntHours/60/24;      { initialise DeltaTlarge }
      DeltaTsmall := DeltaTlarge/5;   { initialise DeltaTsmall }
      TruncatedLarge := False;
      TruncatedSmall := False;

      for i := FirstSlow to LastRapid do
        if C[1,i] <> 0.0
          then Epsilon[i] := C[1,i]*Accuracy/100
          else Epsilon[i] := 1.0e06;

      Steps := ROUND(InflowIntHours/DataIntHours);
      DataPerDay := ROUND(24/DataIntHours);
      CycleNo := 0;

      repeat
        CycleNo := CycleNo+1;
        DataNo := 0;
        UtilizationRates;
        StoreResponse(0);
        GotoXY(27,24);
        TextColor(PrBoxCol.Text);
        Write('Integration time =');

        for L := 1 to NoDiurnalInts do
          begin
            FlowFeed := DynamicFlow[L];
            WastageRate := FlowWaste[L];
            Sti := DynamicSti[L];
            Nti := DynamicNti[L];
            Pti := DynamicPti[L];
            FractionateInfluent;
            FlowDivision;
            AirSupply;

            for m := 1 to Steps do
              begin
                IntegTime := (L-1)*InflowIntHours + (m-1)*DataIntHours;
                DataNo := DataNo+1;
                Integrate;
                UtilizationRates;
                StoreResponse(DataNo);
              end;
          end;

        OutputIntHours := 2.0;
        AssignCrt(OutFile);
        Rewrite(OutFile);
        TextBackground(MenuCol.Back);
        TextColor(MenuCol.Text);
        ClrScr;
        OutputDiurnalResponse;
        Close(OutFile);

      If (ABS(Response[1]^[1,DataPerDay])<0.01) and (ABS(Response[1]^[1,0])<0.01)
        Then Response[1]^[1,DataPerDay]:=Response[1]^[1,0];

      If (ABS(Response[1]^[2,DataPerDay])<0.01) and (ABS(Response[1]^[2,0])<0.01)
         Then Response[1]^[2,DataPerDay]:=Response[1]^[2,0];

      If (ABS(Response[1]^[3,DataPerDay])<0.01) and (ABS(Response[1]^[3,0])<0.01)
        Then Response[1]^[3,DataPerDay]:=Response[3]^[1,0];

      until (ABS(Response[1]^[1,DataPerDay]/Response[1]^[1,0]-1.0) < 0.005) AND
            (ABS(Response[1]^[2,DataPerDay]/Response[1]^[2,0]-1.0) < 0.005) AND
            (ABS(Response[1]^[3,DataPerDay]/Response[1]^[3,0]-1.0) < 0.005) AND
            (CycleNo > 1) ;

      write('*** Dynamic solution reached...Hit any key to continue...');
      repeat until KeyPressed;
      Key := ReadKey;

      SetAvgInputs;   { restore average input concs, flows, etc }
      for k := 1 to LastReactor do  { restore SS concentrations }
        for i := 1 to (TotalCompounds-1) do C[k,i] := CSteady[k,i];

    End; { diurnal }

