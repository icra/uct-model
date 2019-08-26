Unit CfgUnit;

interface

uses Crt,
     VarsUnit,
     IOUnit,
     PrtUnit;

Procedure ProcessConfiguration;

implementation

Procedure Heading1;
 Begin
   FlashScreen;
   MainBox(MainMenu.CurrentOption);
   ReverseVideo(MainBoxCol);
   Msg('  **** PROCESS CONFIGURATION ****  ',3,1);
   Msg('Gp 1. Number of Reactors',42,1);
   NormalVideo(MainBoxCol);
 End;

Procedure Heading2;
 Begin
   MainWindow(MainMenu.CurrentOption);
   ReverseVideo(MainBoxCol);
   Msg('Gp 2. Reactor Vols,',8,3); write(VolType:2);
   NormalVideo(MainBoxCol);
   for k := 1 to LastReactor do
    begin
      GoToXY(3,4+k);
      write('No.',k:2,':');
    end;
 End;

Procedure Heading3;
 Begin
   MainWindow(MainMenu.CurrentOption);
   ReverseVideo(MainBoxCol);
   Msg('Gp 3. Feed Fraction',33,3);
   NormalVideo(MainBoxCol);
End;

Procedure Heading4;
 Begin
   MainWindow(MainMenu.CurrentOption);
   ReverseVideo(MainBoxCol);
   Msg('Gp 4. Aeration/DO',55,3);
   NormalVideo(MainBoxCol);
End;

Procedure Heading5;
 Begin
   MainWindow(MainMenu.CurrentOption);
   ReverseVideo(MainBoxCol);
   Msg('Gp 5. Recycles:',3,6+LastReactor);
   NormalVideo(MainBoxCol);
   write('   Use to include/remove mixed liquor recycles.');
 End;

Procedure WriteNoReactors;
 Begin
  MainWindow(MainMenu.CurrentOption);
  GoToXY(66,1);
  write(' = ',LastReactor);
 End;

Procedure WriteVol (k : integer);
 Begin
  MainWindow(MainMenu.CurrentOption);
  WriteRealFldDec(Vol[k],11,4+k,13,2);
 End;

Procedure WriteFrac (k : integer);
 Begin
  MainWindow(MainMenu.CurrentOption);
  WriteRealFldDec(FracFeed[k],35,4+k,9,2);
 End;

Procedure WriteDOConc (k : integer);
 Begin
  MainWindow(MainMenu.CurrentOption);
  If ReactorAerated[k] then WriteRealFldDec(DOConc[k],58,4+k,7,1)
                       else Msg('Unaerated',58,4+k);
 End;

Procedure WriteDOStatus (k : integer);
 Begin
  MainWindow(MainMenu.CurrentOption);
  If ReactorAerated[k] then Msg('Aerated  ',58,4+k)
                       else Msg('Unaerated',58,4+k);
 End;

Procedure WriteARecycle;
 Begin
  MainWindow(MainMenu.CurrentOption);
  Msg('A recycle : Out of Reactor No.',4,LastReactor+8);
  write(ReactorAOut);
  Msg('Into Reactor No.',16,LastReactor+9);
  write(ReactorAIn);
 End;

Procedure WriteBRecycle;
 Begin
  MainWindow(MainMenu.CurrentOption);
  Msg('B recycle : Out of Reactor No.',41,LastReactor+8);
  write(ReactorBOut);
  Msg('Into Reactor No.',53,LastReactor+9);
  write(ReactorBIn);
 End;

Procedure WriteRASRecycle (k : integer);
 Begin
  MainWindow(MainMenu.CurrentOption);
  if ARecycleSet then GoToXY(4,LastReactor+11)
                 else GoToXY(4,LastReactor+8);
  write('RAS recycle to Reactor No.',k);
 End;

