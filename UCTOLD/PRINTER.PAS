Procedure PrintConfiguration;
  Begin
    writeln(OutFile,' ':19,'********** PROCESS CONFIGURATION **********');
    writeln(OutFile);
    write(OutFile,'Gp 1. Number of Reactors:');
    writeln(OutFile,' = ',LastReactor:2);
    writeln(OutFile);
    write(OutFile,' ':8);
    write(OutFile,'Gp 2. Reactor Vols,',VolType:2);
    write(OutFile,' ':4);
    write(OutFile,'Gp 3. Feed Fraction:');
    write(OutFile,' ':5);
    writeln(OutFile, 'Gp 4. Aeration/DO:');
    writeln(OutFile);
    for i:=1 to LastReactor do
      begin
        write(OutFile,'No.',i:2,':',' ':5,
                       Vol[i]:13:2,' ':12,
                       FracFeed[i]:9:2,' ':18);
        If ReactorAerated[i] then writeln(OutFile,DOConc[i]:6:1)
                             else writeln(OutFile,'Unaerated ');
      end;
    writeln(OutFile); writeln(OutFile);

    If LastReactor > 1 then
      begin
        writeln(OutFile,'Gp 5. Recycles:');
        writeln(OutFile);
        for i:=1 to LastReactor do
          If FlagRASIn[i]=1 then DumInt:=i;
        writeln(OutFile,' ':2,'  RAS recycle flow to Reactor No.',DumInt);
        writeln(OutFile);

        If ARecycleSet then
          begin
            write(OutFile,' ':2,'  A recycle : Out of Reactor No.',ReactorAOut);
            If BRecycleSet then
              writeln(OutFile,' ':6,'  B recycle : Out of Reactor No.',ReactorBOut);
            write(OutFile,' ':2,'              Into Reactor No.',ReactorAIn);
            If BRecycleSet then
              writeln(OutFile,' ':6,'                Into Reactor No.',ReactorBIn);
          end;
        writeln(OutFile);
      end;
   End;  { print configuration }


  Procedure PrintOperation;
    Begin
      writeln(OutFile,' ':15,'**********  PLANT OPERATING PARAMETERS  **********');
      writeln(OutFile);
      write(OutFile,' 1 Influent flow             ',VolType:2,
                    ' d-1          =        ');
      writeln(OutFile,FlowFeedAvg:6:2);
      write(OutFile,' 2 RAS recycle flow          ',VolType:2,
                    ' d-1          =        ');
      writeln(OutFile,FlowRASrecycle:6:2);
      write(OutFile,' 3 SRT (total)               d               =        ');
      writeln(OutFile,Rs:6:2);
      write(OutFile,' 4 Process Temperature       degC            =        ');
      writeln(OutFile,Temp:6:2);
      writeln(OutFile);

      If ARecycleSet then
        begin
          write(OutFile,' 5 A-recycle flow            ',VolType:2,
                        ' d-1          =        ');
          writeln(OutFile,FlowArecycle:6:2);
        end;

      If BRecycleSet then
        begin
          write(OutFile,' 5 B-recycle flow            ',VolType:2,
                        ' d-1          =        ');
          writeln(OutFile,FlowBrecycle:6:2);
        end;

      If SteadyStateSpecified then
        begin
          write(OutFile,' 6 Wastage rate flow         ',VolType:2,
                        ' d-1          =        ');
          writeln(OutFile,FlowWaste:6:2);
        end;
    End;  { print operation }


  Procedure PrintComposition;
    Begin
      writeln(OutFile,'********  WASTEWATER CHARACTERISTICS  ********');
      writeln(OutFile);
      writeln(OutFile,'  Sti      (g COD m-3)         =  ',StiAvg:6:2);
      writeln(OutFile,'  Nti      (g N m-3)           =  ',NtiAvg:6:2);
      writeln(OutFile,'  Fbs      (g COD g-1 COD)     =  ',Fbs:6:2);
      writeln(OutFile,'  Fs,us    (g COD g-1 COD)     =  ',Fus:6:2);
      writeln(OutFile,'  Fs,up    (g COD g-1 COD)     =  ',Fup:6:2);
      writeln(OutFile,'  Fn,a     (g N g-1 N)         =  ',Fnaa:6:2);
      writeln(OutFile,'  Fnob,p   (g N g-1 N)         =  ',Fnox:6:2);
      writeln(OutFile,'  Fn,ous   (g N g-1 N)         =  ',Fnu:6:2);
      writeln(OutFile,'  Fs,zbh   (g Zbh COD g-1 COD) =  ',Fxbh:6:2);
      writeln(OutFile,'  VSS/TSS  (g VSS g-1 TSS)     =  ',VSSTSS:6:2);
      writeln(OutFile,'  Inf Alk  (mole m-3)          =  ',Alki:6:2);
    End;  { composition output }


 Procedure PrintDiurnalPattern;
    Begin
      writeln(OutFile,'            ******  DIURNAL INPUT PATTERN  ******');
      writeln(OutFile);
      write(OutFile,'  Record No    Time (h)     Flow,');
         writeln(OutFile,VolType:2,'/d      COD          TKN');
      writeln(OutFile,'  ---------    --------     ---------      ---          ---');
      for i:=1 to NoDiurnalInts do
        begin
          write(OutFile,i:7,'   ');
          write(OutFile,Time[i]:12:1);
          write(OutFile,DynamicFlow[i]:13:1);
          write(OutFile,DynamicSti[i]:12:1);
          write(OutFile,DynamicNti[i]:12:1); writeln(OutFile);
        end;
      writeln(OutFile);
      writeln(OutFile,' ** Calculated Mean Values :');
      writeln(OutFile,'         Flowrate = ',MeanFlow:7:1);
      writeln(OutFile,'         COD      = ',MeanCOD:7:1);
      writeln(OutFile,'         TKN      = ',MeanTKN:7:1);
    End;  { print diurnal pattern }

  Procedure PrintHeterotrophs;
    Begin
      writeln(OutFile,' HETEROTROPH KINETIC DATA (Values at 20 degC)');
      writeln(OutFile,' ************************');writeln(OutFile);
      writeln(OutFile,'  Mue max soluble        d-1            =  ',MuHatHetero20:6:3);
      writeln(OutFile,'  Ks soluble      (Ksh)  g COD m-3      =  ',Ks20:6:3);
      writeln(OutFile,'  Ks O2           (Koh)  g O2 m-3       =  ',Koh:6:3);
      writeln(OutFile,'  B decay         (bh)   d-1            =  ',Bh20:6:3);
      writeln(OutFile,'  Neta (growth)                         =  ',NetaGrow:6:3);
      writeln(OutFile,'  Ks NO3          (Kno)  g N m-3        =  ',Kno:6:3);
      writeln(OutFile,'  Mue max part    (Kmp)  d-1            =  ',Kmp20:6:3);
      writeln(OutFile,'  Ks particulate  (Ksp)  g COD g-1 COD  =  ',Ksp20:6:3);
      writeln(OutFile,'  Ammonification  (Kr)   m3 g-1 COD d-1 =  ',Kr20:6:3);
      writeln(OutFile,'  Ks NH3          (Kna)  g N m-3        =  ',Kna:6:3);
      writeln(OutFile,'  Adsorption rate (Ka)   g-1 COD m3 d-1 =  ',Ka20:6:3);
    End;  {* print heterotrophs *}


  Procedure PrintAutotrophs;
    Begin
      for i := 1 to 5 do writeln(OutFile);
      writeln(OutFile,' AUTOTROPH KINETIC DATA (Values at 20 degC)');
      writeln(OutFile,' **********************');writeln(OutFile);
      writeln(OutFile,'  Mue max auto          d-1            =   ',MuHatAuto20:6:3);
      writeln(OutFile,'  Ks NH4+       (Ksa)   g N m-3        =   ',Knh20:6:3);
      writeln(OutFile,'  Ks O2         (Koa)   g O2 m-3       =   ',Koa:6:3);
      writeln(OutFile,'  B endogenous  (ba)    d-1            =   ',Ba20:6:3);
    End;  { print autotrophs }


  Procedure PrintStoichParameters;
    Begin
      for i := 1 to 5 do writeln(OutFile);
      writeln(OutFile,' STOICHIOMETRIC PARAMETERS');
      writeln(OutFile,' ************************* ');writeln(OutFile);
      writeln(OutFile,' Yield, hetero  (Yzh)  g COD g-1 COD  =  ',Yh:6:3);
      writeln(OutFile,' Frac inert     (Fe)   g COD g-1 COD  =  ',Fe:6:3);
      writeln(OutFile,' N in biomass  (Fzb,n) g N g-1 COD    =  ',Ixb:6:3);
      writeln(OutFile,' N in inert    (Fze,n) g N g-1 COD    =  ',Ixe:6:3);
      writeln(OutFile,' Yield, auto    (Yza)  g COD g-1 COD  =  ',Ya:6:3);
      writeln(OutFile,' COD:VSS ratio  (Fcv)  g COD g-1 VSS  =  ',CODVSS:6:3);
      writeln(OutFile,' Max adsorption (Fma)  g COD g-1 COD  =  ',Fma:6:3);
    End;


