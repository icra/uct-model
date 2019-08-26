   PROCEDURE FractionateInfluent;

   Var
    OrgN : real;

    Begin
      For i := 1 to TotalCompounds DO C0[i]:=0;

      C0[1]:=Fxbh*Sti;
      C0[4]:=Fup*Sti;
      C0[6]:=(1.0-Fbs)*(1.0-Fus-Fup-Fxbh)*Sti;

      OrgN := (1.0-Fnaa-Fnu)*Nti-Ixe*Fup*Sti-Ixb*Fxbh*Sti;
      if OrgN < 0 then
       begin
        Fnaa := (Nti - Fnu*Nti - Ixe*Fup*Sti - Ixb*Fxbh*Sti)/Nti;
        OrgN := 0.0;
       end;

      C0[7]:= OrgN * Fnox;       {* Org N split  *}
      C0[10]:= OrgN * (1.0-Fnox); {* soluble/part *}
      C0[8]:=Fbs*(1.0-Fus-Fup)*Sti;
      C0[9]:=Fnaa*Nti;
      C0[11] := 0.044;    { small NO3 for case when Rs < Rsm }
      C0[12]:=Alki;
      C0[13]:=Fus*Sti;

      For i := 1 to TotalCompounds DO
       if C0[i] < 0 then C0[i] := 1.0e-06;

    End;  { fractionate influent }


