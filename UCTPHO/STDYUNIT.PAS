Unit StdyUnit;    { steady state program }

interface

 uses Crt,
      VarsUnit,
      IOUnit,
      RateUnit;

 Procedure ScaleValues(Compounds:integer);
 Procedure Newton(Compounds:integer);
 Procedure SteadySolution;
 Procedure StoreAvgConcs;
 Procedure SteadyState;

implementation

var
  Tracer                  : AllReactors;
  TracerConcIn,MassTracer : real;
  Inversions              : integer;

{$I flowss.pas }         { flow distribution for SS case        }
{$I scale.pas }          { scale values for Newton              }
{$I newton.pas }         { solve nonlinear equations            }
{$I waste.pas }          { wastage rate                         }
{$I stdyrslt.pas }       { steady state results                 }

Procedure SteadySolution;

  Procedure Titles;
   Begin
    ClrScr;
    AssignCrt(OutFile);
    Rewrite(OutFile);
    write(OutFile,Chr(201));
    For i := 1 to 76 do write(OutFile,Chr(205)); writeln(OutFile,Chr(187));
    write(OutFile,Chr(186),'                       FOLLOWING         ');
    writeln('CALCULATION                        ',Chr(186));
    write(OutFile,Chr(200));
    For i := 1 to 76 do write(OutFile,Chr(205)); writeln(OutFile,Chr(188));
  End;  (* titles *)

Procedure SeedValues;

  var
   MassXa,MassXg,MassXe,MassXi,MassXn,Ns,bh24,bn04,frac : real;

    Begin
     (* seed values from steady state model *)
     bh24 :=EXP(LN(0.24)+(Temp-20)*LN(1.029));
     bn04 :=EXP(LN(0.04)+(Temp-20)*LN(1.029));
     MassXa := 0.66 * FlowFeed * Sti*(1-fus-fup)*1.2 *(1.0 - Fbs)
                      * Rs / (1 + bh24 * Rs)+0.1;
     MassXg := 0.66 * FlowFeed * Sti*(1-Fus-Fup)*Fbs*0.8
                      * Rs / (1 + bn04 * Rs);
     MassXe := 0.2 * bh24 * Rs * MassXa + 0.25*bn04*Rs*MassXg;
     MassXi := fup * FlowFeed * Sti * Rs;
     Ns := (FzbhN*MassXa + FzehN*(MassXe + MassXi) + FzbgN*MassXg)
                        / (Rs * FlowFeed);
     MassXn := FlowFeed * (Nti -Ns -3.0) * Yza * Rs / (1 + bn04 * Rs);
     for k := 1 to LastReactor do
      begin
       frac := Tracer[k] * Vol[k] / MassTracer;
       { Zbh }
       C[k,1] := frac * MassXa / Vol[k];
       { Zba }
       C[k,2] := frac * MassXn / Vol[k];
       { Zbg }
       C[k,3] := frac * MassXg / Vol[k];
       { Ze }
       C[k,4] := frac * MassXe / Vol[k];
       { Zi }
       C[k,5] := frac * MassXi / Vol[k];
       { Sads }
       if ReactorAerated[k]
           then C[k,6] := 0.20 * C[k,1]
           else if FracFeed[k] > 0.0
                 then C[k,6] := 0.50 * C[k,1]
                 else C[k,6] := 0.30 * C[k,1];
       { Senm}
       C[k,7]:= 0.05* C[k,1];
       { Sphb }
       if ReactorAerated[k]
           then C[k,8] := 0.40 * C0[12]
           else if FracFeed[k] > 0.0
                 then C[k,8] := 0.70 * C0[12]
                 else C[k,8] := 0.70 * C0[12];
       { Nobp }
       C[k,9] := 0.1*C[K,6];
       { Ppp }
       if ReactorAerated[k]
           then C[k,10] := 0.26 * C[k,3]
           else C[k,10] := 0.9*0.26 * C[k,3];
       { Sbsc }
       C[k,11] := 5.0;
       { Sbsa }
       C[k,12] := 1.0;
       { Nh3 }
       if ReactorAerated[k]
           then
              begin
                if FracFeed[k] > 0
                   then C[k,13] := 0.5 * VolumeTotal/Vol[k]
                   else C[k,13] := 0.5;
               end
            else C[k,13] := 0.25*(Nti-Ns);
       { Nobs }
       C[k,14] := C0[14];
       { No3 }
       if ReactorAerated[k]
           then
              begin
                if VolumeUnaerated > 0
                   then C[k,15] := 0.5 * (Nti-Ns)
                   else C[k,15] := 1.0 * (Nti-Ns);
              end
            else C[k,15] := 1.0;
       { Ps }
       if ReactorAerated[k]
           then C[k,16] := C0[16]-0.1*(C0[11]+C0[12])
           else C[k,16] := C0[16]+0.25*(C0[11]+C0[12]);
       { Sus }
       C[k,17] := fus * Sti;
       { Alk }
       C[k,18] := 0.5 * C0[18];
      end;
     for k:=1 to lastreactor  do
      for i:=1 to lastcompound  do
        if C[K,I]<0.1 then c[K,I]:=0.1;

     for i := 1 to NoPart do
        C[LastReactor+1,i] := (FlowFeed+FlowRASrecycle-FlowWaste)/FlowRASrecycle
                                * C[LastReactor,i];
     for i := NoPart+1 to LastCompound do
        C[LastReactor+1,i] := C[LastReactor,i];

    End; (* seed values *)

    Begin  (* steady solution *)
      Titles;
      SeedValues;
      AirSupply;
      ScaleValues(LastCompound);
      Newton(LastCompound);
    End; (* steady solution *)


  Procedure StoreAvgConcs;
    Begin
      For k := 1 to LastReactor do
        For i := 1 to (TotalCompounds - 1) do CSteady[k,i]:=C[k,i];
    End; (* store avg concs *)



