  PROCEDURE SetAvgInputs;
    Begin
      Sti        := StiAvg;
      Nti        := NtiAvg;
      Pti        := PtiAvg;
      FlowFeed   := FlowFeedAvg;
      FlowWaste  := FlowWasteAvg;
      FractionateInfluent;
    End;  {* set average inputs *}
