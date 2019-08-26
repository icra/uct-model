Procedure WriteARecord (i : integer);
 Begin
   TextColor(MainBoxCol.Text);
   TextBackground(MainBoxCol.Back);
   MainWindow(MainMenu.CurrentOption);
   WriteIntgrFldRev(i,6,3+i,2);
   WriteRealFldDec(Time[i],16,3+i,4,1);
   WriteRealFldDec(DynamicFlow[i],21,3+i,12,1);
   WriteRealFldDec(DynamicSti[i],42,3+i,6,1);
   WriteRealFldDec(DynamicNti[i],55,3+i,5,1);
 End;

Procedure WriteAverages;
 Begin
   TextColor(MainBoxCol.RevText);
   TextBackground(MainBoxCol.RevBack);
   MainWindow(MainMenu.CurrentOption);
   msg('** Calculated Mean Values :',4,17);
   msg('Flowrate = ',10,18);
   WriteRealFldDec(MeanFlow,22,18,7,1);
   msg('COD      = ',10,19);
   WriteRealFldDec(MeanCOD,22,19,7,1);
   msg('TKN      = ',10,20);
   WriteRealFldDec(MeanTKN,22,20,7,1);
 End;

Procedure Averages;
  Begin
    CumFlow     := 0.0;
    CumCODLoad  := 0.0;
    CumTKNLoad  := 0.0;
    For i := 1 to NoDiurnalInts do
      begin
        CumFlow    := CumFlow+DynamicFlow[i];
        CumCODLoad := CumCODLoad+DynamicFlow[i]*DynamicSti[i];
        CumTKNLoad := CumTKNLoad+DynamicFlow[i]*DynamicNti[i];
      end;
    MeanFlow := CumFlow/NoDiurnalInts;
    MeanCOD  := CumCODLoad/CumFlow;
    MeanTKN  := CumTKNLoad/CumFlow;
  End;     { averages }


Procedure OutputDiurnalPattern;
  Begin
    MainBox(MainMenu.CurrentOption);
    Averages;
    ReverseVideo(MainBoxCol);
    msg('******  DIURNAL INPUT PATTERN  ******',10,1);
    msg('Record No',2,3);
    msg('Time (h)',15,3);
    msg('Flow(',25,3); write(VolType:3,' d-1)');
    msg(' COD (g m-3) ',39,3);
    msg(' TKN (g m-3) ',52,3);
    NormalVideo(MainBoxCol);
    For i:=1 to NoDiurnalInts do WriteARecord(i);
    Averages;
    WriteAverages;
  End;  { output diurnal pattern }


Procedure ChangeARecord(var ChangedOne : boolean);
  Begin
    ChangedOne := false;
    TextColor(InputBoxCol.Text);
    TextBackground(InputBoxCol.Back);
    msg('Change any values? Y/N.... ',2,1);
    Repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
    If UpCase(YesNo) = 'Y' then
      begin
        ChangedOne := true;
        ClrScr;
        msg('Change in Record No. ',2,1);
        RecordNo := GetInteger(1,NoDiurnalInts);
        ClrScr;
        GoToXY(2,1);
        Write('Time (hours) =  ',(RecordNo-1)*2,'h00 :');
        Time[RecordNo]:=(RecordNo-1)*2.0;
        msg('Flowrate (',4,3); write(VolType:3,' d-1) = ');
          DynamicFlow[RecordNo] := GetReal(0.0,1.0e20);
        msg('COD (gCOD m-3)      = ',4,4);
          DynamicSti[RecordNo] := GetReal(0.0,1.0e20);
        msg('TKN (gN m-3)        = ',4,5);
          DynamicNti[RecordNo] := GetReal(0.0,1.0e20);
        WriteARecord(RecordNo);
        Averages;
        WriteAverages;
      end;
  End;   { change a record }


Procedure StoreData;

var
 FileDummy,Ext   : String;

  Begin
    InputBox(MainMenu.CurrentOption);
    TextColor(InputBoxCol.Text);
    TextBackground(InputBoxCol.Back);
    msg('Do you wish to store these',3,2);
    msg('data on disk ?  Y/N.... ',10,3);
    Repeat YesNo := ReadKey Until UpCase(YesNo) in ['Y','N'];
    If UpCase(YesNo) = 'Y' then
      begin
        ClrScr;
        msg('Enter data file name :',3,1);
        msg('e.g. INFDATA1',10,3);
        msg('FileName = ',10,5);
        repeat
         Readln(FileDummy);
         GoToXY(22,5);
        until FileDummy <> '';
        Ext := 'DAT';
        SetUpFileName(FileDummy,Ext);
        Assign(INFLUENT,FileDummy);
        Rewrite(INFLUENT);
        For j := 1 to 12 do Write(INFLUENT,Time[j],DynamicFlow[j],
                                     DynamicSti[j],DynamicNti[j]);
        Close(INFLUENT);

      end;
  End;  { store data }


Procedure DiskDataInput;

var
  FileDummy,Ext   : String;
  OK,FileSelected : Boolean;
  Answer          : Char;