Procedure SteadyState;

Procedure ScaleVolFlow;

Function Power (B,X:real):real;
   Begin
     Power:=Round(Exp(X*ln(B)));
   end;
Procedure Exponent ;
 Var Y:Real;
begin
     Y:=FlowFeed;
     Expon:=0;
     If Y>100 then
       Repeat
         Y:=Y/10;
         Expon:=(Expon+1);
       Until Y<=100;
 end;

Begin
 Exponent;
 ScaleFactor:=Power(10,Expon);
 FlowFeed:=FlowFeed/ScaleFactor;
 FlowFeedAvg:=FlowFeedAvg/ScaleFactor;
 FlowRASRecycle:=FlowRASRecycle/ScaleFactor;
 FlowARecycle:=FlowARecycle/ScaleFactor;
 FlowBRecycle:=FlowBRecycle/ScaleFactor;
 VolumeTotal:=VolumeTotal/ScaleFactor;
 For k:=1 to LastReactor do
   Vol[k]:=Vol[k]/ScaleFactor;
Writeln('Expon=',expon,'ScaleFactor=',ScaleFactor);
End  (*ScaleVolFlow*);

Procedure RescaleVolFlow;

Begin
 FlowFeed:=FlowFeed*ScaleFactor;
 FlowFeedAvg:=FlowFeedAvg*ScaleFactor;
 FlowWaste:=FlowWaste*ScaleFactor;
 FlowWasteAvg:=FlowWasteAvg*ScaleFactor;
 FlowRASRecycle:=FlowRASRecycle*ScaleFactor;
 FlowARecycle:=FlowARecycle*ScaleFactor;
 FlowBRecycle:=FlowBRecycle*ScaleFactor;
 VolumeTotal:=VolumeTotal*ScaleFactor;
 For k:=1 to LastReactor do
   Vol[k]:=Vol[k]*ScaleFactor;
end;

    Begin   { steady state }

      ClrScr;
      ScaleVolFlow;
      WastageAndFlows;
      SteadySolution;
      Window(1,1,80,25);
      AssignCrt(OutFile);
      Rewrite(OutFile);
      TextColor(ResultsCol.Text);
      TextBackground(ResultsCol.Back);
      OutputSteadyState;     { to screen }
      write('*** Hit any key to continue...');
      repeat until KeyPressed;
      Key := ReadKey;
      Close(OutFile);
      RescaleVolFlow;
      SteadyStateResults;    { to printer - on request }
      StoreAvgConcs;

    End;  { steadystate }

end.  { of unit StdyUnit }

