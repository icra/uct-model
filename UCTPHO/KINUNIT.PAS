Unit KinUnit;

interface

  uses VarsUnit,
       IOUnit;

  Procedure TempAdjustment;
  Procedure Heterotrophs;
  Procedure Autotrophs;
  Procedure PolyPOrganisms;
  Procedure Switches;
  Procedure Arrhenius;

implementation

{$I adjtemp.pas }
{$I kinetic.pas }

Begin    { initial values }

 {Heterotrophs}
  MuHatHetero20  := 2.5;
  Ksh20          := 5.0;
  Bh20           := 0.62;
  NetaGrow       := 0.66;
  KmpA20         := 1.35;
  KmpX20         := 1.35*Netagrow;
  Ksp20          := 0.027;
  Kr20           := 0.032;
  Ka20           := 0.17;
  Kc20           := 0.04;

 {Autotrophs}
  MuHatAuto20  := 0.45;
  Ksa20        := 1.0;
  Ba20         := 0.04;

 {PolyP Organisms}
  MuHatPolyP120  := 1.2;
  KsG120         := 0.18;
  MuHatPolyP220  := 0.42;
  KsG220         := 0.18;
  Bg20           := 0.04;
  bpp20          := 0.03;
  Kp20           := 6.0;

 {Swithes}
  Koh          := 0.002;
  Koa          := 0.002;
  Kog          := 0.002;
  Kha          := 0.01;
  Kno          := 0.1;
  KpsH         := 0.001;
  KpsP         := 0.1;
  Kpp          := 1.0;
  Kac          := 1.0;

 {Arhenius}
  ThetaMuHatH  := 1.200;
  ThetaKsh     := 1.000;
  ThetaBh      := 1.029;
  ThetaKmpA    := 1.029;
  ThetaKmpX    := 1.08;
  ThetaKsp     := 0.910;
  ThetaKr      := 1.029;
  ThetaKa      := 1.029;
  ThetaKc      := 1.029;

  ThetaMuHatA  := 1.123;
  ThetaKsa     := 1.123;
  ThetaBa      := 1.029;

  ThetaMuHatP  := 1.080;
  ThetaKsG     := 1.000;
  ThetaBG      := 1.029;
  ThetaBpp     := 1.029;
  ThetaKp      := 1.029;

End.  { end of KinUnit}