Begin
  AssignCrt(OutFile);
  Rewrite(OutFile);
  MainBox(MainMenu.CurrentOption);
  TextColor(MainBoxCol.Text);
  TextBackground(MainBoxCol.Back);
  Ext := 'DAT';
  DirList(Ext);
  InputBox(MainMenu.CurrentOption);
  TextColor(InputBoxCol.Text);
  TextBackground(InputBoxCol.Back);
  msg('Enter data file name:',3,2);
  msg('e.g. INFLNT1',8,3);

  FileSelected := false;
  Repeat
    GoToXY(3,5);
    ClrEol;
    Write('FileName = ');
    Readln(FileDummy);
    SetUpFileName(FileDummy,Ext);
    Assign(INFLUENT,FileDummy);
    {$I-} RESET(INFLUENT) {$I+};
    OK := (IOResult = 0);
    If not OK then
      begin
        msg('No file...  ',3,5);
        Write(FileDummy);
        msg('Enter another ? Y/N...',5,6);
        Repeat Answer := ReadKey Until UpCase(Answer) in ['Y','N'];
        GoToXY(1,6);
        ClrEol;
      end;
   Until OK or (UpCase(Answer) = 'N');

   Window(1,1,80,25);

   If OK then
     begin
       {$I-}
       For i:=1 to 12 do READ(INFLUENT,Time[i],DynamicFlow[i],
                                               DynamicSti[i],
                                               DynamicNti[i]);
       Close(INFLUENT);
       {$I+}

       OK := (IOResult = 0);
       If OK then
         begin
           FileSelected := true;
           MainBox(MainMenu.CurrentOption);
           OutputDiurnalPattern;
           Repeat
             InputBox(MainMenu.CurrentOption);
             ChangeARecord(Changed);
           Until UpCase(YesNo) <> 'Y';
           If Changed then StoreData;
         end
         else
           begin
             MainWindow(MainMenu.CurrentOption);
             ClrScr;
             msg('There has been a disk READ ERROR',8,10);
             msg('The procedure has been aborted',8,12);
             msg('Press any key to continue... ',8,14);
             Answer := ReadKey;
           end;
     end;

  If FileSelected then DiurnalDataSpecified := true;
End;  { disk data input }


Procedure KbdDataInput;

    Begin

      FlashScreen;
      MainBox(MainMenu.CurrentOption);
      ReverseVideo(MainBoxCol);
      msg('CREATING DATA FOR DYNAMIC ANALYSIS',10,1);
      NormalVideo(MainBoxCol);
      msg('To utilise the program for the simulation of dynamic process',3,3);
      msg('response it is necessary first to set up arrays which contain',3,4);
      msg('the time-varying values of the influent FLOWRATE, COD and TKN.',3,5);
      msg('The program requires 12 sets of values; that is, two-hourly',3,6);
      msg('values. These values can be stored on the working disk drive',3,7);
      msg('once the user is satisfied.',3,8);
      msg('** Hit any key to continue... ',10,11);
      YesNo := ReadKey;

      MainBox(MainMenu.CurrentOption);
      ReverseVideo(MainBoxCol);
      msg('******  DIURNAL INPUT PATTERN  ******',10,1);
      msg('Record No',2,3);
      msg('Time (h)',15,3);
      msg('Flow(',25,3);write(VolType:3,' d-1');
      msg(' COD (g m-3) ',39,3);
      msg(' TKN (g m-3) ',52,3);
      NormalVideo(MainBoxCol);
      InputBox(MainMenu.CurrentOption);
      For i:=1 to NoDiurnalInts do
        begin
          InputWindow(MainMenu.CurrentOption);
          ClrScr;
          GoToXY(2,1);
          Write('Time (hours) =  ',(i-1)*2,'h00 :');
          Time[i]:=(i-1)*2.0;
          msg('Flowrate (',4,3); write(VolType:3,' d-1) = ');
            DynamicFlow[i] := GetReal(0.0,1.0e20);
          msg('COD (gCOD m-3)      = ',4,4);
            DynamicSti[i] := GetReal(0.0,1.0e20);
          msg('TKN (gN m-3)        = ',4,5);
            DynamicNti[i] := GetReal(0.0,1.0e20);
          WriteARecord(i);
        end;
      Averages;
      WriteAverages;

      Repeat
        InputBox(MainMenu.CurrentOption);
        ChangeARecord(Changed);
      Until UpCase(YesNo) <> 'Y';

      StoreData;

      DiurnalDataSpecified := true;

End;   { kbd data input }


Procedure DiurnalDataInput;

Begin
  If DiurnalDataSpecified
    then
      begin
        MainBox(MainMenu.CurrentOption);
        OutputDiurnalPattern;
        InputBox(MainMenu.CurrentOption);
        msg('Select a new data set',3,2);
        msg('from disk? Y/N....',10,4);
        Repeat YesNo := ReadKey Until UpCase(YesNo) in ['Y','N'];
        If UpCase(YesNo) = 'Y'
          then DiskDataInput
          else
            begin
              Changed := false;
              Repeat
                InputBox(MainMenu.CurrentOption);
                ChangeARecord(Changed);
              Until UpCase(YesNo) <> 'Y';
              If Changed then StoreData;
            end;
      end
    else
      begin
        With DataInputMenu do
        begin
          FlashScreen;
          CurrentOption := 1;
          SelectOption(DataInputMenu);
          FlashScreen;
          Case CurrentOption of
             1 : DiskDataInput;
             2 : KbdDataInput;
                end;
        end;
      end;

  If DiurnalDataSpecified then PrintOut('diurnal input');

End;  { diurnal data input }

