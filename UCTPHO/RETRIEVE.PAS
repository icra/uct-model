Program Retrieve;

{ Program to read diurnal response data from .DID file }
{ of reals and convert to a text file for Lotus.       }

uses
 Dos,Crt;

type
 AllowableRange = set of 10..30;

const
 Allowable : AllowableRange = [10,15,30];

var

 DataPerDay,NoDiVars,
 DataInterval,
 i,j,k                      : integer;
 Value                      : array[1..18] of real;
 Time                       : real;
 DIDfile                    : file of real;
 PRNfile                    : text;
 FileDummy,Ext              : string;
 Key                        : char;
 OK                         : boolean;


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
  if Count = 0 then
   begin
    GoToXY(10,5);
    write('No DID data files found .... PROGRAM TERMINATED');
    Halt;
   end;

End;  {* dir list *}

Procedure GetFileNames;
 Begin
  Ext := 'DID';
  DirList(Ext);
 End;

Procedure Msg(MsgString: string; Col,Row: integer);
   { Print a message at location Col,Row }
 begin
    gotoXY(Col,Row);  write(' ':length(MsgString));
    gotoXY(Col,Row);  write(MsgString);
 end;

Procedure ChooseFile;
 Begin
   Window(42,19,77,24);
   msg('Enter data file name :',3,1);
   msg('e.g. DEMO',10,3);
   repeat
    GoToXY(1,5);
    ClrEol;
    msg('FileName = ',10,5);
    repeat
     Readln(FileDummy);
     GoToXY(22,5);
    until FileDummy <> '';
    Ext := 'DID';
    SetUpFileName(FileDummy,Ext);
    Assign(DIDfile,FileDummy);
    {$I-} Reset(DIDfile) {$I+};
    OK := (IOResult = 0);
    Key := ' ';
    If not OK then
      begin
        GoToXY(1,5);
        ClrEol;
        msg('No file...  ',3,5);
        Write(FileDummy);
        msg('Enter another ? Y/N...',5,6);
        Repeat Key := ReadKey Until UpCase(Key) in ['Y','N'];
        GoToXY(1,6);
        ClrEol;
      end;
   until OK or (UpCase(Key) = 'N');
   if UpCase(Key) = 'N' then Halt;
   ClrScr;
   Window(1,1,80,25);
 End;

Procedure GetFileSize;
 Begin
   Window(30,19,77,24);
   msg('Enter "Data interval" (10, 15 or 30) = ',3,2);
   repeat
    Readln(DataInterval);
    GoToXY(42,2);
    ClrEol;
   until DataInterval in Allowable;
   DataPerDay := round(24*60.0/DataInterval);
   msg('Program used (UCTOLD/IAWPRC) (U/I) = ',3,4);
   repeat Key := ReadKey until UpCase(Key) in ['O','A'];
   case UpCase(Key) of
    'U' : NoDiVars := 18;
    'I' : NoDiVars := 17;
    end; { of case }
   ClrScr;
   Window(1,1,80,25);
 End;

Procedure SendToPRN;
 Begin
  ClrScr;
  Ext := 'PRN';
  SetUpFileName(FileDummy,Ext);
  Assign(PRNfile,FileDummy);
  Rewrite(PRNfile);
  write(PRNfile,'" REACTOR"','"   TIME"');
  for j := 1 to NoDiVars do write(PRNfile,'"  Var ',j:2,' "');
  writeln(PRNfile); writeln(PRNfile);
  k := 0;
  while not EOF(DIDfile) do
   begin
    k:= k + 1;
    GoToXY(20,12);
    write('Storing Reactor ',k,' data');
    Time := -DataInterval/60.0;
    for i := 0 to DataPerDay do
     begin
      Time := Time + DataInterval/60.0;
      write(PRNfile,k:9,' ',Time:9:3,' ');
      for j := 1 to NoDiVars do read(DIDfile,Value[j]);
      for j := 1 to NoDiVars do write(PRNfile,Value[j]:9:3,' ');
      writeln(PRNfile);
     end;
    writeln(PRNfile);
   end;
 End;

Begin  { retrieve }

 ClrScr;
 GetFileNames;
 ChooseFile;
 GetFileSize;
 SendToPRN;
 Close(DIDfile);
 Close(PRNfile);

End.
