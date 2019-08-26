PROCEDURE PrintConfiguration;
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


  PROCEDURE PrintOperation;
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


  PROCEDURE PrintComposition;
    Begin
      writeln(OutFile,'********  WASTEWATER CHARACTERISTICS  ********');
      writeln(OutFile);
      writeln(OutFile,'  Sti      (g COD m-3)         =  ',StiAvg:7:3);
      writeln(OutFile,'  Nti      (g N m-3)           =  ',NtiAvg:7:3);
      writeln(OutFile,'  Pti      (g P m-3)           =  ',PtiAvg:7:3);
      writeln(OutFile,'  Fbs      (g COD g-1 COD)     =  ',Fbs:7:3);
      writeln(OutFile,'  Fac      (g COD g-1 COD)     =  ',Fac:7:3);
      writeln(OutFile,'  Fs,us    (g COD g-1 COD)     =  ',Fus:7:3);
      writeln(OutFile,'  Fs,up    (g COD g-1 COD)     =  ',Fup:7:3);
      writeln(OutFile,'  Fsup,P   (g COD g-1 COD)     =  ',FupP:7:3);
      writeln(OutFile,'  Fn,a     (g N g-1 N)         =  ',Fna:7:3);
      writeln(OutFile,'  Fnob,p   (g N g-1 N)         =  ',Fnobp:7:3);
      writeln(OutFile,'  Fn,ous   (g N g-1 N)         =  ',Fnous:7:3);
      writeln(OutFile,'  Fs,zbh   (g Zbh COD g-1 COD) =  ',Fzbh:7:3);
      writeln(OutFile,'  VSS/TSS  (g VSS g-1 TSS)     =  ',VSSTSS:7:3);
      writeln(OutFile,'  Inf Alk  (mole m-3)          =  ',Alki:7:3);
    End;  { composition output }


 PROCEDURE PrintDiurnalPattern;
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

  PROCEDURE PrintHeterotrophs;
    Begin
      writeln(OutFile,' HETEROTROPH KINETIC DATA (Values at 20 degC)');
      writeln(OutFile,' ************************');
      writeln(OutFile,'  Mue max               d-1             =  ',MuHatHetero20:6:3);
      writeln(OutFile,'  Ks COD          (Ksh) g COD m-3       =  ',Ksh20:6:3);
      writeln(OutFile,'  B decay         (bh)  d-1             =  ',Bh20:6:3);
      writeln(OutFile,'  Neta (growth)                         =  ',NetaGrow:6:3);
      writeln(OutFile,'  Hydrolysis rate, aerobic (KmpA) d-1    =  ',KmpA20:6:3);
      writeln(OutFile,'  Hydrolysis rate, anoxic  (KmpX) d-1    =  ',KmpX20:6:3);
      writeln(OutFile,'  Ks hydrolysis   (Ksp) g COD g-1 COD   =  ',Ksp20:6:3);
      writeln(OutFile,'  Ammonification  (Kr)  m3 g-1 COD d-1  =  ',Kr20:6:3);
      writeln(OutFile,'  Adsorption rate (Ka)  m3 g-1 COD d-1  =  ',Kr20:6:3);
      writeln(OutFile,'  Conversion rate (Kc)  m3 g-1 COD d-1  =  ',Kc20:6:3);
    End;  { print heterotrophs }

  PROCEDURE PrintAutotrophs;
    Begin
      for i := 1 to 2 do writeln(OutFile);
      writeln(OutFile,' AUTOTROPH KINETIC DATA (Values at 20 degC)');
      writeln(OutFile,' **********************');
      writeln(OutFile,'  Mue max auto          d-1               =   ',MuHatAuto20:6:3);
      writeln(OutFile,'  Ks NH4+       (Ksa)   g N m-3           =   ',Ksa20:6:3);
      writeln(OutFile,'  B endogenous  (ba)    d-1               =   ',Ba20:6:3);
    End;  { print autotrophs }

  PROCEDURE PrintPolyP;
    Begin
      for i := 1 to 2 do writeln(OutFile);
      writeln(OutFile,' POLYP ORGANISM KINETIC DATA (Values at 20 degC)');
      writeln(OutFile,' ***************************');
      writeln(OutFile,'  Mue max (No P Limit)  d-1             =  ',MuHatPolyP120:6:3);
      writeln(OutFile,'  Ks PHB  ( " )  (KsG1) g COD m-3       =  ',KsG120:6:3);
      writeln(OutFile,'  Mue max (P Limit)     d-1             =  ',MuHatPolyP220:6:3);
      writeln(OutFile,'  Ks PHB  ( " )  (KsG2) g COD m-3       =  ',KsG220:6:3);
      writeln(OutFile,'  B decay        (bG)   d-1             =  ',Bg20:6:3);
      writeln(OutFile,'  PolyP Cleavage (bpp)  d-1             =  ',bpp20:6:3);
      writeln(OutFile,'  HAc Uptake rate (Kp)  d-1             =  ',Kp20:6:3);
    End;  { print polyP }

  PROCEDURE PrintSwitches;
    Begin
      for i := 1 to 2 do writeln(OutFile);
      writeln(OutFile,' SWITCHING FUNCTION KINETIC DATA ');
      writeln(OutFile,' ******************************');
      writeln(OutFile,'  Ks O2 Hetero   (Koh)  g O2 m-3        =  ',Koh:6:3);
      writeln(OutFile,'  Ks O2 Auto     (Koa)  g O2 m-3        =  ',Koa:6:3);
      writeln(OutFile,'  Ks O2 PolyP    (Kog)  g O2 m-3        =  ',KoG:6:3);
      writeln(OutFile,'  Ks Nh3         (Kha)  g N m-3         =  ',Kha:6:3);
      writeln(OutFile,'  Ks NO3         (Kno)  g N m-3         =  ',Kno:6:3);
      writeln(OutFile,'  Ks PO4 Hetero  (KpsH) g P m-3         =  ',KpsH:6:3);
      writeln(OutFile,'  Ks PO4 PolyP   (KpsP) g P m-3         =  ',KpsP:6:3);
      writeln(OutFile,'  Ks PolyP       (Kpp)  g P m-3         =  ',Kpp:6:3);
      writeln(OutFile,'  Ks HAc         (Kac)  g COD m-3       =  ',Kac:6:3);
    End; {print Switches}

  PROCEDURE PrintArhenius;
    Begin
      for i := 1 to 2 do writeln(OutFile);
      writeln(OutFile,' ARRHENIUS TEMPERATURE CONSTANTS (THETAS ref 20 degC)');
      writeln(OutFile,' *******************************');
      writeln(OutFile,'  Mue max hetero                        =  ',ThetaMuHatH:6:3);
      writeln(OutFile,'  Ksh hetero                            =  ',ThetaKsh:6:3);
      writeln(OutFile,'  B  decay hetero                       =  ',ThetaBh:6:3);
      writeln(OutFile,'  Kmp hydrolysis hetero, aerobic        =  ',ThetaKmpA:6:3);
      writeln(OutFile,'  Kmp hydrolysis hetero, anoxic         =  ',ThetaKmpX:6:3);
      writeln(OutFile,'  Ksp hydrol. half-sat.                 =  ',ThetaKsp:6:3);
      writeln(OutFile,'  Kr hetero                             =  ',ThetaKr:6:3);
      writeln(OutFile,'  Ka hetero                             =  ',ThetaKa:6:3);
      writeln(OutFile,'  Kc hetero                             =  ',ThetaKc:6:3);
      writeln(OutFile,'  Mue max auto                          =  ',ThetaMuHatA:6:3);
      writeln(OutFile,'  Ksa auto                              =  ',ThetaKsa:6:3);
      writeln(OutFile,'  B decay auto                          =  ',ThetaBa:6:3);
      writeln(OutFile,'  Mue max polyP                         =  ',ThetaMuHatP:6:3);
      writeln(OutFile,'  Ks PHB polyP                          =  ',ThetaKsG:6:3);
      writeln(OutFile,'  B decay polyP                         =  ',ThetaBg:6:3);
      writeln(OutFile,'  Bpp polyP                             =  ',Thetabpp:6:3);
      writeln(OutFile,'  Kp polyP                              =  ',ThetaKp:6:3);
    End;  { print arrhenius }

  PROCEDURE PrintStoichH;
    Begin
      for i := 1 to 2 do writeln(OutFile);
      writeln(OutFile,' HETEROTROPH STOICHIOMETRIC PARAMETERS');
      writeln(OutFile,' ************************************* ');
      writeln(OutFile,' Yield           (Yzh)    g COD g-1 COD  =  ',Yzh:6:3);
      writeln(OutFile,' Frac inert part (FEp,H)  g COD g-1 COD  =  ',Feph:6:3);
      writeln(OutFile,' Max ads/hetero  (fma)    g COD g-1 COD  =  ',fma:6:3);
      writeln(OutFile,' N in biomass    (FZBH,N) g N g-1 COD    =  ',FzbhN:6:3);
      writeln(OutFile,' N in endog      (FZEH,N) g N g-1 COD    =  ',FzehN:6:3);
      writeln(OutFile,' P in biomass    (FZBH,P) g P g-1 COD    =  ',FzbhP:6:3);
      writeln(OutFile,' P in endog      (FZEH,P) g P g-1 COD    =  ',FzehP:6:3);
      writeln(OutFile,' COD:VSS ratio   (Fcv)    g COD g-1 VSS  =  ',CODVSS:6:3);
    End;

  PROCEDURE PrintStoichA;
    Begin
      for i := 1 to 2 do writeln(OutFile);
      writeln(OutFile,' AUTOTROPH STOICHIOMETRIC PARAMETERS');
      writeln(OutFile,' *********************************** ');
      writeln(OutFile,' Yield           (Yza)    g COD g-1 COD  =  ',Yza:6:3);
      writeln(OutFile,' Frac inert part (FEp,H)  g COD g-1 COD  =  ',Fepa:6:3);
      writeln(OutFile,' N in biomass    (FZBA,N) g N g-1 COD    =  ',FzbaN:6:3);
      writeln(OutFile,' N in endog      (FZEA,N) g N g-1 COD    =  ',FzeaN:6:3);
      writeln(OutFile,' P in biomass    (FZBA,P) g P g-1 COD    =  ',FzbaP:6:3);
      writeln(OutFile,' P in endog      (FZEA,P) g P g-1 COD    =  ',FzeaP:6:3);
    End;

  PROCEDURE PrintStoichP;
    Begin
      for i := 1 to 2 do writeln(OutFile);
      writeln(OutFile,' POLYP ORGANISM STOICHIOMETRIC PARAMETERS');
      writeln(OutFile,' **************************************** ');
      writeln(OutFile,' Yield           (Yzg)    g COD g-1 COD  =  ',Yzg:6:3);
      writeln(OutFile,' Frac inert part (FEp,G)  g COD g-1 COD  =  ',Fepg:6:3);
      writeln(OutFile,' Frac inert sol  (FEs,G)  g COD g-1 COD  =  ',Fesg:6:3);
      writeln(OutFile,' N in biomass    (FZBG,N) g N g-1 COD    =  ',FzbgN:6:3);
      writeln(OutFile,' N in endog      (FZEG,N) g N g-1 COD    =  ',FzegN:6:3);
      writeln(OutFile,' N in inert sol  (FEsG,N) g N g-1 COD    =  ',FesgN:6:3);
      writeln(OutFile,' P in biomass    (FZBG,P) g P g-1 COD    =  ',FzbgP:6:3);
      writeln(OutFile,' P in endog      (FZEG,P) g P g-1 COD    =  ',FzegP:6:3);
      writeln(OutFile,' P rel/HAc up    (Fp,rel) g P g-1 COD    =  ',Fprel:6:3);
      writeln(OutFile,' P up/PHB utiliz (Fp,upt) g P g-1 COD    =  ',Fpupt:6:3);
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
                                          PrintPolyP;
                                          PrintSwitches;
                                          PrintArhenius;
                                         end;
      if WhichOne = 'stoichiometric constants' then
                                         begin
                                          PrintStoichH;
                                          PrintStoichA;
                                          PrintStoichP;
                                         end;
      if WhichOne = 'diurnal input' then PrintDiurnalPattern;
      for i := 1 to 3 do writeln(OutFile);
      close(OutFile);
    end;
  Window(1,1,80,25);
 End;  { print out }
