  PROCEDURE ComponentNames;
    Begin
      Compound[1]:='Zbh  (hetero.)     ';
      Compound[2]:='Zba  (auto.)       ';
      Compound[3]:='Zbg  (polyP org.)  ';
      Compound[4]:='Ze   (endog. COD)  ';
      Compound[5]:='Zi   (inert. COD)  ';
      Compound[6]:='Sads (adsorbed COD)';
      Compound[7]:='Senm (enmeshed COD)';
      Compound[8]:='Sphb (PHB  COD)    ';
      FOR I:=1 TO 8 DO Units[I]:=' g COD m-3';
      Compound[9]:='Nobp (prt bio N)   ';
      Units[9]:=' g N m-3';
      Compound[10]:='Ppp  (stored polyP)';
      Units[10]:=' g P m-3';
      Compound[11]:='Sbs,c (compl.RBCOD)';
      Compound[12]:='Sbs,a (SCFA RBCOD) ';
      FOR I:=11 TO 12 DO Units[I]:=' g COD m-3';
      Compound[13]:='Na    (ammonia N)  ';
      Compound[14]:='Nobs  (sol org N)  ';
      Compound[15]:='No3   (nitrate N)  ';
      FOR I:=13 TO 15 DO Units[I]:=' g N m-3';
      Compound[16]:='Ps    (soluble P)  ';
      Units[16]:=' g P m-3';
      Compound[17]:='Sus   (sol unb COD)';
      Units[17]:=' g COD m-3';
      Compound[18]:='Alkalinity         ';
      Units[18]:=' mole m-3';
      for i := 19 to 21 do Units[i]:=' gO/m3/h';
      Units[22]:=' g VSS m-3';
      Units[23]:=' g N m-3';

      ShortName[1]:='Zbh';
      ShortName[2]:='Zba';
      ShortName[3]:='Zbg';
      ShortName[4]:='Ze';
      ShortName[5]:='Zi';
      ShortName[6]:='Sads';
      ShortName[7]:='Senm';
      ShortName[8]:='Sphb';
      ShortName[9]:='Nobp';
      ShortName[10]:='Ppp';
      ShortName[11]:='Sbsc';
      ShortName[12]:='Sbsa';
      ShortName[13]:='Na';
      ShortName[14]:='Nobs';
      ShortName[15]:='No3';
      ShortName[16]:='Ps';
      ShortName[17]:='Sus';
      ShortName[18]:='Alk';
      ShortName[19]:='Oc';
      ShortName[20]:='On';
      ShortName[21]:='Ot';
      ShortName[22]:='VSS';
      ShortName[23]:='TKN';
    End;  { component names }


