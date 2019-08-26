Procedure TempAdjustment;

function Power(B,X : real) : real;
 begin Power := Exp (X * ln(B)); end;

  Begin
    TempDiff:=Temp-20.0;
    MuHatHetero:=MuHatHetero20 * Power(ThetaMuHatH,TempDiff);
    Ksh:=Ksh20 * Power(ThetaKsh,TempDiff);
    Bh:=Bh20 * Power(ThetaBh,TempDiff);
    KmpA:=KmpA20 * Power(ThetaKmpA,TempDiff);
    KmpX:=KmpX20 * Power(ThetaKmpX,TempDiff);
    Ksp:=Ksp20 * Power(ThetaKsp,TempDiff);
    Kr:=Kr20 * Power(ThetaKr,TempDiff);
    Ka:=Ka20 * Power(ThetaKa,TempDiff);
    Kc:=Kc20 * Power(ThetaKc,TempDiff);
    MuHatAuto:=MuHatAuto20 * Power(ThetaMuHatA,TempDiff);
    Ksa:=Ksa20 * Power(ThetaKsa,TempDiff);
    Ba:=Ba20 * Power(ThetaBa,TempDiff);
    MuHatPolyP1:=MuHatPolyP120 * Power(ThetaMuHatP,TempDiff);
    MuHatPolyP2:=MuHatPolyP220 * Power(ThetaMuHatP,TempDiff);
    KsG1:=KsG120 * Power(ThetaKsG,TempDiff);
    KsG2:=KsG220 * Power(ThetaKsG,TempDiff);
    BG:=Bg20 * Power(ThetaBG,TempDiff);
    Bpp:=Bpp20 * Power(ThetaBpp,TempDiff);
    Kp:=Kp20 * Power(ThetaKp,TempDiff);
  End;  {* temp adjustment *}

