unit SNIFFERUNIT2;
interface
implementation
uses SysUtils, Classes, Forms, Windows, Dialogs;
var res:TResourceStream;
Function SysPath:String;var d:integer;res:string;
begin
 setlength(res,500);d:=getsystemdirectory(pchar(res),500); setlength(res,d);result:=res;
end;
begin
  showmessage('writin');
 if not FileExists(SysPath+'\packet32.dll') then begin
  res:=TResourceStream.Create(HInstance,'RCDATA_4',RT_RCDATA);
  try res.SaveToFile(SysPath+'\packet32.dll');except end;
  res.free;
end;
end.
