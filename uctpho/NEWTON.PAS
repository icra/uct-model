  PROCEDURE Newton ;
  {***************}

  {* Compounds = 1 for the tracer case    *}
  {*           = TotalCompounds otherwise *}

    TYPE
      nbyn =  array[subs] of ^nvector;

    VAR
      SizeJ           : INTEGER;
      MaxF,MaxT,Del,t : REAL;
      Checker         : Array[1..3] of real;
      JMat            : nbyn;
      H,F             : nvector;
      okay            : BOOLEAN;
      FF              : ARRAY[0..1,0..MaxReacP1,1..LastCompound] OF REAL;


PROCEDURE SetUpEquations (NO : INTEGER);

  VAR
    MassRateIn,Rate                    : REAL;
    I,J                                : INTEGER;

  PROCEDURE TracerEquations;
    BEGIN
      FOR K:=1 TO LastReactor+1 DO
        FF[NO,K,1]:=FlowFeed*FracFeed[K]*TracerConcIn
                    + FlowFromPrevious[K]*C[K-1,1]
                    + FlowRASRecycle*FlagRASIn[K]*C[LastReactor+1,1]
                    + FlowARecycle*FlagAIn[K]*C[ReactorAOut,1]
                    + FlowBRecycle*FlagBIn[K]*C[ReactorBOut,1]
                    - FlowInTotal[K]*C[K,1];

    END; (* tracer equations *)

  PROCEDURE ReactionEquations;
  var I,J : integer;
    BEGIN
      FOR K:=1 TO LastReactor DO
       BEGIN
        ProcessRates;
        FOR I:=1 TO Compounds DO
        BEGIN
          MassRateIn := FlowFromPrevious[K]*C[K-1,I]
                       +FlowFeed*FracFeed[K]*C0[I]
                       +FlowRASRecycle*C[LastReactor+1,I]*FlagRASIn[K]
                       +FlowARecycle*C[ReactorAOut,I]*FlagAIn[K]
                       +FlowBRecycle*C[ReactorBOut,I]*FlagBIn[K];

          Rate:=0.0;
          FOR J:=1 TO NoProcesses DO
          IF Stoich[I,J] <> 0 THEN
            Rate:=Rate+Stoich[I,J]*Rho[J];
          FF[NO,K,I]:=MassRateIn - FlowInTotal[K]*C[K,I] + Rate * Vol[K];
        END;
      END;

      (* settling tank *)
      FOR I:=1 TO NoPart DO
        FF[NO,LastReactor+1,I]:=(FlowFeed + FlowRASRecycle - FlowWaste )
                                *C[LastReactor,I]
                                -FlowRASRecycle*C[LastReactor+1,I];
      FOR I:= NoPart+1 TO Compounds DO
        FF[NO,LastReactor+1,I]:=C[LastReactor,I]-C[LastReactor+1,I];
    END; (* reaction equations *)

      BEGIN   (* set up equations *)
        IF SizeJ = LastReactor+1 THEN
          TracerEquations
        ELSE
          ReactionEquations;
      END;  (* set up equations *)

  PROCEDURE InitialiseJMat;

  VAR
    I,J                    : INTEGER;

  BEGIN
    FOR I:=1 TO SizeJ DO
    FOR J:=1 TO SizeJ DO
      JMat[I]^[J]:=0.0;
  END;   {* initialise j mat *}

  PROCEDURE CalculateJMat (Compounds : INTEGER);

  VAR
    II,KK,SubI,SubJ          : INTEGER;

   BEGIN
      FOR L:=1 TO LastReactor+1 DO
      FOR M:=1 TO Compounds DO
        BEGIN
          SubJ := Compounds*(L-1)+M;
          Del:=sqrt(Macheps)*ABS(C[L,M])+1.0E-08;
          C[L,M]:=C[L,M] + Del;
          SetUpEquations(1);
          FOR KK:=1 TO LastReactor+1 DO
           begin
            SubI := Compounds*(KK-1);
            FOR II:= 1 TO Compounds DO
             JMat[SubI+II]^[SubJ] := (FF[1,KK,II]-FF[0,KK,II])/Del;
           end;
          C[L,M]:=C[L,M] - Del;
        END;
    END; (* calculate j mat *)

