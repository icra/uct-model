  PROCEDURE ComponentNames;
    Begin
      Compound[1]:='Zbh (hetero.)    ';
      Compound[2]:='Zba (autotrophs) ';
      Compound[3]:='Ze (endog.)      ';
      Compound[4]:='Zi (prt unb COD) ';
      Compound[5]:='Sads (adsorb.COD)';
      Compound[6]:='Senm (enmesh COD)';
      for i := 1 to 6 do Units[i]:=' g COD m-3';
      Compound[7]:='Nobp (prt bio N) ';
      Units[7]:=' g N m-3';
      Compound[8]:='Sbs (sol bio COD)';
      Units[8]:=' g COD m-3';
      Compound[9]:='Na (ammonia N)   ';
      Compound[10]:='Nobs (sol org N) ';
      Compound[11]:='No3 (nitrate N)  ';
      for i := 9 to 11 do Units[i]:=' g N m-3';
      Compound[12]:='Alkalinity       ';
      Units[12]:=' mole m-3';
      Compound[13]:='Sus (sol unb COD)';
      Units[13]:=' g COD m-3';
      for i := 14 to 16 do Units[i]:=' gO/m3/h';
      Units[17]:=' g VSS m-3';
      Units[18]:=' g N m-3';

      ShortName[1]:='Zbh';
      ShortName[2]:='Zba';
      ShortName[3]:='Ze';
      ShortName[4]:='Zi';
      ShortName[5]:='Sads';
      ShortName[6]:='Senm';
      ShortName[7]:='Nobp';
      ShortName[8]:='Sbs';
      ShortName[9]:='Na';
      ShortName[10]:='Nobs';
      ShortName[11]:='No3';
      ShortName[12]:='Alk';
      ShortName[13]:='Sus';
      ShortName[14]:='Oc';
      ShortName[15]:='On';
      ShortName[16]:='Ot';
      ShortName[17]:='VSS';
      ShortName[18]:='TKN';

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

  WasteList.Heading  := '****  WASTEWATER  CHARACTERISTICS  ****';
  WasteList.Name[1]  := 'Sti(avg) g COD m-3';
  WasteList.Name[2]  := 'Nti(avg) g N m-3';
  WasteList.Name[3]  := 'Fbs      g COD g-1 COD';
  WasteList.Name[4]  := 'Fs,us    g COD g-1  COD';
  WasteList.Name[5]  := 'Fs,up    g COD g-1 COD';
  WasteList.Name[6]  := 'Fn,a     g N g-1 N';
  WasteList.Name[7]  := 'Fnob,p   g N g-1 N';
  WasteList.Name[8]  := 'Fn,ous   g N g-1 N';
  WasteList.Name[9]  := 'Fs,zbh   g Zbh COD g-1 COD';
  WasteList.Name[10] := 'VSS/TSS  g VSS g-1 TSS';
  WasteList.Name[11] := 'Inf Alk  mole m-3';
  WasteList.LastLine := 'RETURN TO MENU';

  KineticMenu.Heading    := '*****  KINETIC CONSTANTS MENU  *****';
  KineticMenu.Caption[1] := 'HETEROTROPHS';
  KineticMenu.Caption[2] := 'AUTOTROPHS';
  KineticMenu.Caption[3] := 'ARRHENIUS CONSTANTS';
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
  HeteroList.Name[3]  := 'Ks O2           (Koh) g O2 m-3';
  HeteroList.Name[4]  := 'B decay         (bh)  d-1';
  HeteroList.Name[5]  := 'Neta (growth)';
  HeteroList.Name[6]  := 'Ks NO3          (Kno) g N m-3';
  HeteroList.Name[7]  := 'Hydrolysis rate (Kmp) d-1';
  HeteroList.Name[8]  := 'Ks hydrolysis   (Ksp) g COD g-1 COD';
  HeteroList.Name[9]  := 'Ammonification  (Kr)  m3 g-1 COD d-1';
  HeteroList.Name[10] := 'Ks NH3          (Kna) g N m-3';
  HeteroList.Name[11] := 'Adsorption rate (Ka)  g-1 COD m3 d-1';
  HeteroList.LastLine := 'RETURN TO MENU';

  AutoList.Heading  := '****  AUTOTROPHS  ****';
  AutoList.Name[1]  := 'Mue max auto          d-1';
  AutoList.Name[2]  := 'Ks NH4+         (Ksa) g N m-3';
  AutoList.Name[3]  := 'Ks O2           (Koa) g O2 m-3';
  AutoList.Name[4]  := 'B endogenous    (ba)  d-1';
  AutoList.LastLine := 'RETURN TO MENU';

  TempList.Heading  := '** ARRHENIUS TEMP CONSTANTS (Thetas ref 20C) **';
  TempList.Name[1]  := 'Mue max hetero';
  TempList.Name[2]  := 'Ksh';
  TempList.Name[3]  := 'B endogenous hetero (Bh)';
  TempList.Name[4]  := 'Kmp hydrolysis';
  TempList.Name[5]  := 'Ksp hydrol. half-sat.';
  TempList.Name[6]  := 'Kr';
  TempList.Name[7]  := 'Mue max auto';
  TempList.Name[8]  := 'Ksa';
  TempList.Name[9]  := 'B endogenous auto (Ba)';
  TempList.Name[10] := 'Ka adsoption rate';
  TempList.LastLine := 'RETURN TO MENU';

  StoichList.Heading  := '****  STOICHIOMETRIC  PARAMETERS  ****';
  StoichList.Name[1]  := 'Yield, hetero   (Yzh)   g COD g-1 COD';
  StoichList.Name[2]  := 'Frac inert      (Fe)    g COD g-1 COD';
  StoichList.Name[3]  := 'N in biomass    (Fzb,n) g N g-1  COD';
  StoichList.Name[4]  := 'N in inert      (Fze,n) g N g-1  COD';
  StoichList.Name[5]  := 'Yield, auto     (Yza)   g COD g-1 COD';
  StoichList.Name[6]  := 'COD:VSS ratio   (Fcv)   g COD g-1 VSS';
  StoichList.Name[7]  := 'Max adsorption  (Fma)   g COD g-1 COD';
  StoichList.LastLine := 'RETURN TO MENU';

  DataInputMenu.Heading    := '*****  DIURNAL DATA INPUT FROM :  *****';
  DataInputMenu.Caption[1] := 'DISK';
  DataInputMenu.Caption[2] := 'KEYBOARD';
  DataInputMenu.LastLine   := 'RETURN TO MENU';

  GraphicsMenu.Heading    := '***  DIURNAL RESPONSE GRAPHICAL OUTPUT  ***';
  GraphicsMenu.Caption[1] := 'PLOT GRAPHS';
  GraphicsMenu.Caption[2] := 'CHECK/CHANGE PLOTTING SCALES';
  GraphicsMenu.LastLine   := 'RETURN TO MENU';

End;  { menu captions }

