
Procedure Msg(MsgString: string; Col,Row: integer);
   { Print a message at location Col,Row }
 begin
    gotoXY(Col,Row);  write(' ':length(MsgString));
    gotoXY(Col,Row);  write(MsgString);
 end;

Procedure WriteIntgrFldRev (Num,XPos,YPos,Fld : integer);
 begin
  GoToXY(XPos,YPos); write(' ':Fld);      { Clear field of width fld }
  ReverseVideo(MainBoxCol);               { and write integer in     }
  GoToXY(XPos,YPos); write(Num:Fld);      { reverse video            }
  NormalVideo(MainBoxCol);
 end;

Procedure WriteRealFldDec (Num : real; XPos,YPos,Fld,Dec : integer);
 begin
  GoToXY(XPos,YPos); write(' ':Fld);      { clear field of width fld }
  GoToXY(XPos,YPos); write(Num:Fld:Dec);  { write real number in     }
 end;                                     { format Fld:Dec           }
