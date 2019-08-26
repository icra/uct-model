Procedure WasteWaterUpdate;   { check/change wastewater composition }

Begin

  ValueDummy[1]  := StiAvg ;
  ValueDummy[2]  := NtiAvg ;
  ValueDummy[3]  := Fbs    ;
  ValueDummy[4]  := Fus    ;
  ValueDummy[5]  := Fup    ;
  ValueDummy[6]  := Fnaa   ;
  ValueDummy[7]  := Fnox   ;
  ValueDummy[8]  := Fnu    ;
  ValueDummy[9]  := Fxbh   ;
  ValueDummy[10] := VSSTSS;
  ValueDummy[11] := Alki;

  TextColor(SelectBoxCol.Frame);
  TextBackground(SelectBoxCol.Back);
  FrameInstructions(1,17,51,25);
  msg('Fbs   = readily biodegradable/biodegradable COD',3,1);
  msg('Fs,us = frac infl COD that is sol unbiodegrad',3,2);
  msg('Fs,up = frac infl COD that is part unbiodegrad',3,3);
  msg('Fn,a  = frac infl TKN that is NH3/NH4',3,4);
  msg('Fnob,p= frac organic bio N that is part',3,5);
  msg('Fn,ous= frac infl TKN that is organic unbio sol',3,6);
  msg('Fs,zbh= frac infl COD that is heterotrophs',3,7);
  Window(1,1,80,25);

  SelectConstant(WasteList);

  StiAvg  := ValueDummy[1] ;
  Sti     := StiAvg;
  NtiAvg  := ValueDummy[2] ;
  Nti     := NtiAvg;
  Fbs     := ValueDummy[3] ;
  Fus     := ValueDummy[4] ;
  Fup     := ValueDummy[5] ;
  Fnaa    := ValueDummy[6] ;
  Fnox    := ValueDummy[7] ;
  Fnu     := ValueDummy[8] ;
  Fxbh    := ValueDummy[9] ;
  VSSTSS  := ValueDummy[10] ;
  Alki    := ValueDummy[11] ;

End;  { wastewater update }

Procedure Settled;
  Begin
    Fbs    := 0.25;
    Fus    := 0.08;
    Fup    := 0.04;
    Fnaa   := 0.83;
    Fnox   := 0.50;
    Fnu    := 0.04;
    Fxbh   := 0.0;
    VSSTSS := 0.83;
  End;

Procedure Raw;
  Begin
    Fbs    := 0.20;
    Fus    := 0.05;
    Fup    := 0.13;
    Fnaa   := 0.75;
    Fnox   := 0.50;
    Fnu    := 0.03;
    Fxbh   := 0.0;
    VSSTSS := 0.75;
  End;


  Procedure InfluentSewage;

  label 100;

    Begin

      FlashScreen;
      If WasteSpecified      { something already input }
        then
         begin
          if DiurnalDataSpecified   { diurnal input already }
           then
             begin
              DiurnalDataInput;
              StiAvg := MeanCOD;
              NtiAvg := MeanTKN;
             end
           else           { only a steady state input so far, but... }
             begin
              InputBox(MainMenu.CurrentOption);
              msg('Set up a Diurnal Pattern? Y/N....',2,3);
              repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
              if UpCase(YesNo) = 'Y' then
                                       begin
                                        DiurnalDataInput;
                                        StiAvg := MeanCOD;
                                        NtiAvg := MeanTKN;
                                       end;
             end
         end

       else        { this is input for the first time }
         begin
          MainBox(MainMenu.CurrentOption);
          ReverseVideo(MainBoxCol);
          msg('****  INFLUENT WASTEWATER CHARACTERISTICS  ****',3,1);
          NormalVideo(MainBoxCol);
          msg('Calculate averages from a Diurnal Pattern? Y/N...',2,3);
          repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
          if UpCase(YesNo) = 'Y'
            then
             begin
              Window(1,1,80,25);
              FlashScreen;
              DiurnalDataInput;
              StiAvg := MeanCOD;
              NtiAvg := MeanTKN;
              if NOT DiurnalDataSpecified then goto 100;
             end
            else
             begin
              msg('  Average Influent COD (g COD m-3)  =  ',2,3);
              StiAvg := GetReal(0.1,10000.0);
              msg('  Average Influent TKN (g N m-3)    =  ',2,5);
              NtiAvg := GetReal(0.1,10000.0);
              SteadyDataSpecified := true;
             end;

          if SteadyDataSpecified or DiurnalDataSpecified then
           begin
            WasteSpecified := true;
            Sti := StiAvg;
            Nti := NtiAvg;
            Alki := 10.0;    { set influent alkalinity first time }

            InputBox(MainMenu.CurrentOption);
            msg('Settled or Raw sewage? (S/R)....',3,3);
            repeat YesNo := ReadKey until UpCase(YesNO) IN ['S','R'];
            If UpCase(YesNo) = 'S'then Settled
                                  else Raw;
           end;

         end;

      Window(1,1,80,25);
      FlashScreen;
      WastewaterUpdate;
      PrintOut('wastewater characteristics');
      FractionateInfluent;

    100:

    End;  { influent sewage }

