Unit InfUnit;

interface

uses Crt,
     VarsUnit,
     IOUnit,
     PrtUnit;

  Procedure FractionateInfluent;
  Procedure SetAvgInputs;
  Procedure DiurnalDataInput;
  Procedure InfluentSewage;

implementation

{$I fracinf.pas }
{$I setavg.pas }
{$I didata.pas }
{$I water.pas }

end.  { end of InfUnit}