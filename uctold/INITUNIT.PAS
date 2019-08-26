Unit InitUnit;    { initialisation unit }

interface

  uses graph,
       VarsUnit,
       Drivers,    { units supplied in Turbo4 }
       Fonts;      { to map in screen/fonts   }

Procedure Initialise;

implementation

{$I macheps.pas }        { calculate machine epsilon           }
{$I strings.pas }        { captions and strings                }
{$I data.pas }           { initial/default values              }
{$I setflg.pas }         { initialise flags                    }
{$I detect.pas }         { detect screen type and set colours  }

Procedure Initialise;
 Begin
  ReacAvail := trunc( MaxAvail / ( 6 * 145 * NoDiVars ) );
  if ReacAvail > MaxReac then ReacAvail := MaxReac;
  CalcMachEps;
  ComponentNames;
  Captions;
  InitialValues;
  SetFlags;
  DetectScreen;
 End;

end.  { end of InitUnit}