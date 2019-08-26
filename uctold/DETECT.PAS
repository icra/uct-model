Procedure DetectScreen;
 begin
  { Register all the drivers }
   if RegisterBGIdriver(@CGADriverProc) < 0 then Halt;
   if RegisterBGIdriver(@EGAVGADriverProc) < 0 then Halt;
   if RegisterBGIdriver(@HercDriverProc) < 0 then Halt;
   if RegisterBGIdriver(@ATTDriverProc) < 0 then Halt;
   if RegisterBGIdriver(@PC3270DriverProc) < 0 then Halt;


  { Register all the fonts }
{   if RegisterBGIfont(@GothicFontProc) < 0 then Halt;
   if RegisterBGIfont(@SansSerifFontProc) < 0 then Halt;
   if RegisterBGIfont(@SmallFontProc) < 0 then Halt; }
   if RegisterBGIfont(@TriplexFontProc) < 0 then Halt;  { only one used }

  DetectGraph(GraphDriver,GraphMode);
  case GraphDriver of
  CGA, EGA, EGA64, VGA:
      begin
        with MenuCol do
         begin
          Frame    := LightGreen;
          Back     := LightBlue;
          Text     := White;
          RevBack  := Red;
          RevText  := Yellow;
         end;
        with MainBoxCol do
         begin
          Frame    := White;
          Back     := LightBlue;
          Text     := White;
          RevBack  := Red;
          RevText  := Yellow;
         end;
        with InputBoxCol do
         begin
          Frame    := Yellow;
          Back     := Black;
          Text     := Yellow;
          RevBack  := Red;
          RevText  := Yellow;
         end;
        with InstructBoxCol do
         begin
          Frame    := Cyan;
          Back     := LightGray;
          Text     := Blue;
          RevBack  := Red;
          RevText  := Yellow;
         end;
        with PrBoxCol do
         begin
          Frame    := Green;
          Back     := Black;
          Text     := LightGreen;
          RevBack  := Red;
          RevText  := Yellow;
         end;
        with SelectBoxCol do
         begin
          Frame    := LightGray;
          Back     := LightBlue;
          Text     := White;
          RevBack  := Red;
          RevText  := Yellow;
         end;
        with FrontCol do
         begin
          Frame    := LightGreen;
          Back     := LightBlue;
          Text     := Yellow;
          RevBack  := Red;
          RevText  := Yellow;
         end;
        with ResultsCol do
         begin
          Frame    := White;
          Back     := LightBlue;
          Text     := White;
          RevBack  := Red;
          RevText  := Yellow;
         end;
      end; { colour screens }


  HercMono, EGAMono, grNotDetected:
      begin
        with MenuCol do
         begin
          Frame    := White;
          Back     := Black;
          Text     := White;
          RevBack  := White;
          RevText  := Black;
         end;
        with MainBoxCol do
         begin
          Frame    := White;
          Back     := Black;
          Text     := White;
          RevBack  := White;
          RevText  := Black;
         end;
        with InputBoxCol do
         begin
          Frame    := White;
          Back     := Black;
          Text     := White;
          RevBack  := White;
          RevText  := Black;
         end;
        with InstructBoxCol do
         begin
          Frame    := White;
          Back     := Black;
          Text     := White;
          RevBack  := White;
          RevText  := Black;
         end;
        with PrBoxCol do
         begin
          Frame    := White;
          Back     := Black;
          Text     := White;
          RevBack  := White;
          RevText  := Black;
         end;
        with SelectBoxCol do
         begin
          Frame    := White;
          Back     := Black;
          Text     := White;
          RevBack  := White;
          RevText  := Black;
         end;
        with FrontCol do
         begin
          Frame    := White;
          Back     := Black;
          Text     := White;
          RevBack  := White;
          RevText  := Black;
         end;
        with ResultsCol do
         begin
          Frame    := White;
          Back     := Black;
          Text     := White;
          RevBack  := White;
          RevText  := Black;
         end;
       with GraphCol do
         begin
          Frame := White;
          Back  := Black;
          Text  := White;
          Line[1] := White;
          Line[2] := White;
          Line[3] := White;
          Line[4] := White;
          Line[5] := White;
          Line[6] := White;
          Line[7] := White;
          Line[8] := White;
          Line[9] := White;
          Line[10] := White;
          Line[11] := White;
          Line[12] := White;
         end;
      end; { mono screens }
    end; { of case statement }

 case GraphDriver of
   CGA:
      begin
        GraphMode := 4;     { hi res CGA - one colour only ! }
        with GraphCol do
         begin
          Frame   := LightGray;
          Back    := White;
          Text    := LightGray;
          Line[1] := LightGray;
          Line[2] := LightGray;
          Line[3] := LightGray;
          Line[4] := LightGray;
          Line[5] := LightGray;
          Line[6] := LightGray;
          Line[7] := LightGray;
          Line[8] := LightGray;
          Line[9] := LightGray;
          Line[10] := LightGray;
          Line[11] := LightGray;
          Line[12] := LightGray;
         end;
      end; { CGA screens }


   EGA, EGA64, VGA:
      begin
        with GraphCol do
         begin
          Frame   := LightBlue;
          Back    := Black;
          Text    := LightBlue;
          Line[1] := Yellow;
          Line[2] := LightCyan;
          Line[3] := LightGreen;
          Line[4] := LightGray;
          Line[5] := Red;
          Line[6] := Magenta;
          Line[7] := Blue;
          Line[8] := Green;
          Line[9] := LightMagenta;
          Line[10] := LightGray;
          Line[11] := LightGray;
          Line[12] := LightGray;
         end;
      end; { non-CGA colour screens }
  end; { of case }

 end; { of detect screen }
