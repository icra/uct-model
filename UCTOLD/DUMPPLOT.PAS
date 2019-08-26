Procedure DumpPlot;

var
   F           : text;
   n1          : integer;
   n2          : integer;
   n           : integer;
   AA          : integer;
   Num         : integer;
   PixelColor  : integer;
   II,l,j,i    : integer;
   XMax,YMax   : Integer;


Begin

   Assign(F,'lpt1');
   rewrite(F);
   ymax := getmaxy;
   xmax := getmaxx;

   n  := XMax;
   n2 := trunc(n/256);
   n1 := n - n2 * 256;

{ set line spacing to 20/216 inches }
   write(F,chr(27),chr(51),chr(24));

   for L := 0 to trunc(YMax/8) + 1 do
   begin
      write(F,chr(27),chr(60)); { send printer head to left hand margin }
      write(F,chr(24));         { clear printer buffer }

      { sets printer up for double-density bit image graphics.  120 dots/inch }
      write(F,chr(27),chr(76),chr(n1),chr(n2));   { My Printer & CGA }
      for I := 0 to XMax do
      begin
         AA := 0;
         for J := 1 to 8 do
         begin
            PixelColor := GetPixel(I,J + ((L-1) * 8));
            if PixelColor > 0 then
            begin
               case J of
               1  :  Num := 128;
               2  :  Num := 64;
               3  :  Num := 32;
               4  :  Num := 16;
               5  :  Num := 8;
               6  :  Num := 4;
               7  :  Num := 2;
               8  :  Num := 1;
               end;   { of case }
               AA := AA + Num;
            end;
        end;
        write(F,Chr(AA));
      end;
      write(F,chr(10));
      flush(F);
   end;
   write(F,chr(10));             { Line Feeds Three Lines }
   write(F,chr(10));
   write(F,chr(10));
   write(F,chr(27),chr(60));     { Printer Carrige Head Home }

   close(F);

End;   { of PrtScr }
