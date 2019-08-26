{* Integration routine incorporating information from
   Dalquist and Bjork ; last edited 18/2/88 by PLD  *}

   PROCEDURE Integrate;
  {******************}

    PROCEDURE Input     (First,Last : Integer);
    {**************}
    Var  I,K : integer;
      BEGIN

        FOR I:=First TO Last DO
          FOR K:=1 TO LastReactor DO
            MassRateIn[K,I]:=DhFromPrevious[K]*C[K-1,I]
                              +DhRAS[K,I]*C[LastReactor,I]
                              +DhArecycle[K]*C[ReactorAOut,I]
                              +DhBrecycle[K]*C[ReactorBOut,I]
                              +DhFeed[K]*C0[I];

      END; {* input *}


    PROCEDURE React     (First,Last : Integer);
    {**************}

      BEGIN

        ProcessRates;
        FOR I:=First TO Last DO Rate[K,I]:=0.0;
        FOR I:=First TO Last DO
          FOR J:=1 TO NoProcesses DO
            IF Stoich[I,J]<>0.0 THEN Rate[K,I]:=Rate[K,I]+Stoich[I,J]*Rho[J];

      END;{* react *}


    PROCEDURE Derivative    (First,Last : Integer);
    {*******************}

      BEGIN

          Input(First,Last);
          FOR K:=1 TO LastReactor DO
            BEGIN
              React(First,Last);
              FOR I:=First TO Last DO
                dCdt[K,I]:=MassRateIn[K,I]-DhOut[K]*C[K,I]+Rate[K,I];

            END;

      END; {* derivative *}


    PROCEDURE Predict (H : REAL;   First,Last: INTEGER);
    {****************}

      BEGIN

        FOR K:=1 TO LastReactor DO
          BEGIN
            FOR I:=First TO Last DO
              BEGIN
                CStart[K,I]:=C[K,I];           (*    preserve variable   *)
                dCdtStart[K,I]:=dCdt[K,I];     (*    preserve variable   *)
                C[K,I]:=C[K,I]+H*dCdt[K,I];
              END;
          END;

      END; {* predict *}

    PROCEDURE Correct ( H: REAL;    First,Last: INTEGER);
    {****************}

      BEGIN

        FOR K:=1 TO LastReactor DO
          BEGIN
            FOR I:=First TO Last DO
              BEGIN
                CCheck[K,I]:=C[K,I];        (*  preserve variable   *)
                C[K,I]:=H/2*(dCdtStart[K,I]+dCdt[K,I])+CStart[K,I];
                LocalEr[K,I]:=1/5*ABS(CCheck[K,I]-C[K,I]);
              END;
          END;

      END; {* corrector *}

    PROCEDURE CalcLocalError ( First,Last: INTEGER);
    {***********************}

      BEGIN
        LocalError :=1.0e-12;
          FOR K:=1 TO LastReactor DO
            FOR I:=First TO Last DO
              IF (LocalEr[K,I]/Epsilon[I]) > LocalError THEN
                LocalError := LocalEr[K,I]/Epsilon[I];

      END; {* local error *}

    PROCEDURE Interpolate ( H: REAL;    First,Last: INTEGER);
    {********************}

      BEGIN

        FOR K:=1 TO LastReactor DO
            FOR I:=First TO Last DO
                C[K,I]:=CStartStep[K,I]+dCdtStart[K,I]*TSmall;

      END; {* interpolate *}

    PROCEDURE PreserveVariable (First,Last :INTEGER;
                                VAR CPreserved: ReacAndComp);
    {*************************}

      BEGIN

        FOR K:=1 TO LastReactor DO
          BEGIN
            FOR I:=First TO Last DO
                CPreserved[K,I]:=C[K,I];
          END;

      END; {* preserve variable *}

    PROCEDURE RecoverVariable   (First,Last :INTEGER;
                                VAR CPreserved: ReacAndComp);
    {************************}
    var K9,I9 : integer;
      BEGIN

        FOR K9:=1 TO LastReactor DO
          BEGIN
            FOR I9:=First TO Last DO
                C[K9,I9]:=CPreserved[K9,I9];
          END;

      END; {* recover variable *}

    PROCEDURE CheckError;
    {*******************}

      BEGIN

          IF LocalError >= 1 THEN
            BEGIN
              TLarge:=Tlarge-DeltaTLarge;
              TSmall:=TSmall-DeltaTLarge;
              DeltaTLarge:=DeltaTLarge * EXP(1/3*LN(Theta/LocalError));
              RecoverVariable(FirstSlow,LastRapid,CStartStep);
            END;
          IF LocalError < 1 THEN
           DeltaTLarge:=DeltaTLarge * EXP(1/3*LN(Theta/LocalError));

      END; {* check error *}

    PROCEDURE CheckErrorSol;
    {**********************}

      BEGIN

          IF LocalError >= 1  THEN
            BEGIN
              TSmall:=TSmall-DeltaTSmall;
              DeltaTSmall:=DeltaTSmall*EXP(1/3 * LN (Theta/LocalError));
              RecoverVariable(FirstRapid,LastRapid,CStart);
            END;
      IF LocalError < 1 THEN
         DeltaTSmall:=DeltaTSmall*EXP(1/3 * LN (Theta/LocalError));

      END; {* check error sol *}


    BEGIN  {* integrate *}

      Tlarge:=0;
      Tsmall:=0;
{      ErrorCriterion;  }
      If TruncatedLarge = TRUE then DeltaTLarge := PrevDeltaTLarge;

      REPEAT
        TruncatedLarge := FALSE;
        IF (TLarge + DeltaTLarge) > IntegIntDays then
          BEGIN
           TruncatedLarge  := TRUE;
           PrevDeltaTLarge := DeltaTLarge;
           DeltaTLarge := IntegIntDays - TLarge;
          END;
        TLarge:=Tlarge+DeltaTlarge;

        GotoXY(46,24);
        ClrEol;
        TextColor(PrBoxCol.Text);
        Write(IntegTime+TLarge*24.0:6:2);

        Derivative(FirstSlow,LastSlow);
        PreserveVariable(FirstSlow,LastRapid,CStartStep);
        Predict(DeltaTLarge,FirstSlow,LastSlow);

        PreserveVariable(FirstSlow,LastSlow,CEnd); (*   before Interpolate   *)
        RecoverVariable(FirstSlow,LastSlow,CStartStep);

        IF TruncatedSmall = TRUE THEN DeltaTSmall := PrevDeltaTSmall;
        IF (LocalError >=1 )     THEN DeltaTSmall:=0.64/60/24;

          REPEAT

              TruncatedSmall := FALSE;
              If (TSmall + DeltaTSmall) > Tlarge then
                Begin
                  TruncatedSmall  := TRUE;
                  PrevDeltaTsmall := DeltaTsmall;
                  DeltaTSmall := TLarge - TSmall;
                End;
              TSmall:=TSmall+DeltaTSmall;
              Derivative(FirstRapid,LastRapid);
              Predict(DeltaTSmall,FirstRapid,LastRapid);

              Interpolate(DeltaTLarge,FirstSlow,LastSlow);

                Derivative(FirstRapid,LastRapid);
                Correct(DeltaTSmall,FirstRapid,LastRapid);
                CalcLocalError(FirstRapid,LastRapid);
                CheckErrorSol;

        UNTIL TSmall>=0.999*TLarge;


        RecoverVariable(FirstSlow,LastSlow,CEnd);   {* after Interpolate *}
        Derivative(FirstSlow,LastSlow);
        Correct(DeltaTLarge,FirstSlow,LastSlow);
        CalcLocalError(FirstSlow,LastSlow);
        CheckError;

      UNTIL Tlarge>=0.999*IntegIntDays;

    END; {* integrate *}



