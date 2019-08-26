Procedure ReDirect(route : CaptionString; NewOption : Integer);
  Begin
   If GoAhead then
   begin              { only redirect on first failure }
    GoAhead := false;
    TextColor(PrBoxCol.Text);
    TextBackground(PrBoxCol.Back);
    FlashScreen;
    FrameInstructions(trunc(40-Length(route)/2),10,
                      trunc(40+Length(route)/2)+6,14);
    GoToXY(2,2);
    Write(route);
    Delay(2000);
    MainMenu.CurrentOption := NewOption;
   end;
  End;

