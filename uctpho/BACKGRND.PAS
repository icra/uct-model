Procedure ReverseVideo(Colours : TextColours);
  Begin
    with Colours do
     begin
       TextColor(Colours.RevText);
       TextBackground(Colours.RevBack);
     end;
  End;

Procedure NormalVideo(Colours : TextColours);
  Begin
    with Colours do
     begin
       TextColor(Colours.Text);
       TextBackground(Colours.Back);
     end;
  End;


Procedure FlashScreen;
  Begin
    Window(1,1,80,25);
    TextBackground(Black);
    ClrScr;
  End;


Procedure QuickBox(TX,TY,BX,BY:Integer);
  Begin
    Window(TX,TY,BX,BY); { Open the window }
    ClrScr;              { Clear it        }
  End;

