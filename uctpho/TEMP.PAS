Procedure ScaleVolFlow;

Function Power (B,X:real):real;
   Begin
     Power:=Round(Exp(X*ln(B)));
   end;
Procedure Exponent ;
 Var Y:Real;
begin
     Y:=FlowFeed;
     Expon:=0;
     If Y>100 then
       Repeat
         Y:=Y/10;
         Expon:=(Expon+1);
       Until Y<=100;
 end;

Begin
 Exponent;
 ScaleFactor:=Power(10,Expon);
 FlowFeed:=FlowFeed/ScaleFactor;
 FlowFeedAvg:=FlowFeedAvg/ScaleFactor;
 FlowRASRecycle:=FlowRASRecycle/ScaleFactor;
 FlowARecycle:=FlowARecycle/ScaleFactor;
 FlowBRecycle:=FlowBRecycle/ScaleFactor;
 VolumeTotal:=VolumeTotal/ScaleFactor;
 For k:=1 to LastReactor do
   Vol[k]:=Vol[k]/ScaleFactor;
Writeln('Expon=',expon,'ScaleFactor=',ScaleFactor);
End  (*ScaleVolFlow*);

Procedure RescaleVolFlow;

Begin
 FlowFeed:=FlowFeed*ScaleFactor;
 FlowFeedAvg:=FlowFeedAvg*ScaleFactor;
 FlowWaste:=FlowWaste*ScaleFactor;
 FlowWasteAvg:=FlowWasteAvg*ScaleFactor;
 FlowRASRecycle:=FlowRASRecycle*ScaleFactor;
 FlowARecycle:=FlowARecycle*ScaleFactor;
 FlowBRecycle:=FlowBRecycle*ScaleFactor;
 VolumeTotal:=VolumeTotal*ScaleFactor;
 For k:=1 to LastReactor do
   Vol[k]:=Vol[k]*ScaleFactor;
end;
