Unit StchUnit;

interface

  uses VarsUnit,
       IOUnit;

  Procedure StoichUpdate;
  Procedure Stoichiometry;

implementation

  Procedure StoichUpdate;
    Begin
      ValueDummy[1] := Yh   ;
      ValueDummy[2] := Fe   ;
      ValueDummy[3] := Ixb  ;
      ValueDummy[4] := Ixe  ;
      ValueDummy[5] := Ya   ;
      ValueDummy[6] := CODVSS   ;
      ValueDummy[7] := Fma   ;

      SelectConstant(StoichList);

      Yh     := ValueDummy[1] ;
      Fe     := ValueDummy[2] ;
      Ixb    := ValueDummy[3] ;
      Ixe    := ValueDummy[4] ;
      Ya     := ValueDummy[5] ;
      CODVSS := ValueDummy[6] ;
      Fma    := ValueDummy[7] ;
    End;  { stoich update }

  Procedure Stoichiometry;
    Begin
      For i := 1 to TotalCompounds do
          for j := 1 to NoProcesses do Stoich[i,j]:=0.0;

     {* aerobic growth of heterotrophs on Ss with NH3 *}
      Stoich[1,1]    := 1.0;
      Stoich[8,1]    := -1.0/Yh;
      Stoich[9,1]    := -Ixb;
      Stoich[12,1]   := -Ixb/14.0;
      Stoich[14,1]   := -(1.0-Yh)/Yh;

     {* aerobic growth of heterotrophs on Ss with NO3 *}
      Stoich[1,2]    := 1.0;
      Stoich[8,2]    := -1.0/Yh;
      Stoich[11,2]    := -Ixb;
      Stoich[12,2]   := +Ixb/14.0;
      Stoich[14,2]   := -(1.0-Yh)/Yh;

     {* anoxic growth of heterotrophs on Ss with NH3 *}
      Stoich[1,3]    := 1.0;
      Stoich[8,3]    := -1.0/Yh;
      Stoich[9,3]    := -Ixb;
      Stoich[11,3]   := -(1-Yh)/(2.86*Yh);
      Stoich[12,3]   := (1.0-Yh)/(14.0*2.86*Yh)-Ixb/14.0;

     {* anoxic growth of heterotrophs on Ss with NO3 *}
      Stoich[1,4]    := 1.0;
      Stoich[8,4]    := -1.0/Yh;
      Stoich[11,4]   := -(1-Yh)/(2.86*Yh)-Ixb;
      Stoich[12,4]   := (1.0-Yh)/(14.0*2.86*Yh)+Ixb/14.0;

     {* aerobic growth of heterotrophs on Sads with NH3 *}
      Stoich[1,5]    := 1.0;
      Stoich[5,5]    := -1.0/Yh;
      Stoich[9,5]    := -Ixb;
      Stoich[12,5]   := -Ixb/14.0;
      Stoich[14,5]   := -(1.0-Yh)/Yh;

     {* aerobic growth of heterotrophs on Sads with NO3 *}
      Stoich[1,6]    := 1.0;
      Stoich[5,6]    := -1.0/Yh;
      Stoich[11,6]    := -Ixb;
      Stoich[12,6]   := +Ixb/14.0;
      Stoich[14,6]   := -(1.0-Yh)/Yh;

     {* anoxic growth of heterotrophs on Sads with NH3 *}
      Stoich[1,7]    := 1.0;
      Stoich[5,7]    := -1.0/Yh;
      Stoich[9,7]    := -Ixb;
      Stoich[11,7]   := -(1-Yh)/(2.86*Yh);
      Stoich[12,7]   := (1.0-Yh)/(14.0*2.86*Yh)-Ixb/14.0;

     {* anoxic growth of heterotrophs on Sads with NO3 *}
      Stoich[1,8]    := 1.0;
      Stoich[5,8]    := -1.0/Yh;
      Stoich[11,8]   := -(1-Yh)/(2.86*Yh)-Ixb;
      Stoich[12,8]   := (1.0-Yh)/(14.0*2.86*Yh)+Ixb/14.0;

     {* decay of heterotrophs *}
      Stoich[1,9]    := -1.0;
      Stoich[3,9]    := Fe;
      Stoich[6,9]    := 1.0-Fe;
      Stoich[7,9]    := Ixb-Fe*Ixe;

     {* adsorption of particulate influent COD *}
      Stoich[5,10]    := 1.0;
      Stoich[6,10]    := -1.0;

     {* Hydrolysis of biodeg part org N*}
      Stoich[7,11]    := -1.0;
      Stoich[10,11]    := 1.0;

     {* ammonification of soluble org N*}
      Stoich[9,12]    := 1.0;
      Stoich[10,12]    := -1.0;
      Stoich[12,12]   := 1.0/14.0;

     {* autotrophic growth *}
      Stoich[2,13]    := 1.0;
      Stoich[9,13]    := -(Ixb+1.0/Ya);
      Stoich[11,13]   := 1.0/Ya;
      Stoich[12,13]   := -(Ixb/14.0+1.0/(7.0*Ya));
      Stoich[14,13]   := -(4.57-Ya)/Ya;

     {* autotrophic decay *}
      Stoich[3,14]    := Fe;
      Stoich[2,14]    := -1.0;
      Stoich[6,14]    := 1.0-Fe;
      Stoich[7,14]    := Ixb-Fe*Ixe;

    End;  { stoichiometry }


begin    { initial values }

  Yh         := 0.45*1.48;
  Fe         := 0.08;
  Ixb        := 0.1/1.48;
  Ixe        := 0.1/1.48;
  Ya         := 0.15;
  CODVSS     := 1.48;
  Fma        := 1.00;

end.  { end of StchUnit}

