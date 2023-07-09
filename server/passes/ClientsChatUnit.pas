unit ClientsChatUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TClientChat = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Memo1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    procedure ShowIt;
    { Public declarations }
  end;

var
  ClientChat: TClientChat;
implementation

uses Unit2;

{$R *.DFM}

procedure TClientChat.ShowIt;
begin
 Memo1.Lines.Clear;
 Edit1.Text:='';
 Show;
end;

procedure TClientChat.Button1Click(Sender: TObject);
begin
 if Edit1.Text<>'' then
 begin
  Form1.ChatSock.Socket.SendText('MTC<'+Form1.NickName+'> '+Edit1.Text);
{  Memo1.Lines.Add('<'+Form1.NickName+'> '+Edit1.Text);}
  Edit1.Text:='';
 end;
end;

procedure TClientChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Form1.ChatSock.Socket.SendText('CCC');
end;

procedure TClientChat.Label2Click(Sender: TObject);
begin
 Form1.ChatSock.Socket.SendText('CVC');
 Form1.Status.Caption:='chat closed.';
 hide;
end;

procedure TClientChat.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) then
 begin
  Button1Click(sender);
  Key := #0;
{  PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);}   
 end;
end;

procedure TClientChat.Label2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 cursor:=crHandPoint;
end;

procedure TClientChat.Memo1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 Cursor:=crDefault;
end;

end.

