PROCEDURE FrameInstructions(UpperLeftX,UpperLeftY,LowerRightX,LowerRightY:Integer);
{ The  border is specified by the Top LH and Lower RH points }

Var   I,J  :Integer;

BEGIN {Frame instructions }
  Window(1,1,80,25);
  GotoXY(UpperLeftX+1, UpperLeftY);
  for I := (UpperLeftX + 1) to (LowerRightX - 1) do
  begin
    Write(chr(223));
  end;
  for I := UpperLeftY to LowerRightY do
  begin
    GotoXY(UpperLeftX , I);  Write(chr(219));
    GotoXY(LowerRightX, I);  Write(chr(219));
  end;
  GotoXY(UpperLeftX+1, LowerRightY);
  for I := (LowerRightX - 1) downto (UpperLeftX + 1) do
  begin
    Write(chr(220));
  end;
  QuickBox(UpperLeftX+1,UpperLeftY+1,LowerRightX-1,LowerRightY-1);
END; {Frame instructions }


PROCEDURE FrameMenu(UpperLeftX,UpperLeftY,LowerRightX,LowerRightY:Integer);
{ The  border is specified by the Top LH and Lower RH points }

Var   I,J  :Integer;

BEGIN
  TextColor(MenuCol.Frame);
  TextBackground(MenuCol.Back);
  FrameInstructions(UpperLeftX,UpperLeftY,LowerRightX,LowerRightY);
  GotoXY(1,2);
  for I := (UpperLeftX + 1) to (LowerRightX - 1) do
  begin
    Write(chr(196));  { draw horizontal line }
  end;
END;


Procedure SelectOption(Var MenuData:MenuRecord);

Procedure OptionMovementInstructions;   {* option selection block movement *}

Begin

  With MenuData do
  begin
  TextColor(InstructBoxCol.Frame);
  TextBackground(InstructBoxCol.Back);
  FrameInstructions(11,20,69,24);
  TextColor(InstructBoxCol.Text);
  GoToXY(7,1);
  Write('Press <Arrows> or <SpaceBar> to move selection');
  GoToXY(15,3);
  Write('Press <Return> to select option');
  Window(1,1,80,25);
  end;

End;  {* option movement instructions *}


Procedure WriteMenu;      {* list menu in DummyMenu array *}

Begin

  With MenuData do
  begin
  FlashScreen;
  Window(1,1,80,25);
  OptionMovementInstructions;
  FrameMenu(6,Offset-2,75,Offset+LastOption+3);
  GoToXY(12,1);
  ReverseVideo(MenuCol);
  Write(Heading);
  NormalVideo(MenuCol);
  For J := 1 to LastOption do
    Begin
      GoToXY(Indent,2+J);
      If J = CurrentOption then ReverseVideo(MenuCol);
      Write(Caption[J]);
      NormalVideo(MenuCol);
    End;
  GoToXY(Indent,LastOption+4);
  Write(LastLine);
  GoToXY(Indent + length(Caption[CurrentOption]), 2 + CurrentOption);
  end;

End;  {* write menu *}


Procedure NextOption;   {* moves the option selection block *}

Begin

  With MenuData do
  begin
  If CurrentOption = (LastOption+1)    { write last option in }
    then                               { normal video         }
      begin
        GoToXY(Indent,LastOption+4);
        Write(LastLine);
      end
    else
      Begin
        GoToXY(Indent,CurrentOption+2);
        Write(Caption[CurrentOption]);
      End;

  If Key in [Chr($20),Chr($50)] then    { space bar / down arrow }
    If CurrentOption = LastOption+1
      then CurrentOption := 1
      else CurrentOption := CurrentOption + 1;

  If Key = Chr($48) then    { up arrow }
    If CurrentOption = 1
      then CurrentOption := LastOption + 1
      else CurrentOption := CurrentOption - 1;

  ReverseVideo(MenuCol);
  If CurrentOption = (LastOption+1)       { write next option in }
    then                                  { reverse video        }
      begin
        GoToXY(Indent,LastOption+4);
        Write(LastLine);
      end
    else
      Begin
        GoToXY(Indent,CurrentOption+2);
        Write(Caption[CurrentOption]);
      End;
  NormalVideo(MenuCol);
  end;

End;  {* next option *}


Begin      {* select option *}

  With MenuData do
  begin
  WriteMenu;
  Key := ' ';     {* not C/R *}
  Repeat
   Key := ReadKey;
   If Key <> Chr($0D) then   { char not a return }
    begin
     If Key = Chr($20) then NextOption  { space bar }
      else If Key = #0 then             { extended key code }
       begin
        Key := ReadKey;
        If Key in [Chr($48),Chr($50)] then NextOption  { up/down arrow }
       end;
    end;
  Until Key = Chr($0D);   { until return }
  Window(1,1,80,25);
  end;

End;  {* select option *}


Procedure SelectConstant(Var ListData:ListRecord);

Procedure LongMovementInstructions;   {* constant selection block movement *}

