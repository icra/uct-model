Procedure TempAdjustment;

function Power(B,X : real) : real;
 begin Power := Exp (X * ln(B)); end;

  Begin
    TempDiff:=Temp-20.0;
    MuHatHetero:=MuHatHetero20 * Power(ThetaMuHatH,TempDiff);
    Ks:=Ks20 * Power(ThetaKs,TempDiff);
    Bh:=Bh20 * Power(ThetaBh,TempDiff);
    Kmp:=Kmp20 * Power(ThetaKmp,TempDiff);
    Ksp:=Ksp20 * Power(ThetaKsp,TempDiff);
    Ka:=Ka20 * Power(ThetaKa,TempDiff);
    Kr:=Kr20 * Power(ThetaKr,TempDiff);
    MuHatAuto:=MuHatAuto20 * Power(ThetaMuHatA,TempDiff);
    Knh:=Knh20 * Power(ThetaKnh,TempDiff);
    Ba:=Ba20 * Power(ThetaBa,TempDiff);

  End;  {* temp adjustment *}

