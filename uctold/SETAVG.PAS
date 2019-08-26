  PROCEDURE SetAvgInputs;
    Begin
      Sti        := StiAvg;
      Nti        := NtiAvg;
      FlowFeed   := FlowFeedAvg;
      FlowWaste  := FlowWasteAvg;
      FractionateInfluent;
    End;  {* set average inputs *}
