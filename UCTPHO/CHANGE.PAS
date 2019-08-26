  PROCEDURE ChangeParameter;
    Begin
      GoToXY(2,1);
      WRITE('Do you wish to change any parameters?');
      GoToXY(10,3);
      write('Y/N.... ');
      REPEAT ChangeAgain := ReadKey UNTIL UpCase(ChangeAgain) in ['Y','N'];
      IF UpCase(ChangeAgain) = 'Y' THEN
        begin
          GoToXY(6,3); ClrEol;
          WRITE('In which group?  1,2,..,',FinalIndex,'    ');
          Group := GetInteger(1,FinalIndex);
        end;
      ClrScr;
    End;
