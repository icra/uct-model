Unit VarsUnit;

interface

CONST

  FirstSlow       =   1;
  LastSlow        =   10;
  FirstRapid      =   11;
  LastRapid       =  18;
  NoPart          =   10;
  TotalCompounds  =  19;  { including DO }
  LastCompound    =  18;
  NoProcesses     =  27;
  NoDiVars        =  23;

  MaxReac         =  12;
  MaxReacP1       =  13;
  MaxN            = 234;   { LastCompound * (MaxReac+1) }
  NoDiurnalInts   =  12;

TYPE

  subs          = 1..MaxN;
  nvector       = array[subs] of Real;
  intvector     = array[subs] of byte;
  permvectors   = array[subs] of subs;
  diarray       = array[1..NoDiVars,0..144] of real;

  ReacAndComp   = array[0..MaxReacP1,1..TotalCompounds] of real;
  AllReactors   = array[0..MaxReacP1] of real;
  AllCompounds  = array[0..TotalCompounds] of real;
  CompAndProc   = array[1..TotalCompounds,1..NoProcesses] of real;
  AllProcesses  = array[1..NoProcesses] of real;

  NameString    = string[40];
  UnitString    = string[20];
  ShortString   = string[4];
  CaptionString = String[50];

  MenuRecord = Record
    Indent,Offset,LastOption,CurrentOption  :    byte;
    Heading,LastLine                  : CaptionString;
    Caption : array[1..LastCompound] of CaptionString;
    end;

  ListRecord = Record
    Indent,Offset,LastConstant,CurrentConstant,
    SecondIndent,ThirdIndent                    :    byte;
    Heading,LastLine                      : CaptionString;
    Name        : array[1..LastCompound] of CaptionString;
    end;

