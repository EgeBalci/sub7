unit KeyDll;

interface

uses Windows;

type
  FLastChar = function : Char; stdcall;
  FSetKeyHook = procedure(Wnd : HWnd); stdcall;
  FClearKeyHook = procedure; stdcall;
  FReturnKeys = procedure(B : Boolean; Wnd : HWnd); stdcall;
  FClickOnKey = procedure(B : Boolean; Wnd : HWnd); stdcall;
  FGetKeyVer = procedure(P : PChar); stdcall;

var
  LastChar : FLastChar;
  SetKeyHook : FSetKeyHook;
  ClearKeyHook : FClearKeyHook;
  ReturnKeys : FReturnKeys;
  ClickOnKey : FClickOnKey;
  GetKeyVer : FGetKeyVer;

procedure LoadKeyDll;
procedure FreeKeyDll;

implementation

const
  DLL : PChar = 'SYSTRAY.dll';
  Handle : THandle = 0;

procedure LoadKeyDll;
begin
  try Handle := LoadLibrary(DLL);except end;
  if Handle = 0 then
    Exit;
  @LastChar := GetProcAddress(Handle, 'LastChar');
  @SetKeyHook := GetProcAddress(Handle, 'SetKeyHook');
  @ClearKeyHook := GetProcAddress(Handle, 'ClearKeyHook');
  @ReturnKeys := GetProcAddress(Handle, 'ReturnKeys');
  @ClickOnKey := GetProcAddress(Handle, 'ClickOnKey');
  @GetKeyVer := GetProcAddress(Handle, 'GetKeyVer');
end;

procedure FreeKeyDll;
begin
  if Handle = 0 then
    Exit;
  try FreeLibrary(Handle);except end;
  Handle := 0;
end;

end.
