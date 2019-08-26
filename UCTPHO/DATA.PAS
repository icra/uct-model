Procedure InitialValues;   { default constant values }
 Begin

  MainMenu.Indent     := 22;
  MainMenu.Offset     :=  6;
  MainMenu.LastOption :=  7;

  KineticMenu.Indent     := 10;
  KineticMenu.Offset     :=  6;
  KineticMenu.LastOption :=  5;

  StoichMenu.Indent     := 10;
  StoichMenu.Offset     :=  6;
  StoichMenu.LastOption :=  3;

  DiurnalSimMenu.Indent     := 10;
  DiurnalSimMenu.Offset     :=  5;
  DiurnalSimMenu.LastOption :=  7;

  IntegList.Indent       :=  3;
  IntegList.Offset       :=  6;
  IntegList.LastConstant :=  3;
  IntegList.SecondIndent := 40;
  IntegList.ThirdIndent  := 50;

  GraphicsMenu.Indent     := 10;
  GraphicsMenu.Offset     :=  8;
  GraphicsMenu.LastOption :=  2;

  AWasteList.Indent       :=  3;
  AWasteList.Offset       :=  3;
  AWasteList.LastConstant :=  7;
  AWasteList.SecondIndent := 40;
  AWasteList.ThirdIndent  := 50;

  BWasteList.Indent       :=  3;
  BWasteList.Offset       :=  3;
  BWasteList.LastConstant :=  7;
  BWasteList.SecondIndent := 40;
  BWasteList.ThirdIndent  := 50;

  DataInputMenu.Indent     := 10;
  DataInputMenu.Offset     :=  6;
  DataInputMenu.LastOption :=  2;

  HeteroList.Indent       :=  3;
  HeteroList.Offset       :=  4;
  HeteroList.LastConstant :=  10;
  HeteroList.SecondIndent := 40;
  HeteroList.ThirdIndent  := 50;

  AutoList.Indent       :=  3;
  AutoList.Offset       :=  6;
  AutoList.LastConstant :=  3;
  AutoList.SecondIndent := 40;
  AutoList.ThirdIndent  := 50;

  PolyPList.Indent       :=  3;
  PolyPList.Offset       :=  6;
  PolyPList.LastConstant :=  7;
  PolyPList.SecondIndent := 40;
  PolyPList.ThirdIndent  := 50;

  SwitchList.Indent       :=  3;
  SwitchList.Offset       :=  6;
  SwitchList.LastConstant :=  9;
  SwitchList.SecondIndent := 40;
  SwitchList.ThirdIndent  := 50;

  TempList.Indent       :=  3;
  TempList.Offset       :=  3;
  TempList.LastConstant :=  17;
  TempList.SecondIndent := 40;
  TempList.ThirdIndent  := 50;

  HStoichList.Indent       :=  3;
  HStoichList.Offset       :=  5;
  HStoichList.LastConstant :=  8;
  HStoichList.SecondIndent := 40;
  HStoichList.ThirdIndent  := 50;

  AStoichList.Indent       :=  3;
  AStoichList.Offset       :=  5;
  AStoichList.LastConstant :=  6;
  AStoichList.SecondIndent := 40;
  AStoichList.ThirdIndent  := 50;

  PStoichList.Indent       :=  3;
  PStoichList.Offset       :=  5;
  PStoichList.LastConstant := 10;
  PStoichList.SecondIndent := 40;
  PStoichList.ThirdIndent  := 50;

  ListParNo[1] :=  1;
  ListParNo[2] :=  2;
  ListParNo[3] :=  3;
  ListParNo[4] :=  6;
  ListParNo[5] :=  8;
  ListParNo[6] := 10;
  ListParNo[7] := 11;
  ListParNo[8] := 15;
  ListParNo[9] := 16;
  ListParNo[10] :=21;

  GraphParNo := 20;

  ScaleMax[1]  :=  4000;
  ScaleMax[2]  :=   400;
  ScaleMax[3]  :=  4000;
  ScaleMax[4]  :=  4000;
  ScaleMax[5]  :=  1000;
  ScaleMax[6]  :=   100;
  ScaleMax[7]  :=    50;
  ScaleMax[8]  :=    20;
  ScaleMax[9]  :=    10;
  ScaleMax[10] :=   100;
  ScaleMax[11] :=    10;
  ScaleMax[12] :=    10;
  ScaleMax[13] :=   100;
  ScaleMax[14] :=    10;
  ScaleMax[15] :=    50;
  ScaleMax[16] :=   100;
  ScaleMax[17] :=    20;
  ScaleMax[18] :=   100;
  ScaleMax[19] :=   100;
  ScaleMax[20] :=   100;
  ScaleMax[21] :=   100;
  ScaleMax[22] := 10000;
  ScaleMax[23] :=    20;

End;