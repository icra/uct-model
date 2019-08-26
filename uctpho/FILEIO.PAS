PROCEDURE SetUpFileName( Var FileName, Ext : String);

Var
  Place,Long        : Integer;

Begin
  Place := Pos('.',FileName);
  Long  := Length(FileName);
  Case Place of
    0   :   if Long > 8 then Delete(FileName,9,Long-8);
    else    begin
              Delete(FileName,Place,Long-Place+1);
              Long := Length(FileName);
              If Long > 8 then Delete(FileName,9,Long-8);
            end;
    end;
  FileName := FileName + '.' + Ext;
End; { set up file name }


PROCEDURE DirList( Var Ext : string);

Var
 DirInfo     : SearchRec;
 Count,XX,YY : integer;

Begin
 ClrScr;
 GoToXY(4,3);
 Write('EXISTING FILES');
 Count := 0;
 FindFirst('*.'+Ext,Archive,DirInfo);
 while DosError = 0 do
  begin
    Count := Count+1;
    case ( Count mod 3) of
       1 : XX := 2;
       2 : XX := 16;
       0 : XX := 30;
       end;
    YY := round(( Count+1.0)/3.0) + 5;
    GoToXY(XX,YY);
    Write(DirInfo.Name);
    FindNext(DirInfo);
  end;

End;  {* dir list *}
