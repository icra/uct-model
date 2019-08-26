  Procedure FlowDivisionSS;
    Begin
      FlowFromPrevious[1]:=0.0;
      For k := 1 to LastReactor do
        begin
          FlowInTotal[k]:=FlowFromPrevious[k]
                    +FlowRASrecycle*FlagRASIn[k]
                    +FlowArecycle*FlagAIn[k]
                    +FlowBrecycle*FlagBIn[k]
                    +FlowFeed*FracFeed[k];

          FlowFromPrevious[k+1]:=FlowInTotal[k]
                                -FlowArecycle*FlagAOut[k]
                                -FlowBrecycle*FlagBOut[k];
        end;
          FlowFromPrevious[LastReactor+1] :=
                FlowFeed + FlowRASrecycle - FlowWaste;
          FlowInTotal[LastReactor+1] := FlowRASrecycle;
    End; {* flow division *}
