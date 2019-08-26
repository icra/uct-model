Procedure CheckIntegParameters;   { check/change integration parameters }
 Begin
  FlashScreen;
  ValueDummy[1] := Accuracy ;
  ValueDummy[2] := Theta    ;
  ValueDummy[3] := DataIntHours * 60 ;

  SelectConstant(IntegList);

  Accuracy     := ValueDummy[1] ;
  Theta        := ValueDummy[2] ;
  DataIntHours := ValueDummy[3] ;

  if DataIntHours <> 10.0
     then if DataIntHours <> 15.0
        then if DataIntHours <> 30.0
           then DataIntHours := 30;
  DataIntHours := DataIntHours/60.0
End;  { checkintegparameters }
