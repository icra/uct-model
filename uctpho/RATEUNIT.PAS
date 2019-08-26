Unit RateUnit;

interface

uses VarsUnit;

  Procedure ProcessRates;
  Procedure AirSupply;
  Procedure UtilizationRates;

implementation

  Procedure ProcessRates;

    Begin

     { dummies }
          MuHeteroS:=MuHatHetero*C[k,1]*C[k,11]/(Ksh+C[k,11]);
          MuHeteroPA:=KmpA*C[k,6]/C[k,1]/(Ksp+C[k,6]/C[k,1]);
          MuHeteroPX:=KmpX*C[k,6]/C[k,1]/(Ksp+C[k,6]/C[k,1]);
          NO3Limit:=C[k,15]/(Kno+C[k,15]);
          NH3Limit:=C[k,13]/(Kha+C[k,13]);
          PppLimit:=C[k,10]/(Kpp+C[k,10]);
          AcLimit :=C[k,12]/(Kac+C[k,12]);
          HPLimit  :=C[k,16]/(KpsH+C[k,16]);
          PPLimit  :=C[k,16]/(KpsP+C[k,16]);

          MuPolyP1:=MuHatPolyP1*C[k,8]/(KsG1+C[k,8]/C[k,3]);
          MuPolyP2:=MuHatPolyP2*C[k,8]/(KsG2+C[k,8]/C[k,3]);

     { aerobic growth of heterotrophs on sol COD with NH3 }
      Rho[1]:=MuHeteroS
              *AirOnHetero[k]*NH3Limit*HPLimit;

     { aerobic growth of heterotrophs on sol COD with NO3-N }
      Rho[2]:=MuHeteroS
              *AirOnHetero[k]*NO3Limit*(1-NH3Limit)*HPLimit;

     { anoxic growth of heterotrophs on sol COD with NH3 }
      Rho[3]:=MuHeteroS
              *AirOffHetero[k]*NO3Limit*NH3Limit*HPLimit;

     { anoxic growth of heterotrophs on sol COD with NO3-N }
      Rho[4]:=MuHeteroS
              *AirOffHetero[k]*NO3Limit*(1-NH3Limit)*HPLimit;

     { aerobic growth of heterotrophs on part COD with NH3 }
      Rho[5]:=MuHeteroPA*C[k,1]
              *AirOnHetero[k]*NH3Limit*HPLimit;

     { aerobic growth of heterotrophs on part COD with NO3-N }
      Rho[6]:=MuHeteroPA*C[k,1]
              *AirOnHetero[k]*NO3Limit*(1-NH3Limit)*HPLimit;

     { anoxic growth of heterotrophs on part COD with NH3 }
      Rho[7]:=MuHeteroPX*C[k,1] {*NetaGrow}
              *AirOffHetero[k]*NO3Limit*NH3Limit*HPLimit;

     { anoxic growth of heterotrophs on part COD with NO3-N }
      Rho[8]:=MuHeteroPX*C[k,1] {*NetaGrow}
              *AirOffHetero[k]*NO3Limit*(1-NH3Limit)*HPLimit;

     { decay of heterotrophs }
      Rho[9]:=Bh*C[k,1];

     { adsorption of enmeshed COD }
      Rho[10]:=Ka*C[k,7]*C[k,1]*(fma-C[k,6]/C[k,1]);
      If (MainMenu.CurrentOption=4) and
          (C[K,6]>C[K,1]) Then
          Rho[10]:=Ka*1000*C[K,1]*(Fma-C[K,6]/C[K,1]);

     { hydrolysis of org N}
      Rho[11]:=(Rho[5]+Rho[6]+Rho[7]+Rho[8])*C[k,9]/C[k,6];

     { ammonification }
      Rho[12]:=Kr*C[k,14]*C[k,1];

     { autotrophic growth }
      Rho[13]:=MuHatAuto*C[k,2]*(C[k,13]/(Ksa+C[k,13]))*AirOnAuto[k]*HPLimit;

     { autotrophic decay }
      Rho[14]:=Ba*C[k,2];

    {* aerobic growth of polyP organisms on Sphb with NH3 *}
      Rho[15]:=MuPolyP1*AirOnHetero[k]*NH3Limit*PPLimit;

    {* aerobic growth of polyP organisms on Sphb with NO3*}
      Rho[16]:=1.0*MuPolyP1
              *AirOnHetero[k]*(1-NH3Limit)*PPLimit*NO3Limit;

    {* process 15 if Ps limited*}
      Rho[17]:=MuPolyP2*AirOnHetero[k]*NH3Limit*(1-PPLimit);

    {* process 16 if Ps limited*}
      Rho[18]:=1.0*MuPolyP2
              *AirOnHetero[k]*(1-NH3Limit)*(1-PPLimit)*NO3Limit;

    {* aerobic decay of polyP organisms *}
      Rho[19]:=Bg*C[k,3]*AirOnHetero[k];

    {* polyP lysis on aerobic death *}
      Rho[20]:=Rho[19]*C[k,10]/C[k,3];

    {* PHB lysis on aerobic death *}
      Rho[21]:=Rho[19]*C[k,8]/C[k,3];

    {* anaerobic/anoxic decay of polyP organisms *}
      Rho[22]:=C[k,3]*Bg*AirOffHetero[k];

    {* lysis of P on anaerobic decay *}
      Rho[23]:=Rho[22]*C[k,10]/C[k,3];

    {* lysis of PHB on anaerobic decay *}
      Rho[24]:=Rho[22]*C[k,8]/C[k,3];

    {* polyP cleavage for anaerobic/anoxic maintainance *}
      Rho[25]:=Bpp*C[k,3]*AirOffHetero[k]*PppLimit;

    {* conversion of complex RBCOD to acetate *}
      Rho[26]:=Kc*C[k,11]*C[k,1]*AirOffHetero[k]*(1-NO3Limit);

    {* sequestration of acetate by polyP organisms *}
      Rho[27]:=Kp*C[k,3]*AcLimit*PppLimit;

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
          Oc[k]:=-(Stoich[19,1]*Rho[1]+Stoich[19,2]*Rho[2]
                   +Stoich[19,5]*Rho[5]+Stoich[19,6]*Rho[6]
                   +Stoich[19,15]*Rho[15]
                   +Stoich[19,16]*Rho[16]+Stoich[19,17]*Rho[17]
                   +Stoich[19,18]*Rho[18]+Stoich[19,19]*Rho[19])/24.0;
          On[k]:=-Stoich[19,13]*Rho[13]/24.0;
          Ot[k]:=Oc[k]+On[k];
          Denit[k]:=-(Stoich[15,2]*Rho[2]+Stoich[15,3]*Rho[3]
                      +Stoich[15,4]*Rho[4]+Stoich[15,6]*Rho[6]
                      +Stoich[15,7]*Rho[7]+Stoich[15,8]*Rho[8]
                      +Stoich[15,16]*Rho[16]+Stoich[15,18]*Rho[18])/24.0;
        end;
    End;  { utilization rates }

end.  { of RateUnit }
