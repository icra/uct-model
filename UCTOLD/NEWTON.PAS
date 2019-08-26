  Procedure Newton;

  { Compounds = 1 for the tracer case    }
  {           = TotalCompounds otherwise }

    TYPE
      nbyn =  array[subs] of ^nvector;

    VAR
      SizeJ           : integer;
      MaxF,Del,t      : real;
      JMat            : nbyn;
      H,F             : nvector;
      okay            : boolean;
      FF              : array[0..1,0..MaxReacP1,1..LastCompound] of real;


Procedure SetUpEquations (NO : integer);

  VAR
    MassRateIn,Rate                    : real;
    i,j                                : integer;

  Procedure TracerEquations;
    Begin
      for k := 1 to LastReactor+1 do
        FF[NO,k,1] := FlowFeed*FracFeed[k]*TracerConcIn
                      + FlowFromPrevious[k]*C[k-1,1]
                      + FlowRASRecycle*FlagRASIn[k]*C[LastReactor+1,1]
                      + FlowARecycle*FlagAIn[k]*C[ReactorAOut,1]
                      + FlowBRecycle*FlagBIn[k]*C[ReactorBOut,1]
                      - FlowInTotal[k]*C[k,1];
    End; { tracer equations }

  Procedure ReactionEquations;
   var i,j : integer;
    Begin
      for k := 1 to LastReactor do
       begin
        ProcessRates;
        for i := 1 to Compounds do
          begin
            MassRateIn := FlowFromPrevious[k]*C[k-1,i]
                          +FlowFeed*FracFeed[k]*C0[i]
                          +FlowRASRecycle*C[LastReactor+1,i]*FlagRASIn[k]
                          +FlowARecycle*C[ReactorAOut,i]*FlagAIn[k]
                          +FlowBRecycle*C[ReactorBOut,i]*FlagBIn[k];
            Rate := 0.0;
            for j := 1 to NoProcesses do
              if Stoich[i,j] <> 0 then
                Rate := Rate+Stoich[i,j]*Rho[j];
            FF[NO,k,i] := MassRateIn - FlowInTotal[k]*C[k,i] + Rate * Vol[k];
          end;
       end;

      { settling tank }
      for i := 1 to NoPart do
        FF[NO,LastReactor+1,i] := (FlowFeed + FlowRASRecycle - FlowWaste )
                                  *C[LastReactor,i]
                                  -FlowRASRecycle*C[LastReactor+1,i];
      for i := NoPart+1 to Compounds do
        FF[NO,LastReactor+1,i] := C[LastReactor,i]-C[LastReactor+1,i];
    End; { reaction equations }

      Begin   { set up equations }
        If SizeJ = LastReactor+1 then
          TracerEquations
        else
          ReactionEquations;
      End;  { set up equations }

  Procedure InitialiseJMat;

  Var
    i,j                    : integer;

  Begin
    for i := 1 to SizeJ do
      for j := 1 to SizeJ do
        JMat[i]^[j] := 0.0;
  End;   { initialise j mat }

  Procedure CalculateJMat (Compounds : integer);

  VAR
    L,m,ii,kk,SubI,SubJ          : integer;

   Begin
      for L := 1 to LastReactor+1 do
        for m := 1 to Compounds do
          begin
            SubJ := Compounds*(L-1)+m;
            Del := sqrt(Macheps)*ABS(C[L,m])+1.0E-08;
            C[L,m] := C[L,m] + Del;
            SetUpEquations(1);
            for kk := 1 to LastReactor+1 do
             begin
               SubI := Compounds*(kk-1);
               for ii := 1 to Compounds do
                 JMat[SubI+ii]^[SubJ] := (FF[1,kk,ii]-FF[0,kk,ii])/Del;
             end;
            C[L,m] := C[L,m] - Del;
          end;
    End; { calculate j mat }

Procedure TransformFVector ( Compounds : integer);
  Begin
    for k := 1 to LastReactor+1 do
      for i := 1 to Compounds do
        F[Compounds*(k-1)+i] := -FF[0,k,i];
  End;  { transform f vector }

{ solution of linear equations   }
{ permed gauss method            }
{ input a & b, output solution x }
{ for scheme  a.x = b            }