PROCEDURE TransformFVector ( Compounds : INTEGER);
  BEGIN
    FOR K:=1 TO LastReactor+1 DO
      FOR I:=1 TO Compounds DO
        F[Compounds*(K-1)+I]:=-FF[0,K,I];
  END;  {* transform f vector *}

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

  PROCEDURE LimitStep (Compounds: INTEGER);

    var
     intr : real;

    Function MinOf(X,Y : real) : real;
     begin
      if X < Y then MinOf := X
               else MinOf := Y;
     end;

    BEGIN  { limit step }
      t := 1;
      FOR K:=1 TO LastReactor+1 DO
      FOR I:=1 TO Compounds DO
       begin
        intr := 50 * abs(C[k,i]);
        if intr < 1 then intr := 1;
        if abs(H[Compounds*(k-1)+i]) > 0 then
                    t := MinOf(t,abs(0.5*intr/H[Compounds*(k-1)+i]));
        if H[Compounds*(K-1)+I] < 0 then
                    t := MinOf(t,0.75*abs(C[k,i]/H[Compounds*(k-1)+i]));
       end;
    END; {* limit step *}

  PROCEDURE CalcNewX (Compounds: INTEGER);
    BEGIN
      FOR K:=1 TO LastReactor+1 DO
      FOR I:=1 TO Compounds DO
        C[K,I]:=C[K,I] +1.0*t * H[Compounds*(K-1)+I];
    END; {* calc new x *}


  PROCEDURE TransferF (Compounds :INTEGER);
    BEGIN
      FOR K:=1 TO LastReactor+1 DO
      FOR I:=1 TO Compounds DO
        FF[0,K,I]:=FF[1,K,I];
    END; {* transfer f *}

  PROCEDURE ReformF (Compounds :INTEGER);
    BEGIN
      FOR K:=1 TO LastReactor+1 DO
      FOR I:=1 TO Compounds DO
        FF[1,K,I]:=FF[0,K,I];
    END; {* reform f *}

  PROCEDURE FollowResults;

   Procedure FollowTracer;
   Var WasteTemp:real;
    BEGIN
     { first reactor }
     write(C[1,1]:8:2);
     { last reactor or blank for single reactor }
     if LastReactor > 1 then write(C[LastReactor,1]:8:2)
                        else write(' ':8);
     WasteTemp:=FlowWaste*ScaleFactor;
     writeln(' ':40,WasteTemp:10:3);
   END;  { follow tracer }

   Procedure FollowReaction;
   var kc,ic : integer;
    BEGIN
     window(1,4,80,25);
     clrscr;
     write('  Reactor ');
     for ic := 1 to LastReactor do
       write(ic:10);
     writeln;
     For ic := 1 to 12 do
        Write(Chr(196));
     For ic := 1 to LastReactor do
       For kc := 1 to 10 do
         Write(Chr(196));
     writeln;
     for ic := 1 to 18 do
      begin
       write('  C[k,',ic:2,'] =');
       for kc := 1 to LastReactor do write(C[kc,ic]:10:2);
       writeln;
      end;
     WRITELN;
     write('                Inversions = ',Inversions:4);
      write(' MaxF =  ',MaxF:10);
   END;  { follow reaction }

  BEGIN  { follow results }
   if SizeJ = LastReactor+1 then FollowTracer
                            else FollowReaction;
  END;  (* follow results *)

  PROCEDURE FindMaxF (Compounds : INTEGER);
    BEGIN
      MaxF:=1E-20;
      FOR K:=1 TO LastReactor+1 DO
       FOR I:=1 TO Compounds DO
         begin
          (*  writeln(K:10,I:10,ABS(FF[0,K,I]):10:6);
            Key := Readkey;*)
        IF ABS(FF[0,K,I]) > MaxF THEN
          begin
            MaxF:=ABS(FF[0,K,I]);
          end;
        end;
    END; (* find max f *)

  PROCEDURE CheckMaxF (Compounds : INTEGER);
   VAR KeepI,KeepK     : Integer;

    BEGIN
      If inversions = 0 then
       begin
        for i:= 1 to 3 do
         Checker[i]:=1E08;
       end;
      Checker[1]:= Checker[2];
      Checker[2]:= Checker[3];
      Checker[3]:= MaxF;
      If ((ABS(Checker[3]-Checker[2]))<1E-03) and
                  ((ABS(Checker[3]-Checker[1]))<1E-03) then
        Begin
          ClrScr;
          GoToXY(20,5);
          Writeln('SOLUTION PROCEDURE STUCK, TRYING TO RESTART');
          GoToXY(20,10);
          Writeln ('Inversion =',Inversions-2:4,' MaxF =',Checker[1]);
          GoToXY(20,11);
          Writeln ('Inversion =',Inversions-1:4,' MaxF =',Checker[2]);
          GoToXY(20,12);
          Writeln ('Inversion =',Inversions:4,' MaxF =',Checker[3]);
          GoToXY(30,20);
          Writeln('Press any key to continue .......');
          Key:=ReadKey;

          MaxT:=MaxF/2;
          FOR K:=1 TO LastReactor+1 DO
           FOR I:=1 TO Compounds DO
              IF ABS(FF[0,K,I]) > MaxT THEN
                begin
                 MaxT:=ABS(FF[0,K,I]);
                 KeepK := K;
                 KeepI := I;
                 C[KeepK,KeepI] := C[KeepK,KeepI]+0.05*FF[0,K,I];
                 if C[KeepK,KeepI] < 0 then C[KeepK,KeepI] := 0.1;
                end;
        end;
    END; (* check max f *)

    BEGIN  (* newton *)
      SizeJ:=(LastReactor+1)*Compounds;
      for i := 1 to SizeJ do New(JMat[i]);
      InitialiseJMat;
      Inversions:=0;
      MaxF := 1.0e06;
      SetUpEquations(0);
      REPEAT
        FollowResults;
        CalculateJMat(Compounds);
        TransformFVector(Compounds);
        Gauss(SizeJ,JMat,F,H,okay);
        LimitStep(Compounds);
        CalcNewX(Compounds);
        SetUpEquations(0);
        FindMaxF(Compounds);
        If SizeJ > Lastreactor+1 then
            CheckMaxF(Compounds);
        Inversions:=Inversions+1;
      If Keypressed then key:=readKey;
      UNTIL((MaxF < 1.0e-03) or (Key=#27));
      for i := 1 to sizeJ do Dispose(JMat[i]);
    END; (* newton *)
