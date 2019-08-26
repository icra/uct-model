Procedure Heterotrophs;   { check/change heterotroph constants }
 Begin
  FlashScreen;
  ValueDummy[1]  := MuHatHetero20  ;
  ValueDummy[2]  := Ksh20          ;
  ValueDummy[3]  := Bh20           ;
  ValueDummy[4]  := NetaGrow       ;
  ValueDummy[5]  := KmpA20          ;
  ValueDummy[6]  := KmpX20          ;
  ValueDummy[7]  := Ksp20          ;
  ValueDummy[8]  := Kr20           ;
  ValueDummy[9]  := Ka20           ;
  ValueDummy[10]  := Kc20           ;

  SelectConstant(HeteroList);

  MuHatHetero20  := ValueDummy[1] ;
  Ksh20          := ValueDummy[2] ;
  Bh20           := ValueDummy[3] ;
  If NetaGrow = ValueDummy[4]
    Then NetaGrow:=ValueDummy[6]/ValueDummy[5]
    Else
      Begin
       NetaGrow:=ValueDummy[4];
       ValueDummy[6]:=NetaGrow*ValueDummy[5];
      end;
  KmpA20         := ValueDummy[5] ;
  If KmpX20 = ValueDummy[6]
    Then KmpX20 := NetaGrow*ValueDummy[5]
    Else KmpX20 := ValueDummy[6];
  Ksp20          := ValueDummy[7] ;
  Kr20           := ValueDummy[8] ;
  Ka20           := ValueDummy[9] ;
  Kc20           := ValueDummy[10] ;
End;  { heterotrophs }


Procedure Autotrophs;   { check/change autotroph constants }
 Begin
  FlashScreen;
  ValueDummy[1] := MuHatAuto20   ;
  ValueDummy[2] := Ksa20         ;
  ValueDummy[3] := Ba20          ;

  SelectConstant(AutoList);

  MuHatAuto20  := ValueDummy[1] ;
  Ksa20        := ValueDummy[2] ;
  Ba20         := ValueDummy[3] ;

End;  { autotrophs }

Procedure PolyPOrganisms;   { check/change polyP constants }
 Begin
  FlashScreen;
  ValueDummy[1]  := MuHatPolyP120  ;
  ValueDummy[2]  := KsG120         ;
  ValueDummy[3]  := MuHatPolyP220  ;
  ValueDummy[4]  := KsG220         ;
  ValueDummy[5]  := Bg20           ;
  ValueDummy[6]  := bpp20          ;
  ValueDummy[7]  := Kp20           ;

  SelectConstant(PolyPList);

  MuHatPolyP120  := ValueDummy[1] ;
  KsG120         := ValueDummy[2] ;
  MuHatPolyP220  := ValueDummy[3] ;
  KsG220         := ValueDummy[4] ;
  Bg20           := ValueDummy[5] ;
  bpp20          := ValueDummy[6] ;
  Kp20           := ValueDummy[7] ;
End;  { PolyP Organisms }

Procedure Switches;   { check/change Switching constants }
 Begin
  FlashScreen;
  ValueDummy[1]  := Koh  ;
  ValueDummy[2]  := Koa  ;
  ValueDummy[3]  := Kog  ;
  ValueDummy[4]  := Kha  ;
  ValueDummy[5]  := Kno  ;
  ValueDummy[6]  := KpsH  ;
  ValueDummy[7]  := KpsP  ;
  ValueDummy[8]  := Kpp  ;
  ValueDummy[9]  := Kac  ;

  SelectConstant(SwitchList);

  Koh  := ValueDummy[1] ;
  Koa  := ValueDummy[2] ;
  Kog  := ValueDummy[3] ;
  Kha  := ValueDummy[4] ;
  Kno  := ValueDummy[5] ;
  KpsH := ValueDummy[6] ;
  KpsP := ValueDummy[7] ;
  Kpp  := ValueDummy[8] ;
  Kac  := ValueDummy[9] ;

End;  { Switches }

Procedure Arrhenius;   { check/change theta values }
 Begin
  FlashScreen;
  ValueDummy[1]  := ThetaMuHatH  ;
  ValueDummy[2]  := ThetaKsh     ;
  ValueDummy[3]  := ThetaBh      ;
  ValueDummy[4]  := ThetaKmpA    ;
  ValueDummy[5]  := ThetaKmpX    ;
  ValueDummy[6]  := ThetaKsp     ;
  ValueDummy[7]  := ThetaKr      ;
  ValueDummy[8]  := ThetaKa      ;
  ValueDummy[9]  := ThetaKc      ;
  ValueDummy[10]  := ThetaMuHatA  ;
  ValueDummy[11] := ThetaKsa     ;
  ValueDummy[12] := ThetaBa      ;
  ValueDummy[13] := ThetaMuHatP  ;
  ValueDummy[14] := ThetaKsG     ;
  ValueDummy[15] := ThetaBG      ;
  ValueDummy[16] := ThetaBpp     ;
  ValueDummy[17] := ThetaKp      ;

  SelectConstant(TempList);

  ThetaMuHatH       := ValueDummy[1] ;
  ThetaKsh          := ValueDummy[2] ;
  ThetaBh           := ValueDummy[3] ;
  ThetaKmpA         := ValueDummy[4] ;
  ThetaKmpX         := ValueDummy[5] ;
  ThetaKsp          := ValueDummy[6] ;
  ThetaKr           := ValueDummy[7] ;
  ThetaKa           := ValueDummy[8] ;
  ThetaKc           := ValueDummy[9] ;
  ThetaMuHatA       := ValueDummy[10];
  ThetaKsa          := ValueDummy[11] ;
  ThetaBa           := ValueDummy[12] ;
  ThetaMuHatP       := ValueDummy[13] ;
  ThetaKsG          := ValueDummy[14] ;
  ThetaBG           := ValueDummy[15] ;
  ThetaBpp          := ValueDummy[16] ;
  ThetaKp           := ValueDummy[17] ;

End;  { arrhenius }
