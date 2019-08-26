PROCEDURE CalcMachEps;
 Begin
  MachEps := 1;
  Repeat
   MachEps := MachEps/2;
  Until (MachEps + 1) = 1;
  MachEps := 2 * MachEps;
 End;