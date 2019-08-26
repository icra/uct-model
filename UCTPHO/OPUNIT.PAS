Unit OpUnit;

interface

uses Crt,
     VarsUnit,
     IOUnit,
     PrtUnit;

Procedure ProcessOperation;

implementation

  Procedure OutputOperation;
    Begin
      FlashScreen;
      MainBox(MainMenu.CurrentOption);
      ReverseVideo(MainBoxCol);
      Msg('******  PLANT OPERATING PARAMETERS  ******',3,1);
      NormalVideo(MainBoxCol);

      WriteIntgrFldRev(1,2,3,1);
      Msg('SRT {total}            d          =',6,3);
      WriteRealFldDec(Rs,43,3,8,1);

      WriteIntgrFldRev(2,2,4,1);
      Msg('Process Temperature    degC       =',6,4);
      WriteRealFldDec(Temp,43,4,8,1);

      Msg('Flow rates:',2,6);

      WriteIntgrFldRev(3,2,7,1);
      Msg('Influent flow          ',6,7); write(VolType:2,' d-1    =');
      WriteRealFldDec(FlowFeedAvg,43,7,8,1);

      WriteIntgrFldRev(4,2,8,1);
      Msg('RAS recycle flow       ',6,8);write(VolType:2,' d-1    =');
      WriteRealFldDec(FlowRASrecycle,43,8,8,1);

      If ARecycleSet then
        begin
          WriteIntgrFldRev(5,2,9,1);
          Msg('A-recycle flow         ',6,9); write(VolType:2,' d-1    =');
          WriteRealFldDec(FlowArecycle,43,9,8,1);
        end;

      If BRecycleSet then
        begin
          WriteIntgrFldRev(6,2,10,1);
          Msg('B-recycle flow         ',6,10); write(VolType:2,' d-1    =');
          WriteRealFldDec(FlowBrecycle,43,10,8,1);
        end;
    End;  {* operation output *}


  Procedure ProcessOperation;

  Procedure SludgeAge;
    Begin
      InputBox(MainMenu.CurrentOption);
      Msg(' Operating sludge age (SRT) of plant (days) = ',2,2);
      Rs := GetReal(0,100);
      MainWindow(MainMenu.CurrentOption);
      WriteIntgrFldRev(1,2,3,1);
      Msg('SRT {total}            d          =',6,3);
      WriteRealFldDec(Rs,43,3,8,1);
    End;

  Procedure Temperature;
    Begin
      InputBox(MainMenu.CurrentOption);
      Msg(' Operating temperature of plant (degC) = ',2,2);
      Temp := GetReal(8,35);
      MainWindow(MainMenu.CurrentOption);
      WriteIntgrFldRev(2,2,4,1);
      Msg('Process Temperature    degC       =',6,4);
      WriteRealFldDec(Temp,43,4,8,1);
    End;

  Procedure FeedRate;
    Begin
      InputBox(MainMenu.CurrentOption);
      if DiurnalDataSpecified
                      then FlowFeedAvg := MeanFlow
                      else
                       begin
                        Msg('Average influent flow (',2,2);
                              write(VolType:2,' d-1)  = ');
                        FlowFeedAvg := GetReal(0,1.0e20);
                       end;
      FlowFeed := FlowFeedAvg;
      MainWindow(MainMenu.CurrentOption);
      Msg('Flow rates:',2,6);
      WriteIntgrFldRev(3,2,7,1);
      Msg('Influent flow          ',6,7); write(VolType:2,' d-1    =');
      WriteRealFldDec(FlowFeedAvg,43,7,8,1);
    End;

  Procedure RASRecycleRate;
    Begin
      InputBox(MainMenu.CurrentOption);
      Msg('  RAS-recycle Flow (',2,2); write(VolType:2,' d-1) = ');
      FlowRASrecycle := GetReal(0,1.0e20);
      MainWindow(MainMenu.CurrentOption);
      WriteIntgrFldRev(4,2,8,1);
      Msg('RAS recycle flow       ',6,8); write(VolType:2,' d-1    =');
      WriteRealFldDec(FlowRASrecycle,43,8,8,1);
    End;

  Procedure ARecycleRate;
    Begin
      InputBox(MainMenu.CurrentOption);
      Msg('  A recycle Flow (',2,2); write(VolType:2,' d-1) = ');
      FlowArecycle := GetReal(0,1.0e20);
      MainWindow(MainMenu.CurrentOption);
      WriteIntgrFldRev(5,2,9,1);
      Msg('A-recycle flow         ',6,9); write(VolType:2,' d-1    =');
      WriteRealFldDec(FlowArecycle,43,9,8,1);
    End;

  Procedure BRecycleRate;
    Begin
      InputBox(MainMenu.CurrentOption);
      Msg('  B recycle Flowrate (',2,2); write(VolType:2,' d-1) = ');
      FlowBrecycle := GetReal(0,1.0e20);
      MainWindow(MainMenu.CurrentOption);
      WriteIntgrFldRev(6,2,10,1);
      Msg('B-recycle flow         ',6,10); write(VolType:2,' d-1    =');
      WriteRealFldDec(FlowBrecycle,43,10,8,1);
    End;

    Begin  {* process operation *}
      If OperationSpecified
       then OutputOperation
       else
        begin
          FlashScreen;
          MainBox(MainMenu.CurrentOption);
          ReverseVideo(MainBoxCol);
          Msg('******  PLANT OPERATING PARAMETERS  ******',3,1);
          NormalVideo(MainBoxCol);
          SludgeAge;
          Temperature;
          FeedRate;
          RASRecycleRate;
          If ARecycleSet then ARecycleRate;
          If BRecycleSet then BRecycleRate;
        end;

      Repeat
        FinalIndex:=4;
        If ARecycleSet then FinalIndex:=5;
        If BRecycleSet then FinalIndex:=6;
        InputBox(MainMenu.CurrentOption);
        ChangeParameter;
        If UpCase(ChangeAgain) = 'Y' then
          begin
            Case Group of
               1 : SludgeAge;
               2 : Temperature;
               3 : FeedRate;
               4 : RASRecycleRate;
               5 : ARecycleRate;
               6 : BRecycleRate;
              end;
            SteadyStateSpecified := False;
          end;
      Until UpCase(ChangeAgain) = 'N';

      PrintOut('operating conditions');

    End;  {* process operation *}

end.  { of OpUnit }