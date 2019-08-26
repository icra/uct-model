Procedure InputBox (Option : integer);
 begin
  TextColor(InputBoxCol.Frame);
  TextBackground(InputBoxCol.Back);
  Case Option of
    1 : FrameInstructions(41,18,78,25);     { wastewater }
    2 : begin                               { configuration }
         if LastReactor < 7 then FrameInstructions(39,19,79,24)
                            else FrameInstructions(39,20,79,25);
        end;
    3 : FrameInstructions(23,19,77,23);     { operation }
      end;
 end;

Procedure InputWindow (Option : integer);
 begin
  TextColor(InputBoxCol.Text);
  TextBackground(InputBoxCol.Back);
  Case Option of
    1 : Window(42,19,77,24);    { wastewater }
    2 : begin                   { configuration }
         if LastReactor < 7 then Window(40,20,78,23)
                            else Window(40,21,78,24);
        end;
    3 : Window(22,20,76,22);    { operation }
      end;
 end;

Procedure MainBox (Option : integer);
 begin
  TextColor(MainBoxCol.Frame);
  TextBackground(MainBoxCol.Back);
  Case Option of
    1 : FrameInstructions(5,2,75,23);              { waste characteristics }
    2 : FrameInstructions(3,2,78,14+LastReactor);  { configuration }
    3 : begin                                      { operation }
         if ARecycleSet then FrameInstructions(5,2,68,14)
                        else FrameInstructions(5,2,68,12);
        end;
      end;
 end;

Procedure MainWindow (Option : integer);
 begin
  TextColor(MainBoxCol.Text);
  TextBackground(MainBoxCol.Back);
  Case Option of
    1 : Window(6,3,74,22);                { waste characteristics }
    2 : Window(4,3,77,13+LastReactor);    { configuration }
    3 : begin                             { operation }
         if ARecycleSet then Window(6,3,67,13)
                        else Window(6,3,67,11);
        end;
      end;
 end;
