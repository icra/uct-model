Unit IOUnit;

interface

uses
  Crt,
  Dos,
  Graph,
  VarsUnit;

Function GetInteger(min, max : integer):integer;
Function GetReal(min, max : real):real;
Procedure ReverseVideo(Colours : TextColours);
Procedure NormalVideo(Colours : TextColours);
Procedure FlashScreen;
Procedure QuickBox(TX,TY,BX,BY:Integer);
Procedure Msg(MsgString: string; Col,Row: integer);
Procedure WriteIntgrFldRev (Num,XPos,YPos,Fld : integer);
Procedure WriteRealFldDec (Num : real; XPos,YPos,Fld,Dec : integer);
Procedure FrameInstructions(UpperLeftX,UpperLeftY,LowerRightX,LowerRightY:Integer);
Procedure FrameMenu(UpperLeftX,UpperLeftY,LowerRightX,LowerRightY:Integer);
Procedure SelectOption(Var MenuData:MenuRecord);
Procedure SelectConstant(Var ListData:ListRecord);
Procedure InputBox (Option : integer);
Procedure InputWindow (Option : integer);
Procedure MainBox (Option : integer);
Procedure MainWindow (Option : integer);
Procedure SetUpFileName( Var FileName, Ext : String);
Procedure DirList( Var Ext : String);
Procedure ChangeParameter;
Procedure ReDirect(route : CaptionString; NewOption : Integer);


implementation

{$I iocheck.pas }        { integer and real input checking   }
{$I backgrnd.pas }       { screen background routines        }
{$I format.pas }         { formatting for screen output      }
{$I menuio.pas }         { menu manipulation                 }
{$I boxes.pas }          { window specification              }
{$I fileio.pas }         { directory of files, etc.          }
{$I change.pas }         { change parameter procedure        }
{$I redirect.pas }       { redirect to another menu option   }

end.  { of IOUnit }