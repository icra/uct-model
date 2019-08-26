Unit KinUnit;

interface

  uses VarsUnit,
       IOUnit;

  Procedure TempAdjustment;
  Procedure Heterotrophs;
  Procedure Autotrophs;
  Procedure Arrhenius;

implementation

{$I adjtemp.pas }
{$I kinetic.pas }

Begin    { initial values }

  MuHatHetero20  := 3.2;
  Ks20           := 5.0;
  Koh            := 0.002;
  Bh20           := 0.62;
  NetaGrow       := 0.33;
  Kno            := 0.10;
  Kmp20          := 1.35;
  Ksp20          := 0.027;
  Kr20           := 0.032;
  Kna            := 0.01;
  Ka20           := 0.17;

  MuHatAuto20  := 0.45;
  Knh20        := 1.0;
  Koa          := 0.002;
  Ba20         := 0.04;

  ThetaMuHatH  := 1.200;
  ThetaKs      := 1.000;
  ThetaBh      := 1.029;
  ThetaKmp     := 1.08;
  ThetaKsp     := 0.910;
  ThetaKr      := 1.029;
  ThetaMuHatA  := 1.123;
  ThetaKnh     := 1.123;
  ThetaBa      := 1.029;
  ThetaKa      := 1.029;

End.  { end of KinUnit}
