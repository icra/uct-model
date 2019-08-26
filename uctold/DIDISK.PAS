Procedure StoreOnDisk;  { store diurnal data on disk }

var
 FileDummy,Ext   : String;

  Begin
    AssignCrt(OutFile);
    Rewrite(OutFile);
    MainBox(1);
    TextColor(MainBoxCol.Text);
    TextBackground(MainBoxCol.Back);
    Ext := 'DID';
    DirList(Ext);
    InputBox(1);
    TextColor(InputBoxCol.Text);
    TextBackground(InputBoxCol.Back);
    msg('Do you wish to store these',3,2);
    msg('data on disk ?  Y/N.... ',10,3);
    Repeat YesNo := ReadKey Until UpCase(YesNo) in ['Y','N'];
    If UpCase(YesNo) = 'Y' then
      begin
        ClrScr;
        msg('Enter data file name :',3,1);
        msg('e.g. PLANT1',10,3);
        msg('FileName = ',10,5);
        repeat
         Readln(FileDummy);
         GoToXY(22,5);
        until FileDummy <> '';
        msg('Wait...',20,6);
        Ext := 'DID';
        SetUpFileName(FileDummy,Ext);
        Assign(EFFLUENT,FileDummy);
        Rewrite(EFFLUENT);
        for k := 1 to LastReactor do
            for j := 0 to DataPerDay do
              for i := 1 to NoDiVars do
                write(EFFLUENT,Response[k]^[i,j]);
        Close(EFFLUENT);

      end;
    Close(OutFile);
  End;  { store data }