Procedure OutputConfiguration;

  Begin
    Heading1;
    WriteNoReactors;
    Heading2;
    Heading3;
    Heading4;

    for k := 1 to LastReactor do
      begin
        WriteVol(k);
        WriteFrac(k);
        WriteDOConc(k);
      end;

    If LastReactor > 1 then
      begin
        Heading5;
        If ARecycleSet then
          begin
            WriteARecycle;
            If BRecycleSet then WriteBRecycle;
          end;
        For i := 1 to LastReactor do
          If FlagRASIn[i]=1 then DumInt:=I;
        WriteRASRecycle(DumInt);
      end;

  End;  { configuration output }


  Procedure ProcessConfiguration;
  {*****************************}

  Procedure NoReactors;
    Begin

      InputBox(MainMenu.CurrentOption);
      Msg(' Number of reactors (max ',2,2);
      write(ReacAvail,')  =  ');
      LastReactor := GetInteger(1,ReacAvail);
      If LastReactor > 1 then Heading1;   { make a bigger box }
      WriteNoReactors;

      For i := 1 to LastReactor+1 do
        begin
          Vol[i]:=0.0;
          ReactorAerated[i]    := TRUE;
          FracFeed[i]          := 0.0;
          FlagRASIn[i]         := 0;
          FlagAIn[i]           := 0;
          FlagBIn[i]           := 0;
          FlagAOut[i]          := 0;
          FlagBOut[i]          := 0;
          FlowInTotal[i]       := 0.0;
          FlowFromPrevious[i]  := 0.0;
        end;
      RecyclesSet   := false;
      ARecycleSet   := false;
      BRecycleSet   := false;
      FlowARecycle             := 0.0;
      FlowBRecycle             := 0.0;
      ReactorAOut              := 0;
      ReactorAIn               := 0;
      ReactorBOut              := 0;
      ReactorBIn               := 0;
      If LastReactor = 1
        then
          begin
            DOConc[1]    := 3.0;
            FracFeed[1]  := 1.0;
            FlagRASIn[1] := 1;
          end;
    End;

  Procedure UnAeratedFraction;
    Begin
      VolumeUnaerated:=0.0;
      For i := 1 to LastReactor do
        If NOT ReactorAerated[i]
          then VolumeUnaerated:=VolumeUnaerated+Vol[i];
    End;

  Procedure ReactorVolumes;
    Begin
      Heading2;
      InputBox(MainMenu.CurrentOption);
      GoToXY(2,1);
      write(' Enter reactor volume(s) - ',VolType:2,':');
      For k := 1 to LastReactor do
        begin
          InputWindow(MainMenu.CurrentOption);
          GoToXY(8,3); ClrEol;
          write('Reactor No. ',k,'  =  ');
          Vol[k] := GetReal(0.01,1.0e20);
          WriteVol(k);
        end;
    End;

  Procedure DistributeFeed;
    Begin
      Heading3;
      for k := 1 to LastReactor do
        begin
          FracFeed[k] := 0.0;
          GoToXY(35,4+k);
          write(' ':9);
        end;

      InputBox(MainMenu.CurrentOption);
      GoToXY(2,1);
      write('Fractional influent distribution:');
      CumVol := 0.0; k := 0;
      Repeat
        InputWindow(MainMenu.CurrentOption);
        K:=K+1;
        GoToXY(4,3);
        ClrEol;
        write('Fraction to Reactor No. ',k,' = ');
        FracFeed[k] := GetReal(0,1-CumVol);
        CumVol:=CumVol+FracFeed[k];
        WriteFrac(k);
      Until (CumVol >=1) OR (K=LastReactor-1);
      if CumVol < 1 then   { remaining flow to last reactor }
        begin
          FracFeed[LastReactor] := 1 - CumVol;
          WriteFrac(LastReactor);
        end;
      writeln;
    End;

  Procedure Recycles;
    Begin
      RecyclesSet   := TRUE;
      ARecycleSet   := FALSE;
      BRecycleSet   := FALSE;
      ReactorAOut   := 0;
      ReactorAIn    := 0;
      ReactorBOut   := 0;
      ReactorBIn    := 0;
      FlowARecycle  := 0.0;
      FlowBRecycle  := 0.0;
      DumInt        := 0;
      For i := 1 to LastReactor+1 do
        begin
          FlagRASIn[i]         := 0;
          FlagAIn[i]           := 0;
          FlagBIn[i]           := 0;
          FlagAOut[i]          := 0;
          FlagBOut[i]          := 0;
        end;

      Heading5;
      GoToXY(4,LastReactor+8); ClrEol;
      GoToXY(16,LastReactor+9); ClrEol;
      GoToXY(4,LastReactor+11); ClrEol;

      InputBox(MainMenu.CurrentOption);
      Msg('Any inter-reactor mixed liquor',2,2);
      Msg('recycles?  Y/N.... ',6,3);
      Repeat YesNo := ReadKey Until UpCase(YesNo) in ['Y','N'];
      If UpCase(YesNo) = 'N'
        then
          begin
            FlagRASIn[1]:=1;
            WriteRASRecycle(1);
          end
        else
          begin
            InputWindow(MainMenu.CurrentOption);
            ClrScr;
            ARecycleSet := TRUE;
            Msg('A recycle : Out of Reactor No. ',2,2);
            DumInt := GetInteger(1,LastReactor);
            FlagAOut[DumInt]:=1;
            ReactorAOut:=DumInt;
            Msg('Into Reactor No. ',14,3);
            DumInt := GetInteger(1,LastReactor);
            FlagAIn[DumInt]:=1;
            ReactorAIn:=DumInt;
            ClrScr;
            WriteARecycle;

            InputWindow(MainMenu.CurrentOption);
            Msg(' Another mixed liquor recycle?',2,1);
            Msg('Y/N.... ',10,3);
            Repeat YesNo := ReadKey Until UpCase(YesNo) in ['Y','N'];
            ClrScr;
            If UpCase(YesNo) = 'Y' then
              begin
                BRecycleSet := TRUE;
                Msg('B recycle : Out of Reactor No. ',2,2);
                DumInt := GetInteger(1,LastReactor);
                FlagBOut[DumInt]:=1;
                ReactorBOut:=DumInt;
                Msg('Into Reactor No.',14,3);
                DumInt := GetInteger(1,LastReactor);
                FlagBIn[DumInt]:=1;
                ReactorBIn:=DumInt;
                ClrScr;
                WriteBRecycle;
              end;

            InputWindow(MainMenu.CurrentOption);
            Msg('RAS recycle from settler to',2,1);
            Msg('Reactor No.',6,3);
            DumInt := GetInteger(1,LastReactor);
            FlagRASIn[DumInt]:=1;
            WriteRASRecycle(DumInt);
          end;
    End;

  Procedure AerationPattern;
    Begin
      Heading4;

      If LastReactor > 1 then
      begin
        For i := 1 to LastReactor do WriteDOStatus(i);
        InputBox(MainMenu.CurrentOption);
        Msg('Reactor aeration pattern:',2,1);
        Repeat
         InputWindow(MainMenu.CurrentOption);
         Msg('Make any changes?  Y/N..... ',6,3);
         Repeat YesNo := ReadKey Until UpCase(YesNo) in ['Y','N'];
         If UpCase(YesNo) = 'Y' then
          begin
            GoToXY(6,3); ClrEol;
            write('  Change Reactor No. ');
            DumInt := GetInteger(1,LastReactor);
            ReactorAerated[DumInt]:= NOT ReactorAerated[DumInt];
            WriteDOStatus(DumInt);
          end;
        Until UpCase(YesNo) = 'N';
      end;

      InputBox(MainMenu.CurrentOption);
      Msg('Aerated reactor DO setpoints:',2,1);
      Msg('e.g.  3   (g O m-3)',8,2);
      For i := 1 to LastReactor do
        begin
          InputWindow(MainMenu.CurrentOption);
          If NOT ReactorAerated[i] then DOConc[i]:=0.0
            else
              begin
                GoToXY(4,4); ClrEol;
                write('Reactor No. ',i,' : DO setpoint = ');
                DOConc[i] := GetReal(0,12);
              end;
          MainWindow(MainMenu.CurrentOption);
          WriteDOConc(i);
        end;

    End;


    Begin   { process configuration }

      ClrScr;

      If ConfigSpecified
       then
        begin
          OutputConfiguration;
          Changed := false;
         end
       else
        begin
          LastReactor := 1;   { dummy to get small initial window }
          Changed := true;
          Heading1;
          NoReactors;
          ReactorVolumes;
          If LastReactor = 1
            then
              begin
                Heading3;
                WriteFrac(1);
                Heading4;
                WriteDOConc(1);
              end
            else
              begin
                DistributeFeed;
                AerationPattern;
                Recycles;
              end;
        End;

      Repeat

        If LastReactor > 1 then FinalIndex:=5
                           else FinalIndex:=4;
        InputBox(MainMenu.CurrentOption);
        ChangeParameter;
        If UpCase(ChangeAgain) = 'Y' then
          begin
            Changed := true;
            If Group = 1 then
              begin
                Heading1;
                NoReactors;
                ReactorVolumes;
                If LastReactor = 1
                 then
                  begin
                    Heading3;
                    WriteFrac(1);
                    Heading4;
                    WriteDOConc(1);
                  end
                 else
                  begin
                    DistributeFeed;
                    AerationPattern;
                    Recycles;
                  end;
              end;
            If Group = 2 then ReactorVolumes;
            If ( (Group = 3) and (LastReactor > 1) ) then DistributeFeed;
            If Group = 4 then AerationPattern;
            If Group = 5 then Recycles;
            SteadyStateSpecified := False;

          end;
      Until UpCase(ChangeAgain) = 'N';

      UnAeratedFraction;

      VolumeTotal:=0.0;
      For k := 1 to LastReactor do VolumeTotal:=VolumeTotal+Vol[k];
      ClrScr;

      PrintOut('process configuration');

    End;  { process configuration }

End.