Procedure PrintOut(WhichOne : NameString);
 Begin
  TextColor(PrBoxCol.Frame);
  TextBackground(PrBoxCol.Back);
  FrameInstructions(8,10,73,18);
  TextColor(PrBoxCol.Text);
  msg('Do you want a hardcopy of ',2,4);
  write(WhichOne);
  write('? Y/N...');
  REPEAT YesNo := ReadKey UNTIL UpCase(YesNo) in ['Y','N'];
  If UpCase(YesNo) = 'Y' then
    begin
      assign(OutFile,'PRN');
      rewrite(OutFile);
      for i := 1 to 3 do writeln(OutFile);
      if WhichOne = 'process configuration' then PrintConfiguration;
      if WhichOne = 'operating conditions' then PrintOperation;
      if WhichOne = 'wastewater characteristics' then PrintComposition;
      if WhichOne = 'kinetic constants' then
                                         begin
                                          PrintHeterotrophs;
                                          PrintAutotrophs;
                                         end;
      if WhichOne = 'stoichiometric constants' then PrintStoichParameters;
      if WhichOne = 'diurnal input' then PrintDiurnalPattern;
      for i := 1 to 3 do writeln(OutFile);
      close(OutFile);
    end;
  Window(1,1,80,25);
 End;  { print out }


