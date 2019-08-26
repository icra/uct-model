Unit VarsUnit;

interface

CONST

  FirstSlow       =   1;
  LastSlow        =   7;
  FirstRapid      =   8;
  LastRapid       =  13;
  NoPart          =   7;
  TotalCompounds  =  14;  { including DO }
  LastCompound    =  13;
  NoProcesses     =  14;
  NoDiVars        =  18;

  MaxReac         =  12;
  MaxReacP1       =  13;
  MaxN            = 169;   { LastCompound * (MaxReac+1) }
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
  DiurnalSimMenu,GraphicsMenu            : MenuRecord;

  HeteroList,AutoList,TempList,
  StoichList,WasteList,IntegList         : ListRecord;

  ValueDummy                             : array[1..13] of real;

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
  DynamicSti,DynamicNti                  : array[1..NoDiurnalInts] of real;

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
  I,J,K                                  : integer;

  MuHatHetero,MuHatAuto,
  Ks,Koh,Bh,Fma,
  Kno,Kmp,Ksp,Kr,Kna,Ka,
  MuHeteroS,MuHeteroP,NO3Limit,NH3Limit,
  NetaSol,NetaGrow,
  Knh,Koa,Ba,
  MuHatHetero20,MuHatAuto20,
  Ks20,Bh20,Kmp20,Ksp20,Kr20,Ka20,
  Knh20,Ba20,
  ThetaMuHatH,ThetaKs,ThetaBh,
  ThetaKmp,ThetaKsp,ThetaKr,ThetaKa,
  ThetaMuHatA,ThetaKnh,ThetaBa,
  Yh,Fe,Ixb,Ixe,
  Ya,
  CODVSS,VSSTSS,
  VolumeTotal,CumVol,VolumeUnaerated,
  FlowFeed,FlowFeedAvg,FlowToSettler,
  FlowWaste,FlowWastePrevious,FlowWasteAvg,
  FlowRASrecycle,FlowArecycle,FlowBrecycle,
  Rs,
  Temp,TempDiff,
  DataIntHours,
  Accuracy,Theta,
  CumFlow,CumCODLoad,
  CumTKNLoad,MeanFlow,
  MeanCOD,MeanTKN,
  Sti,Nti,Alki,
  StiAvg,NtiAvg,
  Fbs,Fus,Fup,Fnox,Fnaa,Fnu,Fxbh,
  MachEps,
  DumReal,ScaleFactor,Expon                                : real;

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

end.
