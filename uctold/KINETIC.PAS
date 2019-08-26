Procedure Heterotrophs;   { check/change heterotroph constants }
 Begin
  FlashScreen;
  ValueDummy[1] := MuHatHetero20  ;
  ValueDummy[2] := Ks20           ;
  ValueDummy[3] := Koh            ;
  ValueDummy[4] := Bh20           ;
  ValueDummy[5] := NetaGrow       ;
  ValueDummy[6] := Kno            ;
  ValueDummy[7] := Kmp20           ;
  ValueDummy[8] := Ksp20           ;
  ValueDummy[9] := Kr20          ;
  ValueDummy[10] := Kna           ;
  ValueDummy[11] := Ka20           ;

  SelectConstant(HeteroList);

  MuHatHetero20  := ValueDummy[1] ;
  Ks20           := ValueDummy[2] ;
  Koh            := ValueDummy[3] ;
  Bh20           := ValueDummy[4] ;
  NetaGrow       := ValueDummy[5] ;
  Kno            := ValueDummy[6] ;
  Kmp20          := ValueDummy[7] ;
  Ksp20          := ValueDummy[8] ;
  Kr20           := ValueDummy[9] ;
  Kna            := ValueDummy[10] ;
  Ka20           := ValueDummy[11] ;
End;  { heterotrophs }


Procedure Autotrophs;   { check/change autotroph constants }
 Begin
  FlashScreen;
  ValueDummy[1] := MuHatAuto20   ;
  ValueDummy[2] := Knh20         ;
  ValueDummy[3] := Koa           ;
  ValueDummy[4] := Ba20          ;

  SelectConstant(AutoList);

  MuHatAuto20  := ValueDummy[1] ;
  Knh20        := ValueDummy[2] ;
  Koa          := ValueDummy[3] ;
  Ba20         := ValueDummy[4] ;

End;  { autotrophs }


Procedure Arrhenius;   { check/change theta values }
 Begin
  FlashScreen;
  ValueDummy[1] := ThetaMuHatH  ;
  ValueDummy[2] := ThetaKs           ;
  ValueDummy[3] := ThetaBh           ;
  ValueDummy[4] := ThetaKmp          ;
  ValueDummy[5] := ThetaKsp          ;
  ValueDummy[6] := ThetaKr          ;
  ValueDummy[7] := ThetaMuHatA   ;
  ValueDummy[8] := ThetaKnh         ;
  ValueDummy[9] := ThetaBa          ;
  ValueDummy[10] := ThetaKa          ;

  SelectConstant(TempList);

  ThetaMuHatH       := ValueDummy[1] ;
  ThetaKs           := ValueDummy[2] ;
  ThetaBh           := ValueDummy[3] ;
  ThetaKmp          := ValueDummy[4] ;
  ThetaKsp          := ValueDummy[5] ;
  ThetaKr           := ValueDummy[6] ;
  ThetaMuHatA       := ValueDummy[7] ;
  ThetaKnh          := ValueDummy[8] ;
  ThetaBa           := ValueDummy[9] ;
  ThetaKa           := ValueDummy[10] ;

End;  { arrhenius }