Begin

  With ListData do
  begin
  TextColor(InstructBoxCol.Frame);
  TextBackground(InstructBoxCol.Back);
  FrameInstructions(5,20,75,24);
  TextColor(InstructBoxCol.Text);
  msg('Hit <SpaceBar> to advance selection block',10,1);
  msg('Hit <Arrows> or <SpaceBar> to move selection',8,1);
  msg('Hit <Return> to enter new value for selected constant',4,3);
  Window(1,1,80,25);
  end;

End;  {* long movement instructions *}


Procedure ShortMovementInstructions;   {* constant selection block movement *}

Begin

  With ListData do
  begin
  TextColor(InstructBoxCol.Frame);
  TextBackground(InstructBoxCol.Back);
  FrameInstructions(53,17,79,24);
  TextColor(InstructBoxCol.Text);
  msg('Hit <Arrows>/<SpaceBar>',2,1);
  msg('to move selection',6,2);
  msg('Hit <Return> to enter',4,4);
  msg('new value for',8,5);
  msg('selected constant',6,6);
  Window(1,1,80,25);
  end;

End;  {* short movement instructions *}


Procedure WriteList;      {* list constants in dummy array *}

Begin

  With ListData do
  begin
  CurrentConstant := LastConstant + 1;
  Window(1,1,80,25);
  If Heading = WasteList.Heading then ShortMovementInstructions
                                 else LongMovementInstructions;
  FrameMenu(5,Offset-2,75,Offset+LastConstant+2);
  GoToXY(Indent+10,1);
  ReverseVideo(MenuCol);
  Write(Heading);
  NormalVideo(MenuCol);
  For J := 1 to LastConstant do
    Begin
      GoToXY(Indent,J+2);
      Write(Name[J]);
      GoToXY(SecondIndent,J+2);
      Write(ValueDummy[J]:7:3);
    End;
  ReverseVideo(MenuCol);
  GoToXY(ThirdIndent,LastConstant+3);
  Write(LastLine);
  NormalVideo(MenuCol);
  end;

End;  {* write list *}


Procedure NextConstant;   {* moves the constant selection block *}

Begin

  With ListData do
  begin
  If CurrentConstant = (LastConstant+1)    { write previous constant }
    then                                   { in normal video         }
      begin
        GoToXY(ThirdIndent,LastConstant+3);
        Write(LastLine);
      end
    else
      Begin
        GoToXY(Indent,CurrentConstant+2);
        Write(Name[CurrentConstant]);
        GoToXY(SecondIndent,CurrentConstant+2);
        Write(ValueDummy[CurrentConstant]:7:3);
      End;

  If Key in [Chr($20),Chr($50)] then         { space bar / down arrow }
   If CurrentConstant = (LastConstant +1)
     then CurrentConstant := 1
     else CurrentConstant := CurrentConstant + 1;

  If Key = Chr($48) then    { up arrow }
    If CurrentConstant = 1
      then CurrentConstant := LastConstant + 1
      else CurrentConstant := CurrentConstant - 1;

  ReverseVideo(MenuCol);
  If CurrentConstant = (LastConstant+1)    { write next constant }
    then                                   { in reverse video    }
      begin
        GoToXY(ThirdIndent,LastConstant+3);
        Write(LastLine);
      end
    else
      Begin
        GoToXY(Indent,CurrentConstant+2);
        Write(Name[CurrentConstant]);
        GoToXY(SecondIndent,CurrentConstant+2);
        Write(ValueDummy[CurrentConstant]:7:3);
      End;
  NormalVideo(MenuCol);
  end;

End;  {* next constant *}


Procedure UpdateConstant;   {* enter new constant value *}

Begin

  With ListData do
  begin
  GoToXY(ThirdIndent,CurrentConstant+2);
  ReverseVideo(MenuCol);
  Write('New value = ');
  ValueDummy[CurrentConstant] := GetReal(0,10000);
  NormalVideo(MenuCol);
  GoToXY(Indent,CurrentConstant+2);
  Write(Name[CurrentConstant]);
  GoToXY(SecondIndent,CurrentConstant+2);
  Write(ValueDummy[CurrentConstant]:7:3);
  ClrEol;
  ReverseVideo(MenuCol);
  CurrentConstant := LastConstant + 1;
  GoToXY(ThirdIndent,LastConstant+3);
  Write(LastLine);
  NormalVideo(MenuCol);
  NoChanges := False;
  end;

End; {* update constant *}


Begin      {* select constant *}

  With ListData do
  begin
  WriteList;
  Key := ' ';    {* not C/R *}
  Repeat
    NoChanges := True;
    Repeat
     Key := ReadKey;
     If Key <> Chr($0D) then   { char not a return }
      begin
       If Key = Chr($20) then NextConstant  { space bar }
        else If Key = #0 then               { extended key code }
         begin
          Key := ReadKey;
          If Key in [Chr($48),Chr($50)] then NextConstant  { up/down arrow }
         end;
      end;
    Until Key = Chr($0D);
    If CurrentConstant<(LastConstant+1) then UpdateConstant;
  Until (Key = Chr($0D)) and NoChanges;
  end;

End;  {* select constant *}

