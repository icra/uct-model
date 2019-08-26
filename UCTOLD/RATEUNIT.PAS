Unit RateUnit;

interface

uses VarsUnit;

  Procedure ProcessRates;
  Procedure AirSupply;
  Procedure UtilizationRates;

implementation

  Procedure ProcessRates;

    Begin

     {* dummies *}
          MuHeteroS:=MuHatHetero*C[K,1]*C[K,8]/(Ks+C[K,8]);
          MuHeteroP:=Kmp*C[K,5]/(Ksp+C[K,5]/C[K,1]);
          NO3Limit:=C[K,11]/(Kno+C[K,11]);
          NH3Limit:=C[K,9]/(Kna+C[K,9]);

     {* aerobic growth of heterotrophs on Ss with NH3 *}
      Rho[1]:=MuHeteroS
              *AirOnHetero[K]*NH3Limit;

     {* aerobic growth of heterotrophs on Ss with NO3 *}
      Rho[2]:=MuHeteroS
              *AirOnHetero[K]*(1-NH3Limit)*NO3Limit;

     {* anoxic growth of heterotrophs on Ss with NH3 *}
      Rho[3]:=MuHeteroS
              *AirOffHetero[K]*NO3Limit*NH3Limit;

     {* anoxic growth of heterotrophs on Ss with NO3 *}
      Rho[4]:=MuHeteroS
              *AirOffHetero[K]*NO3Limit*(1-NH3Limit);

     {* aerobic growth of heterotrophs on Sads with NH3 *}
      Rho[5]:=MuHeteroP
              *AirOnHetero[K]*NH3Limit;

     {* aerobic growth of heterotrophs on Sads with NO3 *}
      Rho[6]:=MuHeteroP
              *AirOnHetero[K]*NO3Limit*(1-NH3Limit);

     {* anoxic growth of heterotrophs on Sads with NH3 *}
      Rho[7]:=MuHeteroP*NetaGrow
              *AirOffHetero[K]*NO3Limit*NH3Limit;

     {* anoxic growth of heterotrophs on Sads with NO3 *}
      Rho[8]:=MuHeteroP*NetaGrow
              *AirOffHetero[K]*NO3Limit*(1-NH3Limit);

     {* decay of heterotrophs *}
      Rho[9]:=Bh*C[K,1];

     {* Adsorption of particulate influent COD *}
      Rho[10]:=Ka*C[K,6]*C[K,1]*(Fma-C[K,5]/C[K,1]);
       If MainMenu.CurrentOption=4 then
         If C[K,5]/C[k,1]>Fma then
           Rho[10]:=Ka*1000*C[K,1]*(Fma-C[K,5]/C[K,1]);


     {* Hydrolysis of biodeg part org N*}
      If C[K,5]=0 Then Rho[11]:=0
         else Rho[11]:=(Rho[5]+Rho[6]+Rho[7]+Rho[8])*C[K,7]/C[K,5];

     {* ammonification of soluble org N*}
      Rho[12]:=Kr*C[K,10]*C[K,1];

     {* autotrophic growth *}
      Rho[13]:=MuHatAuto*C[K,2]*(C[K,9]/(Knh+C[K,9]))*AirOnAuto[K];

     {* autotrophic decay *}
      Rho[14]:=Ba*C[K,2];

    End;

  Procedure AirSupply;
  var  k : integer;
    Begin
      For k:=1 to LastReactor do
        begin
          AirOnHetero[k]  := DOConc[k]/(Koh+DOConc[k]);
          AirOnAuto[k]    := DOConc[k]/(Koa+DOConc[k]);
          AirOffHetero[k] := Koh/(Koh+DOConc[k]);
          AirOffAuto[k]   := Koa/(Koa+DOConc[k]);
        end;
    End;   { air supply }

  Procedure UtilizationRates;
    Begin
      For k:=1 to LastReactor do
        begin
          ProcessRates;
          Oc[K]:=-(Stoich[14,1]*Rho[1]+Stoich[14,2]*Rho[2]
                   +Stoich[14,5]*Rho[5]+Stoich[14,6]*Rho[6])/24.0;
          On[K]:=-Stoich[14,13]*Rho[13]/24.0;
          Ot[K]:=Oc[K]+On[K];
          Denit[K]:=-(Stoich[11,2]*Rho[2]+Stoich[11,3]*Rho[3]
                      +Stoich[11,4]*Rho[4]+Stoich[11,6]*Rho[6]
                      +Stoich[11,7]*Rho[7]+Stoich[11,8]*Rho[8])/24.0;
        end;
    End;  { utilization rates }

end.  { of RateUnit }

