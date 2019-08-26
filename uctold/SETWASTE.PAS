Procedure SetWaste;
  Begin
    NoWasteInts := NoDiurnalInts;    { set up initial wastage pattern }
    for i := 1 to NoDiurnalInts do
      if DynamicFlow[i] > FlowWasteAvg
              then WastageOn[i] := true
              else
                begin
                  NoWasteInts  := NoWasteInts - 1;
                  WastageOn[i] := false;
                end;
    for i := 1 to NoDiurnalInts do
      if  WastageOn[i] then FlowWaste[i] := FlowWasteAvg*12/NoWasteInts
                       else FlowWaste[i] := 0.0;
  End;
