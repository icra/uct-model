  Procedure FlowDivision;

    Begin

      FlowFromPrevious[1] := 0.0;
      for k := 1 to LastReactor do
        begin
          FlowInTotal[k] := FlowFromPrevious[k]
                            +FlowRASrecycle*FlagRASIn[k]
                            +FlowArecycle*FlagAIn[k]
                            +FlowBrecycle*FlagBIn[k]
                            +FlowFeed*FracFeed[k];
          FlowFromPrevious[k+1] := FlowInTotal[k]
                                   -FlowArecycle*FlagAOut[k]
                                   -FlowBrecycle*FlagBOut[k];
          DhOut[k] := FlowInTotal[k]/Vol[k];
          DhFromPrevious[k] := FlowFromPrevious[k]/Vol[k];
          DhArecycle[k] := FlowArecycle*FlagAIn[k]/Vol[k];
          DhBRecycle[k] := FlowBrecycle*FlagBIn[k]/Vol[k];
          DhFeed[k] := FlowFeed*FracFeed[k]/Vol[k];
          DhRASpart := (FlowFeed+FlowRASrecycle-WastageRate)*FlagRASIn[k]/Vol[k];
          DhRASsol := FlowRASrecycle*FlagRASIn[k]/Vol[k];
          if FlowRASrecycle = 0.0 then
            begin
              DhRASpart := 0.0;
              DhRASsol  := 0.0;
            end;
          for i := 1 to (TotalCompounds-1) do
            if i > NoPart then DhRAS[k,i] := DhRASsol
                          else DhRAS[k,i] := DhRASpart;
        end;

    End; { flow division }

