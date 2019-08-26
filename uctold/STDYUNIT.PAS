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
    WRITE(OutFile,Chr(201));
    FOR I:=1 TO 76 DO WRITE(OutFile,Chr(205)); WRITELN(OutFile,Chr(187));
    WRITE(OutFile,Chr(186),'              First Reactor              ');
    if LastReactor > 1
           then writeln('     Last Reactor                  ',Chr(186))
           else writeln('                                   ',Chr(186));
    WRITE(OutFile,Chr(186),'   Zbh     Zba     Sads     Senm   ');
    if LastReactor > 1
           then writeln('No3     Sbs     Na      No3       MaxF   ',Chr(186))
           else writeln('No3     Na      Nobs    Alk       MaxF   ',Chr(186));
    WRITE(OutFile,Chr(200));
    FOR I:=1 TO 76 DO WRITE(OutFile,Chr(205)); WRITELN(OutFile,Chr(188));
    writeln;
  End;  (* titles *)

Procedure SeedValues;

  var
   MassXa,MassXe,MassXi,MassXn,Ns,bh24,bn04,frac : real;

    Begin
     (* seed values from steady state model *)
     (* seed values from steady state model *)
     bh24 :=EXP(LN(0.24)+(Temp-20)*LN(1.029));
     bn04 :=EXP(LN(0.04)+(Temp-20)*LN(1.029));
     MassXa := 0.66 * FlowFeed * Sti*(1-fus-fup) * Rs / (1 + bh24 * Rs);
     MassXe := 0.2 * bh24 * Rs * MassXa;
     MassXi := fup * FlowFeed * Sti * Rs;
     Ns := Ixb * (MassXa + MassXe + MassXi) / (Rs * FlowFeed);
     MassXn := FlowFeed * (Nti -Ns -3.0) * Ya * Rs / (1 + bn04 * Rs);
     for k := 1 to LastReactor do
      begin
       frac := Tracer[k] * Vol[k] / MassTracer;
       { Zbh }
       C[k,1] := frac * MassXa / Vol[k];
       { Ze }
       C[k,3] := frac * MassXe / Vol[k];
       { Zba }
       C[k,2] := frac * MassXn / Vol[k];
       { Sads }
       if ReactorAerated[k]
           then C[k,5] := 0.05 * C[k,1]
           else if FracFeed[k] > 0.0
                 then C[k,5] := 0.10 * C[k,1]
                 else C[k,5] := 0.05 * C[k,1];
       { Senm }
       C[k,6] := 0.5*C[k,5];
       { Zi }
       C[k,4] := frac * MassXi / Vol[k];
       { Nobp }
       C[k,7] := 10.0;
       { Sbs }
       if (( NOT ReactorAerated[k]) AND (FracFeed[k] > 0.0) )
            then C[k,8] := 0.20*C0[8]
            else C[k,8] := 1.0;
       { Na }
       if ReactorAerated[k] then
                              begin
                               if FracFeed[k] > 0
                                        then C[k,9] :=
                                                     0.5 * VolumeTotal/Vol[k]
                                        else C[k,9] := 0.5;
                              end
                            else C[k,9] := 0.25*(Nti-Ns);
       { Nous }
       C[k,10] := 3.0;
       { No3 }
       if ReactorAerated[k] then C[k,11] := 1.0 * (Nti-Ns)
                            else C[k,11] := 0.001;
       { Alk }
       C[k,12] := 0.5 * C0[12];
       { Sus }
       C[k,13] := fus * Sti;
      end;

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