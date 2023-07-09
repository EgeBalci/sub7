unit portscanunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ScktComp, Psock, NMEcho, NMSTRM, NMMSG;

type
  Tportscan = class(TForm)
    host1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    host2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    NMMsg1: TNMMsg;
    Label2: TLabel;
    Edit2: TEdit;
    Button4: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NMMsg1MessageSent(Sender: TObject);
    procedure NMMsg1InvalidHost(var Handled: Boolean);
    procedure NMMsg1ConnectionFailed(Sender: TObject);
    procedure NMMsg1Connect(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  portscan: Tportscan;
  ServerAnswer,Connected,StopIt:boolean;
implementation

{$R *.DFM}

procedure Tportscan.Button1Click(Sender: TObject);
var CurrIP:String;
    fromh,toh:array[1..4] of string;
    fromint,toint:array[1..4] of integer;
    i,pos,oldpos,loop,a,b,c,d:integer;
    NMMsg:TNMMsg;
begin
  pos:=1;
  for loop:=1 to 4 do begin
   for i:=pos to length(host1.text) do if (host1.text[i])='.' then break;
   oldpos:=pos;
   pos:=i;
   fromh[loop]:=copy(host1.text,oldpos,pos-oldpos);
   inc(pos)
  end;
  pos:=1;
  for loop:=1 to 4 do begin
   for i:=pos to length(host2.text) do if (host2.text[i])='.' then break;
   oldpos:=pos;
   pos:=i;
   toh[loop]:=copy(host2.text,oldpos,pos-oldpos);
   inc(pos)
  end;
  for i:=1 to 4 do fromint[i]:=StrToInt(fromh[i]);
  for i:=1 to 4 do toint[i]:=StrToInt(toh[i]);
{ for i:=1 to 3 do
  if (fromint[i]=toint[i]) then
   begin
    fromint[i+1]:=1;
    toint[i+1]:=255;
   end;}
  for a:=fromint[1] to toint[1] do
   for b:=fromint[2] to toint[2] do
    for c:=fromint[3] to toint[3] do
     for d:=fromint[4] to toint[4] do
   begin
    StopIt:=False;
    CurrIP:=IntToStr(a)+'.'+IntToStr(b)+'.'+IntToStr(c)+'.'+IntToStr(d);
    StatusBar1.SimpleText := 'scanning IP: '+CurrIP;
    ServerAnswer:=false;

      NMMsg := TNMMsg.Create(Self);
    try
      NMMsg.TimeOut := StrToInt(Edit2.text);
      NMMsg.ReportLevel := Status_Basic;
      NMMsg.Host := CurrIP;
      NMMsg.Port := 6776;
      NMMsg.FromName := 's7';
      NMMsg.PostIt('a');
      Connected:=True;
    except
      Connected:=False;
    end;
      NMMsg.Free;
{    repeat
     Application.ProcessMessages;
    until ServerAnswer or StopIt;}
    if StopIt then begin StatusBar1.SimpleText:='scanning stopped.';Exit;end;
    if Connected then
     begin
      memo1.lines.add(CurrIP);
      StatusBar1.SimpleText:='found: '+CurrIP;
{      break;}
     end;
 end;
 if Not Connected then StatusBar1.SimpleText:='no ips found.';
end;


procedure Tportscan.Button2Click(Sender: TObject);
begin
 StopIt:=True;
 NMMsg1.Abort;
end;

procedure Tportscan.Button3Click(Sender: TObject);
begin
 hide;
end;

procedure Tportscan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{ csocket.close;
 csocket.active:=false;}
end;

procedure Tportscan.NMMsg1MessageSent(Sender: TObject);
begin
 ServerAnswer:=True;
 Connected:=True;
end;

procedure Tportscan.NMMsg1InvalidHost(var Handled: Boolean);
begin
 ServerAnswer:=True;
 Connected:=False;
end;

procedure Tportscan.NMMsg1ConnectionFailed(Sender: TObject);
begin
 ServerAnswer:=True;
 Connected:=False;
end;

procedure Tportscan.NMMsg1Connect(Sender: TObject);
begin
 ServerAnswer:=True;
 Connected:=False;
end;

procedure Tportscan.Button4Click(Sender: TObject);
const plus=#13#10;
begin
 ShowMessage('ok, here we go,'+plus+
  '-it scans all the ips from the first host to the secound one'+plus+
  '-example: 127.0.0.1 and 127.0.2.3 will scan the last two digits this way: 0.1/0.2/0.3/1.1/1.2/1.3/2.1/2.2/2.3'+plus+
  '-stop obviously stops the scan'+plus+
  '-time out means how many milisecounds should the scanner wait for an answer from the host.'+plus+
  '-example, if you use 2000 [the default] it will wait for a reply 2 secounds on each host'+plus+
  '-don''t use too small values, because you might miss some infected hosts.'+plus+
  '-oh, and remember, it _only_ works for ips infected with SubSeven');
end;

end.
