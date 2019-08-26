Unit DiUnit;    {  }

interface

uses
  Crt,
  VarsUnit,
  IOUnit,
  PrtUnit,
  InfUnit,
  RateUnit,
  GrafUnit;

Procedure DiMain;

implementation

Var
  dCdt,DhRAS,MassRateIn,Rate,
  LocalEr,CStart,CCheck,CInt,
  CEnd,CStartStep,CPreserve,
  dCdtStart,Slope,Intercept           : ReacAndComp;

  Epsilon                             : AllCompounds;

  WastageOn                           : array[1..12] of boolean;

  FlowWaste                           : array[1..12] of real;

  DhFromPrevious,DhFeed,DhOut,
  DhArecycle,DhBrecycle               : AllReactors;

  CycleNo,
  Steps,DataNo,
  DeltaData,
  NoWasteInts,
  a,MaxH,First,Last,LargeLoops,
  SmallLoops,NoCorrections            : integer;

  DhRASpart,DhRASsol,
  WastageRate,
  T,TimeOfData,
  DeltaTlarge,DeltaTsmall,
  Tsmall,Tlarge,
  IntegIntDays,
  IntegTime,
  InflowIntHours,OutputIntHours,
  PrevDeltaTLarge,PrevDeltaTSmall,
  LocalError,Limit,H                  : real;

  TruncatedLarge,TruncatedSmall       : boolean;

{$I flowdi.pas }         { diurnal flow division           }
{$I integrat.pas }       { integration routine             }
{$I diurnal.pas }        { diurnal response calculation    }
{$I diouts.pas }         { diurnal output options          }
{$I outparam.pas }       { selected print parameters       }
{$I intparam.pas }       { selected integration parameters }
{$I dirslts.pas }        { hardcopy of diurnal results     }
{$I didisk.pas }         { store diurnal results on disk   }
{$I setwaste.pas }       { set up initial wastage pattern  }
{$I modwaste.pas }       { modify wastage pattern          }


Procedure DiMain;

Begin

  for i := 1 to ReacAvail do New(Response[i]); { space on stack }
  FlashScreen;
  SetWaste;
  With DiurnalSimMenu do
  begin
    CurrentOption := 1;
    Repeat
      FlashScreen;
      SelectOption(DiurnalSimMenu);
      FlashScreen;
      Case CurrentOption of
        1 : begin
              Diurnal;
              DiurnalSpecified := true;
              CurrentOption := 2;
            end;
        2 : begin
              GoAhead := true;
              if NOT DiurnalSpecified then
                      begin
                        CurrentOption := 1;
                        ReDirect('First SIMULATE...',1);
                       end;
              if GoAhead then DiRslts;
            end;
        3 : begin
              GoAhead := true;
              if NOT DiurnalSpecified then
                      begin
                        CurrentOption := 1;
                        ReDirect('First SIMULATE...',1);
                       end;
              if GoAhead then DrawGraph;
            end;
        4 : begin
              CheckSelection;
              CurrentOption := 1;
            end;
        5 : begin
              CheckIntegParameters;
              DiurnalSpecified := false;
              CurrentOption := 1;
            end;
        6 : begin
              GoAhead := true;
              if NOT DiurnalSpecified then
                      begin
                        CurrentOption := 1;
                        ReDirect('First SIMULATE...',1);
                       end;
              if GoAhead then StoreOnDisk;
              CurrentOption := 1;
            end;
        7 : begin
              ModifyWastage;
              CurrentOption := 1;
            end;
         end;
    Until CurrentOption = LastOption+1;
  end;

  DiurnalSpecified := false;
  MainMenu.CurrentOption := 1;
  ClrScr;

  for i := 1 to ReacAvail do Dispose(Response[i]);
  DiurnalSpecified := false;

End;

begin    { initial values }

  Accuracy     := 0.50;
  Theta        := 0.70;
  DataIntHours := 0.25;

End. { of DiUnit }