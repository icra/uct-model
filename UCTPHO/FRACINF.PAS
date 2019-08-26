   PROCEDURE FractionateInfluent;

   Var
    OrgN : real;

    Begin
      For i := 1 to TotalCompounds DO C0[i]:=0;

      C0[1] := Fzbh*Sti;
      C0[5] := Fup*Sti;
      C0[7] := (1.0-Fbs)*(1.0-Fus-Fup-Fzbh)*Sti;

      OrgN := (1.0-Fna-Fnous)*Nti-Fzehn*Fup*Sti-Fzbhn*Fzbh*Sti;
      if OrgN < 0 then
       begin
        Fna := (Nti - Fnous*Nti - Fzehn*Fup*Sti - Fzbhn*Fzbh*Sti)/Nti;
        OrgN := 0.0;
       end;

      C0[9]  := OrgN * Fnobp;       {Org N split}
      C0[14]  := OrgN * (1.0-Fnobp); { soluble/part}

      RBCOD := Fbs*(1.0-Fus-Fup)*Sti;
      C0[11] := RBCOD*(1.0-Fac);
      C0[12] := RBCOD*Fac;

      C0[13] := Fna*Nti;
      C0[15] := 0.044;     {small NO3 for case when Rs < Rsm }
      C0[16] := Pti-FupP*Fup*Sti;
      C0[18] := Alki;
      C0[17] := Fus*Sti;

      For i := 1 to TotalCompounds DO
       if C0[i] < 0 then C0[i] := 1.0e-06;

    End;  { fractionate influent }

