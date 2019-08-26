{$R-}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$M 16384,0,655360} {Turbo 3 default stack and heap}

PROGRAM UCTOLD;

{   Last edited on 6 December 1990 by M Wentzel    }


Uses
  Crt,
  Dos,
  VarsUnit,     { user defined units }
  InitUnit,
  IOUnit,
  PrtUnit,
  InfUnit,
  KinUnit,
  StchUnit,
  CfgUnit,
  OpUnit,
  StdyUnit,
  DiUnit;


Procedure WasteComposition;
 Begin
  InfluentSewage;
  MainMenu.CurrentOption := 2;
 End;  {* waste composition *}

Procedure Configuration;
 Begin
  ProcessConfiguration;
  ConfigSpecified := True;
  If Changed then OperationSpecified := False;
  MainMenu.CurrentOption := 3;
 End;  {* configuration *}

Procedure Operation;
 Begin
  GoAhead := true;

  If NOT ConfigSpecified then
    ReDirect('First specify plant CONFIGURATION....',2);

  If GoAhead then
   begin
    ProcessOperation;
    TempAdjustment;
    OperationSpecified := True;
    MainMenu.CurrentOption := 4;
   end;
 End;  {* operation *}


Procedure SteadyStateSim;
 Begin
  GoAhead := true;

  If NOT ConfigSpecified then
    ReDirect('First specify plant CONFIGURATION....',2);

  If NOT OperationSpecified then
    ReDirect('First specify plant OPERATING PARAMETERS....',3);

  If NOT WasteSpecified then
    ReDirect('First specify WASTEWATER COMPOSITION....',1);

  If GoAhead then
   begin
    SetAvgInputs;
    SteadyState;
    SteadyStateSpecified := True;
    PrintOut('process configuration');
    PrintOut('operating conditions');
    PrintOut('wastewater characteristics');
    PrintOut('kinetic constants');
    PrintOut('stoichiometric constants');
    MainMenu.CurrentOption := 5;
   end;
 End;  {* steady state sim *}

Procedure DiurnalSim;
 Begin
  GoAhead := true;

  If NOT ConfigSpecified then
    ReDirect('First specify plant CONFIGURATION....',2);

  If NOT OperationSpecified then
    ReDirect('First specify plant OPERATING PARAMETERS....',3);

  If NOT SteadyStateSpecified then
    ReDirect('First do STEADY STATE SIMULATION....',4);

  If NOT DiurnalDataSpecified then
    ReDirect('First SPECIFY DIURNAL PATTERN....',1);

  If GoAhead then
   begin
    DiMain;
    PrintOut('process configuration');
    PrintOut('operating conditions');
    PrintOut('wastewater characteristics');
    PrintOut('kinetic constants');
    PrintOut('stoichiometric constants');
    MainMenu.CurrentOption := 2;
   end;

 End;   {* diurnal sim *}


Procedure KineticConstants;   {* select the set of kinetic constants *}
 Begin
  GoAhead := true;

  If NOT OperationSpecified then
    ReDirect('Specify TEMPERATURE (OPERATING PARAMETERS)....',3);

  If GoAhead then
  With KineticMenu do
  begin
  CurrentOption := 1;
  Repeat
    SelectOption(KineticMenu);
    FlashScreen;
    Case CurrentOption of
      1 : Heterotrophs;
      2 : Autotrophs;
      3 : Arrhenius;
          end;
  Until CurrentOption = LastOption+1;
  TempAdjustment;
  PrintOut('kinetic constants');
  MainMenu.CurrentOption := 4;
  end;
 End;  {* kinetic constants *}


Procedure StoichConstants;   {* check/change stoichiometric constants *}
 Begin
  FlashScreen;
  StoichUpdate;
  Stoichiometry;
  If WasteSpecified then FractionateInfluent;
  PrintOut('stoichiometric constants');
  MainMenu.CurrentOption := 4;
 End;  {* stoich constants *}


  BEGIN   {* mainline program *}
    Initialise;
    FlashScreen;
    FrontPage;
    FlashScreen;
    SecondPage;
    Stoichiometry;
    MainMenu.CurrentOption := 1;

    With MainMenu do
     begin
      Repeat
        SelectOption(MainMenu);
        Case CurrentOption of
          1 : WasteComposition;
          2 : Configuration;
          3 : Operation;
          4 : SteadyStateSim;
          5 : DiurnalSim;
          6 : KineticConstants;
          7 : StoichConstants;
              end;
      Until CurrentOption = LastOption+1;
      ClrScr;
     end;

  END.  {* mainline program *}