Procedure Gauss( n : integer;var  a : nbyn; b : nvector;
                var x : nvector;  var success : boolean);

 label 999;

 const
   assumedzero = 1E-20;

 var
  i,pi,pivi,j : subs;
  pivot,mult : real;
  p : permvectors;

 function dotprod(n : integer;  u,v : nvector;  k : subs) : real;
  var
   i : subs;
   sum : real;
  begin
   sum :=0;
   for i := k to n do
     sum := sum + u[i] * v[i];
   dotprod := sum;
  end;  { dot prod }

 Procedure SubtractRow (n : integer;  var u : nvector;  v : nvector;
                        m : real;  k : subs);
   var
     i : subs;
   begin
     for i := k to n do
       u[i] := u[i] - m * v[i];
   end;  { subtract row }

 Procedure SwapPivRow
    (n : integer;  col : subs;  var pivrow : subs;  var p : permvectors);
   var
     i,pivi : subs;
     max,thisabs : real;
   begin
     pivi := col;  max := abs(a[p[pivi]]^[col]);
     for i := col+1 to n do
     begin
       thisabs := abs(a[p[i]]^[col]);
       if thisabs > max then
       begin
         max := thisabs;  pivi := i;
       end;
     end;
     pivrow := p[pivi];
     if pivi <> col then
     begin
       i := p[col];  p[col] := p[pivi];  p[pivi] := i;
     end;
   end;  { swap piv row }

 begin  { permed gauss }
   for i := 1 to n do p[i] := i;
   for j := 1 to n-1 do
   begin
     SwapPivRow(n,j,pivi,p);
     pivot := a[pivi]^[j];
     if abs(pivot) <= assumedzero then
       begin
        success := false;  goto 999;
       end;
     for i := j+1 to n do
       begin
         pi := p[i];
         mult := a[pi]^[j]/pivot;
         if abs(mult) > assumedzero then
           begin
             a[pi]^[j] := mult;
             SubtractRow(n,a[pi]^,a[pivi]^,mult,j+1);
             b[pi] := b[pi] - mult * b[pivi];
           end else
             a[pi]^[j] := 0;
       end;
   end;
   pi := p[n];
   success := abs(a[pi]^[n]) > assumedzero;
   if success then
   begin
     x[n] := b[pi]/a[pi]^[n];
     for i := n-1 downto 1 do
     begin
       pi := p[i];
       x[i] := (b[pi] - dotprod(n,a[pi]^,x,i+1))/a[pi]^[i];
     end;
   end;
999:
 end;  { simq }

Procedure CalcNewX (Compounds: integer);

  var
   intr : real;

  Function MinOf(X,Y : real) : real;
   begin
    if X < Y then MinOf := X
             else MinOf := Y;
   end;

  Begin  { calc new x }
    for k := 1 to LastReactor+1 do
      for i := 1 to Compounds do
        begin
          t := 1;
          if H[Compounds*(k-1)+i] < 0 then
               t := MinOf(t,0.99*abs(C[k,i]/H[Compounds*(k-1)+i]));
          C[k,i] := C[k,i] + t * H[Compounds*(k-1)+i];
        end;
  End; { calc new x }


Procedure TransferF (Compounds :integer);
  Begin
    for k := 1 to LastReactor+1 do
      for i := 1 to Compounds do
        FF[0,k,i] := FF[1,k,i];
  End; { transfer f }

Procedure ReformF (Compounds :integer);
  Begin
    for k := 1 to LastReactor+1 do
      for i := 1 to Compounds do
        FF[1,k,i] := FF[0,k,i];
  End; { reform f }

Procedure FollowResults;

 Procedure FollowTracer;
 Var WasteTemp:real;
  Begin
   { first reactor }
   write(C[1,1]:8:2);
   { last reactor or blank for single reactor }
   if LastReactor > 1 then write(C[LastReactor,1]:8:2)
                      else write(' ':8);
   Wastetemp:=FlowWaste*ScaleFactor;
   writeln(' ':40,Wastetemp:10:3);
 End;  { follow tracer }

 Procedure FollowReaction;
  var kc,ic : integer;
  Begin
   { first reactor }
   write(C[1,1]:8:2);
   write(C[1,2]:8:2);
   write(C[1,5]:8:2);
   write(C[1,6]:8:2);
   write(C[1,11]:8:2);
   { last reactor or other compounds for single reactor }
   if LastReactor > 1
     then
       begin
         write(C[LastReactor,8]:8:2);
         write(C[LastReactor,9]:8:2);
         write(C[LastReactor,11]:8:2);
       end
     else
       begin
         write(C[1,9]:8:2);
         write(C[1,10]:8:2);
         write(C[1,12]:8:2);
       end;
    writeln('   ',MaxF:10);
   End;  { follow reaction }

  Begin  { follow results }
    if SizeJ = LastReactor+1 then FollowTracer
                             else FollowReaction;
  End;  { follow results }

  Procedure FindMaxF (Compounds : integer);
    Begin
      MaxF := 1E-20;
      for k := 1 to LastReactor+1 do
        for i := 1 to Compounds do
         If ABS(FF[0,k,i]) > MaxF then
            MaxF := ABS(FF[0,k,i]);
    End; { find max f }

    Begin  { newton }
      SizeJ := (LastReactor+1)*Compounds;
      for i := 1 to SizeJ do New(JMat[i]);  { make space on heap }
      InitialiseJMat;
      Inversions:=0;
      MaxF := 1.0e10;
      SetUpEquations(0);
      Repeat
        FollowResults;
        CalculateJMat(Compounds);
        TransformFVector(Compounds);
        Gauss(SizeJ,JMat,F,H,okay);
        CalcNewX(Compounds);
        SetUpEquations(0);
        FindMaxF(Compounds);
        Inversions:=Inversions+1;
      Until (MaxF < 1.0e-03);
      for i := 1 to SizeJ do Dispose(JMat[i]);  { delete from heap }
    End; { newton }
