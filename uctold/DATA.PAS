Procedure InitialValues;   { default constant values }
 Begin

  MainMenu.Indent     := 22;
  MainMenu.Offset     :=  6;
  MainMenu.LastOption :=  7;

  KineticMenu.Indent     := 10;
  KineticMenu.Offset     :=  6;
  KineticMenu.LastOption :=  3;

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

  WasteList.Indent       :=  3;
  WasteList.Offset       :=  3;
  WasteList.LastConstant := 11;
  WasteList.SecondIndent := 40;
  WasteList.ThirdIndent  := 50;

  DataInputMenu.Indent     := 10;
  DataInputMenu.Offset     :=  6;
  DataInputMenu.LastOption :=  2;

  HeteroList.Indent       := 3;
  HeteroList.Offset       := 4;
  HeteroList.LastConstant := 11;
  HeteroList.SecondIndent := 40;
  HeteroList.ThirdIndent  := 50;

  AutoList.Indent       :=  3;
  AutoList.Offset       :=  6;
  AutoList.LastConstant :=  4;
  AutoList.SecondIndent := 40;
  AutoList.ThirdIndent  := 50;

  TempList.Indent       := 3;
  TempList.Offset       := 5;
  TempList.LastConstant := 10;
  TempList.SecondIndent := 40;
  TempList.ThirdIndent  := 50;

  StoichList.Indent       :=  3;
  StoichList.Offset       :=  5;
  StoichList.LastConstant :=  7;
  StoichList.SecondIndent := 40;
  StoichList.ThirdIndent  := 50;

  ListParNo[1] :=  1;
  ListParNo[2] :=  2;
  ListParNo[3] :=  5;
  ListParNo[4] :=  6;
  ListParNo[5] := 17;
  ListParNo[6] :=  8;
  ListParNo[7] :=  9;
  ListParNo[8] := 11;
  ListParNo[9] := 18;
  ListParNo[10] :=16;

  GraphParNo := 16;

  ScaleMax[1]  := 4000;
  ScaleMax[2]  := 400;
  ScaleMax[3]  := 4000;
  ScaleMax[4]  := 4000;
  ScaleMax[5]  := 400;
  ScaleMax[6]  := 1000;
  ScaleMax[7]  := 100;
  ScaleMax[8]  := 20;
  ScaleMax[9]  := 40;
  ScaleMax[10]  := 20;
  ScaleMax[11] := 50;
  ScaleMax[12] := 20;
  ScaleMax[13] := 100;
  ScaleMax[14] := 100;
  ScaleMax[15] := 100;
  ScaleMax[16] := 100;
  ScaleMax[17] := 10000;
  ScaleMax[18] := 50;

End;

