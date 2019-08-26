Unit PrtUnit;

interface

uses
  Crt,
  Dos,
  VarsUnit,
  IOUnit;

Procedure FrontPage;
Procedure SecondPage;
Procedure PrintConfiguration;
Procedure PrintOperation;
Procedure PrintComposition;
Procedure PrintDiurnalPattern;
Procedure PrintHeterotrophs;
Procedure PrintAutotrophs;
Procedure PrintStoichParameters;
Procedure PrintOut(WhichOne : NameString);


implementation

{$I front.pas }          { title page }
{$I second.pas }         { second page }
{$I printer.pas }        { printer routines }

end.  { of PrtUnit }