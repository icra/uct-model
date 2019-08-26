Procedure ScaleValues;
  Begin
    for k := 1 to LastReactor+1 do
      for i := 1 to Compounds do
        if C[k,i] = 0.0 then Scale[Compounds * (k-1) + i] := 1.0
                        else Scale[Compounds * (k-1) + i] := 1/C[k,i];
  End;  { scale values }
