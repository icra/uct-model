Unit StchUnit;

interface

  uses VarsUnit,
       IOUnit;

  Procedure HeteroStoich;
  Procedure AutoStoich;
  Procedure PolyPStoich;
  Procedure Stoichiometry;

implementation

  Procedure HeteroStoich;
    Begin
      ValueDummy[1] := Yzh   ;
      ValueDummy[2] := Feph  ;
      ValueDummy[3] := fma   ;
      ValueDummy[4] := Fzbhn ;
      ValueDummy[5] := Fzehn ;
      ValueDummy[6] := Fzbhp ;
      ValueDummy[7] := Fzehp ;
      ValueDummy[8] := CODVSS   ;

      SelectConstant(HStoichList);

      Yzh    := ValueDummy[1] ;
      Feph   := ValueDummy[2] ;
      fma    := ValueDummy[3] ;
      Fzbhn  := ValueDummy[4] ;
      Fzehn  := ValueDummy[5] ;
      Fzbhp  := ValueDummy[6] ;
      Fzehp  := ValueDummy[7] ;
      CODVSS := ValueDummy[8] ;
    End;  { HeteroStoich }

  Procedure AutoStoich;
    Begin
      ValueDummy[1] := Yza   ;
      ValueDummy[2] := Fepa  ;
      ValueDummy[3] := Fzban ;
      ValueDummy[4] := Fzean ;
      ValueDummy[5] := Fzbap ;
      ValueDummy[6] := Fzeap ;

      SelectConstant(AStoichList);

      Yza    := ValueDummy[1] ;
      Fepa   := ValueDummy[2] ;
      Fzban  := ValueDummy[3] ;
      Fzean  := ValueDummy[4] ;
      Fzbap  := ValueDummy[5] ;
      Fzeap  := ValueDummy[6] ;
    End;  { AutoStoich }

  Procedure PolyPStoich;
    Begin
      ValueDummy[1] := Yzg   ;
      ValueDummy[2] := Fepg  ;
      ValueDummy[3] := Fesg  ;
      ValueDummy[4] := Fzbgn ;
      ValueDummy[5] := Fzegn ;
      ValueDummy[6] := Fesgn;
      ValueDummy[7] := Fzbgp ;
      ValueDummy[8] := Fzegp ;
      ValueDummy[9] := Fprel ;
      ValueDummy[10]:= Fpupt ;

      SelectConstant(PStoichList);

      Yzg     := ValueDummy[1] ;
      Fepg   := ValueDummy[2] ;
      Fesg   := ValueDummy[3] ;
      Fzbgn  := ValueDummy[4] ;
      Fzegn  := ValueDummy[5] ;
      Fesgn  := ValueDummy[6] ;
      Fzbgp  := ValueDummy[7] ;
      Fzegp  := ValueDummy[8] ;
      Fprel  := ValueDummy[9] ;
      Fpupt  := ValueDummy[10];
    End;  { PolyPStoich }

  Procedure Stoichiometry;
    Begin
      For i := 1 to TotalCompounds do
          for j := 1 to NoProcesses do Stoich[i,j]:=0.0;
     { aerobic growth of heterotrophs on sol COD with NH3 }
      Stoich[1,1]    := 1.0;
      Stoich[11,1]   := -1.0/Yzh;
      Stoich[13,1]   := -Fzbhn;
      Stoich[16,1]   := -FzbhP;
      Stoich[18,1]   := -Fzbhn/14.0;
      Stoich[19,1]   := -(1.0-Yzh)/Yzh;

     { aerobic growth of heterotrophs on sol COD with NO3-N }
      Stoich[1,2]    := 1.0;
      Stoich[11,2]   := -1.0/Yzh;
      Stoich[15,2]   := -Fzbhn;
      Stoich[16,2]   := -FzbhP;
      Stoich[18,2]   := +Fzbhn/14.0;
      Stoich[19,2]   := -(1.0-Yzh)/Yzh;

     { anoxic growth of heterotrophs on sol COD with NH3 }
      Stoich[1,3]    := 1.0;
      Stoich[11,3]   := -1.0/Yzh;
      Stoich[13,3]   := -Fzbhn;
      Stoich[15,3]   := -(1-Yzh)/(2.86*Yzh);
      Stoich[16,3]   := -FzbhP;
      Stoich[18,3]   := (1.0-Yzh)/(14.0*2.86*Yzh)-Fzbhn/14.0;

     { anoxic growth of heterotrophs on sol COD with NO3-N }
      Stoich[1,4]    := 1.0;
      Stoich[11,4]   := -1.0/Yzh;
      Stoich[15,4]   := -(1-Yzh)/(2.86*Yzh)-Fzbhn;
      Stoich[16,4]   := -FzbhP;
      Stoich[18,4]   := (1.0-Yzh)/(14.0*2.86*Yzh)+Fzbhn/14.0;

     { aerobic growth of heterotrophs on part COD with NH3 }
      Stoich[1,5]    := 1.0;
      Stoich[6,5]    := -1.0/Yzh;
      Stoich[13,5]   := -Fzbhn;
      Stoich[16,5]   := -FzbhP;
      Stoich[18,5]   := -Fzbhn/14.0;
      Stoich[19,5]   := -(1.0-Yzh)/Yzh;

     { aerobic growth of heterotrophs on part COD with NO3-N }
      Stoich[1,6]    := 1.0;
      Stoich[6,6]    := -1.0/Yzh;
      Stoich[15,6]   := -Fzbhn;
      Stoich[16,6]   := -FzbhP;
      Stoich[18,6]   := +Fzbhn/14.0;
      Stoich[19,6]   := -(1.0-Yzh)/Yzh;

     { anoxic growth of heterotrophs on part COD with NH3 }
      Stoich[1,7]    := 1.0;
      Stoich[6,7]    := -1.0/Yzh;
      Stoich[13,7]   := -Fzbhn;
      Stoich[15,7]   := -(1-Yzh)/(2.86*Yzh);
      Stoich[16,7]   := -FzbhP;
      Stoich[18,7]   := (1.0-Yzh)/(14.0*2.86*Yzh)-Fzbhn/14.0;

     { anoxic growth of heterotrophs on part COD with NO3-N }
      Stoich[1,8]    := 1.0;
      Stoich[6,8]    := -1.0/Yzh;
      Stoich[15,8]   := -(1-Yzh)/(2.86*Yzh)-Fzbhn;
      Stoich[16,8]   := -FzbhP;
      Stoich[18,8]   := (1.0-Yzh)/(14.0*2.86*Yzh)+Fzbhn/14.0;

     { decay of heterotrophs }
      Stoich[1,9]    := -1.0;
      Stoich[4,9]    := FEpH;
      Stoich[7,9]    := 1.0-FEpH;
      Stoich[9,9]    := FzbhN-FEpH*FzehN;
      Stoich[16,9]   := FzbhP-FEpH*FzehP;

     { adsorption of enmeshed part COD }
      Stoich[6,10]   := 1.0;
      Stoich[7,10]   := -1.0;

     { hydrolysis of org N}
      Stoich[9,11]   := -1.0/Yzh;
      Stoich[14,11]  := 1.0/Yzh;

     { ammonification }
      Stoich[13,12]  := 1.0;
      Stoich[14,12]  := -1.0;
      Stoich[18,12]  := 1.0/14.0;

     { autotrophic growth }
      Stoich[2,13]   := 1.0;
      Stoich[13,13]  := -(Fzban+1.0/Yza);
      Stoich[15,13]  := 1.0/Yza;
      Stoich[16,13]  := -FzbaP;
      Stoich[18,13]  := -(Fzban/14.0+1.0/(7.0*Yza));
      Stoich[19,13]  := -(4.57-Yza)/Yza;

     { autotrophic decay }
      Stoich[2,14]   := -1.0;
      Stoich[4,14]   := FEpA;
      Stoich[7,14]   := 1.0-FEpA;
      Stoich[9,14]   := FzbaN-FEpA*FzeaN;
      Stoich[16,14]  := FzbaP-FEpA*FzeaP;

    {* aerobic growth of polyP organisms on Sphb with NH3 *}
      Stoich[3,15]   := 1.0;
      Stoich[8,15]   := -1.0/Yzg;
      Stoich[10,15]  := Fpupt/Yzg;
      Stoich[13,15]  := -FzbgN;
      Stoich[16,15]  := -Fpupt/Yzg-FzbgP;
      Stoich[19,15]  := -(1.0-Yzg)/Yzg;

    {* aerobic growth of polyp organisms on Sphb with NO3*}
      Stoich[3,16]   := 1.0;
      Stoich[8,16]   := -1.0/Yzg;
      Stoich[10,16]  := Fpupt/Yzg;
      Stoich[15,16]  := -FzbgN;
      Stoich[16,16]  := -Fpupt/Yzg-FzbgP;
      Stoich[19,16]  := -(1.0-Yzg)/Yzg;

    {* process 15 if Ps limited *}
      Stoich[3,17]   := 1.0;
      Stoich[8,17]   := -1.0/Yzg;
      Stoich[10,17]  := -FzbgP;
      Stoich[13,17]  := -FzbgN;
      Stoich[19,17]  := -(1.0-Yzg)/Yzg;

    {* process 16 if Ps limited*}
      Stoich[3,18]   := 1.0;
      Stoich[8,18]   := -1.0/Yzg;
      Stoich[10,18]  := -FzbgP;
      Stoich[15,18]  := -FzbgN;
      Stoich[19,18]  := -(1.0-Yzg)/Yzg;

    {* aerobic decay of polyP organisms *}
      Stoich[3,19]   := -1.0;
      Stoich[4,19]   := FEpG;
      Stoich[9,19]   := FzbgN-FEpG*FzegN-FEsG*FEsGN;
{*    Stoich[14,19]  := FEsG*FEsGN;*}
      Stoich[16,19]  := FzbgP-FzegP*FEpG;
      Stoich[17,19]  := FEsG;
      Stoich[19,19]  := -(1.0-FEpG-FEsG);

     {* polyP lysis on aerobic death *}
      Stoich[10,20]  := -1.0;
      Stoich[16,20]  := 1.0;

     {* PHB lysis on aerobic death *}
      Stoich[8,21]   := -1.0;
      Stoich[7,21]  := 1.0;

     {* anaerobic/anoxic decay of polyP organisms *}
      Stoich[3,22]   := -1.0;
      Stoich[4,22]   := FEpG;
      Stoich[9,22]   := FzbgN-FEpG*FzegN-FEsG*FEsGN;
      Stoich[7,22]  := (1-FEpG-FEsG);
{*    Stoich[14,22]  := FEsG*FEsGN;*}
      Stoich[16,22]  := FzbgP-FEpG*FzegP;
      Stoich[17,22]  := FEsG;


     {* polyP lysis on anaerobic death *}
      Stoich[10,23]  := -1.0;
      Stoich[16,23]  := 1.0;

     {* PHB lysis on anaerobic death *}
      Stoich[8,24]   := -1.0;
      Stoich[7,24]  := 1.0;

     {* cleavage of polyP for anaerobic/anoxic maintainance *}
      Stoich[10,25]  := -1.0;
      Stoich[16,25]  := 1.0;

     {* conversion of complex RBCOD to acetate *}
      Stoich[11,26]  := -1.0;
      Stoich[12,26]  := 1.0;

     {* sequestration of acetate by polyP organisms *}
      Stoich[8,27]   := 1.0;
      Stoich[10,27]  := -Fprel;
      Stoich[12,27]  := -1.0;
      Stoich[16,27]  := Fprel;

    END;  {* stoichiometry *}



begin    { initial values }

 {Heterotrophs}
  Yzh         := 0.666;
  FepH       := 0.08;
  fma        := 1.00;
  Fzbhn      := 0.068;
  Fzehn      := 0.068;
  Fzbhp      := 0.02;
  Fzehp      := 0.02;
  CODVSS     := 1.48;

 {Autotrophs}
  Yza         := 0.15;
  FepA       := 0.08;
  Fzban      := 0.068;
  Fzean      := 0.068;
  Fzbap      := 0.02;
  Fzeap      := 0.02;

 {PolyP Organisms}
  Yzg         := 0.666;
  FepG       := 0.25;
  FesG       := 0.20;
  Fzbgn      := 0.068;
  Fzegn      := 0.068;
  Fesgn      := 0.068;
  Fzbgp      := 0.02;
  Fzegp      := 0.02;
  Fprel      := 0.5;
  Fpupt      := 0.75;

end.  { end of StchUnit}