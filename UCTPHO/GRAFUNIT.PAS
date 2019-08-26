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

{$I grafouts.pas  }
{$I grout.pas  }
{$I dumpplot.pas  }
{$I grafplot.pas  }


Procedure SelectedGraphScales;

Begin
  TextColor(MainBoxCol.Frame);
  TextBackground(MainBoxCol.Back);
  FrameInstructions(1,1,78,22);
  ClrScr;
  GoToXY(27,1);
  ReverseVideo(MainBoxCol);
  write('MAXIMUM  PLOTTING  RANGES');
  NormalVideo(MainBoxCol);
  Window(2,2,35,21);
  for i := 1 to (TotalCompounds - 1) do
    begin
      GoToXY(2,i+2);
      ReverseVideo(MainBoxCol);
      write(i:2);
      NormalVideo(MainBoxCol);
      Write(' ',Compound[i],Units[i]);
    end;

  Window(36,2,41,21);
  for i := 1 to (TotalCompounds - 1) do
    begin
      GoToXY(1,i+2);
      write(ScaleMax[i]:5:0);
    end;
  Window(43,2,71,13);
  GoToXY(2,3);
      ReverseVideo(MainBoxCol);
      write('19');
      NormalVideo(MainBoxCol);
  write(' OUR carb','    g O2 m-3 h-1');
  GoToXY(2,4);
      ReverseVideo(MainBoxCol);
      write('20');
      NormalVideo(MainBoxCol);
  write(' OUR nitr','    g O2 m-3 h-1');
  GoToXY(2,5);
      ReverseVideo(MainBoxCol);
      write('21');
      NormalVideo(MainBoxCol);
  write(' OUR tot','     g O2 m-3 h-1');
  GoToXY(2,6);
      ReverseVideo(MainBoxCol);
      write('22');
      NormalVideo(MainBoxCol);
  write(' VSS    ','     g VSS m-3');
  GoToXY(2,7);
      ReverseVideo(MainBoxCol);
      write('23');
      NormalVideo(MainBoxCol);
  write(' TKN    ','     g N m-3');

  Window(72,2,77,13);
  for i := 19 to NoDiVars do
    begin
      GoToXY(1,i-16);
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
  FrameInstructions(44,16,79,24);
  repeat
    TextColor(InputBoxCol.Frame);
    TextBackground(InputBoxCol.Back);
    Window(45,17,78,23);
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

        If (Remove <= 18) then
          Begin
            Window(36,2,41,24);
            TextColor(MainBoxCol.Frame);
            TextBackground(MainBoxCol.Back);
            GoToXY(1,Remove+2);
            write(ScaleMax[Remove]:5:0);
          end

        else
          Begin
            Window(72,2,78,13);
            TextColor(MainBoxCol.Frame);
            TextBackground(MainBoxCol.Back);
            GoToXY(1,Remove-16);
            write(ScaleMax[Remove]:5:0);
          end;

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