VAR

  INFLUENT,EFFLUENT       : FILE of real;

  OutFile                 : TEXT;

  Compound                : array [1..TotalCompounds] of NameString;

  Units                   : array [1..NoDiVars] of UnitString;

  ShortName               : array [1..NoDiVars] of ShortString;

  ScaleMax                : array [1..NoDiVars] of real;

  ListParNo               : array [1..10] of byte;

  Response                : array[1..MaxReac] of ^diarray;

  Stoich                  : CompAndProc;

  C,CSteady               : ReacAndComp;

  Scale                   : nvector;

  VolType                 : string[2];

  MainMenu,KineticMenu,DataInputMenu,
  StoichMenu,
  DiurnalSimMenu,GraphicsMenu            : MenuRecord;

  HeteroList,AutoList,TempList,
  PolyPList,SwitchList,
  HStoichList,AStoichList,PStoichList,
  StoichList,AWasteList,BWasteList,
  IntegList                              : ListRecord;

  ValueDummy                             : array[1..17] of real;

  Vol,
  FracFeed,
  Denit,XvTot,
  Oc,On,Ot,
  DOConc,
  AirOnHetero,AirOnAuto,
  AirOffHetero,AirOffAuto,

  FlowFromPrevious,FlowInTotal           : AllReactors;

  C0                                     : AllCompounds;

  Rho                                    : AllProcesses;

  Feed,Time,DynamicFlow,
  DynamicSti,DynamicNti,
  DynamicPti                             : array[1..NoDiurnalInts] of real;

  FlagAIn,FlagBIn,FlagRASIn,
  FlagAOut,FlagBOut                      : array[1..MaxReacP1] of byte;

  ReactorAerated                         : array [1..MaxReacP1] of boolean;

  ReacAvail,
  LastReactor,
  ReactorAIn,ReactorBIn,
  ReactorAOut,ReactorBOut,
  RecordNo,
  FinalIndex,DumInt,AlterInt,Group,
  GraphParNo,
  DataPerDay,
  I,J,K,L,M,Expon                        : integer;

 {KINETIC CONSTANTS}
 {Heterotroph Constants}
  MuHatHetero,Ksh,Bh,
  KmpA,KmpX,Ksp,Kr,Kc,Ka,
  NetaGrow,fma,
  MuHatHetero20,
  MuHeteroS,MuHeteroPA,MuHeteroPX,
  Ksh20,Bh20,KmpA20,KmpX20,Ksp20,
  Kr20,Ka20,Kc20,
 {Autotroph Constants}
  MuHatAuto,MuHatAuto20,
  Ba,Ba20,Ksa,Ksa20,
 {PolyP Constants}
  MuHatPolyP1,MuHatPolyP2,
  MuPolyP1,MuPolyP2,
  MuHatPolyP120,MuHatPolyP220,
  KsG1,KsG2,KsG120,KsG220,
  BG,BG20,Bpp,Bpp20,
  Kp,Kp20,
 {Switch Constants}
  Kha,Koh,Koa,Kog,
  Kno,Kpsh,KpsP,Kpp,Kac,
 {Arrhenius Constants}
  ThetaMuHatH,ThetaKsh,ThetaBh,
  ThetaKmpA,ThetaKmpX,ThetaKsp,ThetaKr,
  ThetaKa,ThetaKc,
  ThetaMuHatA,ThetaKsa,ThetaBa,
  ThetaMuHatP,ThetaKsG,
  ThetaBG,ThetaBpp,ThetaKp,
 {Switches}
  NO3Limit,NH3Limit,HPlimit,PPLimit,AcLimit,PppLimit,
 {STOICHIOMETRIC CONSTANTS}
 {Heterotrophs}
  Yzh,Fzbhn,Fzbhp,
  Fzehn,Fzehp,FepH,
 {Autotrophs}
  Yza,Fzban,Fzbap,
  Fzean,Fzeap,FepA,
 {PolyP Organisms}
  YzG,Fzbgn,Fzbgp,
  Fzegn,Fzegp,FepG,FesG,
  Fprel,Fpupt,
  FesGn,
 {General}
  CODVSS,VSSTSS,
 {CONFIGURATION CONSTANTS}
  VolumeTotal,CumVol,VolumeUnaerated,
  FlowFeed,FlowFeedAvg,FlowToSettler,
  FlowWaste,FlowWastePrevious,FlowWasteAvg,
  FlowRASrecycle,FlowArecycle,FlowBrecycle,
  Rs,
  Temp,TempDiff,
  DataIntHours,
  Accuracy,Theta,
 {INFLUENT CONSTANTS}
  CumFlow,CumCODLoad,CumPtiLoad,
  CumTKNLoad,MeanFlow,
  MeanCOD,MeanTKN,MeanPti,
  Sti,Nti,Alki,Pti,
  StiAvg,NtiAvg,PtiAvg,RBCOD,
  Fac,Fbs,Fus,Fup,Fnobp,Fna,
  Fnous,Fzbh,FupP,
  MachEps,
  DumReal,ScaleFactor                    : real;

  YesNo,ChangeAgain,Key                  : char;

  NoReactorsSet,VolumesSet,
  FeedDistribSet,RecyclesSet,FlowSet,
  SludgeAgeSet,TempSet,StiSet,NtiSet,
  ARecycleSet,BRecycleSet,NoChanges,
  ConfigSpecified,OperationSpecified,
  SteadyStateSpecified,DiurnalSpecified,
  DiurnalDataSpecified,
  SteadyDataSpecified,
  WasteSpecified,GoAhead,Changed         : boolean;

{ colour screen variables }

type
  TextColours = record
    Frame,
    Back,
    Text,
    RevBack,
    RevText : integer;
  end;

  GraphColours = record
    Frame,
    Back,
    Text : integer;
    Line : array[1..MaxReac] of integer;
  end;

var
 GraphDriver     : integer;
 GraphMode       : integer;
 ErrorCode       : word;

 MenuCol,MainBoxCol,InputBoxCol,
 InstructBoxCol,PrBoxCol,
 SelectBoxCol,FrontCol,ResultsCol     : TextColours;

 GraphCol                             : GraphColours;


implementation

end.