Function GetInteger(min, max : integer):integer;

var
  onedigit           : char;
  temp               : real;
  good, minus, done  : boolean;
  PosX, PosY, digits : byte;

begin
  PosX := WhereX; PosY := WhereY;  { hold the starting location -- if the
                                     person entering data makes an error,
                                     come back to this location and blank
                                     out six character spaces.}
  repeat
    GotoXY(PosX,PosY);
    Write('      ');
    gotoXY(PosX,PosY);
    digits := 0;
    temp   := 0;
    good   := true;
    done   := false;
    repeat
      onedigit := readkey;           { take characters from the keyboard }
      digits := digits + 1;
      if digits = 1 then              { if the FIRST character is a "-" }
          if OneDigit = '-' then      { then the number is negative     }
            begin
              minus := true;
              Write('-');
            end
          else minus := false;
      case OneDigit of
        '0'..'9' : begin
                     temp := 10*temp + ord(OneDigit) - 48;
                     write(OneDigit);            { if the key pressed is a   }
                   end;                          { number, write it on the   }
        #8       : begin                         { screen and add it to      }
                     if digits > 1               { "temp".  If it's a Back   }
                      then                       { Space, blank out the last }
                        begin                    { digit and remove it from  }
                          write(#8,#32,#8);      { "temp".  If it's <return> }
                          digits := digits - 2;  { you're done.              }
                        end
                      else digits := 0;  { don't backspace too far }

                     temp := trunc(temp) div 10;

                   end;
        #13      : done := true;
      end;
      if digits > 6 then done := true;  { integers can be up to 32,767,
                                          a maximum of five digits, plus
                                          one for a possible minus sign.}
      if minus then temp := -temp;  { make temp negative for comparisons }
      if (temp < min) and (done or minus) then
        begin
          good := false;
          done := true;
        end;
      if (temp > max) and (done or (not minus)) then
        begin
          good := false;
          done := true;
        end;
      if minus then temp := - temp; { set temp back to positive for adding
                                      more digits.}
    until done;
  until good and done;
  if minus then temp := -temp;
  GetInteger := trunc(temp);
end;


Function GetReal(min, max : real):real;

var
  onedigit : char;
  temp,valuetemp  : real;
  good, minus, done,decimal : boolean;
  PosX, PosY, digits,decdgts : byte;

Function DigitsToReal(x:real; decdgts:byte): real;
 begin
   while decdgts > 1 do   { note: decimal point was counted also }
     begin
       x := x/10.0;
       decdgts := decdgts - 1;
     end;
   DigitsToReal := x;
 end;

begin
  PosX := WhereX; PosY := WhereY;  { hold the starting location -- if the
                                     person entering data makes an error,
                                     come back to this location and blank
                                     out six character spaces.}
  repeat
    GotoXY(PosX,PosY);
    ClrEol;
    digits  := 0;
    decdgts := 0;
    temp    := 0;
    good    := true;
    done    := false;
    decimal := false;
    repeat
      onedigit := readkey;           { take characters from the keyboard }
      digits := digits + 1;
      if digits = 1 then              { if the FIRST character is a "-" }
          if OneDigit = '-' then      { then the number is negative     }
            begin
              minus := true;
              Write('-');
            end
          else minus := false;
      case OneDigit of
        '0'..'9' : begin
                     temp := 10*temp + ord(OneDigit) - 48;
                     if decimal then decdgts := decdgts + 1;
                     write(OneDigit);            { if the key pressed is a   }
                   end;                          { number, write it on the   }
        '.'      : if NOT decimal then           { screen and add it to      }
                   begin                         { "temp".  If it's a point  }
                     decimal := true;            { note that you have a      }
                     decdgts := 1;               { fraction. If it's a Back  }
                     write(OneDigit);            { Space, blank out the last }
                   end;                          { digit and remove it from  }
        #8       : begin                         { "temp".  If it's <return> }
                     if digits > 1 then          { you're done.              }
                                     begin
                                       write(#8,#32,#8);
                                       digits := digits - 2;
                                     end
                                   else digits := 0; { don't go too far back }
                     if decimal then
                                  begin
                                    decdgts := decdgts - 1;
                                    if decdgts = 0 then { blanked decimal pt }
                                      begin
                                        decimal := false;
                                        temp := temp * 10; { allow div below }
                                      end;
                                  end;
                     temp := int(temp/10);
                   end;
        #13      : done := true;
      end;
      if minus then temp := -temp;  { make temp negative for comparisons }
      valuetemp := DigitsToReal(temp,decdgts);
      if (valuetemp < min) and (done or minus) then
        begin
          good := false;
          done := true;
        end;
      if (valuetemp > max) and (done or (not minus)) then
        begin
          good := false;
          done := true;
        end;
      if minus then temp := - temp; { set temp back to positive for adding
                                      more digits.}
    until done;
  until good and done;
  if minus then temp := -temp;
  GetReal := DigitsToReal(temp,decdgts);
end;
