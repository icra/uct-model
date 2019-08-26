Program PageUp;

var
 OutFile  : Text;

begin
 Assign(OutFile,'PRN');
 Rewrite(OutFile);
 write(OutFile,chr(12),chr(11));
 Close(OutFile);
end.