Procedure Captions;    { assign menu captions to string arrays }
 Begin
  MainMenu.Heading     := '******  MAIN  SIMULATION  PROGRAM  MENU  ******';
  MainMenu.Caption[1]  := 'INFLUENT DATA';
  MainMenu.Caption[2]  := 'PLANT CONFIGURATION';
  MainMenu.Caption[3]  := 'OPERATING PARAMETERS';
  MainMenu.Caption[4]  := 'STEADY STATE SIMULATION';
  MainMenu.Caption[5]  := 'DIURNAL SIMULATION';
  MainMenu.Caption[6]  := 'KINETIC CONSTANTS';
  MainMenu.Caption[7]  := 'STOICHIOMETRY';
  MainMenu.LastLine    := 'EXIT FROM PROGRAM';

  AWasteList.Heading  := '****  COD WASTEWATER  CHARACTERISTICS  ****';
  AWasteList.Name[1]  := 'Sti(avg) g COD m-3';
  AWasteList.Name[2]  := 'Fbs      g COD g-1 COD';
  AWasteList.Name[3]  := 'Fac      g COD g-1 COD';
  AWasteList.Name[4]  := 'Fs,us    g COD g-1  COD';
  AWasteList.Name[5]  := 'Fs,up    g COD g-1 COD';
  AWasteList.Name[6]  := 'Fs,zbh   g Zbh COD g-1 COD';
  AWasteList.Name[7]  := 'VSS/TSS  g VSS g-1 TSS';
  AWasteList.LastLine := 'CONTINUE';

  BWasteList.Heading  := '****  REST OF WASTEWATER  CHARACTERISTICS  ****';
  BWasteList.Name[1]  := 'Nti(avg) g N m-3';
  BWasteList.Name[2]  := 'Fn,a     g N g-1 N';
  BWasteList.Name[3]  := 'Fnob,p   g N g-1 N';
  BWasteList.Name[4]  := 'Fn,ous   g N g-1 N';
  BWasteList.Name[5]  := 'Pti(avg) g P m-3';
  BWasteList.Name[6]  := 'Fsup,P   g P g-1 COD';
  BWasteList.Name[7]  := 'Inf Alk  mole m-3';
  BWasteList.LastLine := 'RETURN TO MENU';

  KineticMenu.Heading    := '*****  KINETIC CONSTANTS MENU  *****';
  KineticMenu.Caption[1] := 'HETEROTROPHS';
  KineticMenu.Caption[2] := 'AUTOTROPHS';
  KineticMenu.Caption[3] := 'POLYP ORGANISMS';
  KineticMenu.Caption[4] := 'SWITCHING FUNCTIONS';
  KineticMenu.Caption[5] := 'ARRHENIUS CONSTANTS';
  KineticMenu.LastLine   := 'RETURN TO MAIN MENU';

  DiurnalSimMenu.Heading    := '*****  SIMULATION OF DIURNAL RESPONSE  *****';
  DiurnalSimMenu.Caption[1] := 'SIMULATE';
  DiurnalSimMenu.Caption[2] := 'HARDCOPY OF RESULTS';
  DiurnalSimMenu.Caption[3] := 'GRAPHICAL OUTPUT';
  DiurnalSimMenu.Caption[4] := 'CHECK/CHANGE SCREEN/PRINTED OUTPUT';
  DiurnalSimMenu.Caption[5] := 'CHECK/CHANGE INTEGRATION PARAMETERS';
  DiurnalSimMenu.Caption[6] := 'STORE DATA ON DISK';
  DiurnalSimMenu.Caption[7] := 'CHECK/CHANGE WASTAGE PATTERN';
  DiurnalSimMenu.LastLine   := 'RETURN TO MAIN MENU';

  IntegList.Heading  := '****  INTEGRATION  PARAMETERS  ****';
  IntegList.Name[1]  := '% Accuracy (0.01 to 1.0)';
  IntegList.Name[2]  := 'Theta (0.5 to 0.8)';
  IntegList.Name[3]  := 'Data interval (10,15 or 30 mins)';
  IntegList.LastLine := 'RETURN TO MENU';

  HeteroList.Heading  := '****  HETEROTROPHS  ****';
  HeteroList.Name[1]  := 'Mue max               d-1';
  HeteroList.Name[2]  := 'Ks COD          (Ksh) g COD m-3';
  HeteroList.Name[3]  := 'B decay         (bh)  d-1';
  HeteroList.Name[4]  := 'Neta (growth)';
  HeteroList.Name[5]  := 'Hydrolysis rate, aerobic (KmpA) d-1';
  HeteroList.Name[6]  := 'Hydrolysis rate, anoxic  (KmpX) d-1';
  HeteroList.Name[7]  := 'Ks hydrolysis   (Ksp) g COD g-1 COD';
  HeteroList.Name[8]  := 'Ammonification  (Kr)  m3 g-1 COD d-1';
  HeteroList.Name[9]  := 'Adsorption rate (Ka)  g-1 COD m3 d-1';
  HeteroList.Name[10]  := 'Conversion rate (Kc)  d-1';
  HeteroList.LastLine := 'RETURN TO MENU';

  AutoList.Heading  := '****  AUTOTROPHS  ****';
  AutoList.Name[1]  := 'Mue max auto          d-1';
  AutoList.Name[2]  := 'Ks NH4+      (Ksa)    g N m-3';
  AutoList.Name[3]  := 'B endogenous (ba)     d-1';
  AutoList.LastLine := 'RETURN TO MENU';

  PolyPList.Heading  := '**** POLYP ORGANISMS ****';
  PolyPList.Name[1]  := 'Mue max (No P Limit)   d-1';
  PolyPList.Name[2]  := 'Ks PHB  ( " )   (KsG1) g COD m-3';
  PolyPList.Name[3]  := 'Mue max (P Limit)      d-1';
  PolyPList.Name[4]  := 'Ks PHB  ( " )   (KsG2) g COD m-3';
  PolyPList.Name[5]  := 'B decay         (bG)   d-1';
  PolyPList.Name[6]  := 'PolyP cleavage  (bpp)  d-1';
  PolyPList.Name[7]  := 'HAc uptake rate (Kp)   d-1';
  PolyPList.LastLine := 'RETURN TO MENU';

  SwitchList.Heading  := '** SWITCHING FUNCTIONS **';
  SwitchList.Name[1]  := 'Ks O2 Hetero.  (Koh)  g O2 m-3';
  SwitchList.Name[2]  := 'Ks O2 Auto.    (Koa)  g O2 m-3';
  SwitchList.Name[3]  := 'Ks O2 PolyP.   (Kog)  g O2 m-3';
  SwitchList.Name[4]  := 'Ks Nh3         (Kha)  g N m-3';
  SwitchList.Name[5]  := 'Ks NO3         (Kno)  g N m-3';
  SwitchList.Name[6]  := 'Ks PO4 Hetero. (KpsH) g P m-3';
  SwitchList.Name[7]  := 'Ks PO4 PolyP.  (KpsP) g P m-3';
  SwitchList.Name[8]  := 'Ks PolyP       (Kpp)  g P m-3';
  SwitchList.Name[9]  := 'Ks Hac         (Kac)  g COD m-3';
  SwitchList.LastLine := 'RETURN TO MENU';

  TempList.Heading  := '** ARRHENIUS TEMP CONSTANTS (Thetas ref 20C) **';
  TempList.Name[1]  := 'Mue max hetero';
  TempList.Name[2]  := 'Ksh hetero';
  TempList.Name[3]  := 'B endogenous hetero (Bh)';
  TempList.Name[4]  := 'Kmp hydrolysis hetero, aerobic';
  TempList.Name[5]  := 'Kmp hydrolysis hetero, anoxic';
  TempList.Name[6]  := 'Ksp hydrol. half-sat.';
  TempList.Name[7]  := 'Kr hetero';
  TempList.Name[8]  := 'Ka hetero';
  TempList.Name[9]  := 'Kc hetero';
  TempList.Name[10]  := 'Mue max auto';
  TempList.Name[11] := 'Ksa auto';
  TempList.Name[12] := 'B endogenous auto (Ba)';
  TempList.Name[13] := 'Mue max polyP';
  TempList.Name[14] := 'KsG polyP';
  TempList.Name[15] := 'B endogenous polyP (Bg)';
  TempList.Name[16] := 'Bpp polyP';
  TempList.Name[17] := 'Kp polyP';
  TempList.LastLine := 'RETURN TO MENU';

  StoichMenu.Heading    := '*** STOICHIOMETRIC CONSTANTS MENU ***';
  StoichMenu.Caption[1] := 'HETEROTROPHS';
  StoichMenu.Caption[2] := 'AUTOTROPHS';
  StoichMenu.Caption[3] := 'POLYP ORGANISMS';
  StoichMenu.LastLine   := 'RETURN TO MAIN MENU';

  HStoichList.Heading  := '******   HETEROTROPHS  ******';
  HStoichList.Name[1]  := 'Yield           (Yzh)   g COD g-1 COD';
  HStoichList.Name[2]  := 'Frac inert part (FEp,H) g COD g-1 COD';
  HStoichList.Name[3]  := 'Max ads/hetero  (fma)   g COD g-1 COD';
  HStoichList.Name[4]  := 'N in biomass   (FZBH,N) g N g-1  COD';
  HStoichList.Name[5]  := 'N in endog     (FZEH,N) g N g-1  COD';
  HStoichList.Name[6]  := 'P in biomass   (FZBH,P) g P g-1  COD';
  HStoichList.Name[7]  := 'P in endog     (FZEH,P) g P g-1  COD';
  HStoichList.Name[8]  := 'COD:VSS ratio  (Fcv)    g COD g-1 VSS';
  HStoichList.LastLine := 'RETURN TO MENU';

  AStoichList.Heading  := '******   AUTOTROPHS   ******';
  AStoichList.Name[1]  := 'Yield           (Yza)   g COD g-1 COD';
  AStoichList.Name[2]  := 'Frac inert part (FEp,A) g COD g-1 COD';
  AStoichList.Name[3]  := 'N in biomass   (FZBA,N) g N g-1  COD';
  AStoichList.Name[4]  := 'N in endog     (FZEA,N) g N g-1  COD';
  AStoichList.Name[5]  := 'P in biomass   (FZBA,P) g P g-1  COD';
  AStoichList.Name[6]  := 'P in endog     (FZEA,P) g P g-1  COD';
  AStoichList.LastLine := 'RETURN TO MENU';

  PStoichList.Heading  := '****** POLYP ORGANISMS ******';
  PStoichList.Name[1]  := 'Yield           (Yzg)   g COD g-1 COD';
  PStoichList.Name[2]  := 'Frac inert part (FEp,G) g COD g-1 COD';
  PStoichList.Name[3]  := 'Frac inert sol  (FEs,G) g COD g-1 COD';
  PStoichList.Name[4]  := 'N in biomass   (FZBG,N) g N g-1  COD';
  PStoichList.Name[5]  := 'N in endog     (FZEG,N) g N g-1  COD';
  PStoichList.Name[6]  := 'N in inert sol (FEsG,N) g N g-1  COD';
  PStoichList.Name[7]  := 'P in biomass   (FZBG,P) g P g-1  COD';
  PStoichList.Name[8]  := 'P in endog     (FZEG,P) g P g-1  COD';
  PStoichList.Name[9]  := 'P rel/HAc up   (Fp,rel) g P g-1  COD';
  PStoichList.Name[10] := 'P up/PHB utiliz(Fp,upt) g P g-1  COD';
  PStoichList.LastLine := 'RETURN TO MENU';

  DataInputMenu.Heading    := '*****  DIURNAL DATA INPUT FROM :  *****';
  DataInputMenu.Caption[1] := 'DISK';
  DataInputMenu.Caption[2] := 'KEYBOARD';
  DataInputMenu.LastLine   := 'RETURN TO MENU';

  GraphicsMenu.Heading    := '***  DIURNAL RESPONSE GRAPHICAL OUTPUT  ***';
  GraphicsMenu.Caption[1] := 'PLOT GRAPHS';
  GraphicsMenu.Caption[2] := 'CHECK/CHANGE PLOTTING SCALES';
  GraphicsMenu.LastLine   := 'RETURN TO DIURNAL MENU';

End;  { menu captions }
