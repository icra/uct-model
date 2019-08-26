Procedure ModifyWastage;  { modify sludge wastage pattern }

Procedure WriteARecord (i : integer);
 Begin
   TextColor(MainBoxCol.Text);
   TextBackground(MainBoxCol.Back);
   MainWindow(1);
   WriteIntgrFldRev(i,6,3+i,2);
   WriteRealFldDec(Time[i],16,3+i,4,1);
   if WastageOn[i] then msg('Yes',31,3+i)
                   else msg(' No',31,3+i);
   WriteRealFldDec(FlowWaste[i],46,3+i,7,2);
 End;


Procedure OutputWastePattern;
  Begin
    MainBox(1);
    ReverseVideo(MainBoxCol);
    msg('******  SLUDGE WASTAGE PATTERN  ******',10,1);
    msg('Record No',2,3);
    msg('Time (h)',15,3);
    msg('Wastage On',28,3);
    msg('Waste Flow (',43,3); write(VolType:3,' d-1)');
    NormalVideo(MainBoxCol);
    For i:=1 to NoDiurnalInts do WriteARecord(i);
    msg('** Mean wastage rate =',4,17);
    WriteRealFldDec(FlowWasteAvg,10,19,7,2);
    write(VolType:3,'/d');
  End;  { output waste pattern }

Procedure ChangeARecord;
  Begin
    TextColor(InputBoxCol.Text);
    TextBackground(InputBoxCol.Back);
    msg('Switch any on/off? Y/N.... ',2,1);
    Repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
    If UpCase(YesNo) = 'Y' then
      begin
        ClrScr;
        msg('Change in Record No. ',2,1);
        RecordNo := GetInteger(1,NoDiurnalInts);
        if DynamicFlow[RecordNo] > FlowWasteAvg*12/NoWasteInts then
          begin
            WastageOn[RecordNo] := NOT WastageOn[RecordNo];
            ClrScr;
            if WastageOn[RecordNo] = true then NoWasteInts := NoWasteInts + 1
                                          else NoWasteInts := NoWasteInts - 1;
            for i := 1 to NoDiurnalInts do
              if  WastageOn[i] then FlowWaste[i] := FlowWasteAvg*12/NoWasteInts
                               else FlowWaste[i] := 0.0;
          end;
        for i:=1 to NoDiurnalInts do WriteARecord(i);
      end;
  End;   { change a record }

  Begin    { modify wastage }
    OutputWastePattern;
    Repeat
      InputBox(1);
      ChangeARecord;
    Until UpCase(YesNo) <> 'Y';
  End;  { modify wastage }