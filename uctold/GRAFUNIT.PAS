Unit GrafUnit;   { graphical output of diurnal response }

interface

uses
  Crt,
  Dos,
  Graph,
  VarsUnit,
  IOUnit;

Procedure DrawGraph;

implementation

{$I diouts.pas  }
{$I grout.pas  }
{$I dumpplot.pas  }
{$I grafplot.pas  }


Procedure SelectedGraphScales;

Begin
  TextColor(MainBoxCol.Frame);
  TextBackground(MainBoxCol.Back);
  FrameInstructions(2,1,42,23);
  TextColor(MainBoxCol.Text);
  Window(3,2,35,22);
  ClrScr;
  GoToXY(8,2);
  ReverseVideo(MainBoxCol);
  write('MAXIMUM  PLOTTING  RANGES');
  NormalVideo(MainBoxCol);
  for i := 1 to (TotalCompounds-1) do
    begin
      GoToXY(2,i+3);
      write(i:2,' ',Compound[i],Units[i]);
    end;
  GoToXY(2,17);
  write('14 ','OUR carb','    g O2 m-3 h-1');
  GoToXY(2,18);
  write('15 ','OUR nitr','    g O2 m-3 h-1');
  GoToXY(2,19);
  write('16 ','OUR tot','     g O2 m-3 h-1');
  GoToXY(2,20);
  write('17 ','Volatile solids','  g VSS m-3');
  GoToXY(2,21);
  Write('18 ','TKN            ','   g N m-3');
  Window(1,1,80,25);

  Window(36,2,41,22);
  for i := 1 to 18 do
    begin
      GoToXY(1,i+3);
      write(ScaleMax[i]:5:0);
    end;

  Window(1,1,80,25);

End;  { selected parameters }



Procedure GraphicsScales;

Var
  Remove             : integer;
  NewScale           : real;

Begin

  SelectedGraphScales;
  TextColor(InputBoxCol.Frame);
  TextBackground(InputBoxCol.Back);
  FrameInstructions(44,8,78,16);
  repeat
    TextColor(InputBoxCol.Frame);
    TextBackground(InputBoxCol.Back);
    Window(45,9,77,15);
    ClrScr;
    GoToXY(3,2);
    write('Alter any ranges ? Y/N... ');
    repeat YesNo := ReadKey until UpCase(YesNo) in ['Y','N'];
    if UpCase(YesNo) = 'Y' then
      begin
        repeat
          GoToXY(3,4);
          ClrEol;
          write('Change Scale No. ');
          Readln(Remove);
        until Remove in [1..NoDiVars];

        repeat
          GoToXY(3,6);
          ClrEol;
          write('New ',ShortName[Remove],' max. range = ');
          Readln(NewScale);
        until NewScale > 0.0;

        ScaleMax[Remove] := NewScale;

        Window(36,2,41,22);
        TextColor(MainBoxCol.Frame);
        TextBackground(MainBoxCol.Back);
        GoToXY(1,Remove+3);
        write(ScaleMax[Remove]:5:0);

      end;

  until UpCase(YesNo) = 'N';
  Window(1,1,80,25);
  GraphicsMenu.CurrentOption := 1;

End;  { graphics scales }


Procedure DrawGraph;

Begin

  FlashScreen;
  With GraphicsMenu do
  begin
    CurrentOption := 1;
    repeat
      SelectOption(GraphicsMenu);
      FlashScreen;
      Case CurrentOption of
        1 : PlotGraph;
        2 : GraphicsScales;
          end;
    until CurrentOption = LastOption+1;
  end;
  FlashScreen;

End;  { of DrawGraph }

End.  { of GrafUnit }
